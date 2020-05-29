use Test;
use lib <lib t/lib>;

use RecipesTestHelp;
use Raku::Recipes::SQLator;
use X::Raku::Recipes::Missing;

my $sqlator = Raku::Recipes::SQLator.new;

isa-ok( $sqlator, Raku::Recipes::SQLator, "Correct class");

done-testing;
