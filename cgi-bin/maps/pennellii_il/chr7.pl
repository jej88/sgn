use strict;
use CXGN::Page;
my $page=CXGN::Page->new('chr7.html','html2pl converter');
$page->header('L. Pennellii Chromosome 7');
print<<END_HEREDOC;

  <img alt="" src="/documents/maps/pennellii_il/Slide7.PNG" />
END_HEREDOC
$page->footer();
