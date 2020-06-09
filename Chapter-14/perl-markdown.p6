#!/usr/bin/env perl6

use Inline::Perl5;

use Text::Markdown:from<Perl5>;

my $tm = Text::Markdown.new;

say $tm.markdown('# HELLO');