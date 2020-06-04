#!/usr/bin/env perl6

use Termbox :ALL;

if tb-init() -> $ret {
    note "tb-init() failed with error code $ret";
    exit 1;
}

END tb-shutdown;

for "Press ESC to exit!".encode.list -> $c {
    state $x = 5;
    tb-change-cell( $x++, 5, $c, TB_BLACK, TB_WHITE );
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
                when TB_KEY_ESC { done }
            }
        }
    }
}
