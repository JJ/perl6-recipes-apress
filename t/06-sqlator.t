use Test;
use lib <lib t/lib>;

use RecipesTestHelp;
use Raku::Recipes::SQLator;
use X::Raku::Recipes::Missing;

my $sqlator = Raku::Recipes::SQLator.new;

isa-ok( $sqlator, Raku::Recipes::SQLator, "Correct class");
my %data = $sqlator.get-ingredient("Rice");
ok( %data, "Retrieves ingredient");
say %data;
is( %data<Unit>, "100g", "Correct hash");

done-testing;
