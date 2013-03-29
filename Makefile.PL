#!/usr/bin/env perl
use strict;
use warnings;
use ExtUtils::MakeMaker;

my( $mm ) = $ExtUtils::MakeMaker::VERSION =~ /^([^_]+)/;

WriteMakefile(
    NAME          => 'SMS::Send::RU::SMS',
    VERSION_FROM  => 'lib/SMS/Send/RU/SMS.pm',
    ABSTRACT_FROM => 'lib/SMS/Send/RU/SMS.pm',
    AUTHOR        => 'Sergey Romanov <sromanov@cpan.org>',
    PREREQ_PM     => {
        'SMS::Send'   => '0',
        'HTTP::Tiny'  => '0',
        'Digest::SHA' => '0',
    },
    ( $mm >= 6.31
        ? ( LICENSE => 'artistic_2' )
        : ()
    ),
    ( $mm < 6.46
        ? ()
        : ( META_MERGE => {
                resources => {
                    license    => 'http://dev.perl.org/licenses/',
                    repository => 'http://github.com/sergeyromanov/sms-send-ru-sms',
                    bugtracker => 'http://github.com/sergeyromanov/sms-send-ru-sms/issues'
                },
                no_index => {directory => [qw/t xt examples/]},
            },
            META_ADD => {
                build_requires     => {},
                configure_requires => {},
                test_requires      => {
                    'Test::More'   => '0.47',
                },
            },
        )
    ),
    test => { TESTS => 't/*.t' }
);
