use X::Raku::Recipes;

class X::Raku::Recipes::Missing::Part is X::Raku::Recipes::Missing {
    submethod BUILD( :$!part="part of meal", :$!name) {}

}

class X::Raku::Recipes::Missing::File is X::Raku::Recipes::Missing {
    submethod BUILD($!part = "file", :$!name){}

}
