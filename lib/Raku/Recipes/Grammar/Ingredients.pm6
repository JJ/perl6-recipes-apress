unit grammar Raku::Recipes::Grammar::Ingredients;

token ingredient      { <quantity> \h* <unit>? }
token quantity { <:N>+ }
token unit     { "g" | "tbsp" | "clove" | "tbsps" | "cloves" }