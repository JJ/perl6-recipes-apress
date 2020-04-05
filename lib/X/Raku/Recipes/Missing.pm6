use X::Raku::Recipes;

class X::Raku::Recipes::Missing::Part does X::Raku::Recipes::Missing {
    submethod BUILD( :$!part="part of meal", :$!name) {}

}

class X::Raku::Recipes::Missing::File does X::Raku::Recipes::Missing {
    submethod BUILD($!part = "file", :$!name){}

}


class X::Raku::Recipes::Missing::Product does X::Raku::Recipes::Missing {
    submethod BUILD($!part = "product", :$!name){}

}