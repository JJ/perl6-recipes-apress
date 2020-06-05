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
for @ingredients -> $k {
    my $this-row = (1 + $row % $split).Int;
    my $this-column = (2 + ($row / $split).Int * ($max-len + 5));
    print-string( "[ ]", $this-column, $this-row, TB_BLACK, TB_BLUE );
    print-string( $k , $this-column + 4, $this-row, TB_BLACK, TB_WHITE );
    $row++;
}
tb-change-cell( 0, 1, ">".ord, TB_YELLOW, TB_RED );

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

subset RowOrColumn of Int where * >= 1;

sub print-string( Str $str, RowOrColumn $column,
                  RowOrColumn $row,
                  $fgcolor,
                  $bgcolor  ) {
    for $str.encode.list -> $c  {
        state $x;
        tb-change-cell( $column + $x++,
                $row,
                $c,
                $bgcolor, $fgcolor );
    }
}