#!/usr/bin/env perl6

use Telegram;
use Raku::Recipes::Grammar::Measured-Ingredients;
use Raku::Recipes::Grammar::Actions;

my $bot = Telegram::Bot.new(%*ENV<RAKU_RECIPES_BOT_TOKEN>);
$bot.start(1); # Starts scanning for updates every second; defaults to every 2 seconds

react {
    whenever $bot.messagesTap -> $msg {
        my $item =  Raku::Recipes::Grammar::Measured-Ingredients.parse($msg.text,
                    actions =>
                    Raku::Recipes::Grammar::Actions::Measured-Ingredients.new);


        if $item {
            say "{ $msg.sender.username }: { $msg.text } in { $msg.chat.id } → $item";
        } else {
            say "There's somethign wrong with the input string; can't compute calories";
        }
    }
    whenever signal(SIGINT) {
        $bot.stop;
        exit;
    }
}