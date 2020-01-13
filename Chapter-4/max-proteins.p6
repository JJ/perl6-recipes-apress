#!/usr/bin/env raku

use Raku::Recipes;

my %calories-table = calories-table;
my @products = %calories-table.keys;

multi sub recipes( -1, $ ) { return [] };

multi sub recipes( $index,
                   $weight  where  %calories-table{@products[$index]}<Calories> > $weight ) {
    return recipes( $index - 1, $weight );
}

multi sub recipes( $index, $weight ) {
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

my $max-calories = 1000;
my @ingredients = recipes( @products.elems -1 , $max-calories );
say @ingredients, " with ", proteins( @ingredients ), "g protein";


sub proteins( @items ) {
    return [+] %calories-table{@items}.map: *<Protein>;
}

