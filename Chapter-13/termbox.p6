#!/usr/bin/env perl6

use Termbox :ALL;
use Raku::Recipes::SQLator;

my %data = Raku::Recipes::SQLator.new.get-ingredients;

if tb-init() -> $ret {
    note "tb-init() failed with error code $ret";
    exit 1;
}

END tb-shutdown;

my $row = 0;
my @ingredients = %data.keys.sort;
my $max-len = @ingredients.map: { .codes };
my $split = @ingredients.elems / 2;
for %data.keys -> $k {
    for $k.encode.list -> $c {
        state $x;
        my $this-column = (5 + ($row / $split).Int * ($max-len + 5));
        my $this-row = 1 + $row % $split;
        # say  $this-row, " $this-column " ;
        tb-change-cell( $this-column + $x++,
                (1+$this-row % $split).Int,
                        $c,
                        TB_BLACK, TB_WHITE );
    }
    $row++;
}

tb-present;

my $events = Supplier.new;
start {
    while tb-poll-event( my $ev = Termbox::Event.new ) { $events.emit: $ev }
}

react whenever $events.Supply -> $ev {
    given $ev.type {
        when TB_EVENT_KEY {
            given $ev.key {
                when TB_KEY_SPACE {
                    tb-change-cell( 12, 5, "V", TB_GREEN, TB_BLACK );
                }
                when TB_KEY_ESC { done }

            }
        }
    }
}
