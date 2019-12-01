#!/usr/bin/env raku

use Text::Markdown;

sub MAIN( $dir = '.' ) {
    my @promises = do for tree( $dir ).List.flat -> $f {
        start {
            my @titles;
            with $f.IO.e {
                my $md = parse-markdown($f[0].slurp);
                @titles = $md.document.items
                   .grep( * ~~ Text::Markdown::Heading )
                           .grep( { $_.level == 1 } );
            }
            @titles;
        }
    }

    my @results = await @promises;
    say "Recipes ⇒\n\t", @results.map( *.chomp).join: "\t";

}

sub tree( $dir ) {
    my @files = gather for dir($dir) -> $f {
        if ( $f.IO.f ) {
            take $f
        } else {
            take tree($f);
        }
    }
    return @files;
}
