#!/usr/bin/env perl6
use Redis;

my $redis = Redis.new("127.0.0.1:6379");
$redis.set("key", "value");
say $redis.get("key");
say $redis.info();
$redis.quit();