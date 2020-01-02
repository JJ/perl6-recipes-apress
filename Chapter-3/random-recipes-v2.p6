#!/usr/bin/env raku

use Raku::Recipes;

my %calories-table = calories-table;

my @main-course = %calories-table.keys.grep: { %calories-table{$_}<Main> eq 'Yes' };
my @side-dish   = %calories-table.keys.grep: { %calories-table{$_}<Side> eq 'Yes' };

with (@main-course X @side-dish).map( *.unique ).grep( *.elems > 1 ).pick {
    say "Your recipe → @_[0] with @_[1] on the side"
}
