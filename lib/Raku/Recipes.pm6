use Text::CSV;

# Utility functions for the Raku Recipes book
unit module Raku::Recipes;

our %calories-table is export;
our @products is export;

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

multi sub optimal-ingredients( -1, $ )  is export  { return [] };

multi sub optimal-ingredients( $index,
			       $weight  where  %calories-table{@products[$index]}<Calories> > $weight )  is export  {
    return optimal-ingredients( $index - 1, $weight );
}

multi sub optimal-ingredients( $index, $weight )  is export  {
    my $lhs = proteins(optimal-ingredients( $index - 1, $weight ));
    my @recipes = optimal-ingredients( $index - 1,
                           $weight -  %calories-table{@products[$index]}<Calories> );
    my $rhs = %calories-table{@products[$index]}<Protein> +  proteins( @recipes );
    if $rhs > $lhs {
        return @recipes.append: @products[$index];
    } else {
        return @recipes;
    }
}

sub proteins( @items )  is export  {
    return [+] %calories-table{@items}.map: *<Protein>;
}
