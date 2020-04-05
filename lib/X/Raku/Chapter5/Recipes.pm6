use Raku::Recipes;

class X::Raku::Recipes::WrongType:api<0> {

    submethod BUILD() {
        X::Obsolete.new(old => "X::Raku::Recipes::WrongType:api<0>",
                    replacement => "X::Raku::Recipes::WrongType:api<1> in
Raku::Recipes",
                when => "using Raku::Recipes"
                    ).throw;
    }
}

class X::Raku::Recipes::ProductMissing:api<0> is Exception {
    has $!product is required;

    submethod BUILD( :$!product) {}

    method message() {
	    return "We don't seem to have information about  $!product";
    }
}

class X::Raku::Recipes::MissingPart:api<0> is Exception {
    has $!part is required;

    submethod BUILD( :$!part ) {}

    method message() {
        return "An essential part of the meal is missing:  $!part";
    }
}
