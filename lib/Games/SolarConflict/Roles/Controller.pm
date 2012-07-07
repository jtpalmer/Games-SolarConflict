package Games::SolarConflict::Roles::Controller;

# ABSTRACT: Controller role

use strict;
use warnings;
use Mouse::Role;

has game => (
    is       => 'rw',
    isa      => 'Games::SolarConflict',
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

