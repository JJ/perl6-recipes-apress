use Raku::Recipes;

class X::Raku::Recipes::WrongType:api<0> is Exception {
    has $!desired-type is required;

    submethod BUILD( :$!desired-type) {}

    method message() {
	    return "Object does not seem to be $!desired-type";
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
