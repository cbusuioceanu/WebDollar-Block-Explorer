#!/bin/bash

#### COLOR SETTINGS ####
BLACK=$(tput setaf 0 && tput bold)
RED=$(tput setaf 1 && tput bold)
GREEN=$(tput setaf 2 && tput bold)
YELLOW=$(tput setaf 3 && tput bold)
BLUE=$(tput setaf 4 && tput bold)
MAGENTA=$(tput setaf 5 && tput bold)
CYAN=$(tput setaf 6 && tput bold)
WHITE=$(tput setaf 7 && tput bold)
BLACKbg=$(tput setab 0 && tput bold)
REDbg=$(tput setab 1 && tput bold)
GREENbg=$(tput setab 2 && tput bold)
YELLOWbg=$(tput setab 3 && tput bold)
BLUEbg=$(tput setab 4 && tput dim)
MAGENTAbg=$(tput setab 5 && tput bold)
CYANbg=$(tput setab 6 && tput bold)
WHITEbg=$(tput setab 7 && tput bold)
STAND=$(tput sgr0)

### System dialog VARS
showinfo="$GREEN[info]$STAND"
showerror="$RED[error]$STAND"
showexecute="$YELLOW[running]$STAND"
showok="$MAGENTA[OK]$STAND"
showdone="$BLUE[DONE]$STAND"
showinput="$CYAN[input]$STAND"
showwarning="$RED[warning]$STAND"
showremove="$GREEN[removing]$STAND"
shownone="$MAGENTA[none]$STAND"
redhashtag="$REDbg$WHITE#$STAND"
abortfm="$CYAN[abort for Menu]$STAND"
##

if [[ -d /tmp ]]; then echo "$showok Temp folder exists."; else echo "$showerror Temp folder does not exist.\\n$showexecute Creating one..."; $(mkdir /tmp); fi # check if there is a Temp folder

read -e -p "$showinput Enter the block number you want to view (ex: 666) $abortfm: " readblknr

if [[ "$readblknr" =~ ^[[:digit:]]+$ ]]; then

	### VARS
	tmpoutput="/tmp/$readblknr-blockchain-explorer.json"
	wgetblock=$(wget --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101 Firefox/60.0" --output-document="$tmpoutput" https://webdollar.network:5001/block/$readblknr.json -q)
	getid=$(cat $tmpoutput | cut -d '"' -f4)
	getblockid=$(cat $tmpoutput | cut -d '"' -f8)
	gettimestamp=$(cat $tmpoutput | cut -d '"' -f12)
	getmineraddr=$(cat $tmpoutput | cut -d '"' -f16)
	gettrxs1=$(cat $tmpoutput | cut -d ',' -f6-12 | cut -d '[' -f2)
	gettrxs2=$(cat $tmpoutput | cut -d ',' -f13-19)
	gettrxs3=$(cat $tmpoutput | cut -d ',' -f20-26)
	gettrxs4=$(cat $tmpoutput | cut -d ',' -f27-33)
	gettrxs5=$(cat $tmpoutput | cut -d ',' -f34-40)
	gettrxs6=$(cat $tmpoutput | cut -d ',' -f41-47)
	gettrxs7=$(cat $tmpoutput | cut -d ',' -f48-54)
	gettrxs8=$(cat $tmpoutput | cut -d ',' -f55-61)
	gettrxs9=$(cat $tmpoutput | cut -d ',' -f62-68)
	gettrxs10=$(cat $tmpoutput | cut -d ',' -f69-75)
	gettrxs11=$(cat $tmpoutput | cut -d ',' -f76-82)
	gettrxs12=$(cat $tmpoutput | cut -d ',' -f83-89)
	gettrxs13=$(cat $tmpoutput | cut -d ',' -f90-96)
	gettrxs14=$(cat $tmpoutput | cut -d ',' -f97-103)
	gettrxs15=$(cat $tmpoutput | cut -d ',' -f104-110)
	gettrxs16=$(cat $tmpoutput | cut -d ',' -f111-117)
	gettrxs17=$(cat $tmpoutput | cut -d ',' -f118-124)
	gettrxs18=$(cat $tmpoutput | cut -d ',' -f125-131)
	gettrxs19=$(cat $tmpoutput | cut -d ',' -f132-138)
	gettrxs20=$(cat $tmpoutput | cut -d ',' -f139-145)

	colorgetid="$GREEN$getid$STAND"
	colorgetblockid="$GREEN$getblockid$STAND"
	colorgettimestamp="$GREEN$gettimestamp$STAND"
	colorgetmineraddr="$GREEN$getmineraddr$STAND"

	gettrxs=$(if [[ $(cat $tmpoutput | cut -d '"' -f20) == from ]]; then
	echo -e "Yes!"\\n
	declare -a array=("$gettrxs1" "$gettrxs2" "$gettrxs3" "$gettrxs4" "$gettrxs5" "$gettrxs6" "$gettrxs7" "$gettrxs8" "$gettrxs9" "$gettrxs10" "$gettrxs11" "$gettrxs12" "$gettrxs13" "$gettrxs14" "$gettrxs15" "$gettrxs16" "$gettrxs17" "$gettrxs18" "$gettrxs19" "$gettrxs20")
	for i in "${array[@]}";
        do
		if [[ -n $i ]]; then
			echo "From: $YELLOW$(echo $i | cut -d '"' -f6)$STAND Amount: $CYAN$(echo $i | cut -d ':' -f4 | cut -d '}' -f1)$STAND  To: $MAGENTA$(echo $i | cut -d '"' -f14)$STAND Fee: $RED$(echo $i | cut -d ',' -f4 | cut -d ':' -f2)$STAND";
		fi

	done

	else
		echo "${RED}No transactions were made.$STAND";
	fi)

		echo "$showinfo Requesting data for block number $readblknr..."
		echo -e "           iD=$colorgetid\\n     Block_id=$colorgetblockid\\n    Timestamp=$colorgettimestamp\\nMiner_address=$colorgetmineraddr"
		echo "Transactions=$gettrxs"


else
	if [[ "$readblknr" == "" ]]; then
		echo "$showerror No empty space allowed. Try again."
		exit 1

	elif [[ "$readblknr" == abort ]]; then
		echo "$showinfo Okay. Bye."
		exit 0

	elif [[ "$readblknr" =~ ^[[:alnum:]]+$ ]]; then
		echo "$showerror Please enter a number starting with 0. Try again."
		exit 1
	fi
fi
