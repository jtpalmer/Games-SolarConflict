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

__END__

=pod

=head1 SYNOPSIS

Start the game from the command line:

    solar-conflict.pl

=head1 DESCRIPTION

This script starts the game.  It will open a 1024x768 window (plus the
size of the window frame).  Game controls are displayed on the menu
screen.  Close the window to end the game.

=head1 SEE ALSO

=over 4

=item * L<Games::SolarConflict>

=back

=cut

