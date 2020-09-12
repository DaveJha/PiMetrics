#!/usr/bin/perl

use JSON;

$path = "</opt/wifimetrics/tempdata/wifi";

open(DATA, $path) or die "Could not find file wifi to parse, $!";


@lines = <DATA>;
$unparsedmac = $lines[1];
$unparsedfreq = $lines[3];
$unparsedqual = $lines[4];
$unparsedessid = $lines[6];

$unparsedmac =~ s/\s+//g;
$unparsedfreq =~ s/\s+//g;
$unparsedqual =~ s/\s+//g;
$unparsedessid =~ s/\s+//g;

$mac = substr $unparsedmac, -17;

$freq = substr $unparsedfreq, index($unparsedfreq, ':')+1, (index($unparsedfreq, 'G')-(index($unparsedfreq, ':')+1));

$quality = substr $unparsedqual, index($unparsedqual, '=')+1, (index($unparsedqual, 'S')-(index($unparsedqual, '=')+1));

$signal = substr $unparsedqual, index($unparsedqual, '=', index($unparsedqual, '=')+1)+1, (index($unparsedqual, 'd')-index($unparsedqual, '=', index($unparsedqual, '=')+1)-1);

$essid = substr $unparsedessid, index($unparsedessid, '"')+1, index($unparsedessid, "'");

$firstInt = substr $quality, 0, index($quality, '/');

$secondInt = substr $quality, index($quality, '/')+1;

if ($secondInt == 0) {
  $quality = $firstInt;
}
else {
  $quality = $firstInt / $secondInt;
}

my %data = (
    "tags" => {
      "test" => "wifiparse",
      "essid"  => $essid,
    },
    "fields" => {
      "freq" => $freq+0,
      "quality"  => $quality,
      "signal"  => $signal+0,
      "mac"  => $mac,
    }
);



open(my $fh, '>', '/opt/wifimetrics/results/resultswifi.json');
my $data_json = encode_json \%data;
print $fh $data_json;
close $fh || die "Couldn't close results file properly";
print "Outputted data to results \n";


close(DATA) || die "Couldn't close file properly";
