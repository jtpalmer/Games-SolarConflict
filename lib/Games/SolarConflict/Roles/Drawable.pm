package Games::SolarConflict::Roles::Drawable;

# ABSTRACT: Drawable role

use strict;
use warnings;
use Mouse::Role;
use SDL::Rect;

requires qw( draw );

has visible => (
    is      => 'rw',
    isa     => 'Bool',
    default => 1,
);

has prev_rect => (
    is      => 'rw',
    default => sub { [] },
);

around draw => sub {
    my ( $orig, $self, $surface ) = @_;

    return unless $self->visible;

    my $rect = $self->prev_rect;
    $self->prev_rect( $self->$orig($surface) );
    return ( $rect, $self->prev_rect );
};

no Mouse::Role;

1;

__END__

=pod

=head1 SEE ALSO

=over 4

=item * L<Games::SolarConflict>

=back

=cut

