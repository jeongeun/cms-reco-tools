#!/bin/bash
jid=$1
while [ -f /proc/$jid/statm ]; do 
    cat /proc/$jid/statm
    sleep 0.1 
done | awk 'BEGIN{max=0;n=0}{if($2>max){max=$2; tstr=strftime(); print n" "max*4" "tstr;};n++; if(n%100==0)print n" "max*4" "tstr" Now "$2*4" "strftime()}END{print max*4}'
