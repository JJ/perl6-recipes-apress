use Text::CSV;

#| Utility functions for the Raku Recipes book
unit module Raku::Recipes;

# Types of food that are checked
our @food-types is export = <Vegan Main Side Dessert Dairy>;

#| Unit that can be used to describe quantities
our @unit-types is export = <g tbsp clove tbsps cloves liters liter l
tablespoons Unit tablespoon>;

our %calories-table is export;

our @products is export;

#| Gets all recipes in the tree
sub recipes( $dir = "recipes/") is export {
    my @files = gather for dir($dir) -> $f {
        if ( $f.IO.f ) {
            take $f
        } else {
            take recipes($f);
        }
    }
    return @files.List.flat;
}

#| Parses measure to return an array with components
sub parse-measure ( $description ) is export {
    $description ~~ / $<unit>=(<:N>*) \s* $<measure>=(\S+) /;
    my $unit = +$<unit>??+$<unit>!!1;
    return ($unit,~$<measure>);
}

multi sub unit-measure ( $description where /^<:N>/ ) is export {
    $description ~~ / $<unit>=(<:N>+) \s* $<measure>=(\S+) /;
    my $value = +val( ~$<unit>  ) // unival( ~$<unit> );
    return ( $value, ~$<measure> );
}

multi sub unit-measure ( $description where /^<alpha>/ ) is export {
    $description ~~ / $<measure>=(\S+) /;
    return ( 1, ~$<measure> );
}

# Returns the table of calories in the CSV file
sub calories-table( $dir = "." ) is export {
    csv(in => "$dir/data/calories.csv",  sep => ';', headers => "auto", key => "Ingredient" ).pairs
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

multi proteins( [] ) is export { 0 }

multi proteins( @items )  is export  {
    return [+] %calories-table{@items}.map: *<Protein>;
}
