#!/usr/bin/env perl6

use Cro::HTTP::Test;
use My::Routes;

test-service static-routes, {
    test get('/'),
            status => 200,
            content-type => 'text/html',
            body => /recipes/;
}

done-testing;