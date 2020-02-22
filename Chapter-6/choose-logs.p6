#!/usr/bin/env raku

use Term::Choose::Util;

my $file = choose-a-file( :init-dir("/var/log") );
say $file.Str;
