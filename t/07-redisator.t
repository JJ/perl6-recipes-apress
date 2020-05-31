use Test;

use Raku::Recipes::Redisator;
use X::Raku::Recipes::Missing;

my $redisator = Raku::Recipes::Redisator.new();

isa-ok( $redisator, Raku::Recipes::Redisator, "Correct class");
my %data = $redisator.get-ingredient("Rice");
ok( %data, "Retrieves ingredient");
is( %data<Unit>, "100g", "Correct hash");

is( $redisator<Rice>, %data, "Associative works");

my %ingredients = $redisator.get-ingredients();
is( %ingredients<Lentils><Unit>, "100g", "Correct hash");

#my @vegan = $redisator.search-ingredients({ Vegan => True });
#ok(@vegan, "Searching works");
#cmp-ok(@vegan.elems, ">=", 14, "Elements are OK");
#nok($redisator.search-ingredients({ :Vegan, :Dairy }), "No vegan and dairy");
#my @vegan'n'dessert = $redisator.search-ingredients({ :Vegan, :Dessert });
#cmp-ok(@vegan'n'dessert, "⊂", @vegan, "Vegan desserts are vegan");

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

is $redisator<Banana><Unit>, "Unit", "Adds correctly stuff";

lives-ok { $redisator.delete-ingredient( "Banana") },
        "Can delete ingredient";

nok( $redisator<Banana>, "Ingredient deleted");


done-testing;
