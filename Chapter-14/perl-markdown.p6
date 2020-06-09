#!/usr/bin/env perl6

use Inline::Perl5;

use Markdent::Handler::CaptureEvents:from<Perl5>;
use Markdent::Parser:from<Perl5>;

my $handler = Markdent::Handler::CaptureEvents.new();

my $parser = Markdent::Parser.new( { handler => $handler } );

$parser.parse( markdown => '# Here we go' );

say $handler.captured_events;