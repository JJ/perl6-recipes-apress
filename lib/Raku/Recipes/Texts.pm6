use Raku::Recipes;
use Text::Markdown;
use Markit;
use Template::Classic;

unit class Raku::Recipes::Texts;

has %.recipes;

method new( $dir where .IO.d  = "recipes") {
    my %recipes;
    for recipes( $dir ) -> $r {
        my $this-md = parse-markdown-from-file($r.path);
        my $title = $this-md.document.items[0].text;
        my $description = $this-md.document.items[1].items.join;
        my @ingredients = $this-md.document.items
            .grep( Text::Markdown::List )
            .grep( !*.numbered )
            .map( *[0].items);
        %recipes{$title} = { description => $description,
                             ingredients => @ingredients,
                             path => $r.path }

        }
    self.bless( :%recipes );

}