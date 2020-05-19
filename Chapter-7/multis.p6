#!/usr/bin/env perl6

use Raku::Recipes;

%calories-table = calories-table();
say %calories-table;

multi sub how-many-calories( Str $description ){
    return samewith( | $description.split(/\s+/))
}

multi sub how-many-calories( Str $quantities, Str $product ) {
    my ($how-much, $unit ) = parse-measure( $quantities );
    return samewith( $how-much, $unit, $product )
}

multi sub how-many-calories( Int $how-much, Str $unit, Str $product ) {
    if %calories-table{$product}<parsed-measures>[1] eq $unit {
        return %calories-table{$product}<Calories> * $how-much
            / %calories-table{$product}<parsed-measures>[0];
    } else {
        fail;
    }
}

sub gimme-calories( $first, $second?, $third?) {
    my ($product, $unit, $how-much);
    if $third {
        ($how-much, $unit, $product) = ($first, $second, $third);
    } elsif $second {
        ($how-much, $unit, $product) = (|parse-measure( $first ), $second);
    } else {
        my @parts = $first.split: /\s+/;
        ($how-much, $unit, $product) = (|parse-measure( @parts[0] ), @parts[1])
    }

    if %calories-table{$product}<parsed-measures>[1] eq $unit {
        return %calories-table{$product}<Calories> * $how-much
                / %calories-table{$product}<parsed-measures>[0];
    } else {
        fail;
    }
}

my @measures = 1000.rand xx 10000;
my @units = <g l liter tablespoon>;
my @first  = @measures X~ @units;
my @food = <Rice Tuna Lentils>;
my @final = @first X~ @food.map: {" $_"};

say @final[^10];

say how-many-calories( "300g Tuna");
say how-many-calories( "300g", "Tuna");
say how-many-calories( 300, "g", "Tuna");

say gimme-calories( "300g Tuna");
say gimme-calories( "300g", "Tuna");
say gimme-calories( 300, "g", "Tuna");
