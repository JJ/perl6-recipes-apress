use Test;
use Raku::Recipes::Grammar::RecipeMark;
use Grammar::Tracer;

my $str = q:to{EOC};
# Tuna risotto

A relatively simple version of this rich, creamy dish of Italian origin.
EOC

my $rm = Raku::Recipes::Grammar::RecipeMark.new;
subtest "Subparse", {
    my $description = "A relatively simple version of this rich, creamy dish of
Italian origin.";
    is $rm.subparse($description, rule => "description" ), $description,
            "Description subparsing working";
    my $title = "Boiled fishtails";
    is $rm.subparse($title, rule => "title" ), $title,
            "Title subparsing working";
}

subtest "Parse", {
    ok $rm.parse( $str ), "Whole parsing works";
}
done-testing;
