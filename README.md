# Hephaestus-shell

This is our main module for interacting with our code base. 

We manage our dependencies through Stack.



## Building with Stack

Plain and simple (cheers to stack's team), build with `stack build` on cloned dir.

This will download all dependencies and install our shell executable on stack-work environment.



## Development

When developing new features or new assets, the best current solution is to compile our shell in ghci and reload it when needed.

First, clone all of hephaestus's repositories under the same directory (hephaestus/ or any/):

- [hephaestus-spl](https://github.com/hephaestus-ng/hephaestus-spl)
- [hephaestus-fm](https://github.com/hephaestus-ng/hephaestus-fm)
- [hephaestus-assets](https://github.com/hephaestus-ng/hephaestus-assets)
- [hephaestus-shell](https://github.com/hephaestus-ng/hephaestus-shell)


Navigate to chosendir/hephaestus-shell/src, and run ghci poiting to dependencies:

```
$ ghci Run.hs -i../../hephaestus-spl/src:../../hephaestus-fm/src:../../hephaestus-assets/src:../../hephaestus-shell/src
```

Once compiled, you can invoke the shell with the `run` function. To recompile any code change in a dependency, just `:r` and rerun the shell.




