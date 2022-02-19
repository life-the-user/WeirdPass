#!/usr/bin/env bash

# Weird password manager 1.2.0

# variables for coloring the text
purple='\033[0;35m'
red='\033[0;31m'
light_red='\033[1;31m'
blue='\033[1;34m'
green='\033[0;32m'
white='\033[1;37m'
dark_gray='\033[1;30m'
nc='\033[0m'


printf "
          ${blue} ____${nc}
 ${purple}__      _${nc}${blue}|  _ \\ __ _ ___ ___${nc}
 ${purple}\\ \\ /\\ /${nc}${blue} | |_) / _\` / __/ __|${nc}
  ${purple}\\ V  V /${nc}${blue}|  __| (_| \\__ \\__ \  ${nc}													
   ${purple}\\_/\\_/${nc} ${blue}|_|   \\__,_|___|___/${nc}
   
${red}Version:${nc} ${light_red}1.2.0${nc}
"

# just to make the "verification" proccess look cool
function loading {
	sleep 0.1
}

printf "
${dark_gray}[${nc}${purple}${nc}${dark_gray}]${nc} Master Password "
read -s master_pass
loading
printf "
${dark_gray}[${nc}${green}${nc}${dark_gray}]${nc} Verify "
read -s master_pass_verify

loading
# prevent user from inputing blank variables, it breaks the code
if [[ "$master_pass" == "" ]]; then
	printf "
${dark_gray}[${nc}${red}✘${nc}${dark_gray}]${nc} Input string is empty
"
	exit 0 

	else
	printf "
${dark_gray}[${nc}${green}✔${nc}${dark_gray}]${nc} Input string is not empty"
fi

loading

# make sure that the input string is longer than 7
# its just to make argon2 work but also for security
if (( ${#master_pass} <= 7 )); then 
	printf "
${dark_gray}[${nc}${red}✘${nc}${dark_gray}]${nc} Input string is not long enough
"
	exit 0
else 
	printf "
${dark_gray}[${nc}${green}✔${nc}${dark_gray}]${nc} Input string is long enough"
fi

loading

# this just verifies the inputs
if [[ "$master_pass_verify" != "$master_pass" ]]; then
	printf "
${dark_gray}[${nc}${red}✘${nc}${dark_gray}]${nc} Inputs do not match
"
	exit 0

	else
	printf "
${dark_gray}[${nc}${green}✔${nc}${dark_gray}]${nc} Inputs match
"
fi

loading

# just reading user inputs
printf "${dark_gray}[${nc}${purple}${nc}${dark_gray}]${nc} Magic Word "
read -s magic_word

loading

printf "
${dark_gray}[${nc}${green}${nc}${dark_gray}]${nc} Verify "
read -s magic_word_verify

loading

# prevent user from inputing blank variables, it breaks the code
if [[ "$magic_word" == "" ]]; then
	printf "
${dark_gray}[${nc}${red}✘${nc}${dark_gray}]${nc} Input string is empty
"
	exit 0 

	else
	printf "
${dark_gray}[${nc}${green}✔${nc}${dark_gray}]${nc} Input string is not empty"
fi

loading
# make sure that the input string is longer than 7
# its just to make argon2 work but also for security
if (( ${#magic_word} <= 7 )); then 
	printf "
${dark_gray}[${nc}${red}✘${nc}${dark_gray}]${nc} Input string is not long enough
"
	exit 0
else 
	printf "
${dark_gray}[${nc}${green}✔${nc}${dark_gray}]${nc} Input string is long enough"
fi

loading
# this just verifies the inputs
if [[ "$magic_word" != "$magic_word_verify" ]]; then
	printf "
${dark_gray}[${nc}${red}✘${nc}${dark_gray}]${nc} Inputs do not match
"
	exit 0

	else
	printf "
${dark_gray}[${nc}${green}✔${nc}${dark_gray}]${nc} Inputs match"
	
fi

loading
# checks if argon2 is installed(credits to Cake for code)
if ! which argon2 >/dev/null; then 
	printf "
${dark_gray}[${nc}${red}✘${nc}${dark_gray}]${nc} Argon2 is not installed or not accessible
"
	exit 0
	else
	printf "
${dark_gray}[${nc}${green}✔${nc}${dark_gray}]${nc} Argon2 is installed
"
		
fi

loading



# this is NOT for additional security reasons but rather to keep the argon2 output constant
# and to test that its working
hashed_master_pass=$(echo -n "$master_pass" | argon2 "$master_pass" -r)
hashed_magic_word=$(echo -n "$magic_word" | argon2 "$master_pass" -r)


# just to check that there is no errors
if [[ $hashed_master_pass == "" || $hashed_magic_word == "" ]]; then

	printf "${dark_gray}[${nc}${red}✘${nc}${dark_gray}]${nc} Argon2 error
"
	exit 0

	else 
	printf "${dark_gray}[${nc}${green}✔${nc}${dark_gray}]${nc} Argon2 lite hashing successful
"
fi

loading

# THE FOLLOWING SETTINGS ARE !!!RECOMMENDED!!! AND SHOULD NOT BE CHANGED
# They are made intentionally hard to compute to make any attempts of bruteforce useless
# On high computing power devices(like gaming PCs) it will take much less but on low-end devices(old smartphones or computers)
# it will take a LOT of time to compute BUT low-end devices will be able to do it
# The idea is that you can access your passwords wherever you are and on any device

# YOU SACRIFISE TIME AND RECEIVE SECURITY
argon2=$(echo "$hashed_magic_word" | argon2 "$hashed_master_pass" -t 100 -m 18 -e -p 2 -l 64)

if [[ $argon2 == "" ]]; then
	printf "${dark_gray}[${nc}${red}✘${nc}${dark_gray}]${nc} Argon2 main hashing error
"
	exit 0
else
	printf "${dark_gray}[${nc}${green}✔${nc}${dark_gray}]${nc} Argon2 main hashing successful
"
fi
# this section will make last digit of the hash impact the length of the argon2 
impact_thingy=${argon2: -1}



# basically if the last digit is 1 or 2 or something from a/A to e/E the $IMP will be 0
# same thing with everything else

if [[ $impact_thingy -eq 1 || $impact_thingy -eq 2 || $impact_thingy =~ '^[a-eA-E]+$' ]]; then
		impact_thingy=0
	elif [[ $impact_thingy -eq 3 || $impact_thingy -eq 4 || $impact_thingy =~ '^[f-jF-J]+$' ]]; then
		impact_thingy=1
	elif [[ $impact_thingy -eq 5 || $impact_thingy -eq 6 || $impact_thingy =~ '^[k-oK-O]+$' ]]; then
		impact_thingy=2
	elif [[ $impact_thingy -eq 7 || $impact_thingy -eq 8 || $impact_thingy =~ '^[p-tP-T]+$' ]]; then
		impact_thingy=3
	elif [[ $impact_thingy -eq 9 || $impact_thingy -eq 0 || $impact_thingy =~ '^[u-zU-Z]+$' ]]; then
		impact_thingy=4
	fi

# removing some trash
modifications=${argon2//+/}
modifications=${modifications//\$/}
modifications=${modifications//\//}

# shift to the left 
shift_controll=5
# maximum length of the output (and minimum is length_controll-4)
length_controll=32

# this controlls the length
length=$(( $length_controll - $impact_thingy))

# here $IMP controlls the shift to left
shift=$(( $length_controll + $shift_controll )) 


# cuts the hash
output=${modifications: -$shift:$length}

# this cuts all the hash that comes after 
# the hash used for the password
minimum_cut=$(( 1 - $shift ))
argon2=${argon2: -150:$minimum_cut}

# this removes all the letters
for i in {a..z}; do
    argon2=${argon2//$i/}
done
for i in {A..Z}; do
    argon2=${argon2//$i/}
done

# remove trash
argon2=${argon2//+/}
argon2=${argon2//\$/}
argon2=${argon2//\//}


# now we find what amount of symbols there will be
amount_symbols=${argon2: -1:1}

if (( $amount_symbols == 1 || $amount_symbols == 2 )); then
		amount_symbols=2	
	elif (( $amount_symbols == 3 || $amount_symbols == 4 )); then
		amount_symbols=3
	elif (( $amount_symbols == 5 || $amount_symbols == 6 )); then
		amount_symbols=4
	elif (( $amount_symbols == 7 || $amount_symbols == 8 )); then
		amount_symbols=5
	elif (( $amount_symbols == 9 || $amount_symbols == 0 )); then
		amount_symbols=6
fi

# loooooooooop
for amount_symbols in $(seq 1 $amount_symbols ); do	


	# this is the first time i used math in coding
	# its a big brain custom formula to make my "algorithm" work
	# basically to make the loop work and change stuff every loop it
	# makes the variables increase and increase that makes it to choose different digits
	# trust me it works
	temporary=$(( $amount_symbols - 1 ))
	n1=$(( 1 + 3 * $temporary ))
	n2=$(( 2 + 3 * $temporary ))
	n3=$(( 3 + 3 * $temporary ))
	n4=$(( 4 + 3 * $temporary ))

	# gets the digits out of $argon2
	D2=${argon2: -$n1:1}
	D3=${argon2: -$n2:1}
	D4=${argon2: -$n3:1}
	D5=${argon2: -$n4:1}

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
					Dsymb="#"
				elif (( $Dsymb == 5 )); then
					Dsymb="$"
				elif (( $Dsymb == 6 )); then
					Dsymb="%"
				elif (( $Dsymb == 7 )); then
					Dsymb="^"
				elif (( $Dsymb == 8 )); then
					Dsymb="&"
				elif (( $Dsymb == 9 )); then
					Dsymb="*"
				elif (( $Dsymb == 10 )); then
					Dsymb="("
				elif (( $Dsymb == 11 )); then
					Dsymb=")"
				elif (( $Dsymb == 12 )); then
					Dsymb="_"
				elif (( $Dsymb == 13 )); then
					Dsymb="-"
				elif (( $Dsymb == 14 )); then
					Dsymb="+"
				elif (( $Dsymb == 15 )); then
					Dsymb="="
				elif (( $Dsymb == 16 )); then
					Dsymb="}"
				elif (( $Dsymb == 17 )); then
					Dsymb="{"
				elif (( $Dsymb == 18 )); then
					Dsymb="]"
				elif (( $Dsymb == 19 )); then
					Dsymb="["
				elif (( $Dsymb == 20 )); then
					Dsymb="|"
				elif (( $Dsymb == 21 )); then
					Dsymb="\\"
				elif (( $Dsymb == 22 )); then
					Dsymb="\""
				elif (( $Dsymb == 23 )); then
					Dsymb="'"
				elif (( $Dsymb == 24 )); then
					Dsymb=":"
				elif (( $Dsymb == 25 )); then
					Dsymb=";"
				elif (( $Dsymb == 26 )); then
					Dsymb="?"
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
			substitution=${output:$SIDE$D3:1}
			output=${output/$substitution/$Dsymb}
	fi
done

loading
# checks if there are the following symbols in the string, there is a chance that
# it will be an error
if [[ $output =~ ["!@#\$%^\&*()-_+={}|\\\"\';:/?.>,<"] ]]; then
	printf "${dark_gray}[${nc}${green}✔${nc}${dark_gray}]${nc} Symbols generation successful
"
else 
	printf "${dark_gray}[${nc}${red}✘${nc}${dark_gray}]${nc} Symbols generation error
"
		exit 0
fi
loading
printf "${dark_gray}[${nc}${light_red}${nc}${dark_gray}]${nc} ${red}Password: ${nc}"
echo "$output"
