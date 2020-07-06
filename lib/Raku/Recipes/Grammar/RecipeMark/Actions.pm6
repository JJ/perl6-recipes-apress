unit class Raku::Recipes::Grammar::RecipeMark::Actions;

method TOP($/) { make $/.made }

method instruction-list( $/ ) {
    my @instructions = gather for $/.hash<numbered-instruction> ->
$instruction {
        take $instruction.made
    }
    make @instructions;
}
method numbered-instruction($/) {
    make $/<numbering>.made => $/<instruction>.made;
}
method numbering($/) { make +$/; }
method instruction($/) { make $/<action-verb>.made => $/<sentence>.made}
method action-verb($/) { make ~$/; }
method sentence($/) { make ~$/; }