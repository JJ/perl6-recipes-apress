#!/usr/bin/env raku

use YAMLish;
use Raku::Recipes::Roly;
use X::Raku::Recipes;

my $conf = slurp( @*ARGS[0] // "Chapter-5/recipe.yaml" );
my $recipes = Raku::Recipes::Roly.new;

my %conf = load-yaml( $conf );

for <main side> -> $part {
    %conf{$part} // X::Raku::Recipes::MissingPart.new( :$part ).throw();
    $recipes.check-type( $conf{$part}, $part )
    // X::Raku::Recipes::WrongType.new(
	:actual-type( $recipes.calories-table(){$conf{$part}} ).throw();
		 
}

