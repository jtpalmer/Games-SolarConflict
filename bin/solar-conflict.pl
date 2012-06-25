#!perl

# ABSTRACT: Play the game
# PODNAME: solar-conflict.pl

use strict;
use warnings;

BEGIN {
    if ( $^O eq 'darwin' && $^X ne /SDLPerl$/ ) {
        exec 'SDLPerl', $0, @ARGV or die "Failed to exec SDLPerl: $!";
    }
}

use Games::SolarConflict;

Games::SolarConflict->new->run();

exit;

