#!/usr/bin/env perl6

use Raku::Recipes;
use Markit;

my $md = Markdown.new;



sub recipe( $md, $recipe ) {
    return  $md.markdown( $recipe.slurp );
}
