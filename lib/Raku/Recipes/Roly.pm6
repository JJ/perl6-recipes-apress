use Text::CSV;
use Raku::Recipes;

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

git=head1 CAVEATS

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

#| Check type of ingredient
method check-type( Str $ingredient where $ingredient ∈ %!calories-table.keys,
		   Str $type where $type ∈ @food-types --> Bool ) {
    return %!calories-table{$ingredient}{$type};
}
