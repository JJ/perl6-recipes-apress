#!/usr/bin/env raku

use Raku::Recipes;

my %calories-table = calories-table;
my @producst = %calories-table.keys;

my $max-calories = 2000;

sub calories( @diet where !%diet.keys.elems ) { 0 };

sub calories( @diet ) {
}
