package Games::SolarConflict::Sprite::Rotatable;

# ABSTRACT: Rotatable sprite

use strict;
use warnings;
use Mouse;
use SDLx::Sprite::Animated;

has _sprite => (
    is       => 'ro',
    isa      => 'SDLx::Sprite::Animated',
    init_arg => 'sprite',
    handles  => [qw( x y h w rect clip draw draw_xy alpha_key )],
);

has increment => (
    is      => 'ro',
    isa     => 'Int',
    lazy    => 1,
    default => sub { 360 / ( $_[0]->rows * $_[0]->cols ) },
);

has rows => (
    is      => 'ro',
    isa     => 'Int',
    lazy    => 1,
    default => sub { $_[0]->h / $_[0]->rect->h },
);

has cols => (
    is      => 'ro',
    isa     => 'Int',
    lazy    => 1,
    default => sub { $_[0]->w / $_[0]->rect->w },
);

# XXX SDL_BlitSurface alters the destination rect if there is clipping,
# so save and restore it
around draw => sub {
    my ( $orig, $self, $surface ) = @_;

    my $x = $self->rect->x;
    my $y = $self->rect->y;
    my $w = $self->rect->w;
    my $h = $self->rect->h;

    my @rects = $self->$orig($surface);

    $self->rect->x($x);
    $self->rect->y($y);
    $self->rect->w($w);
    $self->rect->h($h);

    return @rects;
};

sub rotation {
    my ( $self, $rot ) = @_;

    while ( $rot >= 360 ) { $rot -= 360 }
    while ( $rot < 0 ) { $rot += 360 }

    my $frame = int( $rot / $self->increment );

    my $clip = $self->clip;
    $clip->x( ( $frame % $self->cols ) * $self->rect->h );
    $clip->y( int( $frame / $self->cols ) * $self->rect->w );
}

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

=pod

=for Pod::Coverage rotation

=cut

