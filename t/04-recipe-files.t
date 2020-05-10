use Test; # -*- mode: perl6 -*-

use Raku::Recipes::Texts;

my $recipes-text = Raku::Recipes::Texts.new();

subtest "Test basic load", {
    ok( $recipes-text.recipes, "Loads recipes");
    #ok( "Buckwheat pudding" )
    say $recipes-text.recipes.raku;
}
done-testing;
