#!/usr/bin/env perl
#
# Author: mc.cheung
# Email:  mc.cheung@aol.com
# DateCreated: 2014/11/18

use strict;
use warnings;

use Data::Dumper;
use WWW::DomainSearch qw/search_with_list/;

my @domains = qw/kck6 baba lala lolo lulu nana haha hoho/;
my @suff    = qw/net com/;

my $ok_domains = search_with_list( \@domains, \@suff );
print Dumper($ok_domains);
