#!/usr/bin/perl -w

# Convert .Xdefaults or similar terminal colors to iTerm2 scheme
# Only supports simple hex colors, no funny stuff

use strict;

print <<eof;
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
eof

my %cols = (
    2 => "Blue",
    1 => "Green",
    0 => "Red",
);

while (<>) {
    if(/^[^!]*color(\d+):\s+#(\w{6})/) {
        print "\t<key>Ansi $1 Color</key>\n\t<dict>\n";
        print &do_color($2);
        print "\t</dict>\n";
    } elsif(/^[^!]*(fore|back)ground:\s+#(\w{6})/) {
        my $fb = $1;
        $fb =~ tr/fb/FB/;
        print "\t<key>" . $fb . "ground Color</key>\n\t<dict>\n";
        print &do_color($2);
        print "\t</dict>\n";
    }
}

print "</dict>\n</plist>";

sub do_color {
    my $i = 0;
    my $ret = '';
    for (shift =~ m/.{2}/gs) {
        $ret .= "\t\t<key>$cols{$i} Component</key>\n\t\t<real>";
        $ret .= sprintf("%.16f", hex($_)/255);
        $ret .= "</real>\n";
        $i++;
    }
    return $ret;
}