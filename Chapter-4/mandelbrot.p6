#!/usr/bin/env raku

sub mandelbrot( Complex $c --> Seq ) {
    say $c;
    0, *²+$c ... *.abs > 2;
}

my @mandelbrot[201;201];
for -100..100 X -100..100 -> ( $re, $im ) {
    my $mandel-seq := mandelbrot( Complex.new( $re/100, $im/100 ) );
    with $mandel-seq[100] {
        @mandelbrot[100+$re;100+$im] = '■';
    } else {
        @mandelbrot[100+$re;100+$im] = chr( 0x25A1 + $mandel-seq.elems/10 );
    }
}
say @mandelbrot;
