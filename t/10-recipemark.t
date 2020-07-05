use Test;
use Raku::Recipes::Grammar::RecipeMark;
use Grammar::Tracer;

my $str = q:to{EOC};
# Tuna risotto

A relatively simple version of this rich, creamy dish of Italian origin.

## Ingredients (for 4 persons)

## Preparation (75m)

1. Slightly-fry tuna with its own oil it until it browns a bit, you can
 do this while you start doing the rest, save a bit of oil for the rice.
1. Stir-fry garlic until golden-colored, chopped if you so like, retire if
 you don't like the color.
2. Add finely-chopped onion, and stir-fly until transparent.
3. Add rice and stir-fry until grains become transparent in the tips.
4. Add wine or beer and stir until it's absorbed by grains.
5. Repeat several times: add fish broth, stir, until water is evaporated, until rice is soft but a bit chewy.
6. Add tuna, butter, grated cheese, and turn heating off, removing until
 creamy.
7. Rest for 5 minutes before serving.
EOC

my $rm = Raku::Recipes::Grammar::RecipeMark.new;
subtest "Subparse", {
    my $description = "A relatively simple version of this rich, creamy dish of
Italian origin.";
    is $rm.subparse($description, rule => "sentence" ), $description,
            "Sentence subparsing working";
    is $rm.subparse($description, rule => "description" ), $description,
            "Description subparsing working";
    my $title = "Boiled fishtails";
    is $rm.subparse($title, rule => "title" ), $title,
            "Title subparsing working";

    my $verb = "Stir-fry";
    is $rm.subparse($verb, rule => "action-verb" ), $verb,
            "Verb subparsing working";

    my $instruction = "$verb garlic until golden-colored, chopped if you so like, retire if you don't like the color.";
    for substr($instruction, 0, *-1).split: / ","?\h+ / -> $w {
        is $rm.subparse( $w, rule => "words" ), $w, "Parsing $w";
    }
    my $match= $rm.subparse( $instruction, rule=> "instruction");
    is $match, $instruction, "Instruction parsing";
    is $match<action-verb>, $verb, "Sub-instruction parsing";

    my $numbered-instruction = "2. $instruction";
    $match = $rm.subparse( $numbered-instruction, rule =>
    'numbered-instruction');
    is $match, $numbered-instruction, "Parsing numbered instructions";
    is $match<numbering>, "2", "Numbering";

    my $instructions = q:to/EOC/.chomp;
1. Slightly-fry tuna with its own oil it until it browns a bit, you can
 do this while you start doing the rest, save a bit of oil for the rice.
1. Stir-fry garlic until golden-colored, chopped if you so like, retire if
 you don't like the color.
2. Add finely-chopped onion, and stir-fly until transparent.
3. Add rice and stir-fry until grains become transparent in the tips.
4. Add wine or beer and stir until it's absorbed by grains.
EOC

    $match = $rm.subparse( $instructions, rule => 'instruction-list');
    is $match, $instructions, "Instruction list";

    $match = check-rule( $rm, "* ½ onion", "itemized-ingredient" );


}

subtest "Parse", {
    ok $rm.parse( $str.chomp ), "Whole parsing works";
}
done-testing;

#| Several checks for rules
sub check-rule(  Raku::Recipes::Grammar::RecipeMark $rm,
                 Str $str, $rule ) {
    my $match = $rm.subparse( $str, rule => $rule );
    ok( $match, "Checking $rule");
    is( $match, $str, "Parsing with $rule correct");
    return  $match;
}