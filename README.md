# Weird Password Manager
WeirdPass is a simple but at the same time weird password manager/generator that allows to remember all your secure passwords without saving them anywhere. WeirdPass was originally insiped by [Spectre algorithm](https://spectre.app/) but to make things simpler and less nerdy I have decided to make something similar myself.
## How does it work?
It generates a constant and secure password out of 2 inputs: `Master Password` and `Magic Word`. It works similarly to any hashing algorithms and uses [argon2](https://github.com/P-H-C/phc-winner-argon2) to generate it.
* **Master Password** - Should be a [**secure password**](https://www.security.org/how-secure-is-my-password/).
* **Magic Word** - Can be absolutely anything that identifies the account.

For example: 
|Master Password|Magic Word| Output|
|----|-----|-----| 
|`N3$Er%g0nN@-g1v3/y0u^Up`|`CooLuSeRNaMe/twIttEr~cOm`|`g1Vh9OR\|rp#ADvMEbygdO@BCwGshw\|\|`| 
|`N3$Er%g0nN@-g1v3/y0u^Up`|`CooLuSeRNaMe/rEddIt~cOm`|`CnG18L7iqp\|oRyMGJJBIDCek)juQ`|
|`N3$Er%g0nN@-g1v3/y0u^Up`|`CooLuSeRNaMe/gIthUb~cOm`|`4r@E8yiS2F2Ke$z7XX1pG0Xr3zX=wzQB`|

**[WARNING]: NEVER use similar syntax for Master Password and Magic Word as shown in examples above!                                         
This will give the attacker clues how to bruteforce!**

Basically this "Password Manager" doesnt store anything and everything can be accessed anywhere.
## Is it secure?
Nothing can be secure 100% but at the moment its considered secure. 

There are several factors the stetament is based on:
* The code is simple _(supposed to be)_ and anyone can easily understand how it works.
* The code is using [argon2](https://github.com/P-H-C/phc-winner-argon2) hashing algorithm, and set by default to be as secure as possible.

**If you found any major security issue please contact me through discord or email me _(email supposed to be here)_**.
### DISCLAIMER: You are using it at your own risk!
* **No one can guarantee** that the version that you are using doesnt have any security flaws.               
_(most likely it doesnt, even if so I would immediately fix it and announce about it)_                 
* Also **your Magic Word must be creative enough and Master Password must be [secure enough](https://www.security.org/how-secure-is-my-password/)** in case of a bruteforce attack, othewise 💀...
* I highly recommend **being up to date and sometimes visit this repo for news**, keep in mind that **every update the output password that you were usually using might change**.
## Installation:
To install WeirdPass you simply should follow these steps:
* Install [argon2](https://github.com/P-H-C/phc-winner-argon2)
    * Say big thanks to argon2 devs
    * Install using whatever package manager you are using
* Download the latest version of WeirdPass from [releases](https://github.com/life-the-user/WeirdPass/releases/tag/Latest)
* Execute it
    * Put the downloaded WeirdPass.sh wherever you want
    * Copy the path to it
    * add execution permission by `chmod +x ~/path-to/WeirdPass.sh`
    * execute it: `~/path-to/WeirdPass.sh`
    * **or** simply execute it using `bash ~/path-to/WeirdPass.sh`
## Contribution
If you want to help me with improving this project I'm really happy to see you, to make it simpler here are the main "rules" to follow:
* Security is number one
* Keep the code as simple as possible
* Please comment more than usual

For now the code is ugly, need improvements and new features but as time goes I'm sure everything will be much more advanced.



If you found any grammar mistakes ect. excuse me 😳...                                                
Also I'm new to github so I can be dumb.

