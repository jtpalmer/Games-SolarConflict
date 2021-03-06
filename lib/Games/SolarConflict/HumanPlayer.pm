package Games::SolarConflict::HumanPlayer;

# ABSTRACT: Human player model

use strict;
use warnings;
use Mouse;

with 'Games::SolarConflict::Roles::Player';

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

__END__

=pod

=head1 SEE ALSO

=over 4

=item * L<Games::SolarConflict>

=back

=cut

