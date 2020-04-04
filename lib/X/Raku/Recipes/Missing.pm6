use X::Raku::Recipes;

class X::Raku::Recipes::Missing::Part is X::Raku::Recipes::Missing {
    submethod TWEAK() {
        $!part = "part of meal";
    }

}

class X::Raku::Recipes::Missing::File is X::Raku::Recipes::Missing {
    submethod TWEAK() {
        $!part = "file";
    }

}
