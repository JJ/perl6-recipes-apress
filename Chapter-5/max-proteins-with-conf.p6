#!/usr/bin/env raku

use Raku::Recipes;
use JSON::Fast;

my %conf = from-json( (@*ARGS[0].IO.e ?? @*ARGS[0].IO !! "config.json".IO ).slurp );
%calories-table = calories-table( %conf<dir> );
@products = %calories-table.keys;

my $max-calories = %conf<calories>;

my @results = gather for ^%conf<repetitions> {
    @products = @products.pick(*);
    my @ingredients = optimal-ingredients( @products.elems -1 , $max-calories );
    my $proteins = proteins( @ingredients );
    say @ingredients, " with $proteins g protein";
    take @ingredients => $proteins;
}
say @results.Hash;
say "Best ", @results.Hash.maxpairs;


