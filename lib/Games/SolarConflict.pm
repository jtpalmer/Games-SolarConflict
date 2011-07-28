package Games::SolarConflict;

# ABSTRACT: Spacewar! clone

use Mouse;
use SDL;
use SDL::Rect;
use SDLx::App;
use SDLx::Surface;
use SDLx::Sprite;
use SDLx::Sprite::Animated;
use Games::SolarConflict::Sprite::Rotatable;
use Games::SolarConflict::Sun;
use Games::SolarConflict::Spaceship;
use Games::SolarConflict::Torpedo;
use Games::SolarConflict::HumanPlayer;
use Games::SolarConflict::ComputerPlayer;
use Games::SolarConflict::Controller::MainMenu;
use Games::SolarConflict::Controller::MainGame;
use Games::SolarConflict::Controller::GameOver;

has app => (
    is       => 'ro',
    isa      => 'SDLx::App',
    required => 1,
    handles  => [qw( run )],
);

has background => (
    is       => 'ro',
    isa      => 'SDLx::Surface',
    required => 1,
);

has sun => (
    is       => 'ro',
    isa      => 'Games::SolarConflict::Sun',
    required => 1,
);

has spaceship1 => (
    is       => 'ro',
    isa      => 'Games::SolarConflict::Spaceship',
    required => 1,
);

has spaceship2 => (
    is       => 'ro',
    isa      => 'Games::SolarConflict::Spaceship',
    required => 1,
);

has _controllers => (
    is      => 'ro',
    isa     => 'HashRef',
    lazy    => 1,
    builder => '_build_controllers',
);

sub _build_controllers {
    my ($self) = @_;

    return {
        main_menu => sub {
            my (%args) = @_;
            return Games::SolarConflict::Controller::MainMenu->new(%args);
        },
        main_game => sub {
            my (%args) = @_;
            return Games::SolarConflict::Controller::MainGame->new(%args);
        },
        game_over => sub {
            my (%args) = @_;
            return Games::SolarConflict::Controller::GameOver->new(%args);
        },
    };
}

around BUILDARGS => sub {
    my ( $orig, $class, %args ) = @_;

    my $app = SDLx::App->new(
        w     => 1024,
        h     => 768,
        title => 'SolarConflict',
        eoq   => 1,
    );

    my $assets = $args{assets};

    my %file = (
        background => $assets->file('background.png'),
        sun        => $assets->file('sun.png'),
        spaceship1 => $assets->file('spaceship1.png'),
        spaceship2 => $assets->file('spaceship2.png'),
        explosion  => $assets->file('explosion.png'),
    );

    my %view = (
        background => SDLx::Surface->load( $file{background} ),
        sun        => SDLx::Sprite->new( image => $file{sun} ),
        spaceship1 => Games::SolarConflict::Sprite::Rotatable->new(
            sprite => SDLx::Sprite::Animated->new(
                rect  => SDL::Rect->new( 0, 0, 32, 32 ),
                image => $file{spaceship1},
            ),
        ),
        spaceship2 => Games::SolarConflict::Sprite::Rotatable->new(
            sprite => SDLx::Sprite::Animated->new(
                rect  => SDL::Rect->new( 0, 0, 32, 32 ),
                image => $file{spaceship2},
            ),
        ),
        explosion => SDLx::Sprite::Animated->new(
            rect            => SDL::Rect->new( 0, 0, 32, 32 ),
            image           => $file{explosion},
            max_loops       => 1,
            ticks_per_frame => 2,
        ),
    );

    my @torpedos1 = map { Games::SolarConflict::Torpedo->new() } 1 .. 10;
    my @torpedos2 = map { Games::SolarConflict::Torpedo->new() } 1 .. 10;

    my %objects = (
        app        => $app,
        background => $view{background},
        sun        => Games::SolarConflict::Sun->new( sprite => $view{sun} ),
        spaceship1 => Games::SolarConflict::Spaceship->new(
            sprite    => $view{spaceship1},
            explosion => $view{explosion},
            torpedos  => \@torpedos1,
        ),
        spaceship2 => Games::SolarConflict::Spaceship->new(
            sprite    => $view{spaceship2},
            explosion => $view{explosion},
            torpedos  => \@torpedos2,
        ),
    );

    return $class->$orig( %args, %objects );
};

sub BUILD {
    my ($self) = @_;

    $self->transit_to('main_menu');
}

sub get_controller {
    my ( $self, $name, %args ) = @_;

    return $self->_controllers->{$name}->( %args, game => $self );
}

sub get_player {
    my ( $self, %args ) = @_;

    my $spaceship = 'spaceship' . $args{number};

    if ( $args{type} eq 'human' ) {
        return Games::SolarConflict::HumanPlayer->new(
            spaceship => $self->$spaceship );
    }
    else {
        return Games::SolarConflict::ComputerPlayer->new(
            spaceship => $self->$spaceship );
    }
}

sub transit_to {
    my ( $self, $state, %params ) = @_;

    my $app = $self->app;

    $app->remove_all_handlers();

    my $controller = $self->get_controller( $state, %params );

    $app->add_event_handler( sub { $controller->handle_event(@_) } )
        if $controller->can('handle_event');

    $app->add_move_handler( sub { $controller->handle_move(@_) } )
        if $controller->can('handle_move');

    $app->add_show_handler( sub { $controller->handle_show(@_) } )
        if $controller->can('handle_show');
}

__PACKAGE__->meta->make_immutable;

no Mouse;

1;

__END__

=head1 NAME

Games::SolarConflict - Spacewar! clone

=head1 SYNOPSIS

    perl solarconflict.pl

=head1 DESCRIPTION

Games::SolarConflict is a Spacewar! clone.

=head1 BUGS AND LIMITATIONS

Please report bugs at: https://github.com/jtpalmer/Games-SolarConflict/issues

=head1 AUTHOR

Jeffrey T. Palmer C<< <jtpalmer@cpan.org> >>

=head1 SEE ALSO

=over 4

=item *

L<SDL>

=item *

L<http://en.wikipedia.org/wiki/Spacewar!>

=back

=cut
