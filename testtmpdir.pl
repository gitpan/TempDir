#!/usr/bin/perl -I.

use TempDir;

my $dir = TempDir->new;

print "The temporary directory of your $^O OS is $dir\n";

my $file = $dir."/temporayfile$$";

print "I'm opening the temporary file $file\n";

open (OUT, ">$file") || die "Couldn't open output file $file\n";
print OUT "Test\n";
close (OUT);

print "I'm deleting the temporary file $file\n";
unlink ($file);
