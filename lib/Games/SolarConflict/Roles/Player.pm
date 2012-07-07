package Games::SolarConflict::Roles::Player;

# ABSTRACT: Player role

use strict;
use warnings;
use Mouse::Role;

has spaceship => (
    is       => 'ro',
    isa      => 'Games::SolarConflict::Spaceship',
    required => 1,
);

no Mouse::Role;

1;

__END__

=pod

=head1 SEE ALSO

=over 4

=item * L<Games::SolarConflict>

=back

=cut

