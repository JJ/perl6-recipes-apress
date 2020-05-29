use Test;

use Raku::Recipes::CSVDator;
use X::Raku::Recipes::Missing;

my $rr = Raku::Recipes::CSVDator.new( "." );

my %ingredients = $rr.ingredients;
my @products = %ingredients.keys;

subtest "File has been processed into data", {
    is( %ingredients{@products[0]}<Dairy>, True|False, "Values processed" );
    cmp-ok( @products.elems, ">", 1, "Many elements in the table" );
};

subtest "Particular ingredients and measures are OK", {
    ok( %ingredients<Rice>, "Rice is there" );
    is( $rr.get-ingredient("Rice"), %ingredients<Rice>, "Single ingredient retrieved");
    is( %ingredients<Rice><types>.elems, 4, "Rice food types");
    is( %ingredients<Rice><parsed-measures>[1], "g", "Measure for rice is
OK" );
    throws-like { $rr.get-ingredient( "Goo" )},
            X::Raku::Recipes::Missing::Product,
        "Correct exception thrown";
};

subtest "Search works", {
    my @vegan = $rr.search-ingredients( { Vegan => True });
    ok( @vegan , "Searching works");
    cmp-ok( @vegan.elems, ">=", 14, "Elements are OK" );
    nok( $rr.search-ingredients( { :Vegan, :Dairy } ), "No vegan and dairy" );
    my @vegan'n'dessert = $rr.search-ingredients( { :Vegan, :Dessert } );
    cmp-ok( @vegan'n'dessert, "⊂", @vegan, "Vegan desserts are vegan")
}

done-testing;
