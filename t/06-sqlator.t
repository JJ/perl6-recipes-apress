use Test;
use lib <lib t/lib>;

use RecipesTestHelp;
use Raku::Recipes::SQLator;
use X::Raku::Recipes::Missing;

my $filename = "Chapter-12/ingredients.sqlite3".IO.e
    ??"Chapter-12/ingredients.sqlite3"
        !!"ingredients.sqlite3";

my $sqlator = Raku::Recipes::SQLator.new($filename);

isa-ok( $sqlator, Raku::Recipes::SQLator, "Correct class");
my %data = $sqlator.get-ingredient("Rice");
ok( %data, "Retrieves ingredient");
is( %data<Unit>, "100g", "Correct hash");

done-testing;
