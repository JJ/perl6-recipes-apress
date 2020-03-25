class X::Recipes::WrongType is Exception {
    method message(Exception:D:, Str $actual-type, Str $desired-type--> Str:D) {
	return "Object seems to be of type $actual-type while we were expecting $desired-type";
    }
	
	
}
