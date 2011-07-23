#!perl

use Test::More tests => 1;

BEGIN {
    use_ok( 'Games::SolarConflict' ) || print "Bail out!\n";
}

diag( "Testing Games::SolarConflict $Games::SolarConflict::VERSION, Perl $], $^X" );
