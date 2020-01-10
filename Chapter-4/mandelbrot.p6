#!/usr/bin/env raku

sub mandelbrot( Complex $c --> Seq ) {
    0, *²+$c ... *.abs > 2;
}

my @mandelbrot[81;81];
for -40..40 X -40..40 -> ( $re, $im ) {
    my $mandel-seq := mandelbrot( Complex.new( $re/40, $im/40 ) );
    with $mandel-seq[100] {
        @mandelbrot[40+$re;40+$im] = '■';
    } else {
        @mandelbrot[40+$re;40+$im] = chr( 0x25A1 + $mandel-seq.elems/10 );
    }
}
print-shaped(@mandelbrot);


sub print-shaped( @array where @array.shape.elems == 2  ) {
    my @shape = @array.shape;
    for ^@shape[0] -> $i {
        my $row;
        for ^@shape[1] -> $j {
            $row ~= @array[$i;$j];
        }
        $row.say;
    }
}

