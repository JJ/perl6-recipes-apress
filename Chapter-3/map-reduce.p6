#!/usr/bin/env raku

use Text::CSV;

csv(in => "data/calories.csv",  sep => ';', headers => "auto", key => "Ingredient" ).pairs
    ==> map( {
       $_.value<Ingredient>:delete;
       $_.value<parsed-measures> = parse-measure( $_.value<Unit> );
       $_ } )
    ==> my %calories;

my @recipes;
for dir("data/recipes/", test => /\.csv$/) -> $r {
    say "Processing $r";
    say csv(in => $r, sep => ";", headers => "auto", key => "Ingredient");
}

say @recipes;

sub parse-measure ( $description ) {
    $description ~~ / $<unit>=(<:N>*) \s* $<measure>=(\S+) /;
    my $unit = +$<unit>??+$<unit>!!1;
    return ($unit,~$<measure>);
}


