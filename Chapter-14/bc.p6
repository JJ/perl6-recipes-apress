#!/usr/bin/env perl6

my $bc = Proc::Async.new: :w, ‘bc’, ‘-l’;

my $promise = $bc.start;

await $bc.print("3+2\n");

$bc.close-stdin;
await $promise;