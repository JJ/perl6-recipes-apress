#!/usr/bin/env perl6


my $number = 6.rand.Int;
my $prompt = "*";
say $number;
while ( my $guess = prompt("$prompt Your guess>") ) ne "" {
    if $guess == $number { last }
    elsif $guess < $number { $prompt = "<" }
    else { $prompt = ">" }
}