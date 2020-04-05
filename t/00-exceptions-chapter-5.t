use Test; # -*- mode: perl6 -*-
use X::Raku::Chapter5::Recipes;


throws-like { X::Raku::Recipes::WrongType.new( desired-type => "Main" ) },
        X::Obsolete, message => /api/,  "Obsolete OK";

my $x =  X::Raku::Recipes::MissingPart.new( part => "course", name => "main" );
isa-ok $x, X::Raku::Recipes::MissingPart, "Type OK";
throws-like { $x.throw },  X::Raku::Recipes::MissingPart, message => /course/,  "Throws OK";

$x =  X::Raku::Recipes::ProductMissing.new( product => "Fish tails" );
isa-ok $x, X::Raku::Recipes::ProductMissing, "Type OK";
throws-like { $x.throw },  X::Raku::Recipes::ProductMissing, message => /information/,  "Throws OK";


done-testing;
