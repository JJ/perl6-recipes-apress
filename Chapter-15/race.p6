#!/usr/bin/env raku

# Grab Nutrients.csv from https://data.nal.usda.gov/dataset/usda-branded-food-products-database/resource/c929dc84-1516-4ac7-bbb8-c0c191ca8cec
my @nutrients = "/home/jmerelo/Documentos/Nutrients.csv".IO.lines;
for @nutrients.race( :batch( @nutrients.elems/6), :6degree  ) {
    my @data = $_.split('","');
    .say if @data[2] eq "Protein" and @data[4] > 70 and @data[5] ~~ /^g/;
};
