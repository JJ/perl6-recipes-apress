use Text::CSV;

# Utility functions for the Raku Recipes book
unit module Raku::Recipes;

# Parses measure to return an array with components
sub parse-measure ( $description ) {
    $description ~~ / $<unit>=(<:N>*) \s* $<measure>=(\S+) /;
    my $unit = +$<unit>??+$<unit>!!1;
    return ($unit,~$<measure>);
}

# Returns the table of calories in the CSV file
sub calories-table( $dir = "." ) is export {
    csv(in => "data/calories.csv",  sep => ';', headers => "auto", key => "Ingredient" ).pairs
    ==> map( {
       $_.value<Ingredient>:delete;
       $_.value<parsed-measures> = parse-measure( $_.value<Unit> );
       $_ } );

}
