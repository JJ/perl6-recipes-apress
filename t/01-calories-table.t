use Test;

use Raku::Recipes;

my %calories = calories-table( "data" );

cmp-ok( %calories.keys.elems, ">", 1, "Many elements in the table" );
ok( %calories<Rice>, "Rice is there" );
is( %calories<Rice><parsed-measures>[1], "g", "Measure for rice is OK" );

done-testing;