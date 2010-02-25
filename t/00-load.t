#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Log::WithCallbacks' ) || print "Bail out!
";
}

diag( "Testing Log::WithCallbacks $Log::WithCallbacks::VERSION, Perl $], $^X" );
