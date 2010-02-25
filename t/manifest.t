#!perl -T

use strict;
use warnings;
use Test::More;

eval "use Test::CheckManifest 0.9; 1" 
    or plan( skip_all => "Test::CheckManifest 0.9 required for MANIFEST test" );

ok_manifest();
