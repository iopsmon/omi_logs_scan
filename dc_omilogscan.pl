#!/usr/bin/perl
##+——————————————————————————-+
##DESCRIPTION: copys all the omi logs into a new folder and scans for severity levels, see below variables / only for Linux OMi
##USE:perl dc_omilogscan.pl
##EXAMPLE:
##DATE:18/11/2016
##AUTHOR:Deepak Chohan
##VERSION:
##+——————————————————————————-+

use warnings;
use strict;
use POSIX qw(strftime);

#My Variables
my $datestring = strftime “%Y-%m-%d”, localtime;
my $MYPATH = “./”;
my $OMILOGS = “/opt/HP/BSM/log” ;
my $MYLOGSFOLDER = “/tmp/omilogs” ;

#Severity Levels
my $SLEVEL1 = “ERROR”;
my $SLEVEL2 = “WARN”;
my $SLEVEL3 = “DEBUG”;

 
#This gets the OMI log folder sizes – combined total
sub MyLogFolderSize 
  {
   my $LogSize = `du -s $OMILOGS` ;
   print ” The OMI Folder Size is : $LogSize\n” ;
  }


#creates new files
my $omireportlog = “$MYPATH/all_omilogs_report.txt”;
open( my $logfile1, ‘>’, $omireportlog) or die “Could not open file ‘$omireportlog’ $!”;

#This ones just for ERROR Matches
my $omierrorreportlog = “$MYPATH/omi_error_report.txt”;
open( my $logfile2, ‘>’, $omierrorreportlog) or die “Could not open file ‘$omierrorreportlog’ $!”;

#This ones for WARN matches
my $omiwarningreportlog = “$MYPATH/omi_warning_report.txt”;
open( my $logfile3, ‘>’, $omiwarningreportlog) or die “Could not open file ‘$omiwarningreportlog’ $!”;

#This ones for DEBUG matches – you need to enabled dugging for the right files – see omi help
my $omidebugreportlog = “$MYPATH/omi_debug_report.txt”;
open( my $logfile4, ‘>’, $omidebugreportlog) or die “Could not open file ‘$omidebugreportlog’ $!”;

 
#This removes old folders, makes a new one and copies all the OMi logs to it
sub MyGetLogFolders 
  {
   `rm -fr $MYLOGSFOLDER`;
   `mkdir $MYLOGSFOLDER`;
   print “Please Wait Logs Are Being Copied”;
   `cp -R $OMILOGS $MYLOGSFOLDER`;
  }

 

#This scans the log files for the current date and and ERROR or WARN log entries
sub MyScanLogs 
  {
    my @files = `find $MYLOGSFOLDER -name “*.log”`;
    foreach my $file(@files) {
	open FILE, “$file” or die “Unable to open files”;
	while(<FILE>) {
	 if (/\Q$datestring/ && /$SLEVEL1/) {
	 print “$file $_\n”;
	 print $logfile2 “$file $_\n”;
   }
	 if (/\Q$datestring/ && /$SLEVEL2/) {
	 print “$file $_\n”;
	 print $logfile3 “$file $_\n”;
	}
	 if (/\Q$datestring/ && /$SLEVEL3/) {
	 print “$file $_\n”;
	 print $logfile4 “$file $_\n”;
   }
  }
 }
}


#Gets the folder size
MyLogFolderSize() ;
#Removes the old folder, makes a new one and copys the logs to it
MyGetLogFolders ();
#Scans the logs files
MyScanLogs ();
#
#close $logfile1;
close $logfile2;
close $logfile3;
close $logfile4;

#End of Script 