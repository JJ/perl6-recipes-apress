#!/usr/bin/env perl6

use SDL2::Raw;
use lib 'lib';
use SDL2;

constant OPAQUE = 255;
constant GRID_X = 25;
constant GRID_Y = 25;

LEAVE SDL_Quit;

my $occupied =  @*ARGS[0] // 0.1;

my int ($w, $h) = 800, 600;
my $window = init-window( $w, $h );
LEAVE $window.destroy;

my $renderer = SDL2::Renderer.new( $window, :flags(ACCELERATED) );
SDL_ClearError;
constant @infected = (255,0,0,OPAQUE);
constant @healthy = (0,255,0,OPAQUE);

my @grid[$w/GRID_X;$h/GRID_Y];

$renderer.draw-color( |@healthy );
for ^@grid.shape[0] -> $i {
    for ^@grid.shape[1] -> $j {
        if ( 1.rand < $occupied ) {
            my $dest-rect = rect-at-grid($i, $j);
            $renderer.fill-rect($dest-rect);
        }
    }
}
$renderer.present;
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

sub rect-at-grid( $grid_x, $grid_y ) {
    SDL_Rect.new: x => $grid_x*GRID_X, y => $grid_y*GRID_Y,
                  w => GRID_X, h => GRID_Y;
}

sub gridify ( $x, $y) {
    return ($x / GRID_X).Int, ($y/GRID_Y).Int;
}

#| Handle events
proto sub handle-event( | ) {*}

multi sub handle-event( $renderer, SDL2::Raw::SDL_MouseButtonEvent $mouse ) {
    say $mouse.raku;
    say "Clicked at {$mouse.x}, {$mouse.y}";
    $renderer.draw-color(0x22, 0x22, 0x22, OPAQUE);
    my $dest-rect = rect-at-grid( | gridify( $mouse.x, $mouse.y));
    say $dest-rect.raku;
    $renderer.fill-rect( $dest-rect);
    $renderer.present;
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