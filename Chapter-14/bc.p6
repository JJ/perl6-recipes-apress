#!/usr/bin/env perl6

sub term:<bcp> { prompt(" " x 6 ~  "← ") }


my $bc = Proc::Async.new: :w, ‘bc’, ‘-l’;
my $next;
my @outputs;

$bc.stdout.tap: -> $res {
    @outputs.append: $res;
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
    if ! $next {
        $bc.close-stdin;
    }
    bc-send($bc, $next);
}