#!/usr/bin/env perl6

use GTK::Simple;
use GTK::Simple::App;
use GTK::Simple::RadioButton;
use Raku::Recipes::SQLator;

my $app = GTK::Simple::App.new( title => "Select ingredients" );

my $dator = Raku::Recipes::SQLator.new();

my @panels = do for <Main Side Dessert> {
    create-type-panel( $dator, $_)
};

say @panels.raku;
$app.set-content(
            GTK::Simple::VBox.new(
                create-type-buttons( @panels ),
                GTK::Simple::HBox.new( |@panels )
            )
        );

$app.border-width = 15;
$app.run;

sub create-type-buttons( @panels ) {
    my $button-set = GTK::Simple::HBox.new(
            my $vegan = GTK::Simple::Button.new(label => "Vegan"),
            my $second = GTK::Simple::Button.new(label => "Dairy"),
            my $exit = GTK::Simple::Button.new(label => "Exit"),
            );
    $second.sensitive = True;
    $vegan.clicked.tap({
        .sensitive = False;
        $second.sensitive = False;

    }
            );
    $exit.clicked.tap({ $app.exit; });
    return $button-set;
}

sub create-radio-buttons ( $dator, @labels is copy ) {
    my $label = shift @labels;
    my $first-radio-button =
            GTK::Simple::RadioButton.new(:$label )
            but $dator.get-ingredient($label);
    say $first-radio-button.Hash;
    my @radio-buttons = ( $first-radio-button ) ;
    while @labels {
        $label = shift @labels;
        my $this-radio-button =
                GTK::Simple::RadioButton.new(:$label)
                but $dator.get-ingredient($label);
        @radio-buttons.append: $this-radio-button;
        $this-radio-button.add( $first-radio-button );
    }
    @radio-buttons;
}

sub create-button-set( $dator, $title, @labels ) {
    my $label = GTK::Simple::TextView.new;
    $label.text = "→ $title";
    my @radio-buttons = create-radio-buttons( $dator, @labels );
    GTK::Simple::VBox.new( $label, |@radio-buttons);
}

sub create-type-panel( Raku::Recipes::Dator $dator,
                       $type where $type ∈ <Main Side Dessert> ) {
    my @ingredients = $dator.search-ingredients( { $type => "Yes" });
    create-button-set( $dator, $type, @ingredients );
}