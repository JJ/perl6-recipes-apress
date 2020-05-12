use Test; # -*- mode: perl6 -*-

use Raku::Recipes::Texts;

my $recipes-text = Raku::Recipes::Texts.new();

subtest "Test basic load", {
    my %recipes = $recipes-text.recipes;
    ok( %recipes, "Loads recipes");
    ok( "Buckwheat pudding" ∈ %recipes.keys,
            "We have buckwheat pudding");
    ok( %recipes{"Buckwheat pudding"},
            "Includes key «$_»" ) for <description ingredients>;
}
done-testing;