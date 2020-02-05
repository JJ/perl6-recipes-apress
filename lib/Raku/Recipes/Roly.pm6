use Text::CSV;
use Raku::Recipes;

# Utility functions for the Raku Recipes book
unit role Raku::Recipes::Roly;

has %.calories-table;
has @.products;

method new( $dir = "." ) {
    my $calorie-table-file;
    with %*ENV<CALORIE_TABLE_FILE> {
        $calorie-table-file = $_;
    } else {
        $calorie-table-file = "$dir/data/calories.csv";
    }
    my %calories-table = csv(in => $calorie-table-file,
                             sep => ';',
                             headers => "auto",
                             key => "Ingredient" ).pairs
    ==> map( {
       $_.value<Ingredient>:delete;
       $_.value<parsed-measures> = parse-measure( $_.value<Unit> );
       $_ } );

    for %calories-table.kv -> $, %ingredient {
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

method products () { return @!products };
method calories-table() { return %!calories-table };
