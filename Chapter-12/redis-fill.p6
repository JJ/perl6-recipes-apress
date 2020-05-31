#!/usr/bin/env perl6
use Redis;
use Raku::Recipes::Redisator;
use Raku::Recipes::SQLator;

my %data = Raku::Recipes::SQLator.new.get-ingredients;
my $redisr = Raku::Recipes::Redisator.new;

for %data.kv -> $ingredient, %data {
    say $ingredient, "⇒", %data;
    $redisr.insert-ingredient($ingredient,%data);
    say $redisr.get-ingredients;
}

say $redisr.get-ingredients;