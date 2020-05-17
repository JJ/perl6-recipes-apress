unit module Raku::Recipes::Grammar::Actions;

class Measured-Ingredients {
    method TOP($/) {
        make $/<ingredient>.made =>  $/<unit>.made => $/<quantity>.made
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