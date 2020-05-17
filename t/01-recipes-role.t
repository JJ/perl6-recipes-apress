use Test; # -*- mode: perl6 -*-
use X::Raku::Recipes;
use Raku::Recipes::Roly;

my $rr = Raku::Recipes::Roly.new( "." );

my @products = $rr.products;
my %calories-table = $rr.calories-table;

subtest "File has been processed into data", {
    is( %calories-table{@products[0]}<Dairy>, True|False, "Values processed" );
    cmp-ok( @products.elems, ">", 1, "Many elements in the table" );
};

subtest "Particular ingredients and measures are OK", {
    ok( %calories-table<Rice>, "Rice is there" );
    ok( $rr.is-ingredient("Rice"), "Rice is a product");
    nok( $rr.is-ingredient("Lint"), "Lint is not a product");
    is( %calories-table<Rice><parsed-measures>[1], "g", "Measure for rice is OK" );
    throws-like  { $rr.calories("boogers",100) },
            X::Raku::Recipes::Missing::Product,
            "Not an ingredient";
    is( $rr.calories("Rice",300), 390, "Correct calories for rice");
    is( $rr.calories("Rice" => "g" => 300), 390, "Correct calories for Pair");
};

subtest "There's documentation for the module", {
    ok $pod, "There's documentation";

};

subtest "Food types are correct", {
    ok $rr.check-type( "Tuna", "Main"), "Tuna is main";
    ok $rr.check-type( "Rice", "Vegan" ), "Rice is vegan";
    ok $rr.check-type( "Apple", "Dessert"), "Apple is dessert";
    ok $rr.check-type( "Egg", "Dairy"), "Egg is dairy";
}

subtest "U tnitypes are correct", {
    ok $rr.check-unit( "Tuna", "g"), "Tuna uses g";
    ok $rr.check-unit( "Beer", "liter" ), "Beer uses liters";
    ok $rr.check-unit( "Apple", "Unit"), "Apple use units";
    ok $rr.check-unit( "Olive Oil", "tablespoon"), "Oil measured in tablespoons";
}

subtest "Composing dishes", {
    throws-like { $rr.calories-for( main => "Whatever" => 300,
            side => "Whatever" => 3
            ) },
            X::Raku::Recipes::Missing::Product, "Whatever not a product";
    throws-like { $rr.calories-for( main => "Apple" => 300,
            side => "Whatever" => 3
            ) },
          X::Raku::Recipes::WrongType, "Apple not a main dish";
    is( $rr.calories-for( main => "Tuna" => 250,
            side => "Rice" => 100  ), 455, "Calories for dish
computed correctly");
}

done-testing;
