unit grammar Raku::Recipes::Grammar::RecipeMark;

use Raku::Recipes::Grammarole::Measured-Ingredients;

token TOP {
    "#" \h+ <title>
    \v ** 2
    <description>
    \v ** 2
    "##" \h+ Ingredients
    \v ** 2
    <ingredient-list>
    \v ** 2
    "##" \h+ Preparation
    \v ** 2
    <instructions-list>
}