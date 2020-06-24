#!/usr/bin/env perl6

use Inline::Perl5;

use MealMaster:from<Perl5>;
use Text::Markdown:from<Perl5>;

use Raku::Recipes::Recipe;

my $threads = @*ARGS[0] // 4;

my Channel $queue .= new;

my $parser = MealMaster.new();
my @recipes = $parser.parse("Chapter-15/allrecip.mmf");

my @promises = do for ^$threads {
    start react whenever $queue -> $recipe {
        say $recipe;
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