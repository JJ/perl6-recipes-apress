use RecipeMark::Grammar;
use RecipeMark::Grammar::Actions;

use JSON::Fast;

unit class RecipeMark;
has Str $.title;
has Str $.description;
has UInt $.persons;
has UInt $.preparation-minutes;
has %.ingredient-list;
has @.instruction-list;

method new( $file where .IO.e) {
    my %temp = RecipeMark::Grammar.parse(
            $file.IO.slurp,
            actions => RecipeMark::Grammar::Actions.new
            ).made;
    self.bless(| %temp );
}

method to-json() {
    return to-json self.Hash ;
}

method Hash() {
    return { title => $!title,
             description => $!description,
             persons => $!persons,
             preparation-minutes => $!preparation-minutes,
             ingredient-list => %!ingredient-list,
             instruction-list => @!instruction-list
    }
}