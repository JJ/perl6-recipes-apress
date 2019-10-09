#!/usr/bin/env perl6

use v6;

class Recipes {
    has $.folder;
    has $!is-win = $*DISTRO.is-win;

    multi method show( $self where .is-win: ) {
        shell "dir {$self.folder}";
    }

    multi method show( $self: ) {
         shell "ls {$self.folder}";
    }
}

Recipes.new(folder => "recipes").show
