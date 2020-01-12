#!/usr/bin/env raku

use Raku::Recipes;

my %calories-table = calories-table;
my @products = %calories-table.keys;
my @recipes;
my $max-calories = 2000;

multi sub proteins( 0 ) { 0 };

multi sub proteins( $index, $weight ) {
    say "I $index W $weight";
    if %calories-table{@products[$index]}<Calories> > $weight {
        say "Big stuff";
        return proteins( $index - 1, $weight );
    } else {
        say "Not so big";
        my $lhs = proteins( $index - 1, $weight );
        my $rhs = %calories-table{@products[$index]}<Protein>
        + proteins( $index - 1,
                    $weight -  %calories-table{@products[$index]}<Calories> );
        say "L $lhs R $rhs";
        return max( $lhs, $rhs);
    }
}

say proteins( @products.elems -1 , $max-calories );




