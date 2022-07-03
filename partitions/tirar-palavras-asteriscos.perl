#!/usr/bin/perl -w

my $count=0;
while ($line = <STDIN>) {
   chomp $line; 
   @line = split (" ", $line); 
   foreach my $tok (@line) {
       if ($tok =~ /^\*/) {
         print "$tok\n";
       }
   }
}
