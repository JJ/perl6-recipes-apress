#!/usr/bin/env perl6

use Raku::Recipes;
use Markit;

my $md = Markdown.new;

for recipes() -> $recipe {
    my $html = ~$recipe;
    $html ~~ s/\.md/\.html/;
    $html ~~ s/recipes/build/;
    say $html;
    spurt $html,  $md.markdown( $recipe.slurp );
}
