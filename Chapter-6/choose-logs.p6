#!/usr/bin/env raku

use Term::Choose :choose;

my @dir = dir( "/var/log" );

my $file = choose( @dir.map( *.Str ) );

say $file.Str;
