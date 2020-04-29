#!/usr/bin/env perl6

use Raku::Recipes;
use Markit;

my $md = Markdown.new;

for recipes() -> $recipe {
    say $md.markdown( $recipe.slurp );
}
