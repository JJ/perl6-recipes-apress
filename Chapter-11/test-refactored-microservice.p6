#!/usr/bin/env perl6

use Cro::HTTP::Test;
use My::Routes;

test-service static-routes, {
    test get('/'),
            status => 200,
            content-type => 'text/html',
            body => /recipes/;
}

test-service type-routes, {
    test get("Dessert"),
        status => 200,
        content-type => "application/json",
        body => /Apple/
}

test-service ingredient-routes, {
    test get("Apple"),
            status => 200,
            content-type => "application/json",
            body => /Vegan/
}

done-testing;