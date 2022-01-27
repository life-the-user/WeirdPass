# !/usr/bin/env bash

# Weird password manager 1.0

# VARIABLE INFO
# MP - master password
# MW - magic word
# ARG2 - output of argon2
# IL - impact length
# SYM - numbers that impact symbols
# TV - temporary variable
# IMP - impact of the argon2 output
# D№ - digits
# SIDE - from which side the counting begins
# SET - settings
# OPT - option
# sorry for all the strange variables


# this just verifies the inputs
echo "
WeirdPass 1.0:

WARNING: If you are running WeirdPass on a low computing power device
	   DEFAULT ARGON2 SETTINGS MAY DAMAGE YOUR DEVICE (^C to quit)
"


echo -n "Please enter the master password... "
read -s MP

echo -n "Verify... "
read -s MPV

if [[ "$MPV" != "$MP" ]]; then
	echo "passwords dont match"
	ec=0 
	# i have no idea what this is doing but it works (took from stack overflow :0) 
	return $ec 2>/dev/null || exit $ec
fi


echo ""


# this just verifies the inputs
echo -n "Please enter the magic word... "
read -s MW

echo -n "Verify... "
read -s MWV

if [[ "$MWV" != "$MWV" ]]; then
	echo "Magic words dont match"
	ec=0 
	return $ec 2>/dev/null || exit $ec
fi




echo "
"

echo "Generating...
"

# this is not for additional security reasons but rather to keep the argon2 output constant
HMP=$(echo -n "$MP" | shasum --algorithm 256)
HMW=$(echo -n "$MW" | shasum --algorithm 256)

# the settings here are set to make bruteforce impossible 
ARG2=$(echo "$HMW" | argon2 $HMP -t 200 -m 19 -e -p 4 -l 64)

# the following settings should be alright  for the low-end devices
# ARG2=$(echo "$HMW" | argon2 $HMP -t 50 -m 16 -e -p 2 -l 64)



# this section will make last digit of the hash impact the length of the ARG2 
IL=${ARG2: -1}


TV=1

# some stupid and long "calculations"
# basically if the last digit is 1 or 2 or something from a/A to e/E the $IMP will be 0
# same thing with everything else

re1='^[0-9]+$'
if ! [[ $IL =~ $re1 ]] ; then
   TV=0
fi
if  [[ $NUM -eq 1 ]]; then
	if (( $IL == 1 || $IL == 2 )); then
		IMP=0
	
	elif (( $IL == 3 || $IL == 4 )); then
		IMP=1
	elif (( $IL == 5 || $IL == 6 )); then
		IMP=2
	elif (( $IL == 7 || $IL == 8 )); then
		IMP=3
	elif (( $IL == 9 || $IL == 0 )); then
		IMP=4
	fi

else 

	re2='^[a-eA-E]+$'
	if [[ $IL =~ $re2 ]] ; then

		IMP=0
	fi	
	re3='^[f-jF-J]+$'
	
	if [[ $IL =~ $re3 ]] ; then

		IMP=1
	fi	
	re4='^[k-oK-O]+$'
	
	if [[ $IL =~ $re4 ]] ; then

		IMP=2
	fi	
	re5='^[p-tP-T]+$'
	
	if [[ $IL =~ $re5 ]] ; then
		IMP=3
	fi	
	re6='^[u-zU-Z]+$'
	
	if [[ $IL =~ $re6 ]] ; then

		IMP=4
	fi
fi

# removing some trash
MOD=${ARG2//+/}
MOD=${MOD//\$/}
MOD=${MOD//\//}

# shift to the left 
VAR1=5
# maximum length of the output (and minimum is VAR2-4)
VAR2=32

# this controlls the length
IMP1=$(( $VAR2 - $IMP))

# here $IMP controlls the shift to left
IMP2=$(( $VAR2 + $VAR1 )) 


# cuts the hash
AC=${MOD: -$IMP2:$IMP1}

# this cuts all the hash that comes after 
# the hash used for the password
MIN=$(( 1 - $IMP2 ))
NUM2=${ARG2: -150:$MIN}

# this removes all the letters
for RML1 in {a..z}; do
    NUM2=${NUM2//$RML1/}
done
for RML2 in {A..Z}; do
    NUM2=${NUM2//$RML2/}
done

# remove trash
NUM2=${NUM2//+/}
NUM2=${NUM2//\$/}
NUM2=${NUM2//\//}

# 1/4 will determine what symbol is chosen 
# 2/5 counts from the side and gets a char to switch with
# 3/6 will determine from which side the counting will be

# gets the digits out of $NUM2
D1=${NUM2: -1:1}
D2=${NUM2: -2:1}
D3=${NUM2: -3:1}

# from which side it counts
if (( $D3 < 5 )); then
	SIDE=" -"
else
	SIDE=""	
fi

# just ignore this long part lol
# it chooses the symbol 
if (( $D1 == 0 )); then
	D1="!"
	elif (( $D1 == 1 )); then
		D1="@"
	elif (( $D1 == 2 )); then
		D1="#"
	elif (( $D1 == 3 )); then
		D1="$"
	elif (( $D1 == 4 )); then
		D1="%"
	elif (( $D1 == 5 )); then
		D1="&"
	elif (( $D1 == 6 )); then
		D1="*"
	elif (( $D1 == 7 )); then
		D1=")"
	elif (( $D1 == 8 )); then
		D1="("
	elif (( $D1 == 9 )); then
		D1="-"
fi

# if the $D3 = " -" and if $D2 will be 0
# it will just not do anything
# so i fixed it the following way
D2=$(( $D2 + 1 ))

# final output of 1st substitution 
SUBS1=${AC:$SIDE$D2:1}
OUT1=${AC//$SUBS1/$D1}

# same thing
D4=${NUM2: -4:1}
D5=${NUM2: -5:1}
D6=${NUM2: -6:1}

if (( $D6 < 5 )); then
	SIDE=" -"
else
	SIDE=""	
fi

# just ignore this long part lol
if (( $D4 == 0 )); then
	D4="="
	elif (( $D4 == 1 )); then
		D4="_"
	elif (( $D4 == 2 )); then
		D4="+"
	elif (( $D4 == 3 )); then
		D4="="
	elif (( $D4 == 4 )); then
		D4=":"
	elif (( $D4 == 5 )); then
		D4=";"
	elif (( $D4 == 6 )); then
		D4="|"
	elif (( $D4 == 7 )); then
		D4="/"
	elif (( $D4 == 8 )); then
		D4=">"
	elif (( $D4 == 9 )); then
		D4="<"
fi

D5=$(( $D5 + 1 ))

SUBS2=${OUT1:$SIDE$D5:1}
OUT1=${OUT1//$SUBS2/$D4}


echo "
$OUT1"

