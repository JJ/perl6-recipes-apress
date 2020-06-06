#!/usr/bin/env perl6

use GTK::Simple;
use GTK::Simple::App;
use GTK::Simple::RadioButton;

my $app = GTK::Simple::App.new( title => "Select ingredients" );
my @buttons = create-radio-buttons( <a b c >);
$app.set-content(
            GTK::Simple::VBox.new(
                create-type-buttons,
                |@buttons
            )
        );

$app.border-width = 20;
$app.run;

sub create-type-buttons() {
    my $button-set = GTK::Simple::HBox.new(
            my $button = GTK::Simple::Button.new(label => "Vegan"),
            my $second = GTK::Simple::Button.new(label => "Dairy")
            );
    $second.sensitive = False;
    $button.clicked.tap({ .sensitive = False; $second.sensitive = True });
    $second.clicked.tap({ $app.exit; });
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