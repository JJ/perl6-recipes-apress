#!/usr/bin/env perl6

use Telegram;

my $bot = Telegram::Bot.new(%*ENV<RAKU_RECIPES_BOT_TOKEN>);
$bot.start(1); # Starts scanning for updates every second; defaults to every 2 seconds

my $msgTap = $bot.messagesTap; # A tap for updates

react {
    whenever $msgTap -> $msg {
        say "{$msg.sender.username}: {$msg.text} in {$msg.chat.id}";
    }
    whenever signal(SIGINT) {
        $bot.stop;
        exit;
    }
}