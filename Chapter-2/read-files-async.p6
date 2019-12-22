#!/usr/bin/env perl6

use v6;

sub MAIN( $dir = '.' ) {
    my $supply = supply tree-emit( $dir );
    say "Now let's rock";
    my @titles = gather {
	$supply.tap( -> $f { take $f.IO.slurp.lines.head } )
    };
    say "Recipes ⇒\n", @titles.join("\n");
    
}

sub tree-emit( $dir ) {
    for dir($dir) -> $f {
        if ( $f.IO.f ) {
            say "Let's emit $f";
	    emit $f
        } else {
	    tree-emit($f);
        }
    }
}
