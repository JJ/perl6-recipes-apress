use Test;

use Raku::Recipes::Redisator;
use X::Raku::Recipes::Missing;

my $redisator = Raku::Recipes::Redisator.new();
isa-ok( $redisator, Raku::Recipes::Redisator, "Correct class");

my %new-ingredient = Calories => "85",
                     Unit => "Unit",
                     Protein => "1.1",
                     Vegan => "Yes",
                     Dairy => "No",
                     Dessert => "Yes",
                     Main => "No",
                     Side => "Yes";

lives-ok { $redisator.insert-ingredient( "Banana", %new-ingredient) },
        "Can insert ingredient";

my %data = $redisator.get-ingredient("Banana");
ok( %data, "Retrieves ingredient");
is( %data<Unit>, "Unit", "Correct hash");
is $redisator<Banana><Unit>, "Unit", "Adds correctly stuff";
is( $redisator<Banana>, %data, "Associative works");

my %ingredients = $redisator.get-ingredients();
is( %ingredients<Banana><Unit>, "Unit", "Correct hash from all retrieved");

my @vegan = $redisator.search-ingredients({ Vegan => "Yes" });
ok(@vegan, "Searching works");
cmp-ok(@vegan.elems, ">=", 1, "Elements are OK");
nok($redisator.search-ingredients({ :Vegan, :Dairy }), "No vegan and dairy");
my @vegan'n'dessert = $redisator.search-ingredients({ :Vegan, :Dessert });
cmp-ok(@vegan'n'dessert, "⊆", @vegan, "Vegan desserts are vegan");


lives-ok { $redisator.delete-ingredient( "Banana") },
        "Can delete ingredient";

nok( $redisator<Banana>, "Ingredient deleted");


done-testing;
