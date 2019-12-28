#!/usr/bin/env raku

use Text::CSV;

my %calories = csv(in => "data/calories.csv",  sep => ';', headers => "auto", key => "Ingredient" );

%calories.keys.map: { %calories{$_}<Ingredient>:delete };
say %calories;


