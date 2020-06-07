#!/usr/bin/env perl6

use SDL2::Raw;
use lib 'lib';
use SDL2;

LEAVE SDL_Quit;

my int ($w, $h) = 800, 600;
my $window = init-window( $w, $h );
LEAVE $window.destroy;

my $renderer = SDL2::Renderer.new( $window, :flags(ACCELERATED) );
LEAVE $renderer.destroy;
SDL_ClearError;
my $renderer_info = $renderer.renderer-info;
say $renderer_info;

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
    main: loop {
        while SDL_PollEvent($event) {
            my $casted_event = SDL_CastEvent($event);
            given $casted_event {
                when *.type == QUIT {
                    last main;
                }
            }
        }

    }
}