#!/usr/bin/env perl6

my $bc = Proc::Async.new: :w, ‘bc’, ‘-l’;
my $next;
$bc.stdout.tap: -> $res {
    say ‘line: ’, $res;
    $next = prompt("Next ");
    if ! $next {
        $bc.close-stdin;
    }
    $bc.print($next.trim ~ "\n");
}

$next = prompt("Next ");
my $promise = $bc.start;
$bc.print($next.trim ~ "\n");
await $promise;