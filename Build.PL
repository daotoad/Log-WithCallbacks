#!perl

use Module::Build;

Module::Build->new(
    module_name         => 'Log::WithCallbacks',
    license             => 'perl',
    dist_author         => 'Mark Swayne <mark_swayne@charter.net>',
    requires => {
        perl            => '5.6.0',
    },
    build_requires => {
        'Test::More'    => 0,
    },
    create_makefile_pl  => 'traditional',
    create_packlist     => 1,
)->create_build_script;

