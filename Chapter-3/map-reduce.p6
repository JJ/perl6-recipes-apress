#!/usr/bin/env raku

use Text::CSV;

my %calories = csv(in => "data/calories.csv",  sep => ';', headers => "auto", key => "Ingredient" );

%calories.keys
    ==> map( { %calories{$_}<Ingredient>:delete } )
    ==> grep( { %calories{$_}<Dairy> eq 'No'} )
    ==> my @non-dairy-ingredients;

%calories.keys 
    ==> map( { %calories{$_}<Dairy>:delete } );

say %calories{ @non-dairy-ingredients};


