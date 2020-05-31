#!/usr/bin/env perl6
use Redis;

my $redis = Redis.new("127.0.0.1:6379");
$redis.hmset("recipes:banana",
        Calories => 85,
        Unit => "Unit",
        Protein => 1.1,
        Vegan => "Yes",
        Dairy => "No",
        Dessert => "Yes",
        Main => "No",
        Side => "Yes");
say $redis.hgetall("recipes:banana");
$redis.quit();