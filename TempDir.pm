#
# TempDir.pm, version 1.2 30 September 1999
#
# Copyright (c) 1999 SANFACE Software
# mailto:sanface@sanface.com
# http://www.sanface.com
# 
# Free usage under the same Perl Licence condition.
#

package TempDir;

use strict;
use vars qw($VERSION);
$VERSION = "1.2";

sub new
  {
      my $tempdir;

# Windows 32 bit ('95, '98, NT)
      if ($^O =~ /^MSWin32$/i)      {$tempdir=&find_win_temp_dir}

# Unix
      elsif ($^O =~ /^aix$/i)           {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^bsd386$/i)        {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^dec_osf$/i)       {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^dgux$/i)          {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^freebsd$/i)       {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^hp_osf1$/i)       {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^hpux$/i)          {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^irix$/i)          {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^linux$/i)         {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^mips_osf1$/i)     {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^netbsd$/i)        {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^next$/i)          {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^sco$/i)           {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^sco_xenix$/i)     {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^solaris$/i)       {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^sunos$/i)         {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^svr4$/i)          {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^sysv$/i)          {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^ultrix$/i)        {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^uts$/i)           {$tempdir=&find_unix_temp_dir}
      elsif ($^O =~ /^solaris$/i)       {$tempdir=&find_unix_temp_dir}

# Mac     [from Chris Nandor mailto:pudge@pobox.com]
      elsif ($^O =~ /^MacOS$/i)     {$tempdir=$ENV{TMPDIR}}

# BeOS    [from David Cantrell mailto:david@wirestation.co.uk]
      elsif ($^O =~ /beos/)          {$tempdir="/tmp"}
# /tmp, which is a symlink to /boot/var/tmp.
# It's probably a good idea to use /tmp though in case it changes in the future.# Does it support $ENV{'TEMP'} ?
# Not sure.

# OpenVMS [from Dave Smith mailto:smith@nwoca.org]
      elsif ($^O =~ /VMS/)          {$tempdir="/sys\$scratch"}
# or  elsif ($^O =~ /VMS/)          {$tempdir="SYS\$SCRATCH"}

# default .
      else {$tempdir="."}

      return $tempdir;
  }

sub find_win_temp_dir(){
        for ($ENV{TEMP}, $ENV{TMP},
                        $ENV{windir} . '\\temp', 'c:\\temp', '.')
        { return $_ if $_ and -d and -r _ and -w _ }
        die "Can't find a temp directory\n";
}

sub find_unix_temp_dir(){
        for ($ENV{TMPDIR}, '/var/tmp', '/usr/tmp', '/tmp', '.')
        { return $_ if $_ and -d and -r _ and -w _ }
        die "Can't find a temp directory\n";
}

1;

__END__

=head1 NAME

TempDir - Module to check the correct temporary directory in every OS supported
by PERL

=head1 SYNOPSIS

  use TempDir;

  $dir=TempDir->new ;

  print "Correct temporary directory in the $^O OS is $dir\n";

=head1 DESCRIPTION

What's the problem?
Every PERL tool use temporary files.
If you want your code can be simply portable on different OS, you need to select
the correct temporary directory.
The purpose of this module is to check the correct temporary directory in every
OS supported by PERL to use it.
We need your help.
We ask you to send us the correct tempory directory for every OS supported by
PERL and to suggest us good modifies (<sanface@sanface.com>).

At the moment this is the list of OS supported and the list of variables and
directories the module check to find the correct to use:
Windows 32 bit ('95, '98, NT)
$ENV{TEMP}, $ENV{TMP}, $ENV{windir} . '\\temp', 'c:\\temp', '.'

Unix
  [aix bsd386 dec_osf dgux freebsd hp_osf1 hpux irix linux mips_osf1 netbsd next
   sco sco_xenix solaris sunos svr4 sysv ultrix uts]
$ENV{TMPDIR}, '/var/tmp', '/usr/tmp', '/tmp', '.'

Mac                           $ENV{TMPDIR}
OpenVMS                       /sys\$scratch (or SYS\$SCRATCH)
beos                          /tmp

=head1 Constructor

=over 4

=item B<new>

This is the constructor and the only method of this library. It returns the
correct temporary directory if it checks correctly the OS, otherwise it returns
the default directory B<.>

=back

=head1 Copyright

  Copyright 1999, SANFACE Software

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 Availability

The latest version of this library is likely to be available from:

http://www.sanface.com

and at any CPAN mirror ( http://www.perl.com/CPAN/authors/id/S/SA/SANFACE/ )

=cut

