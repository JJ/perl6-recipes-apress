unit class Raku::Recipes::Grammar::RecipeMark::Actions;

method TOP($/) { say $/.made; make $/.made }

method numbered-instruction($/) {
    say $/;
    make $/<numbering>.made => $/<instruction>.made;
}
method numbering($/) { make +$/; }
method instruction($/) { make $/<action-verb>.made => $/<sentence>.made}
method action-verb($/) { make ~$/; }
method sentence($/) { say $/; make ~$/; }