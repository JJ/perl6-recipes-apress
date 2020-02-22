#!/usr/bin/env raku

use Term::Choose :choose;

my @dir = dir( "/var/log" );

my $file;
repeat {
    $file = choose( @dir.map( *.Str ), :choice-prompt("Choose file or 'q' to exit") );
} while $file; 
say $file.Str;
