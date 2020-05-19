use Test; # -*- mode: perl6 -*-
use Raku::Recipes::Ingredients;

my @ingredients = ("100g tuna", "200g rice", "150g tomatoes");
my $ingredients = Raku::Recipes::Ingredients.new( :@ingredients );

ok( $ingredients, "Can instantiate");

class With-Ingredients does Raku::Recipes::Ingredients {};
ok( With-Ingredients.new( :@ingredients), "Baked in class");
