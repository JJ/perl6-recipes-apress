#!/usr/bin/env raku

use Raku::Recipes::Classy;

multi sub MAIN() {
    say Raku::Recipes::Classy.new.products;
}

multi sub MAIN( Bool :$Dairy, Bool :$Vegan, Bool :$Main, Bool :$Side, Bool :$Dessert ) {
    say Raku::Recipes::Classy.new.filter-ingredients( :$Dairy, :$Vegan, :$Main,  :$Side,  :$Dessert );
}

multi sub MAIN(Bool :$Dairy, Bool :$Vegan, Bool :$Main,
	       Bool :$Side, Bool :$Dessert,
	       Int :$min-proteins) {
    my $rr =  Raku::Recipes::Classy.new;
    my @filtered = $rr.filter-ingredients( :$Dairy, :$Vegan, :$Main,  :$Side,  :$Dessert );
    my %ingredients = $rr.calories-table;
    say @filtered.grep: { %ingredients{$_}<Protein> > $min-proteins };
}
