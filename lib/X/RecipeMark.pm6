unit module X::RecipeMark;

role Base is Exception {
    has $.pos;
    submethod BUILD( :$!pos ) {}
}

class OutOfOrder does Base {
    has $.number;
    has $.last;

    submethod BUILD( :$!pos, :$!number, :$!last ) {}

    multi method message () {
        "Found instruction number $!number while waiting for number > $.last "
    }
}

class RepeatedIngredient does Base {
    has $.name;

    submethod BUILD( :$!pos, :$!name ) {}

    multi method message () {
        "Ingredient $!name appears twice in position $!pos "
    }

}