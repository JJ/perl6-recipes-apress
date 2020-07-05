use Grammar::Tracer;

unit grammar Raku::Recipes::Grammar::RecipeMark;

use Raku::Recipes::Grammarole::Measured-Ingredients;

token TOP {
    "#" \h+ <title>
    <.separation>
    <description>
    <.separation>
    "##" \h+ Ingredients \h+ "(for" \h+ $<persons> = \d+ \h+ person s? ")"
    <.separation>
#    <ingredient-list>
#    <separation>
    "##" \h+ Preparation \h+ "(" $<time> = \d+ "m)"
    <.separation>
#    <instructions-list>
}

token separation { \v ** 2 }

token title { <words>+ % \h }

token description { [<sentence> | <sentence>+ % \s+] }

token sentence { <words>+ % [\s+|"," \s+] "."}

token words { \w+ }
