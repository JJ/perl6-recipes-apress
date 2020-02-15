#!/usr/bin/env perl6


use Sys::Lastlog;
say Sys::Lastlog.new().list.map( .has-logged-in );

