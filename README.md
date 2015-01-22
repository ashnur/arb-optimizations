I use browserify to create `test-compiled.js` from `test.js` and `integer.js`
`browserify test.js > test-compiled.js`

then I do:
```
~/temp/node-v0.11.15-linux-x64/bin/node --trace-hydrogen\
                                         --trace-phase=Z\
                                         --trace-deopt\
                                         --code-comments\
                                         --hydrogen-track-positions\
                                         --redirect-code-traces\
                                         --print-opt-code\
                                         --redirect-code-traces-to=code.asm\
                                         test_compiled.js
```



