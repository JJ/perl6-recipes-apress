use Test; # -*- mode: perl6 -*-

use Raku::Recipes::Grammar::Measured-Ingredients;
use Raku::Recipes::Grammar::Actions;

subtest "Test items", {
    my $item = Raku::Recipes::Grammar::Measured-Ingredients.parse("2 egg",
            actions =>
            Raku::Recipes::Grammar::Actions::Measured-Ingredients.new);

    say $item.made;
    $item = Raku::Recipes::Grammar::Measured-Ingredients.parse("150g Tuna");
    is( $item, "150g Tuna", "Parses item");
    is( +$item<quantity>, 150, "Parses number OK");
    is( $item<unit>, "g", "Parses unit OK");
    is( $item<ingredient>, "Tuna", "Parses ingredient OK");

}
done-testing;
