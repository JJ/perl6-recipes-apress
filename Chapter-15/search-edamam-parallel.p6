#!/usr/bin/env perl6

use Cro::HTTP::Client;
use URI::Encode;
use Raku::Recipes::SQLator;

my $appID = %*ENV{'EDAMAM_APP_ID'};
my $api-key = %*ENV{'EDAMAM_API_KEY'};
my $api-req = "\&app_id=$appID\&app_key=$api-key";

my $dator = Raku::Recipes::SQLator.new;
my $cro = Cro::HTTP::Client.new(base-uri => "https://api.edamam.com/");

my @requests = gather for $dator.get-ingredients.keys -> $ingredient {
    say $ingredient;
    with await $cro.get( "search?q=" ~ uri_encode(lc($ingredient)) ~
            $api-req) {
        take $_;
    };
}

for @requests -> $response {
    say $response.raku;
    my %data = await $response.body;
    say %data<hits>.map( *<recipe><label> ).join: "\n";
}



