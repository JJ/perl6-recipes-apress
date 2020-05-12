#!/usr/bin/env perl6

use Cro::HTTP::Server;
use Cro::HTTP::Router;
use Raku::Recipes::Roly;
use Raku::Recipes;

my $rrr = Raku::Recipes::Roly.new();

sub static-routes {
    route {
        get -> *@path {
            static 'build/', @path, :indexes<index.html index.htm>;
        }
    }

}

my $recipes = route {
    include "content" => static-routes;
    get -> "Type", Str $type where $type ∈ @food-types {
        my %ingredients-table = $rrr.calories-table;
        my @result =  %ingredients-table.keys.grep: {
            %ingredients-table{$_}{$type} };
        content 'application/json', @result;
    }

    get -> "Ingredient", Str $ingredient where $rrr.is-ingredient($ingredient) {
        content 'application/json', $rrr.calories-table{$ingredient};
    }
    get -> "Ingredient",
           Str $ingredient where !$rrr.is-ingredient($ingredient) {
        not-found;
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