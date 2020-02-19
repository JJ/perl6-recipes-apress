#!/usr/bin/env raku

say "/var/log/syslog".IO.lines.grep: /"-WARNING **"/;
