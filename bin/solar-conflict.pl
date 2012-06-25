#!perl

# ABSTRACT: Play the game
# PODNAME: solar-conflict.pl

use strict;
use warnings;

BEGIN {
    if ( $^O eq 'darwin' && $^X !~ /SDLPerl$/ ) {
        exec 'SDLPerl', $0, @ARGV or die "Failed to exec SDLPerl: $!";
    }
}

use Games::SolarConflict;

Games::SolarConflict->new->run();

exit;

=pod

=head1 SYNOPSIS

    solar-conflict.pl

=head1 DESCRIPTION

This script starts the game.  It will open a 1024x768 pixel window (plus
the size of the window frame).  Game controls are displayed on the menu
screen.

=head1 SEE ALSO

=over 4

=item * L<Games::SolarConflict>

=back

=cut

