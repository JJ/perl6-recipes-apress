#!/usr/bin/env perl6

use Cro::HTTP::Test;
require "ingredients-microservice-v3.p6";

say ::("ingredients-microservice-v3.p6");

my &static-routes-for-testing = ::("ingredients-microservice-v3.p6::TEST::EXPORT::DEFAULT:&static-routes");

test-service static-routes-for-testing, {
    test get('/content/'),
            status => 200,
            content-type => 'text/HTML',
            body => /recipes/;
}

done-testing;