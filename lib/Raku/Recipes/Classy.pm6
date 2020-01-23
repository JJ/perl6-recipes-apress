use Text::CSV;
use Raku::Recipes;

# Utility functions for the Raku Recipes book
unit class Raku::Recipes::Classy;

has %.calories-table;
has @.products;

method new( $dir = "." ) {
    my %calories-table = csv(in => "$dir/data/calories.csv",  sep => ';', headers => "auto", key => "Ingredient" ).pairs
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

multi method optimal-ingredients( -1, $ )  is export  { return [] };

multi method optimal-ingredients( $index,
			          $weight  where  %!calories-table{@!products[$index]}<Calories> > $weight )   {
    return self.optimal-ingredients( $index - 1, $weight );
}

multi method optimal-ingredients( $index, $weight )  {
    my $lhs = self.proteins(self.optimal-ingredients( $index - 1, $weight ));
    my @recipes = self.optimal-ingredients( $index - 1,
                                            $weight -  %!calories-table{@!products.[$index]}<Calories> );
    my $rhs = %!calories-table{@!products[$index]}<Protein> +  self.proteins( @recipes );
    if $rhs > $lhs {
        return @recipes.append: @!products[$index];
    } else {
        return @recipes;
    }
}

multi method proteins( [] ) { 0 }

multi method proteins( @items )   {
    return [+] %!calories-table{@items}.map: *<Protein>;
}

method products () { return @!products };
method calories-table() { return %!calories-table };
