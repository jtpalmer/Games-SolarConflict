package Games::SolarConflict::ComputerPlayer;
use strict;
use warnings;
use Mouse;

with 'Games::SolarConflict::Roles::Player';

# ABSTRACT: Computer player model

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

