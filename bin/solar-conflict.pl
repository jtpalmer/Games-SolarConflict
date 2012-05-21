#!perl
use strict;
use warnings;

BEGIN {
    if ( $^O eq 'darwin' && $^X ne 'SDLPerl' ) {
        exec 'SDLPerl', $0, @ARGV or die "Failed to exec SDLPerl: $!";
    }
}

use Games::SolarConflict;

# PODNAME: solar-conflict.pl
# ABSTRACT: Play the game

Games::SolarConflict->new->run();

exit;

