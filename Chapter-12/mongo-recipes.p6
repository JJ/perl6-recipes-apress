#!/usr/bin/env perl6

use MongoDB::Client;
use MongoDB::Database;
use BSON::Document;
use Raku::Recipes::Texts;

my $recipes-text = Raku::Recipes::Texts.new();

my MongoDB::Client $client .= new(:uri('mongodb://'));
my MongoDB::Database $database = $client.database('recipes');

my @documents;
for $recipes-text.recipes.kv -> $title, %data {
    say "Creating $title ", %data.raku;
    %data<title> = $title;
    @documents.append: BSON::Document.new((|%data)),
}

say "Inserting docs";
my BSON::Document $req .= new: (
insert => 'recipes',
documents => @documents
);
my BSON::Document $doc = $database.run-command($req);
say $doc.raku;
if $doc<ok> {
    say "Docs inserted";
}