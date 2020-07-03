use Test; # -*- mode: perl6 -*-

use Raku::Recipes::Grammarole::Measured-Ingredients;

my $ingredients = q:to/EOS/;
* 320g tuna (canned)
* 250g rice
* ½ onion
* 250g cheese (whatever is in your fridge)
* 2 tablespoons olive oil
* 4 cloves garlic
* 1 spoon butter (or margarine)
* ⅓ liter wine (or beer)
EOS

grammar Tester does Raku::Recipes::Grammarole::Measured-Ingredients {}

subtest "Test alternatives",{
    for $ingredients.chomp.split: /\s* \* \s+/ -> $ingredient {
        my $item = Tester.subparse($ingredient,
                                    rule => "ingredient-description");
        is($item, $ingredient, "Parses $ingredient");
    }
}

done-testing;
