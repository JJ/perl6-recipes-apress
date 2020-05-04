#!/usr/bin/env perl6

use Raku::Recipes;
use Markit;
use Template::Classic;

my $template-file = "resources/templates/recipe.html".IO.e
                ??"resources/templates/recipe.html".IO.slurp
                !!%?RESOURCES<templates/recipe.html>.slurp;

my $md = Markdown.new;
my &generate-page := template :($content), $template-file;

for recipes() -> $recipe {
    my $html-fragment = recipe($md,$recipe);
    my @page = generate-page( $html-fragment );
    say @page.eager.join;
}

sub recipe( $md, $recipe ) {
    return  $md.markdown( $recipe.slurp );
}
