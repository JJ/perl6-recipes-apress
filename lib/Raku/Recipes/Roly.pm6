use Text::CSV;
use Raku::Recipes;

#| Basic file-loading role
unit role Raku::Recipes::Roly;

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

#| Basic getter for products
method products () { return @!products };

#| Basic getter for the calorie table
method calories-table() { return %!calories-table };
