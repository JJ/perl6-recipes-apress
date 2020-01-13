#!/usr/bin/env raku

use Math::Matrix;

my Math::Matrix $m .= new( (1..9).rotor(3 ) );
say $m;

