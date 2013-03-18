#!/usr/bin/env perl
use strict;
use warnings;
use Test::More qw( no_plan );

BEGIN {
    use_ok('SMS::Send');
    use_ok('SMS::Send::RU::SMS');
}

my $sender = new_ok('SMS::Send', ['RU::SMS',
    _login    => 'Gandalf',
    _password => 'friend',
]);
