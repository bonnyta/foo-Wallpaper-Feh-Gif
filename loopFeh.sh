#!/bin/bash
[ "$#" -lt "1" ] || [ "$#" -gt "2" ] && {  echo -e "ERROR : args number invalid \n $0 speed /path/name.gif" ; echo "try 0.010 as speed" ; exit 1 ; }
dir=/tmp/back4  
#example of speed  : 0.010
speed=$1
name=$2

[[ "`which feh 1>/dev/null ; echo $?`" == "0" ]] && { prog='feh --bg-fill $dir/$hash/$i ' ; }
[[ "`which xfconf-query 1>/dev/null ; echo $?`" == "0" ]] && { prog='xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -s $dir/$hash/$i '; }
[[ "`which osascript  1>/dev/null ; echo $?`"  == "0" ]]  && { prog='osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$dir/$hash/$i\" " '; }
#osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/davidwalsh/Downloads/pubg-background.jpg"'

[[ "$name" == "" ]] && { name=$speed ; speed=${name##*-} ; }

#hash=`md5sum $name | cut -f1 -d" "`
[[ "`which osascript  1>/dev/null ; echo $?`"  == "0" ]]  && { hash=`md5 $name | cut -f4 -d" "`  ; } || { hash=`md5sum $name | cut -f1 -d" "` ;}

[[ ! -d $dir ]] && mkdir $dir 

[[ ! -d $dir/$hash ]] && { mkdir $dir/$hash ; echo "spliting .." ; convert -coalesce $name $dir/$hash/$hash.png ; echo ok ; }

while : ; do for i in ` ls -rt $dir/$hash  ` ; do osascript -e "tell application \"System Events\" to tell every desktop to set picture to  \"$dir/$hash/$i\" "   ; sleep $speed ; done ; done    
   