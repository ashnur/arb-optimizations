var arb = require('./integer.js')
//var BigNumber = require('bignumber.js')
var strings = [
"38271247903867597018219902051751493585656390647884959502519410904",
'80332454895002089541444205322579928998184014866042414751517667515',
'10499081046217426521600383293040812906094121662838510888633780592',
'24385664471370498491910141344546152745871584092082102405576545748'
]
//var bignums = strings.map(function(str){ return BigNumber(str) })


for ( var i = 100000; i > 0; i-- ) {
  var m = arb.memory.alloc(2)
  var arbnums = strings.map(arb.parse)
  arb.to_dec(arbnums.reduce(function(p, n){
    return arb.add(p, n)
  }))
  arb.memory.free(m)
}

///console.log('bignum sum', bignums.reduce(function(p, n){
///  return p.plus(n)
///}).toString(10))

// --trace-hydrogen --trace-phase=Z --trace-deopt --code-comments --hydrogen-track-positions --redirect-code-traces --redirect-code-traces-to=code.asm
