#!/usr/bin/env perl6

use SDL2::Raw;
use lib <lib Chapter-13/lib>;
use SDL2;
use My::Unit;


LEAVE SDL_Quit;

my $occupied =  @*ARGS[0] // 0.1;

my int ($w, $h) = 800, 600;
my $window = init-window( $w, $h );
LEAVE $window.destroy;

my $renderer = SDL2::Renderer.new( $window, :flags(ACCELERATED) );
SDL_ClearError;


my @grid[$w/GRID_X;$h/GRID_Y];

$renderer.draw-color( |@healthy );
for ^@grid.shape[0] -> $x {
    for ^@grid.shape[1] -> $y {
        if ( 1.rand < $occupied ) {
            @grid[$x;$y] = My::Unit.new( :$renderer, :$x, :$y );
            @grid[$x;$y].render;
        }
    }
}
sdl-loop($renderer);

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
sub sdl-loop ( $renderer ) {
    my SDL_Event $event .= new;
    loop {
        while SDL_PollEvent($event) {
            handle-event( $renderer, SDL_CastEvent($event) );
        }
    }
}

#| Handle events
proto sub handle-event( | ) {*}

multi sub handle-event( $renderer, SDL2::Raw::SDL_MouseButtonEvent $mouse ) {
    say $mouse.raku;
    say "Clicked at {$mouse.x}, {$mouse.y}";

}

sub gridify ( $x, $y) {
    return ($x / GRID_X).Int, ($y/GRID_Y).Int;
}

multi sub handle-event( $, SDL2::Raw::SDL_KeyboardEvent $key ) {
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

multi sub handle-event( $, $event ) {
    say $event.raku;
    given $event {
        when ( *.type == QUIT )
        {
            exit;
        }
    }
}