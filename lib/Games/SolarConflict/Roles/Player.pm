package Games::SolarConflict::Roles::Player;
use strict;
use warnings;
use Mouse::Role;

# ABSTRACT: Player role

has spaceship => (
    is       => 'ro',
    isa      => 'Games::SolarConflict::Spaceship',
    required => 1,
);

no Mouse::Role;

1;

