#!/usr/bin/env perl
use strict;
use warnings;
use Plack::Builder;

# psgi-dev 用。mt.psgi の前段で公開ディレクトリを返す。
# 管理画面（mt.cgi など）と mt-static は MT::PSGI に任せる。
my $html_root = $ENV{MT_HTML_ROOT} || '/var/www/local/html';

my $mt_app = do './mt.psgi';
die "failed to parse mt.psgi: $@" if $@;
die "failed to load mt.psgi: $!"  unless defined $mt_app;

my $mt_path = qr{^/(?:mt\.cgi|mt-[^/]+\.cgi|mt-static)(?:/|$)};

builder {
    enable sub {
        my $app = shift;
        sub {
            my $env  = shift;
            my $path = $env->{PATH_INFO} // '/';
            if ( $path eq '' || $path eq '/' ) {
                $env->{PATH_INFO} = '/index.html';
            }
            elsif ( $path =~ m{/$} && $path !~ $mt_path ) {
                $env->{PATH_INFO} .= 'index.html';
            }
            return $app->($env);
        };
    };

    enable 'Static',
        path => sub { $_[0] !~ $mt_path },
        root         => $html_root,
        pass_through => 1;

    $mt_app;
};
