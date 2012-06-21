package Games::SolarConflict::Roles::Controller;
use strict;
use warnings;
use Mouse::Role;

# ABSTRACT: Controller role

has game => (
    is       => 'rw',
    isa      => 'Games::SolarConflict',
    required => 1,
);

no Mouse::Role;

1;

