use Test; # -*- mode: perl6 -*-

use Raku::Recipes;

my @all-recipes = recipes();

ok( @all-recipes, "There are recipes" );

done-testing;
