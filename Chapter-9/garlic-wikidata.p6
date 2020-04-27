#!/usr/bin/env perl6

use Wikidata::API;

my $query = "Chapter-9/ingredients.sparql";

my $recipes-with-garlic= query($query);

say "Recipes with garlic:\n", $recipes-with-garlic;