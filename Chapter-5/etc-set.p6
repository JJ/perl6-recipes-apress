#!/usr/bin/env raku

my $can-haz-etcdctl = shell "etcdctl --version", :out;

die "Can't find etcdctl" unless $can-haz-etcdctl.out.slurp ~~ /"etcdctl version"/;

sub MAIN( $key, $value ) {
    my $output = shell "etcdctl set $key $value", :out;
    my $set-value = $output.out.slurp.trim;
    say "--$value-- --$set-value--";
    if $value eq $set-value {
        say "🔑 $key has been set to $value";
    } else {
        die "Couldn't set $key to $value";
    }
}
      
