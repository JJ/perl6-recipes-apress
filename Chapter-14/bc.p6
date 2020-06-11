#!/usr/bin/env perl6

sub term:<bcp> { prompt(" " x 6 ~  "← ") }


my $bc = Proc::Async.new: :w, ‘bc’, ‘-l’;
my $next;
my @outputs;

$bc.stdout.tap: -> $res {
    @outputs.append: $res.trim;
    say "[ {@outputs.elems} ] → ", $res;
    get-next($bc);
}

$bc.stderr.tap: {
    say ‘Error in input ’, $_;
    get-next($bc)
}

$next = bcp;
my $promise = $bc.start;
bc-send($bc, $next);
await $promise;

sub bc-send( $bc, Str $str ) {
    $bc.print($str.trim ~ "\n");
}

sub get-next( $bc ){
    my $next = bcp;
    $next.trim;
    if ! $next {
        $bc.close-stdin;
    }
    if $next ~~ /"@" $<output> = (\d*) / {
        my $index = $<output> ne "" ?? $<output> - 1 !! @outputs.elems - 1;
        my $result = @outputs[$index] // 0;
        $next ~~ s/"@"\d*/$result/;
    }
    bc-send($bc, $next);
}