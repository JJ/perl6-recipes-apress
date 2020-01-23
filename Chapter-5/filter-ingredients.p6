#!/usr/bin/env raku

use Raku::Recipes::Classy;

sub MAIN( Bool :$Dairy, Bool :$Vegan, Bool :$Main, Bool :$Side, Bool :$Dessert ) {
    my %ingredients = Raku::Recipes::Classy.new().calories-table;
    my @flags = <Dairy Vegan Main Side Dessert>.grep: { defined ::{"\$$_"} };
    my @filtered = %ingredients.keys.grep: -> $i {
        my @checks =  @flags.map: -> $k {
            %ingredients{$i}{$k} eq ::{"\$$k"}
        }
        so @checks.all;
    }
    say @filtered;
}
