use Test; # -*- mode: perl6 -*-

use Raku::Recipes::Roly;

my $rr = Raku::Recipes::Roly.new( "." );

my @products = $rr.products;
my %calories-table = $rr.calories-table;

subtest {
    is( %calories-table{@products[0]}<Dairy>, True|False, "Values processed" );
    cmp-ok( @products.elems, ">", 1, "Many elements in the table" );
},  "Products";

subtest {
    ok( %calories-table<Rice>, "Rice is there" );
    is( %calories-table<Rice><parsed-measures>[1], "g", "Measure for rice is OK" );
}, "Calories table";

subtest {
    say Raku::Recipes::Roly.WHY;
    for <new products calories-table> -> $m {
	ok Raku::Recipes::Roly.{$m}.WHY, "Pod comments work";
    }
}

done-testing;
