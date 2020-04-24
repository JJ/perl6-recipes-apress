#!/usr/bin/env raku

use Raku::Recipes::Roly;
use X::Raku::Recipes;
use X::Raku::Recipes::Missing;

my $rrr = Raku::Recipes::Roly.new();
my $main = @*ARGS[0] // "Chickpeas";
my $side = @*ARGS[1] // "Rice";
my $calories;

try {
    $calories = $rrr.calories-for( main => $main => 200,
                                   side => $side => 250 );
    CATCH {
       when X::Raku::Recipes::Missing::Product {
            given .message {
                when /$main/ { $main = "Pasta" }
                when /$side/ { $side = "Potatoes" }
            }
            $calories = $rrr.calories-for( main => $main => 200,
                    side => $side => 250 );
        }
        when X::Raku::Recipes::WrongType {
            given .message {
                when /Main/ { $main = "Chickpeas" }
                when /Side/ { $side = "Rice" }
            }
            $calories = $rrr.calories-for( main => $main => 200,
                    side => $side => 250 );
        }
       default {
           die "There's something wrong with ingredients, I can't generate
that";
       }
    }
}

say "Calories for a main dish of $main and side of $side are $calories";