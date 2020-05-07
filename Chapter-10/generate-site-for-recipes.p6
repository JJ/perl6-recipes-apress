#!/usr/bin/env perl6

use Raku::Recipes;
use Markit;
use Template::Classic;
use Text::Markdown;

my $template-name="templates/recipe-with-title.html";
my $template-file = "resources/$template-name".IO.e
        ??"resources/$template-name".IO.slurp
        !!%?RESOURCES{$template-name}.slurp;

my $md = Markdown.new;
my &generate-page := template :($title,$content), $template-file;

for recipes() -> $recipe {
    my $this-md = parse-markdown-from-file($recipe.path);
    my $html-fragment = recipe($md,$recipe);
    note "Can't find title for $recipe" unless $this-md.document.items[0].text;
    my @page = generate-page( $this-md.document.items[0].text, $html-fragment );
    spurt-with-dir($recipe, @page.eager.join );
}

sub recipe( $md, $recipe ) {
    return  $md.markdown( $recipe.slurp );
}

sub spurt-with-dir( $file-path, $content ) {
    my $html-path-name = ~$file-path;
    $html-path-name ~~ s/\.md/\.html/;
    $html-path-name ~~ s/recipes/build/;
    my $html-path = IO::Path.new($html-path-name);
    my $html-dir = $html-path.dirname.IO;
    $html-dir.mkdir unless $html-dir.d;
    spurt $html-path-name,  $content;

}
