#!/usr/bin/env perl6

use MongoDB::Client;
use MongoDB::Database;
use BSON::Document;

my MongoDB::Client $client .= new(:uri('mongodb://'));
my MongoDB::Database $database = $client.database('myPetProject');
# Inserting data
my BSON::Document $req .= new: (
insert => 'famous-people',
documents => [
BSON::Document.new((
name => 'Larry',
surname => 'Wall',
)),
]
);
my BSON::Document $doc = $database.run-command($req);
if $doc<ok> {
    say "Pffoei, inserted";
}