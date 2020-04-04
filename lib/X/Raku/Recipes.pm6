use Raku::Recipes;

class X::Raku::Recipes::WrongType is Exception {
    has $!desired-type is required;

    submethod BUILD( :$!desired-type) {}

    method message() {
	    return "Object does not seem to be $!desired-type";
    }
}

class X::Raku::Recipes::ProductMissing is Exception {
    has $!product is required;

    submethod BUILD( :$!product) {}

    method message() {
	    return "We don't seem to have information about  $!product";
    }
}

class X::Raku::Recipes::Missing is Exception {
    has $!part is required;
    has $!name is required;

    submethod BUILD( :$!part, :$!name ) {}

    method message() {
        return "the $!part $!name seems to be missing. Please provide it";
    }
}
