use Test; # -*- mode: perl6 -*-

use Raku::Recipes::Grammarole::Measured-Ingredients;
use Grammar::Tracer;

subtest "Test alternatives",{
    my $ingredient = "2 eggs (free run)";
    my $item =
            Raku::Recipes::Grammarole::Measured-Ingredients
                .subparse( $ingredient,
                            rule => "measured-ingredient");
    is( $item, $ingredient, "Parses item" );
}
done-testing;
