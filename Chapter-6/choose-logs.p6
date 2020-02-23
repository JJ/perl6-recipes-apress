#!/usr/bin/env raku

use Term::Choose :choose;
use Term::TablePrint;

my @files = dir( "/var/log" ).grep: *.f;

my $file;
repeat {
    $file = choose( @files.map( *.Str ), :prompt("Choose file or 'q' to exit") );
    my $i;
    my @lined-file = $file.IO.lines.map: ++$i ~ " " ~ *;
    say @lined-file;
} while $file; 
say $file.Str;
