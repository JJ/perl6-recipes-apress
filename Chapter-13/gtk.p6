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

$app.set-content(
            GTK::Simple::VBox.new(
                create-type-buttons,
                GTK::Simple::HBox.new( |@panels )
            )
        );

$app.border-width = 15;
$app.run;

sub create-type-buttons() {
    my $button-set = GTK::Simple::HBox.new(
            my $button = GTK::Simple::Button.new(label => "Vegan"),
            my $second = GTK::Simple::Button.new(label => "Dairy"),
            my $exit = GTK::Simple::Button.new(label => "Exit"),
            );
    $second.sensitive = False;
    $button.clicked.tap({ .sensitive = False; $second.sensitive = True });
    $exit.clicked.tap({ $app.exit; });
    return $button-set;
}

sub create-radio-buttons ( @labels is copy ) {
    my $first-radio-button =
            GTK::Simple::RadioButton.new(:label(shift @labels));
    my @radio-buttons = ( $first-radio-button ) ;
    while @labels {
        my $this-radio-button =
                GTK::Simple::RadioButton.new(:label(shift @labels));
        @radio-buttons.append: $this-radio-button;
        $this-radio-button.add( $first-radio-button );
    }
    @radio-buttons;
}

sub create-button-set( $title, @labels ) {
    my $label = GTK::Simple::TextView.new;
    $label.text = "→ $title";
    my @radio-buttons = create-radio-buttons( @labels );
    GTK::Simple::VBox.new( $label, |@radio-buttons);
}

sub create-type-panel( Raku::Recipes::Dator $dator,
                       $type where $type ∈ <Main Side Dessert> ) {
    my @ingredients = $dator.search-ingredients( { $type => "Yes" });
    create-button-set( $type, @ingredients );
}