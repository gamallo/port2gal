#!/usr/bin/perl -w

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;

$file = shift(@ARGV);
open (FILE, $file) or die "O ficheiro não pode ser aberto: $!\n";


while ($v = <FILE>) {
    chomp $v;
    if ($v =~ /ir$/) {
      $VerbsIR{$v}++;
    }
    elsif ($v =~ /er$/) {
      $VerbsER{$v}++;
    }

  }

while ($line = <>) {
      chomp($line);

      #corregir investemento....:
    my @listPals;
    my $p;
    (@listPals) = split (" ", $line);
    $line="";
    foreach $p (@listPals) {

       ##investemento -> investimento
      if ($p =~ /emento/) {
         ($raiz) = split ("emento", $p);
         $inf = $raiz . "ir";
        # print STDERR "$raiz\n";
         if (defined $VerbsIR{$inf}) {
            $p =~ s/emento/imento/i;
         }

      }

      ##comí -> comi
      elsif ($p =~ /í$/) {
         ($raiz) = split ("í", $p);
         $inf3 = $raiz . "ir";
         $inf2 = $raiz . "er";
        # print STDERR "$raiz\n";
         if ( (defined $VerbsIR{$inf3}) || (defined $VerbsER{$inf2}) ) {
            $p = $p . "n";
         }

      }




      $line .= $p . " ";
    }
    print "$line\n";
}



