use Raku::Recipes::Roly;

my @products;
BEGIN {
    @products = Raku::Recipes::Roly.new.products;
}

unit grammar Raku::Recipes::Grammar::Quantified-Ingredients;
token TOP      { <quantity> [\h* <unit> \h+ <ingredient> | \h+ <ingredient>]}
token quantity { <:N>+ }
token unit     { "g" | "tbsp" | "clove" | "tbsps" | "cloves" }
token ingredient {:i @products }