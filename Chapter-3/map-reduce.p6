#!/usr/bin/env raku

use Text::CSV;

my %calories = csv(in => "data/calories.csv",  sep => ';', headers => "auto", key => "Ingredient" ).pairs.map: { $_.value<Ingredient>:delete; $_ };

say %calories;

sub parse-measure ( $description ) {
    $description ~~ / $<unit>=(<:N>*) \s* $<measure>=(\S+) /;
    my $unit = $<unit> // 1;
    return ($unit,$<measure>);
}


