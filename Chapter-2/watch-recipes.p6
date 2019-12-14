#!/usr/bin/env raku

my $dir = $*ARGS[0] // 'recipes';

my $dir-watch-supply= IO::Notification.watch-path($dir);

$dir-watch-supply.tap: -> $change {
    say $change.raku if $change.event ~~ FileChanged;
};

await Promise.in(20).then: { say "Finished watch"; };
