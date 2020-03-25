#!/usr/bin/env raku

use YAMLish;

my %conf = load-yaml( "recipe.yaml".IO.slurp );

say %conf;
