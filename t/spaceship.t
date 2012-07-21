use strict;
use warnings;
use Test::More;
use Test::MockObject;
use SDL;
use Games::SolarConflict::Spaceship;

$ENV{SDL_VIDEODRIVER} = 'dummy' unless $ENV{RELEASE_TESTING};

my $sprite = Test::MockObject->new();
$sprite->set_isa('Games::SolarConflict::Sprite::Rotatable');
my $explosion = Test::MockObject->new();
$explosion->set_isa('SDLx::Sprite::Animated');

my $ship = Games::SolarConflict::Spaceship->new(
    x         => 1,
    y         => 1,
    v_x       => 10,
    v_y       => 10,
    mass      => 100,
    sprite    => $sprite,
    explosion => $explosion,
);

ok $ship->does('Games::SolarConflict::Roles::Physical'),
    '$ship does Physical';
ok $ship->does('Games::SolarConflict::Roles::Drawable'),
    '$ship does Drawable';

is $ship->x, 1, '$ship->x';

done_testing();

