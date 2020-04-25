use Test; # -*- mode: perl6 -*-

use Raku::Recipes::Grammar::Ingredients;

subtest "Test quantities", {
    is( Raku::Recipes::Grammar::Ingredients.subparse( "⅓",
            rule => 'quantity'),
            "⅓", "Parses fractions" );
    is( Raku::Recipes::Grammar::Ingredients.subparse( "333",
            rule => 'quantity'),
            "333", "Parses integers" );
}

done-testing;
