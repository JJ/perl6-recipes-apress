use Cro::HTTP::Router;
use Raku::Recipes::Roly;
use Raku::Recipes;

unit module My::Routes;

our $rrr = Raku::Recipes::Roly.new();

sub static-routes is export {
    route {
        get -> *@path {
            static 'build/', @path, :indexes<index.html>;
        }
    }

}

sub type-routes is export {
    route {
        get -> Str $type where $type ∈ @food-types {
            my %ingredients-table = $rrr.calories-table;
            my @result =  %ingredients-table.keys.grep: {
                %ingredients-table{$_}{$type} };
            content 'application/json', @result;
        }
    }
}

sub ingredient-routes is export {
    route {
        get -> Str $ingredient where $rrr.is-ingredient($ingredient) {
            content 'application/json', $rrr.calories-table{$ingredient};
        }
    }
}