use Raku::Recipes;

class X::Raku::Recipes::WrongType:api<1> is Exception {
    has $!desired-type is required;
    has $!product;

    submethod BUILD(:$!desired-type,
                    :$!product = "Object") {}

    method message() {
	    return "$!product does not seem to be of type $!desired-type";
    }
}

class X::Raku::Recipes::WrongUnit:api<1> is Exception {
    has $!desired-unit is required;
    has $!unit;

    submethod BUILD(:$!desired-unit,
                    :$!unit) {}

    method message() {
        return "$!unit does not match the product, should be $!desired-unit";
    }
}

role X::Raku::Recipes::Missing:api<1> is Exception {
    has $!part is required;
    has $!name is required;

    submethod BUILD( :$!part, :$!name ) {}

    method message() {
        return "the $!part $!name seems to be missing. Please provide it";
    }

    method gist(X::Raku::Recipes::Missing:D: ) {
        self.message()
    }

}
