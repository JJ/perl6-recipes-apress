use Test; # -*- mode: perl6 -*-

use Raku::Recipes::Classy;

my $rr = Raku::Recipes::Classy.new( "." );

my @products = $rr.products;
my %calories-table = $rr.calories-table;

is( %calories-table{@products[0]}<Dairy>, True|False, "Values processed" );
                    
cmp-ok( @products.elems, ">", 1, "Many elements in the table" );
ok( %calories-table<Rice>, "Rice is there" );
is( %calories-table<Rice><parsed-measures>[1], "g", "Measure for rice is OK" );

is $rr.proteins( <Rice Chickpeas> ), 9.7, "Proteins computed correctly";

my @optimal = $rr.optimal-ingredients( @products.elems -1 , 500 );
like @optimal[0], /\w+/, "Optimal protein combo";

done-testing;
