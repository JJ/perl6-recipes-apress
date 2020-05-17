use Text::CSV;
use Raku::Recipes;
use X::Raku::Recipes::Missing;
use X::Raku::Recipes;

=begin pod

=head1 NAME

Raku::Recipes::Roly - Example of a Role, which includes also utility functions for Raku Recipes book (by Apress)

=head1 SYNOPSIS

=begin code
use Raku::Recipes::Roly;

my $rrr = Raku::Recipes::Roly.new; # "Puns" role with the default data dir

say $rrr.calories-table; # Prints the loaded calorie table
say $rrr.products;       # Prints the products that form the set of ingredients
=end code

=head1 DESCRIPTION

Simple data-loading role that can be composed into classes that will deal with tables of ingredients, every one with tabular data.

=head1 CAVEATS

The file needs to be called C<calories.csv> and be placed in a C<data/> subdirectory.

=end pod

our $pod is export = $=pod[0];

#| Basic file-loading role
unit role Raku::Recipes::Roly:ver<0.0.2>;

#| Contains the table of calories
has %.calories-table;

#| Products or ingredients will be stored for brevity here
has @.products;

#|[
Creates a new calorie table, reading it from the directory indicated,
the current directory by default. The file will be in a subdirectory data,
and will be called calories.csv
]
method new( $dir = "." ) {
    my $calorie-table-file = %*ENV<CALORIE_TABLE_FILE>
       // "$dir/data/calories.csv";
    X::Raku::Recipes::Missing::File.new(:name($calorie-table-file)).throw
            unless $calorie-table-file.IO.e;
    my %calories-table = csv(in => $calorie-table-file,
                             sep => ';',
                             headers => "auto",
                             key => "Ingredient" ).pairs
    ==> map( {
       $_.value<Ingredient>:delete;
       $_.value<parsed-measures> = parse-measure( $_.value<Unit> );
       $_ } );

    for %calories-table.values -> %ingredient {
        for %ingredient.keys -> $k {
            given  %ingredient{$k} {
                when "Yes" { %ingredient{$k} = True }
                when "No"  { %ingredient{$k} = False };
            }
        }
    };
    @products = %calories-table.keys;
    self.bless( :%calories-table, :@products );
}

#| Basic getter for products
method products () { return @!products };
#= → Returns an array with the existing products.

#| Basic getter for the calorie table
method calories-table() { return %!calories-table };

#| Checks if a product exist
proto method is-ingredient( | ) {*}
multi method is-ingredient( Str $product where $product ∈ self.products() -->
        True) {}
multi method is-ingredient( Str $product where $product ∉ self.products() -->
        False) {}

#| Compute calories, given a product and a quantity. Raises exception if the
#| product does not exist.
method calories( Str $product is copy, $quantity) {
    $product = tc $product;
    X::Raku::Recipes::Missing::Product.new(:product($product)).throw
            unless $product ∈ self.products();
    return %!calories-table{$product}<Calories>*$quantity
            /%!calories-table{$product}<parsed-measures>[0];
}

#| Computes calories for a dish composed of main and side.
#| Every one is a pair product, quantity
method calories-for( :$main, :$side) {
    X::Raku::Recipes::Missing::Product.new(:name($main.key)).throw
            unless self.is-ingredient($main.key);
    X::Raku::Recipes::WrongType.new(:product($main.key),
                                    :desired-type("Main")).throw
            unless self.check-type($main.key,"Main");
    X::Raku::Recipes::Missing::Product.new(:name($side.key)).throw
            unless self.is-ingredient($side.key);
    X::Raku::Recipes::WrongType.new(:product($side.key),
                                :desired-type("Side")).throw
            unless self.check-type($side.key,"Side");

    return self.calories( $main.key, $main.value ) +
            self.calories( $side.key, $side.value );

}

#| Check type of ingredient
method check-type( Str $ingredient where $ingredient ∈ %!calories-table.keys,
		   Str $type where $type ∈ @food-types --> Bool ) {
    return %!calories-table{$ingredient}{$type};
}

#| Check type of ingredient
method check-unit( Str $ingredient where $ingredient ∈ %!calories-table.keys,
                   Str $unit where $unit ∈ @unit-types --> Bool ) {
    return;
}