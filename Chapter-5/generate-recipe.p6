#!/usr/bin/env raku

use YAMLish;
use Raku::Recipes::Roly;
use X::Raku::Recipes;

my $conf = slurp( @*ARGS[0] // "Chapter-5/recipe.yaml" );
my $recipes = Raku::Recipes::Roly.new;

my %conf = load-yaml( $conf );

for <main side> -> $part {
    %conf{$part} // X::Raku::Recipes::MissingPart.new( :$part ).throw();
    X::Raku::Recipes::ProductMissing.new( :product(%conf{$part}) ).throw() if %conf{$part} ∉ $recipes.products;
    X::Raku::Recipes::WrongType.new( :desired-type( $part )).throw() unless $recipes.check-type( %conf{$part}, $part.tc );
    
}

