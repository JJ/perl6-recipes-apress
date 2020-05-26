#!/usr/bin/env perl6


my $number = 1+5.rand.Int;
my $prompt = "*";
while ( my $guess = prompt("$prompt Your guess>") ) != $number {
    $prompt = $guess > $number ?? ">" !! "<";
}