#!/usr/bin/perl -w
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;

$file = shift(@ARGV);
open (FILE, $file) or die "O ficheiro n�o pode ser aberto: $!\n";

$symb = "\*\+\?\¿\!\¡\'\"\#\(\)\\[\\]\¨\{\}\\\\";

while (my $pair = <FILE>) {
    chomp $pair;
    my ($orig, $translit) = split ('\t', $pair);
    $orig =~ s/[$symb]+//g;
    $orig =~ s/^[$symb]//;
    $translit =~ s/[$symb]+//g;
    $translit =~ s/^[$symb]//;

    $Dico{$orig} = $translit;

}


my $count=0;
while ($line = <STDIN>) {
   chomp $line; 
   @line = split (" ", $line); 

   foreach my $tok (@line) {
       if ($tok =~ /^\*/) {
	   $tok =~ s/[$symb]+//g;
           $tok =~ s/^[$symb]//;
	   $line =~ s/\*$tok/$Dico{$tok}/g if ($Dico{$tok});
       }
   }
   $line =~ s/\*//g;
   print "$line\n";
}
