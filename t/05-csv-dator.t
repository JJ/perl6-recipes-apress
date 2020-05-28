use Test;

use Raku::Recipes::CSVDator;

my $rr = Raku::Recipes::CSVDator.new( "." );

my %ingredients = $rr.ingredients;
my @products = %ingredients.keys;

subtest "File has been processed into data", {
    is( %ingredients{@products[0]}<Dairy>, True|False, "Values processed" );
    cmp-ok( @products.elems, ">", 1, "Many elements in the table" );
};

subtest "Particular ingredients and measures are OK", {
    ok( %ingredients<Rice>, "Rice is there" );
    is( %ingredients<Rice><types>.elems, 4, "Rice food types");
    is( %ingredients<Rice><parsed-measures>[1], "g", "Measure for rice is
OK" );
};

done-testing;
