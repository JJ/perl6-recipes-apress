#!/usr/bin/env perl6

use Inline::Perl5;

use MealMaster:from<Perl5>;

my $parser = MealMaster.new();
my @recipes = $parser.parse("Chapter-14/apetizer.mmf");
for @recipes -> $r {
   say $r.title;
    for $r.ingredients {
        say "→ ", .product;
    }
}
