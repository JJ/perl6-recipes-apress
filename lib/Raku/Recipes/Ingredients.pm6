#| Role that describes generic recipe ingredients
unit role Raku::Recipes::Ingredients;

has @.ingredients;

method gist { return @!ingredients.map( "* " ~ * ~ "\n").join; }
