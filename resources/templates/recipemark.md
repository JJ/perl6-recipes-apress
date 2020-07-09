# <%= $recipemark.title %>

<%= $recipemark.description %>

## Ingredients (for <%= $recipemark.persons %> persons)
<%
    my %ingredients = $recipemark.ingredient-list;
    for %ingredients.kv -> $product, %data {
        take
    }

%>

## Preparation (<%= $recipemark.persons %>m)

