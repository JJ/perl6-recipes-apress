use Raku::Recipes::Roly;
use Raku::Recipes::Grammar::Measures;

my @products;
BEGIN {
    @products = Raku::Recipes::Roly.new.products;
}

unit role Raku::Recipes::Grammarole::Measured-Ingredients does
    Raku::Recipes::Grammar::Measures;
token ingredient-description {
    <measured-ingredient> \h* <options>?
}

token measured-ingredient {
    [ <quantity> \h* <unit> \h+ <ingredient> || <quantity> \h+ <ingredient>]
}

token options {
    ['(' ~ ')' .+? ]
}

token product {:i @products "s"? }