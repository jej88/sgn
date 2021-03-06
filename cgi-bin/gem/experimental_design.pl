#!/usr/bin/perl

=head1 NAME

  experimental_design.pl
  Controller for experimental design mason components

=cut
 
=head1 DESCRIPTION

  This is the script to show the web_page using MASON

=cut

=head1 AUTHORS

 Aureliano Bombarely Gomez
 (ab782@cornell.edu)

=cut


use strict;
use warnings;

use HTML::Mason;
use CXGN::Page;

use CXGN::MasonFactory;
use CXGN::DB::Connection;
use CXGN::DB::DBICFactory;
use CXGN::GEM::Schema;
use CXGN::GEM::ExperimentalDesign;

my $m = CXGN::MasonFactory->new();

## Use of CXGN::Page to take the arguments from the URL

my %args = CXGN::Page->new()
                     ->get_all_encoded_arguments();


## Create the schema used for all the gem searches

my $psqlv = `psql --version`;
chomp($psqlv);

my @schema_list = ('gem', 'biosource', 'metadata', 'public');
if ($psqlv =~ /8\.1/) {
    push @schema_list, 'tsearch2';
}

my $schema = CXGN::DB::DBICFactory->open_schema( 'CXGN::GEM::Schema', search_path => \@schema_list, );


my $expdesign = CXGN::GEM::ExperimentalDesign->new($schema);
if (exists $args{'id'} && $args{'id'} =~ m/^\d+$/) {
   $expdesign = CXGN::GEM::ExperimentalDesign->new($schema, $args{'id'});
} elsif (exists $args{'name'}) {
   $expdesign = CXGN::GEM::ExperimentalDesign->new_by_name($schema, $args{'name'});
}

my @exp_list;
if (defined $expdesign->get_experimental_design_id() ) {
    @exp_list = $expdesign->get_experiment_list();
}

my @pubs = ();
if (defined $expdesign->get_experimental_design_id()) {
   @pubs = $expdesign->get_publication_list();
}


## There are two ways to access to the page, using id=int or name=something. If use other combinations give an error message 

if (defined $expdesign->get_experimental_design_id or defined $expdesign->get_experimental_design_name ) {
    $m->exec('/gem/experimental_design_detail.mas', 
	     schema    => $schema, 
	     expdesign => $expdesign, 
	     pub_list  => \@pubs, 
	     exp_list  => \@exp_list );
} else {
    $m->exec('/gem/gem_page_error.mas', 
	     schema => $schema, 
	     object => $expdesign );
}

