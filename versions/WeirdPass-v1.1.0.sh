#!/usr/bin/env bash

# Weird password manager 1.1.0

# Im really sorry for all of these strange variables
# i will change them to something better in future commits


# this just verifies the inputs
echo "
           ____
 __      _|  _ \\ __ _ ___ ___
 \\ \\ /\\ / | |_) / _\` / __/ __|
  \\ V  V /|  __| (_| \\__ \\__ \  													
   \\_/\\_/ |_|   \\__,_|___|___/
   
Version: 1.1.0
"


echo -n "Please enter the Master Password... "
read -s MP

echo -n "Verify... "
read -s MPV

if [[ "$MPV" != "$MP" ]]; then
	echo "Passwords dont match"
	exit 0
fi


echo ""


# this just verifies the inputs
echo -n "Please enter the Magic Word... "
read -s MW

echo -n "Verify... "
read -s MWV

if [[ "$MWV" != "$MWV" ]]; then
	echo "Magic words dont match"
	exit 0
fi




echo "
"

echo "Generating...
"

# this is NOT for additional security reasons but rather to keep the argon2 output constant
HMP=$(echo -n "$MP" | shasum --algorithm 256)
HMW=$(echo -n "$MW" | shasum --algorithm 256)



# THE FOLLOWING SETTINGS ARE !!!RECOMMENDED!!! AND SHOULD NOT BE CHANGED
# They are made intentionally hard to compute to make any attempts of bruteforce useless
# On high computing power devices(like gaming PCs) it will take much less but on low-end devices(old smartphones or computers)
# it will take a LOT of time to compute BUT low-end devices will be able to do it
# The idea is that you can access your passwords wherever you are and on any device

# YOU SACRIFISE TIME AND RECEIVE SECURITY
ARG2=$(echo "$HMW" | argon2 "$HMP" -t 300 -m 18 -e -p 2 -l 64)


# this section will make last digit of the hash impact the length of the ARG2 
IL=${ARG2: -1}



# basically if the last digit is 1 or 2 or something from a/A to e/E the $IMP will be 0
# same thing with everything else

if [[ $IL -eq 1 || $IL -eq 2 || $IL =~ '^[a-eA-E]+$' ]]; then
		IMP=0
	elif [[ $IL -eq 3 || $IL -eq 4 || $IL =~ '^[f-jF-J]+$' ]]; then
		IMP=1
	elif [[ $IL -eq 5 || $IL -eq 6 || $IL =~ '^[k-oK-O]+$' ]]; then
		IMP=2
	elif [[ $IL -eq 7 || $IL -eq 8 || $IL =~ '^[p-tP-T]+$' ]]; then
		IMP=3
	elif [[ $IL -eq 9 || $IL -eq 0 || $IL =~ '^[u-zU-Z]+$' ]]; then
		IMP=4
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


# now we find what amount of symbols there will be
D1=${NUM2: -1:1}

if (( $D1 == 1 || $D1 == 2 )); then
		D1=2	
	elif (( $D1 == 3 || $D1 == 4 )); then
		D1=3
	elif (( $D1 == 5 || $D1 == 6 )); then
		D1=4
	elif (( $D1 == 7 || $D1 == 8 )); then
		D1=5
	elif (( $D1 == 9 || $D1 == 0 )); then
		D1=6
fi

# this is a small detail to prevent code break	
OUT1=$AC

# loooooooooop
for D1 in $(seq 1 $D1 ); do	


	# this is the first time i used math in coding
	# its a big brain custom formula to make my "algorithm" work
	# basically to make the loop work and change stuff every loop it
	# makes the variables increase and increase that makes it to choose different digits
	# trust me it works
	temp2=$(( $D1 - 1 ))
	n1=$(( 1 + 3 * $temp2 ))
	n2=$(( 2 + 3 * $temp2 ))
	n3=$(( 3 + 3 * $temp2 ))
	n4=$(( 4 + 3 * $temp2 ))

	# gets the digits out of $NUM2
	D2=${NUM2: -$n1:1}
	D3=${NUM2: -$n2:1}
	D4=${NUM2: -$n3:1}
	D5=${NUM2: -$n4:1}

# this is to prevent empty strings from breaking the code
if ! [[ -z "$D2" || -z "$D3" || -z "$D4" || -z "$D5" ]]; then

	# this is to prevent 01 .. 09 strings from breaking the code
	if [[ "$D2" == "0" ]]; then

	# it should be / 3 because there are 32 possible symbols and $D2$D5 can be maximum 99
		Dsymb=$(( $D5 / 3 ))

	else
		Dsymb=$(( $D2$D5 / 3 ))

	fi

		# now goes this long part of getting the symbols, i dont know how to optimise it
			if (( $Dsymb == 0 )); then
				Dsymb="~"
				elif (( $Dsymb == 1 )); then
					Dsymb="\`"
				elif (( $Dsymb == 2 )); then
					Dsymb="!"
				elif (( $Dsymb == 3 )); then
					Dsymb="@"
				elif (( $Dsymb == 4 )); then
					Dsymb="\#"
				elif (( $Dsymb == 5 )); then
					Dsymb="\$"
				elif (( $Dsymb == 6 )); then
					Dsymb="%"
				elif (( $Dsymb == 7 )); then
					Dsymb="^"
				elif (( $Dsymb == 8 )); then
					Dsymb="\&"
				elif (( $Dsymb == 9 )); then
					Dsymb="*"
				elif (( $Dsymb == 10 )); then
					Dsymb="\("
				elif (( $Dsymb == 11 )); then
					Dsymb="\)"
				elif (( $Dsymb == 12 )); then
					Dsymb="_"
				elif (( $Dsymb == 13 )); then
					Dsymb="-"
				elif (( $Dsymb == 14 )); then
					Dsymb="+"
				elif (( $Dsymb == 15 )); then
					Dsymb="="
				elif (( $Dsymb == 16 )); then
					Dsymb="\}"
				elif (( $Dsymb == 17 )); then
					Dsymb="\{"
				elif (( $Dsymb == 18 )); then
					Dsymb="\]"
				elif (( $Dsymb == 19 )); then
					Dsymb="\["
				elif (( $Dsymb == 20 )); then
					Dsymb="\|"
				elif (( $Dsymb == 21 )); then
					Dsymb="\\"
				elif (( $Dsymb == 22 )); then
					Dsymb="\""
				elif (( $Dsymb == 23 )); then
					Dsymb="\'"
				elif (( $Dsymb == 24 )); then
					Dsymb=":"
				elif (( $Dsymb == 25 )); then
					Dsymb=";"
				elif (( $Dsymb == 26 )); then
					Dsymb="\?"
				elif (( $Dsymb == 27 )); then
					Dsymb="/"
				elif (( $Dsymb == 28 )); then
					Dsymb=">"
				elif (( $Dsymb == 29 )); then
					Dsymb="."
				elif (( $Dsymb == 30 )); then
					Dsymb="<"
				elif (( $Dsymb == 32 )); then
					Dsymb=","
				elif (( $Dsymb == 33 )); then
					Dsymb="~"
			fi
			
				# from which side it counts
			if (( $D4 < 5 )); then
					SIDE=" -"
				else
					SIDE=""	
			fi
			# if the $D4 = " -" and if $D3 will be 0
			# it will just not do anything
			# so i fixed it the following way
			D3=$(( $D3 + 1 ))
			
			# finally here gets the symbol and substitutes 
			SUBS1=${OUT1:$SIDE$D3:1}
			OUT1=${OUT1/$SUBS1/$Dsymb}
	fi
done


echo "
$OUT1"

