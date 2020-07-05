use Test;
use Raku::Recipes::Grammar::RecipeMark;
use Grammar::Tracer;

my $str = q:to{EOC};
# Tuna risotto

A relatively simple version of this rich, creamy dish of Italian origin.

## Ingredients (for 4 persons)

## Preparation (75m)

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
    is $match<action-verb>, $verb, "Sub-instruction parsint";

}

subtest "Parse", {
    ok $rm.parse( $str ), "Whole parsing works";
}
done-testing;
