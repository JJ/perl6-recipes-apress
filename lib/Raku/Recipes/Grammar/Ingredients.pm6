unit grammar Raku::Recipes::Grammar::Ingredients;

token TOP      { <quantity> \h* <unit>? }
token quantity { <:N>+ }
token unit     { "g" | "tbsp" | "clove" | "tbsps" | "cloves" }