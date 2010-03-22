#!/usr/bin/perl
use strict;
# mpdmon-realtime
# Copyright (C) trapd00r 2010
# This version of mpdmon shows a one-line string with playingtime/totaltime
# and the artist/album/title. Good for including in screens hardstatusline,
# conky, dzen2, your small shell up in the right corner or whatever.
# If you want to be able to see history, you'll want mpdmon-full;
# http://github.com/trapd00r/mpdmon-full

use Audio::MPD;
my $mpd = Audio::MPD->new;

sub monitor {
  my $np = "";
  while(1) {
    my $current = $mpd->current;
    my $output;
    if(!$current) {
      $output = 'undef';
      $current = 'undef';
    }
    else {
      $output = $mpd->current->artist . ' - ' . 
                $mpd->current->album  . ' - ' .
                $mpd->current->title;
    }
    my $time1 = $mpd->status->time->sofar;
    my $time2 = $mpd->status->time->total;
    
    $| = 1;
    printf(" [%s/%s]\r", $time1, $time2);
    if("$np" ne "$current") {
      $np = $current;
      printf("\t\t%s\r", $output);
    }
    sleep 1;
  }
}

&monitor;
