#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 2;

use SMS::Send;

my( $sender, $sent );

$sender = SMS::Send->new('RU::SMS',
    _login    => $ENV{SMS_LOGIN},
    _password => $ENV{SMS_PASSWORD},
);

$sent = $sender->send_sms(
    text  => 'Hello you',
    to    => $ENV{MY_NUMBER},
    _test => 1,
);

ok($sent, "Message with login/password sent OK");

$sender = SMS::Send->new('RU::SMS',
    _api_id => $ENV{SMS_API_ID}
);

$sent = $sender->send_sms(
    text  => 'Hello again',
    to    => $ENV{MY_NUMBER},
    _test => 1,
);

ok($sent, "Message with api_id sent OK");
