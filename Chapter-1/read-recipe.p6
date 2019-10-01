#!/usr/bin/env perl6

use Text::Markdown;

sub MAIN( $file ) {
    with $file.IO.e {
        my $md = parse-markdown-from-file($file);
        say "Recipes: "
                for $md.document.items
                .grep( * ~~ Text::Markdown::Heading )
                .grep( { $_.level == 1 } );
    }
}
