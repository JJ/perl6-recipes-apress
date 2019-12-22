#!/usr/bin/env raku

say [∩] do .slurp.lines for dir( @*ARGS[0] // "emails", test => /txt$/ );

