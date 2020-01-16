#!/usr/bin/env raku

use Raku::Recipes;
use JSON::Fast;

my %conf = from-json( (@*ARGS[0].IO.e ?? @*ARGS[0].IO !! "config.json".IO ).slurp );
say %conf;
my %calories-table = calories-table( %conf<filename> );
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

my $max-calories = %conf<calories>;

my @results = gather for ^%conf<repetitions> {
    my @ingredients = recipes( @products.elems -1 , $max-calories );
    my $proteins = proteins( @ingredients );
    say @ingredients, " with $proteins g protein";
    take @ingredients => $proteins;
}

say @results.maxpairs;

sub proteins( @items ) {
    return [+] %calories-table{@items}.map: *<Protein>;
}

