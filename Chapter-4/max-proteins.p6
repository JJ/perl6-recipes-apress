#!/usr/bin/env raku

use Raku::Recipes;

my %calories-table = calories-table;
my @products = %calories-table.keys;
my @recipes;
my $max-calories = 2000;

multi sub recipes( 0, $ ) { return [] };

multi sub recipes( $index, $weight ) {
    if %calories-table{@products[$index]}<Calories> > $weight {
        return recipes( $index - 1, $weight );
    } else {
        my $lhs = proteins(recipes( $index - 1, $weight ));
        my @recipes = recipes( $index - 1,
                               $weight -  %calories-table{@products[$index]}<Calories> );
        my $rhs = %calories-table{@products[$index]}<Protein> +  proteins( @recipes );
        if $rhs > $lhs {
            return @recipes.append: @products[$index];
        } else {
            return @recipes;
        }
    }
}

say recipes( @products.elems -1 , $max-calories );


sub proteins( @products ) {
    return [+] %calories-table{@recipes}.map: *<Protein>;
}

