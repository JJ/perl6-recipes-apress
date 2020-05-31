=begin pod

=head1 NAME

Raku::Recipes::Redisator - Uses Redis to store and
retrieve data

=head1 SYNOPSIS

=begin code
use Raku::Recipes::Redisator;

=end code

=head1 DESCRIPTION

Use a Redis driver to get to data, with basic CRUD operations.

=end pod

use Redis;
use Raku::Recipes::Dator;
use Raku::Recipes;
use X::Raku::Recipes::Missing;

#| Basic calorie table handling role
unit class Raku::Recipes::Redisator does Raku::Recipes::Dator does Associative;

#| Contains the table of calories
has $!redis;

#|[
Connects to the database
]
method new( $url = "127.0.0.1:6379" ) {
    my $redis = Redis.new($url, :decode_response);
    self.bless( :$redis );
}

submethod BUILD( :$!redis ) {}

#| Retrieves a single ingredient by name
method get-ingredient( Str $ingredient ) {
$!redis.hgetall( $ingredient);
}

#| To make it work as Associative.
multi method AT-KEY( Str $ingredient ) {
    return self.get-ingredient( "recipes:$ingredient" );
}

#| Retrieves all ingredients in a hash
method get-ingredients {
    my @keys = $!redis.hkeys.grep: /^^"recipes:"/;
    my %rows;
    for @keys -> $k {
        $k ~~ /<?after "recipes:">$<key>=(\w+)/;
        %rows{~$<key>} = $!redis.hgetall(~$<key>)
    }
    return %rows;
}

#| Search ingredients by criteria
method search-ingredients( %search-criteria ) {
 die "NYI"
}

#| Insert a new ingredient
method insert-ingredient( Str $ingredient, %data ) {
   $!redis.hmset("recipes:$ingredient", |%data )
}

#| Deletes an ingredient by name
method delete-ingredient( Str $ingredient) {
   $!redis.hdel("recipes:$ingredient")
}