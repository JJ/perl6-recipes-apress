#!/usr/bin/env perl6


{ $^b > $^a
        ?? &?BLOCK($^a, prompt("> "))
        !! $^b < $^a ?? &?BLOCK($^a, prompt("< ")) !! "✓".say
}((1..6).pick,0)