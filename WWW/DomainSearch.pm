package WWW::DomainSearch;
use strict;
use warnings;

use LWP::UserAgent;
use JSON qw/from_json/;

require Exporter;
our @ISA       = qw/Exporter/;
our @EXPORT_OK = qw/search_with_list/;

sub search_with_list {
    my ( $domain_list, $suff ) = @_;

    # $domain_list and $suff need a Array ref
    return if ref $suff ne 'ARRAY';
    return if ref $domain_list ne 'ARRAY';

    my @ok_domains;
    my $ua = init_ua();

    foreach my $domain (@$domain_list) {
        foreach my $suff (@$suff) {
            my $domain = $domain . '.' . $suff;
            my $url    = "http://www.qiuyumi.org/query/whois.$suff.php";
            my $res    = $ua->post( $url, { name => $domain, } );

            my $json;
            eval { $json = from_json( $res->content ); };
            next unless $json;
            next unless $json->{available};

            if ( $json->{available} eq 'true' || $json->{available} eq '1' ) {
                push @ok_domains, $domain;
            }
        }
    }

    return \@ok_domains;
}

sub init_ua {
    my $ua = LWP::UserAgent->new();
    $ua->default_header( 'X-Requested-With' => 'XMLHttpRequest' );
    return $ua;
}

1;
