#!/usr/bin/env raku

use Text::Markdown;

sub MAIN( $dir = '.' ) {
    my @promises = do for tree( $dir ) -> $f {
	start {
	    my @titles;
	    with $f.IO.e {
		my $md = parse-markdown-from-file($f);
		@titles = $md.document.items
		   .grep( * ~~ Text::Markdown::Heading )
                   .grep( { $_.level == 1 } );
	    }
	    @titles;
	}
    }
    say @promises;
	

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
