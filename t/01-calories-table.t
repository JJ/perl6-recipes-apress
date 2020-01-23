use Test; # -*- mode: perl6 -*-

use Raku::Recipes;

%calories-table = calories-table( "." );
@products = %calories-table.keys;

cmp-ok( @products.elems, ">", 1, "Many elements in the table" );
ok( %calories-table<Rice>, "Rice is there" );
is( %calories-table<Rice><parsed-measures>[1], "g", "Measure for rice is OK" );

is proteins( <Rice Chickpeas> ), 9.7, "Proteins computed correctly";
@products .= sort;
is @products[0], "Apple", "Sorted products";

my @optimal = optimal-ingredients( @products.elems -1 , 500 );
is @optimal[0], "Rice", "Optimal protein combo";

done-testing;
