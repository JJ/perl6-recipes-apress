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
    is( %calories-table<Rice><types>.elems, 4, "Rice food types");
    nok( $rr.is-ingredient("Lint"), "Lint is not a product");
    is( %calories-table<Rice><parsed-measures>[1], "g", "Measure for rice is OK" );
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

done-testing;
