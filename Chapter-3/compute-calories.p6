#!/usr/bin/env raku

use Parser::FreeXL::Native;

my %ingredients = %( Rice => g => 350,
                     Tuna =>  g => 400 ,
                     Cheese => g => 200 );

my Parser::FreeXL::Native $xl-er .= new;

$xl-er.open("data/calories.xls");
$xl-er.select_sheet(0);
my %calories;
for 1..^$xl-er.sheet_dimensions[0] -> $r {
    $xl-er.get_cell($r,1).value ~~ /$<q>=(\d+)\s*$<unit>=(\S+)/;
    with $<unit> {
        %calories{$xl-er.get_cell($r,0).value} = { unit => ~$<unit>,
                                                   q => +$<q>,
                                                   calories => $xl-er.get_cell($r,2).value };
    }
}
my $total-calories = 0;

for %ingredients.keys -> $i {
    if %ingredients{$i}.key eq %calories{$i}<unit> {
        $total-calories +=
            %calories{$i}<calories> * %ingredients{$i}.value / %calories{$i}<q>
    }
}

say "Total calories ⇒ $total-calories";
        