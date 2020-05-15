use Cro::HTTP::Router;
use Cro::HTTP::Router::WebSocket;

sub routes() is export {
    route {
        my $chat = Supplier.new;
        get -> 'calories' {
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
