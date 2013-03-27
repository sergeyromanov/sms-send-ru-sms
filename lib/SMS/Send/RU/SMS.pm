package SMS::Send::RU::SMS;

use strict;
use warnings;

use base 'SMS::Send::Driver';

use Digest::SHA qw(sha512_hex);
use HTTP::Tiny;

our $VERSION = '0.01';

my $send_url  = 'http://sms.ru/sms/send';
my $token_url = 'http://sms.ru/auth/get_token';

sub new {
    my $class = shift;

    my $self = {
        _ua => HTTP::Tiny->new,
        @_,
    };

    return bless $self, $class;
}

sub send_sms {
    my( $self, %args ) = @_;

    my $res = $self->{_ua}->post_form($send_url,
    {
        ( $self->{_api_id}
            ? ( api_id => $self->{_api_id} )
            : do {
                my $token = $self->_get_token;
                (
                    login  => $self->{_login},
                    token  => $token,
                    sha512 => sha512_hex($self->{_password} . $token),
                )
              }
        ),
        (map { (/^_(.+)/ ? $1 : $_) => $args{$_} } keys %args),
    });

    return $res->{content} =~ /^100\b/;
}

sub _get_token {
    my $self = shift;

    return $self->{_ua}->get($token_url)->{content};
}

1 && q[David Bowie - Life On Mars?];

__DATA__

=head1 NAME

SMS::Send::RU::SMS - L<SMS::Send> backend for L<http://sms.ru>

=head1 SYNOPSIS

    use SMS::Send;

    my $sender = SMS::Send->new('RU::SMS',
        _login    => 'sms_ru_login',
        _password => 'sms_ru_password',
    );

    my $sent = $sender->send_sms(
        text => "Perl is dead, but I'm not dead yet",
        to   => '79212128506',
    );

    if ( $sent ) {
        say "Message sent OK";
    }
    else {
        say "Failed to send message";
    }

=head1 SEE ALSO

L<SMS::Send> - base class to use this one.

=head1 AUTHOR

Sergey Romanov, C<sromanov@cpan.org>.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2013 by Sergey Romanov.

This library is free software; you can redistribute it and/or modify
it under the terms of the Artistic License version 2.0.

=cut
