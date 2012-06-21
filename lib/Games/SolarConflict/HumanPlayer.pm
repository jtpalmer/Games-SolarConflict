package Games::SolarConflict::HumanPlayer;
use strict;
use warnings;
use Mouse;

with 'Games::SolarConflict::Roles::Player';

# ABSTRACT: Human player model

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

