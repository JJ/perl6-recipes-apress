#!/usr/bin/env perl6

use Inline::Perl5;

use MealMaster:from<Perl5>;

use Raku::Recipes::Recipe;
use Raku::Recipes::SQLator;

my $threads = @*ARGS[0] // 4;

my Channel $queue .= new;

my $parser = MealMaster.new();
my @recipes = $parser.parse("Chapter-15/allrecip.mmf");

my %ingredients = Raku::Recipes::SQLator.new.get-ingredients;
my @known = %ingredients.keys.map: *.lc;

my @promises = do for ^$threads {
    start react whenever $queue -> $recipe {
        my @real-ingredients = $recipe.ingredients.grep: /^^\w+/;
        my @processed = gather for @real-ingredients -> $i is copy {
            if $i ~~ m:i/ <|w> $<ingredient> = (@known) <|w>/ {
                my $ing = ~$<ingredient>;
                my $subst = "[$ing](/ingredient/$ing)";
                $i ~~ s:i!<|w> $ing <|w> ! $subst !;
            }
            take $i;
        }
        say "Processed ", @processed;
    }
}

for @recipes -> $r {
    my $description = "Categories: " ~ $r.categories().join( " - ");
    my $title;
    if $r.title ~~ Str {
        $title = $r.title
    } else {
        $title = $r.title.decode
    }
    my $recipe = Raku::Recipes::Recipe.new(
        :$title,
        :$description,
        ingredients => $r.ingredients().map: {.product }
            );
    $queue.send: $recipe;
}

$queue.close;

await @promises;