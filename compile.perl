#!/usr/bin/perl -w

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;


while ($line = <STDIN>) {
    
    if ($line =~ /First Part/) {
	print $line;
	print " my \$line_orig = \$line;\n";
        print "(my \@line) = split (\" \", \$line);\n";
	print "my \$i=0;\n";
        print "my \@oov=();\n";
        print "foreach my \$tok (\@line) {\n";
        print "  if (\$tok =~ /^\\*/) {\n";
	print "    \$tok =~ s/\[\*\]\+//g;\n";
	print "    \$tok =~ s/^\\*//;\n";
	print "    \@oov[\$i] = \$tok;\n";
	print "    \$i++;\n";
	print "  }\n";
	print " }\n";
	print "for (my \$oov=0;\$oov<=\$#oov;\$oov++) {\n";
	print "\$line = \$oov[\$oov];\n";
    }
    elsif ($line =~ /Second Part/) {
	print $line;
	print "\$line_orig =~ s/\\*\$oov[\$oov]/\$line/g;\n";
    
        print "}\n";
        print "print \"\$line_orig\\n\";\n";
    }
    elsif ($line =~ /print \"\$line\\n\"/) {next}
    else {
	print $line;
    }
 }
    



