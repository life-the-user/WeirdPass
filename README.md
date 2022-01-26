# Weird Password Manager
WeirdPass is a simple but at the same time weird password manager/generator that allows to remember all your secure passwords without saving them anywhere. WeirdPass was originally insiped by [Spectre algorithm](https://spectre.app/) but to make things simpler and less nerdy I have decided to make something similar myself.
## How does it work?
It generates a constant and secure password out of 2 inputs: `Master Password` and `Magic Word`. It works similarly to any Hashing algorithms and uses [argon2](https://github.com/P-H-C/phc-winner-argon2) to generate it.

For example:
|Master Password|Magic Word| Output|
|----|-----|-----| 
|`N3vEr-g0nn@-g1v3-y0u-^Up`|john@example.com|Address1| 
|`N3vEr-g0nn@-g1v3-y0u-^Up`||
