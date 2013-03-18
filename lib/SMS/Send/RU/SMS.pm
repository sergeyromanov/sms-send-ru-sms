package SMS::Send::RU::SMS;

use strict;
use warnings;

use base 'SMS::Send::Driver';

use Digest::SHA qw(sha512_hex);
use HTTP::Tiny;

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

1;
