use Raku::Recipes;

class X::Raku::Recipes::WrongType:api<1> is Exception {
    has $!desired-type is required;

    submethod BUILD( :$!desired-type) {}

    method message() {
	    return "Object does not seem to be of type $!desired-type";
    }
}

class X::Raku::Recipes::Missing:api<1> is Exception {
    has $!part is required;
    has $!name is required;

    submethod BUILD( :$!part, :$!name ) {}

    method message() {
        return "the $!part $!name seems to be missing. Please provide it";
    }
}
