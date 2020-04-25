#!/usr/bin/env perl6

use Raku::Recipes::Grammar::Ingredients;
use Grammar::ErrorReporting;

say Raku::Recipes::Grammar::Ingredients.parse("* 2 tbsps");