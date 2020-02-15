#!/usr/bin/env perl6


use Sys::Lastlog;

for Sys::Lastlog.new().list.grep: *.entry.time > 0 -> $e {
    say $e.user.username;
}

