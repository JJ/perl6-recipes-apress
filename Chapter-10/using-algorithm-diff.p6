#!/usr/bin/env raku

use Algorithm::Diff;


constant $prefix = "recipes/main/rice/";
for sdiff( "$prefix/tuna-risotto.md".IO.lines, "$prefix/tuna-risotto-low-cost.md".IO.lines).rotor(3) -> @diff {
    say qq:to/EO/ unless @diff[0] eq 'u';
# @diff[0]
    ← @diff[1]
    → @diff[2]
EO 

};

