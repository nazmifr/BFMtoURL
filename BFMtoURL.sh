#!/bin/bash
beginswith() { case $2 in "$1"*) true;; *) false;; esac; }
message="There has been an error (or some links have expired, Whoops!). The ((developper)) is aware of it and working on fixing it. Check https://github.com/nazmifr/BFMtoURL for more info"

# to help me repair the script as soon as there is an update on the BFMTV website, the urls are logged, comment the appropriate line to disable this function, as you can see in the source, nothing personal is sent, but it's always good to check any .sh script you run
#urlin=https://www.bfmtv.com/paris/replay-emissions/bonjour-paris/comment-est-transporte-le-vaccin-une-entreprise-de-rueil-malmaison-a-mis-au-point-une-boite-refrigeree_VN-202101060214.html
# check if there is STDIN, if not, get the first parameter $1 and check if it starts with https (no batch files starting with https:// please), if so it is parsed as single url, if not, the file is opened with a loop for each line to parse
if test ! -t 0; then
	urlin=`cat -`
	videoid=`curl -s $urlin | grep -Eo "videoid=\"[0-9]{1,}.|data-video-id=\"[0-9]{1,}." | cut -d\" -f2- | sed 's/.$//'`
	accountid=`curl -s $urlin | grep -Eo "accountid=\"[0-9]{1,}.|data-account=\"[0-9]{1,}." | cut -d\" -f2- | sed 's/.$//'`
	url="http://players.brightcove.net/$accountid/default_default/index.html?videoId=$videoid"
	if [ -n "$accountid" ]; then
    echo $url
	else
	echo ""
	errormsg=$message
	fi
	curl -s -o /dev/null "https://nazmi.fr/bugs/bfmtourl.php?value1=$accountid&value2=$videoid&source=$urlin"
else
	urlinput=$1
	if beginswith https:// "$urlinput"; then
    urlin=$urlinput
	videoid=`curl -s $urlin | grep -Eo "videoid=\"[0-9]{1,}.|data-video-id=\"[0-9]{1,}." | cut -d\" -f2- | sed 's/.$//'`
	accountid=`curl -s $urlin | grep -Eo "accountid=\"[0-9]{1,}.|data-account=\"[0-9]{1,}." | cut -d\" -f2- | sed 's/.$//'`
	url="http://players.brightcove.net/$accountid/default_default/index.html?videoId=$videoid"
	if [ -n "$accountid" ]; then
    echo $url
	else
	errormsg=$message
	echo ""
	fi
	curl -s -o /dev/null "https://nazmi.fr/bugs/bfmtourl.php?value1=$accountid&value2=$videoid&source=$urlin"
	else
		while read LINE
		do     
			#echo $LINE
			urlin=$LINE
			videoid=`curl -s $urlin | grep -Eo "videoid=\"[0-9]{1,}.|data-video-id=\"[0-9]{1,}." | cut -d\" -f2- | sed 's/.$//'`
			accountid=`curl -s $urlin | grep -Eo "accountid=\"[0-9]{1,}.|data-account=\"[0-9]{1,}." | cut -d\" -f2- | sed 's/.$//'`
			#videoid=`curl -s $urlin | grep -Eo "videoid=\"[0-9]{1,}." | cut -d\" -f2- | sed 's/.$//'`
			#accountid=`curl -s $urlin | grep -Eo "accountid=\"[0-9]{1,}." | cut -d\" -f2- | sed 's/.$//'`
			url="http://players.brightcove.net/$accountid/default_default/index.html?videoId=$videoid"
			if [ -n "$accountid" ]; then
			echo $url
			else
			echo ""
			errormsg=$message
			fi
			curl -s -o /dev/null "https://nazmi.fr/bugs/bfmtourl.php?value1=$accountid&value2=$videoid&source=$urlin"
		done < $urlinput
	fi
fi
echo ""
echo ""
echo "$errormsg"
