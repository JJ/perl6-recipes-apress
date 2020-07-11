[![Tests utility module](https://github.com/JJ/perl6-recipes-apress/workflows
/Tests%20utility%20module/badge.svg)](https://github.com/JJ/perl6-recipes-apress/actions)

# Raku recipes for Apress

Scripts and modules for the book

Every chapter has its own META6.json file. Download and build needed
modules getting into each of them.

    zef install --deps-only .

## Resources


Programs used in every Chapter are in its own directory.

The `Raku::Recipes` and `RecipeMark` distributions are contained in the [`lib`](lib/), with tests in the [`t`](dir). Once this is downloaded, install it with 

    zef test .
	

