package Games::SolarConflict::ComputerPlayer;

# ABSTRACT: Computer player model

use strict;
use warnings;
use Mouse;

with 'Games::SolarConflict::Roles::Player';

has _fire_time => (
    is      => 'rw',
    isa     => 'Num',
    default => 0,
);

sub handle_move {
    my ( $self, $step, $app, $t ) = @_;

    if ( $t > $self->_fire_time + 1 ) {
        $self->spaceship->fire_torpedo();
        $self->_fire_time($t);
    }
}

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

__END__

=pod

=for Pod::Coverage handle_move

=head1 SEE ALSO

=over 4

=item * L<Games::SolarConflict>

=back

=cut

