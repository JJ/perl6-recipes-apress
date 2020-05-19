use Test; # -*- mode: perl6 -*-
use Raku::Recipes::Recipe;

my @ingredients = ("100g tuna", "200g rice", "150g tomatoes");
my $recipe = Raku::Recipes::Recipe.new( :title("Tuna with rice"),
        :description("Very basic but flavourful dish"),
        :@ingredients );

ok( $recipe, "Can instantiate");

like( $recipe.gist, /"* " {@ingredients[0]} /, "Gist is OK" );

done-testing;
