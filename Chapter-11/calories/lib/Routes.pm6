use Cro::HTTP::Router;
use Cro::HTTP::Router::WebSocket;

sub routes() is export {
    route {
        get -> {
            content 'text/html', "<h1>Recipes: calories computer </h1>";
        }

        my $chat = Supplier.new;
        get -> 'chat' {
            web-socket -> $incoming {
                supply {
                    whenever $incoming -> $message {
                        $chat.emit(await $message.body-text);
                    }
                    whenever $chat -> $text {
                        # Compute calories here
                        emit $text;
                    }
                }
            }
        }
    }
}
