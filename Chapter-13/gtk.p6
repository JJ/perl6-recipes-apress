#!/usr/bin/env perl6

use GTK::Simple;
use GTK::Simple::App;

my $app = GTK::Simple::App.new( title => "Hello GTK!" );

$app.set-content(
        GTK::Simple::VBox.new(
                my $button = GTK::Simple::Button.new(label => "Hello World!"),
                my $second = GTK::Simple::Button.new(label => "Goodbye!")
                )
        );

$app.border-width = 20;
$second.sensitive = False;
$button.clicked.tap({ .sensitive = False; $second.sensitive = True });
$second.clicked.tap({ $app.exit; });
$app.run;