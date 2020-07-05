use Grammar::Tracer;

unit grammar Raku::Recipes::Grammar::RecipeMark;

use Raku::Recipes::Grammarole::Measured-Ingredients;

token TOP {
    "#" \h+ <title>
    <.separation>
    <description>
#    <separation>
#    "##" \h+ Ingredients (for $<persons> = \d persons)
#    <separation>
#    <ingredient-list>
#    <separation>
#    "##" \h+ Preparation ($<time> = \d m)
#    <separation>
#    <instructions-list>
}

token separation { \v ** 2 }

token title { <words>+ % \h }

token description { <sentence> | <sentence>+ % \s+ }

token sentence { <words>+ % [\s+|"," \s+] "."}

token words { \w+ }
