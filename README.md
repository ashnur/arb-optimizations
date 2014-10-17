I am trying to optimize my bigint library.

The index.js file contains the whole of the lib, set to the variable `bigint`

Below that, I am using the exported functions to perform some kind of calculations
which I've copied from a bn.js benchmark.

Then I run 

```
~/node11/node-v0.11.14-linux-x64/bin/node --trace-hydrogen --trace-phase=Z --trace-deopt --code-comments --hydrogen-track-positions --redirect-code-traces --redirect-code-traces-to=code.asm --print-opt-code index.js 
```

I use node v0.11, because node v0.10 doesn't support all the flags, and my d8 (arch linux packaged) also complains about `--print-opt-code`, ( I will compile a v8 later, but it takes more than a hour while my crappy netbook is practically unusable, so I tried first with node11 )


Problem is, I don't see those `deopt` flags in the IRHydra2 (I am loading both the hydrogen* and the code.asm files).

Is there something I should/could do differently?
