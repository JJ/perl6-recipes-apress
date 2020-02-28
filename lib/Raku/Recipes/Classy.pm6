use Text::CSV;
use Raku::Recipes;
use Raku::Recipes::Roly;

#! Utility functions for the Raku Recipes book
unit class Raku::Recipes::Classy does Raku::Recipes::Roly;

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

method filter-ingredients( Bool :$Dairy, Bool :$Vegan, Bool :$Main, Bool :$Side, Bool :$Dessert ) {
    
    my @flags;
    for <Dairy Vegan Main Side Dessert> -> $f {
        @flags.push($f) with ::{"\$$f"};
    }
    my @filtered = %!calories-table.keys.grep: -> $i {
        my @checks =  @flags.map: -> $k {
            %!calories-table{$i}{$k} eq ::{"\$$k"}
        }
        so @checks.all;
    }
    return @filtered;
}
