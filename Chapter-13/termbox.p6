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
my $ingredient-index = 0;
my @ingredients = %data.keys.sort;
my $max-len = @ingredients.map: { .codes };
my $split = @ingredients.elems / 2;
for @ingredients -> $k {
    my ($this-column,$this-row )  = ingredient-to-coords( $row );
    print-string( "[ ]", $this-column + 1 , $this-row, TB_BLACK, TB_BLUE );
    print-string( $k , $this-column + 5, $this-row, TB_BLACK, TB_WHITE );
    $row++;
}
draw-cursor($ingredient-index);
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
                    $ingredient-index =
                            ($ingredient-index+1) % @ingredients.elems;
                    my ( $this_column, $this_row ) = ingredient-to-coords
                            ($ingredient-index);
                    draw-cursor( $ingredient-index );
                    tb-present;
                }
                when TB_KEY_ESC { done }

            }
        }
    }
}

subset RowOrColumn of Int where * >= 1;

sub draw-cursor( $ingredient-index ) {
    my ($cursor_c, $cursor_r) = ingredient-to-coords( $ingredient-index);
    tb-change-cell( $cursor_c, $cursor_r, ">".ord, TB_YELLOW, TB_RED );

}
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

sub ingredient-to-coords( UInt $ingredient-index) {
    return 1 + ($ingredient-index / $split).Int * ($max-len + 5),
            (1 + $ingredient-index % $split).Int;
}