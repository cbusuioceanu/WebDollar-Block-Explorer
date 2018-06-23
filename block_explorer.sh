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
	getid=$(jq . $tmpoutput | grep -w id | awk '{print$2}' | sed s'/[,]//g')
	getblockid=$(jq . $tmpoutput | grep block_id | awk '{print$2}' | sed s'/[,]//g' | head -1)
	gettimestamp=$(jq . $tmpoutput | grep timestamp | awk 'NR==1{$1=""; print$0}' | sed s'/[",]//g')
	gethash=$(jq . $tmpoutput | grep -w hash | awk '{print$2}' | sed s'/[",]//g')
	getnonce=$(jq . $tmpoutput | grep nonce | awk 'NR==1{print$2}' | sed s'/[",]//g')
	getprevhash=$(jq . $tmpoutput | grep previous_hash | awk '{print$2}' | sed s'/[",]//g')
	getmineraddr=$(jq . $tmpoutput | grep miner_address | awk '{print$2}' | sed s'/[",]//g')
	gettrxs1=$(jq . -c $tmpoutput | cut -d ',' -f19-29)
	gettrxs2=$(jq . -c $tmpoutput | cut -d ',' -f37-47)
	gettrxs3=$(jq . -c $tmpoutput | cut -d ',' -f55-65)
	gettrxs4=$(jq . -c $tmpoutput | cut -d ',' -f73-83)
	gettrxs5=$(jq . -c $tmpoutput | cut -d ',' -f91-101)
	gettrxs6=$(jq . -c $tmpoutput | cut -d ',' -f109-119)
	gettrxs7=$(jq . -c $tmpoutput | cut -d ',' -f127-137)
	gettrxs8=$(jq . -c $tmpoutput | cut -d ',' -f145-155)
	gettrxs9=$(jq . -c $tmpoutput | cut -d ',' -f163-173)
	gettrxs10=$(jq . -c $tmpoutput | cut -d ',' -f181-191)
	gettrxs11=$(jq . -c $tmpoutput | cut -d ',' -f199-209)
	gettrxs12=$(jq . -c $tmpoutput | cut -d ',' -f217-227)
	gettrxs13=$(jq . -c $tmpoutput | cut -d ',' -f235-245)
	gettrxs14=$(jq . -c $tmpoutput | cut -d ',' -f253-263)
	gettrxs15=$(jq . -c $tmpoutput | cut -d ',' -f271-281)
	gettrxs16=$(jq . -c $tmpoutput | cut -d ',' -f289-299)
	gettrxs17=$(jq . -c $tmpoutput | cut -d ',' -f307-317)
	gettrxs18=$(jq . -c $tmpoutput | cut -d ',' -f325-335)
	gettrxs19=$(jq . -c $tmpoutput | cut -d ',' -f343-353)
	gettrxs20=$(jq . -c $tmpoutput | cut -d ',' -f361-371)

	colorgetid="$GREEN$getid$STAND"
	colorgetblockid="$GREEN$getblockid$STAND"
	colorgettimestamp="$GREEN$gettimestamp$STAND"
	colorgetmineraddr="$GREEN$getmineraddr$STAND"
	colorgethash="$GREEN$gethash$STAND"
	colorgetnonce="$GREEN$getnonce$STAND"
	colorgetprevhash="$GREEN$getprevhash$STAND"

	gettrxs=$(if [[ $(jq . -c $tmpoutput | grep trxs_number | cut -d ':' -f21 | cut -d '"' -f2) == from ]]; then
	echo -e "${GREEN}Yes!$STAND"\\n
	declare -a array=("$gettrxs1" "$gettrxs2" "$gettrxs3" "$gettrxs4" "$gettrxs5" "$gettrxs6" "$gettrxs7" "$gettrxs8" "$gettrxs9" "$gettrxs10" "$gettrxs11" "$gettrxs12" "$gettrxs13" "$gettrxs14" "$gettrxs15" "$gettrxs16" "$gettrxs17" "$gettrxs18" "$gettrxs19" "$gettrxs20")

	for i in "${array[@]}";
        do
		if [[ -n $i ]]; then
			echo "From: $YELLOW$(echo $i | cut -d '"' -f22)$STAND Amount: $CYAN$(echo $i | cut -d '"' -f25 | sed s'/[:},]//g')$STAND  To: $MAGENTA$(echo $i | cut -d '"' -f32)$STAND Fee: $RED$(echo $i | cut -d '"' -f43 | sed s'/[:]//g')$STAND";
		fi

	done

	else
		echo "${RED}No transactions were made.$STAND";
	fi)

		echo "$showinfo Requesting data for block number $readblknr..."
		echo -e "           ID=$colorgetid\\n     Block_id=$colorgetblockid\\n    Timestamp=$colorgettimestamp\\n        Nonce=$colorgetnonce\\n         Hash=$colorgethash\\nPrevious_Hash=$colorgetprevhash\\nMiner_address=$colorgetmineraddr"
		echo " Transactions=$gettrxs"


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
