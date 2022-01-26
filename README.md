# Weird Password Manager
WeirdPass is a simple but at the same time weird password manager/generator that allows to remember all your secure passwords without saving them anywhere. WeirdPass was originally insiped by [Spectre algorithm](https://spectre.app/) but to make things simpler and less nerdy I have decided to make something similar myself.
## How does it work?
It generates a constant and secure password out of 2 inputs: `Master Password` and `Magic Word`. It works similarly to any hashing algorithms and uses [argon2](https://github.com/P-H-C/phc-winner-argon2) to generate it.
* **Master Password** - Should be a [**secure password**](https://www.security.org/how-secure-is-my-password/).
* **Magic Word** - Can be absolutely anything that identifies the account.

For example: 
|Master Password|Magic Word| Output|
|----|-----|-----| 
|`N3$Er%g0nN@-g1v3/y0u^Up`|`CoolUsername/twitter.com`|`g1Vh9OR\|rp#ADvMEbygdO@BCwGshw\|\|`| 
|`N3$Er%g0nN@-g1v3/y0u^Up`|`CoolUsername/reddit.com`|`CnG18L7iqp\|oRyMGJJBIDCek)juQ`|
|`N3$Er%g0nN@-g1v3/y0u^Up`|`CoolUsername/github.com`|`4r@E8yiS2F2Ke$z7XX1pG0Xr3zX=wzQB`|

Basically this "Password Manager" doesnt store anything and everything can be accessed anywhere.
## Is it secure?
Nothing can be secure 100% but at the moment its considered secure. 

There are several factors the stetament is based on:
* The code is simple _(supposed to be)_ and anyone can easily understand how it works.
* The code is using [argon2](https://github.com/P-H-C/phc-winner-argon2) hashing algorithm, and set by default to be as secure as possible.
### DISCLAIMER: You are using it on your own risk!
* **No one can guarantee** that the version that you are using doesnt have any security flaws.               
_(most likely it doesnt, even if so I would immediately fix it and announce about it)_                 
* Also **your Master Password must be [secure enough](https://www.security.org/how-secure-is-my-password/)** in case of a bruteforce attack, othewise 💀...
* I highly recommend **being up to date and sometimes visit this repo for news**, keep in mind that **every update the output password that you were usually using might change**.

