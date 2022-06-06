#! /usr/bin/perl

# update fhmdbstruct

# copyright (c) 2010 asip solutions, inc. all rights reserved.

# usage:
#   run this script at ASIPmeister/share/fhmdb/

open f, ">fhmdbstruct" or die;
select f;
print "<FHM_Structure>\n";
foreach $lib (glob "*") {
  if (-d $lib) {
    #print $lib;
    print "  <library name=\"$lib\">\n";
    foreach $cls (glob "$lib/*") {
      if (-d $cls) {
        #print $cls;
        $cls =~ /(.*)\/(.*)/;
        print "    <class name=\"$2\">\n";
        foreach $fhm (glob "$cls/*.fhm") {
          #print $fhm;
          $fhm =~ /(.*)\/(.*)\/(.*)\.fhm/;
          #print "$1-$2-$3\n";
          print "      <model>$3</model>\n";
        }
        print "    </class>\n";
      }
    }
    print "  </library>\n";
  }
}
print "</FHM_Structure>\n";
close f;
print STDERR "fhmdbstruct updated.\n";
