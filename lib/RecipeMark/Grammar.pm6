use Raku::Recipes::Grammarole::Measured-Ingredients;
use Grammar::PrettyErrors;

unit grammar RecipeMark::Grammar
        does Raku::Recipes::Grammarole::Measured-Ingredients
        does Grammar::PrettyErrors;

token TOP {
    "#" \h+ <title>
    <.separation>
    <description>
    <.separation>
    "##" \h+ Ingredients \h+ "(for" \h+ $<persons> = \d+ \h+ person s? ")"
    <.separation>
    <ingredient-list>
    <.separation>
    "##" \h+ Preparation \h+ "(" $<time> = \d+ "m)"
    <.separation>
    <instruction-list>
}

token separation { \v ** 2 }

token title { <words>+ % \h }

token description { [<.sentence> | <.sentence>+ % \s+] }

token ingredient-list { <itemized-ingredient>+ % \v }

token itemized-ingredient { ["*"|"-"] \h+ <ingredient-description>}

token instruction-list { <numbered-instruction>+  % \v }

token numbered-instruction { <numbering> \h+ <instruction> }

token instruction { <action-verb> \h <sentence>}

token numbering { \d+ )> "." }

token action-verb { <.words>  }

token sentence { <.words>+ % [[","|";"|":"]? \s+] "."}

token words { <[\w \- \']>+ }
