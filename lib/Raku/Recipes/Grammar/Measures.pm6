unit role Raku::Recipes::Grammar::Measures;

token quantity { <:N>+ }
token unit     { "g" | "tbsp" | "clove" | "tbsps" | "cloves" }
