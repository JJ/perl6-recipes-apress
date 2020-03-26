use Raku::Recipes;

class X::Raku::Recipes::WrongType is Exception {
    has $!actual-type is required;
    has $!desired-type is required;

    submethod BUILD( :$!actual-type, :$!desired-type) {}

    method message() {
	return "Object seems to be of type $!actual-type while we were expecting $!desired-type";
    }
}

class X::Raku::Recipes::MissingPart is Exception {
    has $!part is required;

    submethod BUILD( :$!part ) {}

    method message() {
	return "An essential part of the meal is missing:  $!part";
    }
}
