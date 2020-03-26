#!/usr/bin/env raku

use YAMLish;
use Raku::Recipes::Classy;

my %conf = load-yaml( "Chapter-5/recipe.yaml".IO.slurp );


