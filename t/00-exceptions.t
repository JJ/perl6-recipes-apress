use Test; # -*- mode: perl6 -*-
use X::Raku::Recipes;

my $x =  X::Raku::Recipes::WrongType.new( actual-type => "Dessert",
					  desired-type => "Main" );

isa-ok $x, X::Raku::Recipes::WrongType, "Type OK";

throws-like { $x.throw },  X::Raku::Recipes::WrongType, message => /Dessert/,  "Throws OK";

done-testing;
