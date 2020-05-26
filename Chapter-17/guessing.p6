#!/usr/bin/env perl6

while ( my $g = prompt(" Your guess> ") ) != ( my $n = 1+5.rand.Int ) { ($g > $n ?? ">" !! "<").print ; }