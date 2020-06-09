#!/usr/bin/env perl6

use Inline::Perl5;

use MealMaster:from<Perl5>;
use Raku::Recipes::Recipe;

my $parser = MealMaster.new();
my @recipes = $parser.parse("Chapter-14/apetizer.mmf");

for @recipes -> $r {
    my $description = "Categpries " ~ $r.categories().join( " - ");
    my $recipe = Raku::Recipes::Recipe.new(
        title => $r.title,
        ingredients => $r.ingredients().map: {.product},
        :$description );
    say $recipe.raku;
    say $description;
}
