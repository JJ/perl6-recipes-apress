#!/usr/bin/env perl6

use Wikidata::API;

my $query = "Chapter-12/ingredients.sparql".IO.slurp;

my $ingredients= query($query);

say "Ingredients:\n",
        $ingredients<results><bindings>
            .map: { tc utf8y( $_<itemLabel><value>) };

sub utf8y ( $str ) {
    Buf.new( $str.ords ).decode("utf8")
}