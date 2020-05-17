unit module Raku::Recipes::Grammar::Actions;

class Measured-Ingredients {
    method TOP($/) {
        my $unit = $/<unit>.made // "Unit";
        make $/<ingredient>.made =>  $unit => $/<quantity>.made
    }
    method ingredient($/) {
        make tc ~$/;
    }
    method quantity($/) {
        make +val( ~$/  ) // unival( ~$/ )
    }
    method unit($/){
        make ~$/;
    }

}