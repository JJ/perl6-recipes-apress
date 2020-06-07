#!/usr/bin/env perl6

use SDL2::Raw;
use lib 'lib';
use SDL2;

LEAVE SDL_Quit;

my int ($w, $h) = 800, 600;
my $window = init-window( $w, $h );
LEAVE $window.destroy;

my $renderer-info = SDL2::Renderer.new( $window, :flags(ACCELERATED) )
        .renderer-info;
SDL_ClearError;

sdl-loop;

#-------------------- routines -----------------------------------------

#| Init window
sub init-window( int $w, int $h ) {
    die "couldn't initialize SDL2: { SDL_GetError }" if SDL_Init(VIDEO) != 0;
    SDL2::Window.new(
            :title("Particle System!"),
            :width($w),
            :height($h),
            :flags(SHOWN)
            );
}


#| Rendering loop
sub sdl-loop () {
    my SDL_Event $event .= new;
    loop {
        while SDL_PollEvent($event) {
            handle-event( SDL_CastEvent($event) )
        }
    }
}

#| Handle events
proto sub handle-event( | ) {*}

multi sub handle-event( SDL2::Raw::SDL_MouseButtonEvent $mouse ) {
    say $mouse.raku;
    say "Clicked at {$mouse.x}, {$mouse.y}";
}

multi sub handle-event( SDL2::Raw::SDL_KeyboardEvent $key ) {
    say $key.raku;
    given $key {
        when (*.type == KEYDOWN )
        {
            if $key.sym == 27 {
                exit;
            }
        }
    }
}

multi sub handle-event( $event ) {
    say $event.raku;
    given $event {
        when ( *.type == QUIT )
        {
            exit;
        }
    }
}