use Test;
use RecipeMark;

my $recipe = RecipeMark.new("recipes/main/rice/tuna-risotto.md");

ok( $recipe, "Created recipe");
isa-ok( $recipe, RecipeMark, "Correct class");
is( $recipe.ingredient-list.keys.elems, 9, "Correct ingredients");
ok ( "Rice" ∈ $recipe.ingredient-list.keys, "Rice is there");

done-testing;
