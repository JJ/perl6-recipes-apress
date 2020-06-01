use Red:api<2>;

model Raku::Recipes::IngRedient is rw is table<Ingredient> {
    has Int         $.id        is serial;
    has Str         $.name      is column{ :unique };
    has Str         $.unit      is column{ :!nullable };
    has Int         $.calories  is column{ :!nullable };
    has Num         $.protein   is column{ :!nullable };
    has Bool        $.dairy     is column{ :!nullable };
    has Bool        $.vegan     is column{ :!nullable };
    has Bool        $.main      is column{ :!nullable };
    has Bool        $.side      is column{ :!nullable };
    has Bool        $.dessert   is column{ :!nullable };
}
