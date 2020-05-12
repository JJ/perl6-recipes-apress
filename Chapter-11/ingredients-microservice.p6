#!/usr/bin/env perl6

use Cro::HTTP::Server;
use Cro::HTTP::Router;

my $recipes = route {
    get -> {
        content 'text/html', 'Hello World!';
    }
}

my Cro::Service $μservice = Cro::HTTP::Server.new(
        :host('localhost'), :port(31415), application => $recipes
);

$μservice.start;

react whenever signal(SIGINT) {
    $μservice.stop;
    exit;
}