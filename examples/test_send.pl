#!/usr/bin/env perl

use 5.012;
use utf8;

use SMS::Send;

my $sender = SMS::Send->new('RU::SMS',
    _login    => $ENV{SMS_LOGIN},
    _password => $ENV{SMS_PASSWORD},
);

my $sent = $sender->send_sms(
    text  => 'Алиса, миелофон!',
    to    => $ENV{MY_NUMBER},
    _test => 1,
);

if ( $sent ) {
    say "Message sent OK";
}
else {
    say "Failed to send message";
}
