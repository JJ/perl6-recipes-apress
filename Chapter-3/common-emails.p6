#!/usr/bin/env raku

say [∩] do for dir( @*ARGS[0] // "emails", test => /txt$/ ) -> $f {
	$f.slurp.lines;
}

