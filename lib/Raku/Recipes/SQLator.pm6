=begin pod

=head1 NAME

Raku::Recipes::SQLator - Uses SQLite or other relational database to store and
retrieve data

=head1 SYNOPSIS

=begin code
use Raku::Recipes::SQLator;

=end code

=head1 DESCRIPTION

Use a database driver to get to data


=end pod

use DBIish;
use Raku::Recipes::Dator;
use Raku::Recipes;
use X::Raku::Recipes::Missing;

#| Basic calorie table handling role
unit class Raku::Recipes::SQLator does Raku::Recipes::Dator;

#| Contains the table of calories
has $!dbh;

#|[
Connects to the database
]
method new( $file = "Chapter-12/ingredients.sqlite3" ) {
    my $dbh = DBIish.connect("SQLite", :database($file));

    self.bless( :$dbh );
}

submethod BUILD( :$!dbh ) {}

method get-ingredient( Str $ingredient ) {
    my $sth = self!run-statement(q:to/GET/,$ingredient);
SELECT * FROM recipedata where name = ?;
GET
    return $sth.allrows()[0];
}

#| Hashifies a row to make it an uniform format
sub hashify( @row ) {
    my %hash;
}

method !run-statement( $stmt, *@args ) {
    my $sth = $!dbh.prepare($stmt);
    $sth.execute(@args);
    return $sth;
}

method get-ingredients() { die "NYI";
}

method search-ingredients( %search-criteria ) {
    die "NYI";
}

method !check( %ingredient-data, %search-criteria) {
    die "NYI";
}

method insert-ingredient( Str $ingredient, %data ) {
    die "Ingredients are immutable in this class";
}

method delete-ingredient( Str $ingredient) {
    die "Ingredients are immutable in this class";
}