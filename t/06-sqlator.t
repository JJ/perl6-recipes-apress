use Test;
use lib <lib t/lib>;

use RecipesTestHelp;
use Raku::Recipes::SQLator;
use X::Raku::Recipes::Missing;

my $filename = "Chapter-12/ingredients.sqlite3".IO.e
    ??"Chapter-12/ingredients.sqlite3"
        !!"ingredients.sqlite3";

my $sqlator = Raku::Recipes::SQLator.new($filename);

isa-ok( $sqlator, Raku::Recipes::SQLator, "Correct class");
my %data = $sqlator.get-ingredient("Rice");
ok( %data, "Retrieves ingredient");
is( %data<Unit>, "100g", "Correct hash");

is( $sqlator<Rice>, %data, "Associative works");

my %ingredients = $sqlator.get-ingredients();
is( %ingredients<Lentils><Unit>, "100g", "Correct hash");

my @vegan = $sqlator.search-ingredients({ Vegan => True });
ok(@vegan, "Searching works");
cmp-ok(@vegan.elems, ">=", 12, "Elements are OK");
nok($sqlator.search-ingredients({ :Vegan, :Dairy }), "No vegan and dairy");
my @vegan'n'dessert = $sqlator.search-ingredients({ :Vegan, :Dessert });
cmp-ok(@vegan'n'dessert, "⊂", @vegan, "Vegan desserts are vegan");

done-testing;
