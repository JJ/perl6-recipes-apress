#!/usr/bin/env perl6

use SDL2::Raw;
use lib 'lib';
use SDL2;
constant OPAQUE = 255;

LEAVE SDL_Quit;

my int ($w, $h) = 800, 600;
my $window = init-window( $w, $h );
LEAVE $window.destroy;

my $renderer = SDL2::Renderer.new( $window, :flags(ACCELERATED) );
SDL_ClearError;

for ^80 -> $i {
    for ^60 -> $j {
        $renderer.draw-color($i*3, $j*4, 0x22, 22);
        my SDL_Rect $dest-rect .= new: x => $i*10, y => $j*10,
                                       w => 10, h => 20;
        $renderer.fill-rect( $dest-rect);
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
            $renderer.present;
        }
    }
}

#| Handle events
proto sub handle-event( | ) {*}

multi sub handle-event( $renderer, SDL2::Raw::SDL_MouseButtonEvent $mouse ) {
    say $mouse.raku;
    say "Clicked at {$mouse.x}, {$mouse.y}";
    $renderer.draw-color(0x22, 0x22, 0x22, OPAQUE);
    my SDL_Rect $dest-rect .= new: x => $mouse.x, y => $mouse.y,
                                   w => 10, h => 20;
    say $dest-rect.raku;
    $renderer.fill-rect( $dest-rect);
#    $renderer.draw-point( $mouse.x, $mouse.y );
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

sub create-rect($renderer) {
    my $texture = $renderer.create-texture(
            :format(%PIXELFORMAT<ARGB8888>),
            :access(TARGET),
            :width(8),
            :height(6)
            );

    $renderer.render-target($texture);
    $renderer.draw-color(0, 0, 0, 0);
    $renderer.clear;
    $renderer.draw-color(25, 25, 25, OPAQUE );
    SDL_SetTextureBlendMode($texture, 1);
    $texture;
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