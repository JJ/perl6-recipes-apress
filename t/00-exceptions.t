use Test; # -*- mode: perl6 -*-
use X::Raku::Recipes;

my $x =  X::Raku::Recipes::WrongType.new( desired-type => "Main" );
isa-ok $x, X::Raku::Recipes::WrongType, "Type OK";
throws-like { $x.throw },  X::Raku::Recipes::WrongType, message => /Main/,  "Throws OK";

$x =  X::Raku::Recipes::Missing.new( part => "course", name => "main" );
isa-ok $x, X::Raku::Recipes::Missing, "Type OK";
throws-like { $x.throw },  X::Raku::Recipes::Missing, message => /course/,  "Throws OK";

$x =  X::Raku::Recipes::ProductMissing.new( product => "Fish tails" );
isa-ok $x, X::Raku::Recipes::ProductMissing, "Type OK";
throws-like { $x.throw },  X::Raku::Recipes::ProductMissing, message => /information/,  "Throws OK";


done-testing;
