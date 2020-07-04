use Raku::Recipes::CSVDator;
use Raku::Recipes::Grammar::Measures;

my @products;
BEGIN {
    @products = Raku::Recipes::CSVDator.new.products.map:
            {$_.ends-with("s")?? $_ !! ( $_, $_ ~ "s").Slip }
    say @products;
}

unit role Raku::Recipes::Grammarole::Measured-Ingredients does
    Raku::Recipes::Grammar::Measures;
token ingredient-description {
    <measured-ingredient> \h* <options>?
}

token measured-ingredient {
    [ <quantity> \h* <unit> \h+ <product> || <quantity> \h+ <product>]
}

token options {
    '(' ~ ')' $<content> = .+?
}

token product {:i @products }