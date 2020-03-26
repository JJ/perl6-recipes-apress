use Test; # -*- mode: perl6 -*-

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
    is( %calories-table<Rice><parsed-measures>[1], "g", "Measure for rice is OK" );
};

subtest "There's documentation for the module", {
    ok $pod, "There's documentation";

};

subtest "Food types are correct", {
    ok $rr.check-type( "Tuna", "Main"), "Tuna is main";
    ok $rr.check-type( "Rice", "Vegan" ), "Rice is vegan";
    ok $rr.check-type( "Apple", "Dessert"), "Apple is dessert";
    ok $rr.check-type( "Egg", "Dairy"); "Apple is dairy";
}

done-testing;
