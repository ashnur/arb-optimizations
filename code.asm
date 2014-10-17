[deoptimize global object @ 0x364e0630f9e1]
--- FUNCTION SOURCE (multiply) id{0,0} ---
(A, B) {

    var size_a = heap[adrs[A]]
    var size_b = heap[adrs[B]]

    // header(2 blocks) is in both, so has to be removed
    var size_r = size_a + size_b - 2
    var R = alloc(size_r) 
    var Rp = adrs[R]
    var Ap = adrs[A]
    var Bp = adrs[B]

    heap[Rp + 1] = 0 // type integer
    for ( var ii = 2; ii < size_r; ii++ ) heap[Rp + ii] = 0 // get rid of garbage

    var tj = 0
    var c = 0
    var n = 0

    for ( var i = 2; i < size_a; i++ ) {
      var a = heap[Ap + i]
      n = 0
      for ( var j = 2; j < size_b; j++ ) {
        c = n
        tj = a * heap[Bp + j] + heap[Rp + i + j - 2] + c
        heap[Rp + i + j - 2] = tj & 0x3ffffff
        n = (tj / 0x4000000) | 0
      }
      heap[Rp + i + size_b - 2] = n
    }

    var trailing_zeroes = 0
    var k = size_a + size_b - 3 + Rp
    while ( k > Rp + 2 && heap[k] === 0) {
      k--
      trailing_zeroes++
    }

    var size_r = size_a + size_b - trailing_zeroes - 2
    if ( trailing_zeroes ) heap[Rp] = size_r

    return R
  }

--- END ---
--- FUNCTION SOURCE (alloc) id{0,1} ---
(length){
      // there is no check for it but length has to be larger than 0
      if ( length > unallocated ) {
        extend(length)
      }
      unallocated -= length
      // save data index to data_idx and advance the break point with length
      var data_idx = brk
      brk = brk + length
      // save data_idx in address space and advance next
      var pointer = next++
      adrs[pointer] = data_idx
      heap[data_idx] = length
      return pointer
    }

--- END ---
INLINE (alloc) id{0,1} AS 1 AT <0:179>
--- Raw source ---
(A, B) {

    var size_a = heap[adrs[A]]
    var size_b = heap[adrs[B]]

    // header(2 blocks) is in both, so has to be removed
    var size_r = size_a + size_b - 2
    var R = alloc(size_r) 
    var Rp = adrs[R]
    var Ap = adrs[A]
    var Bp = adrs[B]

    heap[Rp + 1] = 0 // type integer
    for ( var ii = 2; ii < size_r; ii++ ) heap[Rp + ii] = 0 // get rid of garbage

    var tj = 0
    var c = 0
    var n = 0

    for ( var i = 2; i < size_a; i++ ) {
      var a = heap[Ap + i]
      n = 0
      for ( var j = 2; j < size_b; j++ ) {
        c = n
        tj = a * heap[Bp + j] + heap[Rp + i + j - 2] + c
        heap[Rp + i + j - 2] = tj & 0x3ffffff
        n = (tj / 0x4000000) | 0
      }
      heap[Rp + i + size_b - 2] = n
    }

    var trailing_zeroes = 0
    var k = size_a + size_b - 3 + Rp
    while ( k > Rp + 2 && heap[k] === 0) {
      k--
      trailing_zeroes++
    }

    var size_r = size_a + size_b - trailing_zeroes - 2
    if ( trailing_zeroes ) heap[Rp] = size_r

    return R
  }


--- Optimized code ---
optimization_id = 0
source_position = 6452
kind = OPTIMIZED_FUNCTION
name = multiply
stack_slots = 10
Instructions (size = 2588)
0x9c023aa5ba0     0  55             push rbp
0x9c023aa5ba1     1  4889e5         REX.W movq rbp,rsp
0x9c023aa5ba4     4  56             push rsi
0x9c023aa5ba5     5  57             push rdi
0x9c023aa5ba6     6  4883ec50       REX.W subq rsp,0x50
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x9c023aa5baa    10  488b45f8       REX.W movq rax,[rbp-0x8]    ;; debug: position 6452
                  ;;; <@3,#1> gap
0x9c023aa5bae    14  488945e8       REX.W movq [rbp-0x18],rax
                  ;;; <@12,#9> -------------------- B1 --------------------
                  ;;; <@13,#9> gap
0x9c023aa5bb2    18  488bf0         REX.W movq rsi,rax
                  ;;; <@14,#11> stack-check
0x9c023aa5bb5    21  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023aa5bbc    28  7305           jnc 35  (0x9c023aa5bc3)
0x9c023aa5bbe    30  e89d02f8ff     call StackCheck  (0x9c023a25e60)    ;; code: BUILTIN
                  ;;; <@16,#11> lazy-bailout
                  ;;; <@17,#11> gap
0x9c023aa5bc3    35  488b45e8       REX.W movq rax,[rbp-0x18]
                  ;;; <@18,#12> load-context-slot
0x9c023aa5bc7    39  488b9897000000 REX.W movq rbx,[rax+0x97]    ;; debug: position 6479
                  ;;; <@20,#13> load-context-slot
0x9c023aa5bce    46  488b909f000000 REX.W movq rdx,[rax+0x9f]    ;; debug: position 6484
                  ;;; <@22,#15> check-non-smi
0x9c023aa5bd5    53  f6c201         testb rdx,0x1            ;; debug: position 6489
0x9c023aa5bd8    56  0f846c080000   jz 2218  (0x9c023aa644a)
                  ;;; <@24,#16> check-maps
0x9c023aa5bde    62  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aa5be8    72  4c3952ff       REX.W cmpq [rdx-0x1],r10
0x9c023aa5bec    76  0f855d080000   jnz 2223  (0x9c023aa644f)
                  ;;; <@26,#17> load-named-field
0x9c023aa5bf2    82  488b520f       REX.W movq rdx,[rdx+0xf]
                  ;;; <@28,#18> load-named-field
0x9c023aa5bf6    86  8b4a0b         movl rcx,[rdx+0xb]
                  ;;; <@30,#19> load-named-field
0x9c023aa5bf9    89  488b520f       REX.W movq rdx,[rdx+0xf]
                  ;;; <@31,#19> gap
0x9c023aa5bfd    93  4c8b4518       REX.W movq r8,[rbp+0x18]
                  ;;; <@32,#577> tagged-to-i
0x9c023aa5c01    97  41f6c001       testb r8,0x1
0x9c023aa5c05   101  0f858a050000   jnz 1525  (0x9c023aa6195)
0x9c023aa5c0b   107  49c1e820       REX.W shrq r8,32
                  ;;; <@33,#577> gap
0x9c023aa5c0f   111  4c8945c0       REX.W movq [rbp-0x40],r8
                  ;;; <@34,#20> bounds-check
0x9c023aa5c13   115  413bc8         cmpl rcx,r8
0x9c023aa5c16   118  0f8638080000   jna 2228  (0x9c023aa6454)
                  ;;; <@36,#21> load-keyed
0x9c023aa5c1c   124  428b3482       movl rsi,[rdx+r8*4]
0x9c023aa5c20   128  85f6           testl rsi,rsi
0x9c023aa5c22   130  0f8831080000   js 2233  (0x9c023aa6459)
                  ;;; <@38,#22> check-non-smi
0x9c023aa5c28   136  f6c301         testb rbx,0x1
0x9c023aa5c2b   139  0f842d080000   jz 2238  (0x9c023aa645e)
                  ;;; <@40,#23> check-maps
0x9c023aa5c31   145  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aa5c3b   155  4c3953ff       REX.W cmpq [rbx-0x1],r10
0x9c023aa5c3f   159  0f851e080000   jnz 2243  (0x9c023aa6463)
                  ;;; <@42,#24> load-named-field
0x9c023aa5c45   165  488b5b0f       REX.W movq rbx,[rbx+0xf]
                  ;;; <@44,#25> load-named-field
0x9c023aa5c49   169  8b7b0b         movl rdi,[rbx+0xb]
                  ;;; <@46,#26> load-named-field
0x9c023aa5c4c   172  488b5b0f       REX.W movq rbx,[rbx+0xf]
                  ;;; <@48,#27> bounds-check
0x9c023aa5c50   176  3bfe           cmpl rdi,rsi
0x9c023aa5c52   178  0f8610080000   jna 2248  (0x9c023aa6468)
                  ;;; <@50,#28> load-keyed
0x9c023aa5c58   184  448b0cb3       movl r9,[rbx+rsi*4]
0x9c023aa5c5c   188  4585c9         testl r9,r9
0x9c023aa5c5f   191  0f8808080000   js 2253  (0x9c023aa646d)
                  ;;; <@51,#28> gap
0x9c023aa5c65   197  4c894de0       REX.W movq [rbp-0x20],r9
0x9c023aa5c69   201  4c8b5d10       REX.W movq r11,[rbp+0x10]
                  ;;; <@52,#579> tagged-to-i
0x9c023aa5c6d   205  41f6c301       testb r11,0x1            ;; debug: position 6520
0x9c023aa5c71   209  0f8552050000   jnz 1577  (0x9c023aa61c9)
0x9c023aa5c77   215  49c1eb20       REX.W shrq r11,32
                  ;;; <@53,#579> gap
0x9c023aa5c7b   219  4c895db8       REX.W movq [rbp-0x48],r11
                  ;;; <@54,#37> bounds-check
0x9c023aa5c7f   223  413bcb         cmpl rcx,r11
0x9c023aa5c82   226  0f86ea070000   jna 2258  (0x9c023aa6472)
                  ;;; <@56,#38> load-keyed
0x9c023aa5c88   232  428b0c9a       movl rcx,[rdx+r11*4]
0x9c023aa5c8c   236  85c9           testl rcx,rcx
0x9c023aa5c8e   238  0f88e3070000   js 2263  (0x9c023aa6477)
                  ;;; <@58,#44> bounds-check
0x9c023aa5c94   244  3bf9           cmpl rdi,rcx
0x9c023aa5c96   246  0f86e0070000   jna 2268  (0x9c023aa647c)
                  ;;; <@60,#45> load-keyed
0x9c023aa5c9c   252  8b148b         movl rdx,[rbx+rcx*4]
0x9c023aa5c9f   255  85d2           testl rdx,rdx
0x9c023aa5ca1   257  0f88da070000   js 2273  (0x9c023aa6481)
                  ;;; <@61,#45> gap
0x9c023aa5ca7   263  488955d8       REX.W movq [rbp-0x28],rdx
0x9c023aa5cab   267  498bd9         REX.W movq rbx,r9
                  ;;; <@62,#49> add-i
0x9c023aa5cae   270  03da           addl rbx,rdx             ;; debug: position 6606
0x9c023aa5cb0   272  0f80d0070000   jo 2278  (0x9c023aa6486)
                  ;;; <@63,#49> gap
0x9c023aa5cb6   278  48895db0       REX.W movq [rbp-0x50],rbx
0x9c023aa5cba   282  488bcb         REX.W movq rcx,rbx
                  ;;; <@64,#52> sub-i
0x9c023aa5cbd   285  83e902         subl rcx,0x2             ;; debug: position 6615
0x9c023aa5cc0   288  0f80c5070000   jo 2283  (0x9c023aa648b)
                  ;;; <@65,#52> gap
0x9c023aa5cc6   294  48894dd0       REX.W movq [rbp-0x30],rcx
                  ;;; <@66,#55> load-context-slot
0x9c023aa5cca   298  4c8bb0af000000 REX.W movq r14,[rax+0xaf]    ;; debug: position 6631
                  ;;; <@67,#55> gap
0x9c023aa5cd1   305  4c8975c8       REX.W movq [rbp-0x38],r14
                  ;;; <@68,#56> check-value
0x9c023aa5cd5   309  49baa1fc35064e360000 REX.W movq r10,0x364e0635fca1    ;; object: 0x364e0635fca1 <JS Function alloc (SharedFunctionInfo 0xc1217b4f389)>
0x9c023aa5cdf   319  4d3bf2         REX.W cmpq r14,r10
0x9c023aa5ce2   322  0f85a8070000   jnz 2288  (0x9c023aa6490)
                  ;;; <@70,#59> constant-t
0x9c023aa5ce8   328  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@72,#62> load-context-slot
0x9c023aa5cf2   338  488b7637       REX.W movq rsi,[rsi+0x37]    ;; debug: position 2205
                  ;;; <@74,#581> tagged-to-i
0x9c023aa5cf6   342  40f6c601       testb rsi,0x1
0x9c023aa5cfa   346  0f85fd040000   jnz 1629  (0x9c023aa61fd)
0x9c023aa5d00   352  48c1ee20       REX.W shrq rsi,32
                  ;;; <@77,#63> compare-numeric-and-branch
0x9c023aa5d04   356  3bce           cmpl rcx,rsi             ;; debug: position 2203
0x9c023aa5d06   358  0f8e30000000   jle 412  (0x9c023aa5d3c)
                  ;;; <@78,#67> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@82,#78> -------------------- B3 (unreachable/replaced) --------------------
                  ;;; <@86,#64> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@90,#70> -------------------- B5 --------------------
                  ;;; <@92,#59> constant-t
0x9c023aa5d0c   364  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2229
                                                             ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@94,#71> load-context-slot
0x9c023aa5d16   374  488b7e4f       REX.W movq rdi,[rsi+0x4f]    ;; debug: position 2229
                  ;;; <@96,#72> push-argument
0x9c023aa5d1a   378  49ba214130064e360000 REX.W movq r10,0x364e06304121    ;; debug: position 2236
                                                             ;; object: 0x364e06304121 <undefined>
0x9c023aa5d24   388  4152           push r10
                  ;;; <@98,#580> smi-tag
0x9c023aa5d26   390  8bf1           movl rsi,rcx
0x9c023aa5d28   392  48c1e620       REX.W shlq rsi,32
                  ;;; <@100,#73> push-argument
0x9c023aa5d2c   396  56             push rsi
                  ;;; <@102,#59> constant-t
0x9c023aa5d2d   397  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@104,#74> call-function
0x9c023aa5d37   407  e8e42ff8ff     call 0x9c023a28d20       ;; debug: position 2236
                                                             ;; code: STUB, CallFunctionStub, argc = 1
                  ;;; <@106,#75> lazy-bailout
                  ;;; <@110,#81> -------------------- B6 --------------------
                  ;;; <@112,#59> constant-t
0x9c023aa5d3c   412  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2258
                                                             ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@114,#82> load-context-slot
0x9c023aa5d46   422  488b4637       REX.W movq rax,[rsi+0x37]    ;; debug: position 2258
                  ;;; <@116,#582> tagged-to-i
0x9c023aa5d4a   426  a801           test al,0x1
0x9c023aa5d4c   428  0f85dc040000   jnz 1678  (0x9c023aa622e)
0x9c023aa5d52   434  48c1e820       REX.W shrq rax,32
                  ;;; <@118,#83> sub-i
0x9c023aa5d56   438  2b45d0         subl rax,[rbp-0x30]      ;; debug: position 2271
0x9c023aa5d59   441  0f8036070000   jo 2293  (0x9c023aa6495)
                  ;;; <@120,#583> smi-tag
0x9c023aa5d5f   447  8bd8           movl rbx,rax
0x9c023aa5d61   449  48c1e320       REX.W shlq rbx,32
                  ;;; <@122,#59> constant-t
0x9c023aa5d65   453  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@124,#85> store-context-slot
0x9c023aa5d6f   463  48895e37       REX.W movq [rsi+0x37],rbx    ;; debug: position 2271
                  ;;; <@126,#59> constant-t
0x9c023aa5d73   467  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@128,#87> load-context-slot
0x9c023aa5d7d   477  488b5e3f       REX.W movq rbx,[rsi+0x3f]    ;; debug: position 2378
                  ;;; <@129,#87> gap
0x9c023aa5d81   481  488bd3         REX.W movq rdx,rbx
                  ;;; <@130,#586> tagged-to-i
0x9c023aa5d84   484  f6c201         testb rdx,0x1            ;; debug: position 2394
0x9c023aa5d87   487  0f85df040000   jnz 1740  (0x9c023aa626c)
0x9c023aa5d8d   493  48c1ea20       REX.W shrq rdx,32
                  ;;; <@131,#586> gap
0x9c023aa5d91   497  488bca         REX.W movq rcx,rdx
                  ;;; <@132,#90> add-i
0x9c023aa5d94   500  034dd0         addl rcx,[rbp-0x30]      ;; debug: position 2398
0x9c023aa5d97   503  0f80fd060000   jo 2298  (0x9c023aa649a)
                  ;;; <@134,#587> smi-tag
0x9c023aa5d9d   509  8bc1           movl rax,rcx
0x9c023aa5d9f   511  48c1e020       REX.W shlq rax,32
                  ;;; <@136,#59> constant-t
0x9c023aa5da3   515  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@138,#92> store-context-slot
0x9c023aa5dad   525  4889463f       REX.W movq [rsi+0x3f],rax    ;; debug: position 2398
                  ;;; <@140,#59> constant-t
0x9c023aa5db1   529  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@142,#94> load-context-slot
0x9c023aa5dbb   539  488b4647       REX.W movq rax,[rsi+0x47]    ;; debug: position 2484
                  ;;; <@144,#588> tagged-to-i
0x9c023aa5dbf   543  a801           test al,0x1
0x9c023aa5dc1   545  0f85d6040000   jnz 1789  (0x9c023aa629d)
0x9c023aa5dc7   551  48c1e820       REX.W shrq rax,32
                  ;;; <@145,#588> gap
0x9c023aa5dcb   555  488945a8       REX.W movq [rbp-0x58],rax
0x9c023aa5dcf   559  488bf8         REX.W movq rdi,rax
                  ;;; <@146,#97> add-i
0x9c023aa5dd2   562  83c701         addl rdi,0x1
0x9c023aa5dd5   565  0f80c4060000   jo 2303  (0x9c023aa649f)
                  ;;; <@148,#590> smi-tag
0x9c023aa5ddb   571  8bcf           movl rcx,rdi
0x9c023aa5ddd   573  48c1e120       REX.W shlq rcx,32
                  ;;; <@150,#59> constant-t
0x9c023aa5de1   577  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@152,#98> store-context-slot
0x9c023aa5deb   587  48894e47       REX.W movq [rsi+0x47],rcx    ;; debug: position 2484
                  ;;; <@154,#59> constant-t
0x9c023aa5def   591  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@156,#101> load-named-field
0x9c023aa5df9   601  488b4e17       REX.W movq rcx,[rsi+0x17]    ;; debug: position 2497
                  ;;; <@158,#102> load-context-slot
0x9c023aa5dfd   605  488bb19f000000 REX.W movq rsi,[rcx+0x9f]
                  ;;; <@160,#105> check-non-smi
0x9c023aa5e04   612  40f6c601       testb rsi,0x1            ;; debug: position 2513
0x9c023aa5e08   616  0f8496060000   jz 2308  (0x9c023aa64a4)
                  ;;; <@162,#106> check-maps
0x9c023aa5e0e   622  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aa5e18   632  4c3956ff       REX.W cmpq [rsi-0x1],r10
0x9c023aa5e1c   636  0f8587060000   jnz 2313  (0x9c023aa64a9)
                  ;;; <@164,#108> check-maps
                  ;;; <@166,#110> check-maps
                  ;;; <@168,#111> load-named-field
0x9c023aa5e22   642  488b760f       REX.W movq rsi,[rsi+0xf]
                  ;;; <@170,#112> load-named-field
0x9c023aa5e26   646  448b460b       movl r8,[rsi+0xb]
                  ;;; <@172,#113> load-named-field
0x9c023aa5e2a   650  488b760f       REX.W movq rsi,[rsi+0xf]
                  ;;; <@174,#114> bounds-check
0x9c023aa5e2e   654  443bc0         cmpl r8,rax
0x9c023aa5e31   657  0f8677060000   jna 2318  (0x9c023aa64ae)
                  ;;; <@175,#114> gap
0x9c023aa5e37   663  4c8bc3         REX.W movq r8,rbx
                  ;;; <@176,#585> tagged-to-i
0x9c023aa5e3a   666  41f6c001       testb r8,0x1
0x9c023aa5e3e   670  0f8597040000   jnz 1851  (0x9c023aa62db)
0x9c023aa5e44   676  49c1e820       REX.W shrq r8,32
                  ;;; <@178,#115> store-keyed
0x9c023aa5e48   680  44890486       movl [rsi+rax*4],r8
                  ;;; <@180,#118> load-context-slot
0x9c023aa5e4c   684  488b8997000000 REX.W movq rcx,[rcx+0x97]    ;; debug: position 2528
                  ;;; <@182,#120> check-non-smi
0x9c023aa5e53   691  f6c101         testb rcx,0x1            ;; debug: position 2545
0x9c023aa5e56   694  0f8457060000   jz 2323  (0x9c023aa64b3)
                  ;;; <@184,#121> check-maps
0x9c023aa5e5c   700  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aa5e66   710  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023aa5e6a   714  0f8548060000   jnz 2328  (0x9c023aa64b8)
                  ;;; <@186,#126> load-named-field
0x9c023aa5e70   720  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@188,#127> load-named-field
0x9c023aa5e74   724  8b710b         movl rsi,[rcx+0xb]
                  ;;; <@190,#128> load-named-field
0x9c023aa5e77   727  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@192,#129> bounds-check
0x9c023aa5e7b   731  3bf2           cmpl rsi,rdx
0x9c023aa5e7d   733  0f863a060000   jna 2333  (0x9c023aa64bd)
                  ;;; <@193,#129> gap
0x9c023aa5e83   739  488b5dd0       REX.W movq rbx,[rbp-0x30]
                  ;;; <@194,#130> store-keyed
0x9c023aa5e87   743  891c91         movl [rcx+rdx*4],rbx
                  ;;; <@198,#136> -------------------- B7 --------------------
                  ;;; <@199,#136> gap
0x9c023aa5e8a   746  488b55e8       REX.W movq rdx,[rbp-0x18]    ;; debug: position 2565
                                                             ;; debug: position 6637
                  ;;; <@200,#138> load-context-slot
0x9c023aa5e8e   750  488b8a9f000000 REX.W movq rcx,[rdx+0x9f]    ;; debug: position 6659
                  ;;; <@202,#140> check-non-smi
0x9c023aa5e95   757  f6c101         testb rcx,0x1            ;; debug: position 6664
0x9c023aa5e98   760  0f8424060000   jz 2338  (0x9c023aa64c2)
                  ;;; <@204,#141> check-maps
0x9c023aa5e9e   766  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aa5ea8   776  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023aa5eac   780  0f8515060000   jnz 2343  (0x9c023aa64c7)
                  ;;; <@206,#142> load-named-field
0x9c023aa5eb2   786  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@208,#143> load-named-field
0x9c023aa5eb6   790  8b710b         movl rsi,[rcx+0xb]
                  ;;; <@210,#144> load-named-field
0x9c023aa5eb9   793  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@212,#145> bounds-check
0x9c023aa5ebd   797  3bf0           cmpl rsi,rax
0x9c023aa5ebf   799  0f8607060000   jna 2348  (0x9c023aa64cc)
                  ;;; <@214,#146> load-keyed
0x9c023aa5ec5   805  8b3c81         movl rdi,[rcx+rax*4]
0x9c023aa5ec8   808  85ff           testl rdi,rdi
0x9c023aa5eca   810  0f8801060000   js 2353  (0x9c023aa64d1)
0x9c023aa5ed0   816  4863ff         REX.W movsxlq rdi,rdi
                  ;;; <@215,#146> gap
0x9c023aa5ed3   819  48897da0       REX.W movq [rbp-0x60],rdi
0x9c023aa5ed7   823  4c8b45c0       REX.W movq r8,[rbp-0x40]
                  ;;; <@216,#154> bounds-check
0x9c023aa5edb   827  413bf0         cmpl rsi,r8              ;; debug: position 6685
0x9c023aa5ede   830  0f86f2050000   jna 2358  (0x9c023aa64d6)
                  ;;; <@218,#155> load-keyed
0x9c023aa5ee4   836  468b0481       movl r8,[rcx+r8*4]
0x9c023aa5ee8   840  4585c0         testl r8,r8
0x9c023aa5eeb   843  0f88ea050000   js 2363  (0x9c023aa64db)
                  ;;; <@219,#155> gap
0x9c023aa5ef1   849  4c8b4db8       REX.W movq r9,[rbp-0x48]
                  ;;; <@220,#163> bounds-check
0x9c023aa5ef5   853  413bf1         cmpl rsi,r9              ;; debug: position 6706
0x9c023aa5ef8   856  0f86e2050000   jna 2368  (0x9c023aa64e0)
                  ;;; <@222,#164> load-keyed
0x9c023aa5efe   862  428b3489       movl rsi,[rcx+r9*4]
0x9c023aa5f02   866  85f6           testl rsi,rsi
0x9c023aa5f04   868  0f88db050000   js 2373  (0x9c023aa64e5)
                  ;;; <@224,#166> load-context-slot
0x9c023aa5f0a   874  488b8a97000000 REX.W movq rcx,[rdx+0x97]    ;; debug: position 6714
                  ;;; <@225,#166> gap
0x9c023aa5f11   881  48894dc0       REX.W movq [rbp-0x40],rcx
0x9c023aa5f15   885  4c8bcf         REX.W movq r9,rdi
                  ;;; <@226,#169> add-i
0x9c023aa5f18   888  4183c101       addl r9,0x1              ;; debug: position 6722
0x9c023aa5f1c   892  0f80c8050000   jo 2378  (0x9c023aa64ea)
                  ;;; <@228,#172> check-non-smi
0x9c023aa5f22   898  f6c101         testb rcx,0x1            ;; debug: position 6729
0x9c023aa5f25   901  0f84c4050000   jz 2383  (0x9c023aa64ef)
                  ;;; <@230,#173> check-maps
0x9c023aa5f2b   907  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aa5f35   917  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023aa5f39   921  0f85b5050000   jnz 2388  (0x9c023aa64f4)
                  ;;; <@232,#178> load-named-field
0x9c023aa5f3f   927  4c8b590f       REX.W movq r11,[rcx+0xf]
                  ;;; <@234,#179> load-named-field
0x9c023aa5f43   931  458b730b       movl r14,[r11+0xb]
                  ;;; <@236,#180> load-named-field
0x9c023aa5f47   935  4d8b5b0f       REX.W movq r11,[r11+0xf]
                  ;;; <@238,#181> bounds-check
0x9c023aa5f4b   939  453bf1         cmpl r14,r9
0x9c023aa5f4e   942  0f86a5050000   jna 2393  (0x9c023aa64f9)
                  ;;; <@240,#171> constant-i
0x9c023aa5f54   948  4533c9         xorl r9,r9
                  ;;; <@242,#182> store-keyed
0x9c023aa5f57   951  45894cbb04     movl [r11+rdi*4+0x4],r9
                  ;;; <@244,#207> gap
0x9c023aa5f5c   956  41bf02000000   movl r15,0x2             ;; debug: position 6766
                  ;;; <@246,#208> -------------------- B8 (loop header) --------------------
                  ;;; <@249,#211> compare-numeric-and-branch
0x9c023aa5f62   962  443bfb         cmpl r15,rbx             ;; debug: position 6769
                                                             ;; debug: position 6772
0x9c023aa5f65   965  0f8d32000000   jge 1021  (0x9c023aa5f9d)
                  ;;; <@250,#212> -------------------- B9 (unreachable/replaced) --------------------
                  ;;; <@254,#218> -------------------- B10 --------------------
                  ;;; <@256,#220> stack-check
0x9c023aa5f6b   971  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023aa5f72   978  0f82ce030000   jc 1958  (0x9c023aa6346)
                  ;;; <@257,#220> gap
0x9c023aa5f78   984  4c8bcf         REX.W movq r9,rdi
                  ;;; <@258,#224> add-i
0x9c023aa5f7b   987  4503cf         addl r9,r15              ;; debug: position 6797
0x9c023aa5f7e   990  0f807a050000   jo 2398  (0x9c023aa64fe)
                  ;;; <@260,#236> bounds-check
0x9c023aa5f84   996  453bf1         cmpl r14,r9              ;; debug: position 6805
0x9c023aa5f87   999  0f8676050000   jna 2403  (0x9c023aa6503)
                  ;;; <@261,#236> gap
0x9c023aa5f8d  1005  498bc1         REX.W movq rax,r9
                  ;;; <@262,#171> constant-i
0x9c023aa5f90  1008  4533c9         xorl r9,r9               ;; debug: position 6729
                  ;;; <@264,#237> store-keyed
0x9c023aa5f93  1011  45890c83       movl [r11+rax*4],r9      ;; debug: position 6805
                  ;;; <@266,#240> add-i
0x9c023aa5f97  1015  4183c701       addl r15,0x1             ;; debug: position 6782
                  ;;; <@269,#243> goto
0x9c023aa5f9b  1019  ebc5           jmp 962  (0x9c023aa5f62)
                  ;;; <@270,#215> -------------------- B11 (unreachable/replaced) --------------------
                  ;;; <@274,#244> -------------------- B12 --------------------
                  ;;; <@276,#596> constant-d
0x9c023aa5f9d  1021  48b80000000000009041 REX.W movq rax,0x4190000000000000    ;; debug: position 6843
                                                             ;; debug: position 7130
0x9c023aa5fa7  1031  66480f6ed0     REX.W movq xmm2,rax
                  ;;; <@278,#274> gap
0x9c023aa5fac  1036  b802000000     movl rax,0x2             ;; debug: position 6892
                  ;;; <@280,#275> -------------------- B13 (loop header) --------------------
                  ;;; <@283,#278> compare-numeric-and-branch
0x9c023aa5fb1  1041  3b45e0         cmpl rax,[rbp-0x20]      ;; debug: position 6895
                                                             ;; debug: position 6897
0x9c023aa5fb4  1044  0f8d30010000   jge 1354  (0x9c023aa60ea)
                  ;;; <@284,#279> -------------------- B14 (unreachable/replaced) --------------------
                  ;;; <@288,#285> -------------------- B15 --------------------
                  ;;; <@290,#287> stack-check
0x9c023aa5fba  1050  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023aa5fc1  1057  0f82c0030000   jc 2023  (0x9c023aa6387)
                  ;;; <@291,#287> gap
0x9c023aa5fc7  1063  498bd8         REX.W movq rbx,r8
                  ;;; <@292,#291> add-i
0x9c023aa5fca  1066  03d8           addl rbx,rax             ;; debug: position 6937
0x9c023aa5fcc  1068  0f8036050000   jo 2408  (0x9c023aa6508)
                  ;;; <@294,#298> bounds-check
0x9c023aa5fd2  1074  443bf3         cmpl r14,rbx
0x9c023aa5fd5  1077  0f8632050000   jna 2413  (0x9c023aa650d)
                  ;;; <@296,#299> load-keyed
0x9c023aa5fdb  1083  418b1c9b       movl rbx,[r11+rbx*4]
                  ;;; <@298,#591> uint32-to-double
0x9c023aa5fdf  1087  f2480f2adb     REX.W cvtsi2sd xmm3,rbx    ;; debug: position 7024
                  ;;; <@299,#591> gap
0x9c023aa5fe4  1092  4c8b4da0       REX.W movq r9,[rbp-0x60]
                  ;;; <@300,#360> add-i
0x9c023aa5fe8  1096  4403c8         addl r9,rax              ;; debug: position 7051
0x9c023aa5feb  1099  0f8021050000   jo 2418  (0x9c023aa6512)
                  ;;; <@302,#326> gap
0x9c023aa5ff1  1105  33d2           xorl rdx,rdx             ;; debug: position 6974
0x9c023aa5ff3  1107  41bf02000000   movl r15,0x2
                  ;;; <@304,#327> -------------------- B16 (loop header) --------------------
                  ;;; <@307,#330> compare-numeric-and-branch
0x9c023aa5ff9  1113  443b7dd8       cmpl r15,[rbp-0x28]      ;; debug: position 6977
                                                             ;; debug: position 6979
0x9c023aa5ffd  1117  0f8dbd000000   jge 1312  (0x9c023aa60c0)
                  ;;; <@308,#331> -------------------- B17 (unreachable/replaced) --------------------
                  ;;; <@312,#337> -------------------- B18 --------------------
                  ;;; <@314,#339> stack-check
0x9c023aa6003  1123  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023aa600a  1130  0f82b8030000   jc 2088  (0x9c023aa63c8)
                  ;;; <@315,#339> gap
0x9c023aa6010  1136  488bfe         REX.W movq rdi,rsi
                  ;;; <@316,#346> add-i
0x9c023aa6013  1139  4103ff         addl rdi,r15             ;; debug: position 7036
0x9c023aa6016  1142  0f80fb040000   jo 2423  (0x9c023aa6517)
                  ;;; <@318,#353> bounds-check
0x9c023aa601c  1148  443bf7         cmpl r14,rdi
0x9c023aa601f  1151  0f86f7040000   jna 2428  (0x9c023aa651c)
                  ;;; <@320,#354> load-keyed
0x9c023aa6025  1157  418b3cbb       movl rdi,[r11+rdi*4]
                  ;;; <@322,#593> uint32-to-double
0x9c023aa6029  1161  f2480f2ae7     REX.W cvtsi2sd xmm4,rdi    ;; debug: position 7032
                  ;;; <@324,#355> mul-d
0x9c023aa602e  1166  f20f59e3       mulsd xmm4,xmm3          ;; debug: position 7026
                  ;;; <@325,#355> gap
0x9c023aa6032  1170  498bf9         REX.W movq rdi,r9
                  ;;; <@326,#363> add-i
0x9c023aa6035  1173  4103ff         addl rdi,r15             ;; debug: position 7055
0x9c023aa6038  1176  0f80e3040000   jo 2433  (0x9c023aa6521)
                  ;;; <@328,#366> sub-i
0x9c023aa603e  1182  83ef02         subl rdi,0x2             ;; debug: position 7059
0x9c023aa6041  1185  0f80df040000   jo 2438  (0x9c023aa6526)
                  ;;; <@330,#373> bounds-check
0x9c023aa6047  1191  443bf7         cmpl r14,rdi
0x9c023aa604a  1194  0f86db040000   jna 2443  (0x9c023aa652b)
                  ;;; <@332,#374> load-keyed
0x9c023aa6050  1200  418b0cbb       movl rcx,[r11+rdi*4]
                  ;;; <@334,#594> uint32-to-double
0x9c023aa6054  1204  f2480f2ae9     REX.W cvtsi2sd xmm5,rcx    ;; debug: position 7047
                  ;;; <@336,#375> add-d
0x9c023aa6059  1209  f20f58ec       addsd xmm5,xmm4          ;; debug: position 7041
                  ;;; <@338,#592> int32-to-double
0x9c023aa605d  1213  0f57c9         xorps xmm1,xmm1          ;; debug: position 7066
0x9c023aa6060  1216  f20f2aca       cvtsi2sd xmm1,rdx
                  ;;; <@340,#378> add-d
0x9c023aa6064  1220  f20f58cd       addsd xmm1,xmm5          ;; debug: position 7064
                  ;;; <@342,#595> double-to-i
0x9c023aa6068  1224  f2480f2cd1     REX.W cvttsd2siq rdx,xmm1    ;; debug: position 7099
0x9c023aa606d  1229  4883fa01       REX.W cmpq rdx,0x1
0x9c023aa6071  1233  7112           jno 1253  (0x9c023aa6085)
0x9c023aa6073  1235  4883ec08       REX.W subq rsp,0x8
0x9c023aa6077  1239  f20f110c24     movsd [rsp],xmm1
0x9c023aa607c  1244  e81fb0feff     call 0x9c023a910a0       ;; code: STUB, DoubleToIStub, minor: 266372
0x9c023aa6081  1249  4883c408       REX.W addq rsp,0x8
0x9c023aa6085  1253  8bd2           movl rdx,rdx
                  ;;; <@344,#394> bit-i
0x9c023aa6087  1255  81e2ffffff03   andl rdx,0x3ffffff       ;; debug: position 7102
                  ;;; <@346,#406> store-keyed
0x9c023aa608d  1261  418914bb       movl [r11+rdi*4],rdx
                  ;;; <@348,#410> div-d
0x9c023aa6091  1265  f20f5eca       divsd xmm1,xmm2          ;; debug: position 7130
0x9c023aa6095  1269  0f28c9         movaps xmm1,xmm1
                  ;;; <@350,#597> double-to-i
0x9c023aa6098  1272  f2480f2cd1     REX.W cvttsd2siq rdx,xmm1
0x9c023aa609d  1277  4883fa01       REX.W cmpq rdx,0x1
0x9c023aa60a1  1281  7112           jno 1301  (0x9c023aa60b5)
0x9c023aa60a3  1283  4883ec08       REX.W subq rsp,0x8
0x9c023aa60a7  1287  f20f110c24     movsd [rsp],xmm1
0x9c023aa60ac  1292  e8efaffeff     call 0x9c023a910a0       ;; code: STUB, DoubleToIStub, minor: 266372
0x9c023aa60b1  1297  4883c408       REX.W addq rsp,0x8
0x9c023aa60b5  1301  8bd2           movl rdx,rdx
                  ;;; <@352,#417> add-i
0x9c023aa60b7  1303  4183c701       addl r15,0x1             ;; debug: position 6989
                  ;;; <@355,#420> goto
0x9c023aa60bb  1307  e939ffffff     jmp 1113  (0x9c023aa5ff9)
                  ;;; <@356,#334> -------------------- B19 (unreachable/replaced) --------------------
                  ;;; <@360,#421> -------------------- B20 --------------------
                  ;;; <@361,#421> gap
0x9c023aa60c0  1312  498bd9         REX.W movq rbx,r9        ;; debug: position 7161
                  ;;; <@362,#428> add-i
0x9c023aa60c3  1315  035dd8         addl rbx,[rbp-0x28]      ;; debug: position 7173
0x9c023aa60c6  1318  0f8064040000   jo 2448  (0x9c023aa6530)
                  ;;; <@364,#431> sub-i
0x9c023aa60cc  1324  83eb02         subl rbx,0x2             ;; debug: position 7182
0x9c023aa60cf  1327  0f8060040000   jo 2453  (0x9c023aa6535)
                  ;;; <@366,#443> bounds-check
0x9c023aa60d5  1333  443bf3         cmpl r14,rbx             ;; debug: position 7189
0x9c023aa60d8  1336  0f865c040000   jna 2458  (0x9c023aa653a)
                  ;;; <@368,#444> store-keyed
0x9c023aa60de  1342  4189149b       movl [r11+rbx*4],rdx
                  ;;; <@370,#447> add-i
0x9c023aa60e2  1346  83c001         addl rax,0x1             ;; debug: position 6907
                  ;;; <@373,#450> goto
0x9c023aa60e5  1349  e9c7feffff     jmp 1041  (0x9c023aa5fb1)
                  ;;; <@374,#282> -------------------- B21 (unreachable/replaced) --------------------
                  ;;; <@378,#451> -------------------- B22 --------------------
                  ;;; <@379,#451> gap
0x9c023aa60ea  1354  488b45b0       REX.W movq rax,[rbp-0x50]    ;; debug: position 7224
                  ;;; <@380,#459> sub-i
0x9c023aa60ee  1358  83e803         subl rax,0x3             ;; debug: position 7254
0x9c023aa60f1  1361  0f8048040000   jo 2463  (0x9c023aa653f)
                  ;;; <@382,#462> add-i
0x9c023aa60f7  1367  0345a0         addl rax,[rbp-0x60]      ;; debug: position 7258
0x9c023aa60fa  1370  0f8044040000   jo 2468  (0x9c023aa6544)
                  ;;; <@383,#462> gap
0x9c023aa6100  1376  488b5da0       REX.W movq rbx,[rbp-0x60]
                  ;;; <@384,#491> add-i
0x9c023aa6104  1380  83c302         addl rbx,0x2             ;; debug: position 7282
0x9c023aa6107  1383  0f803c040000   jo 2473  (0x9c023aa6549)
                  ;;; <@386,#486> gap
0x9c023aa610d  1389  33d2           xorl rdx,rdx             ;; debug: position 7267
                  ;;; <@388,#487> -------------------- B23 (loop header) --------------------
                  ;;; <@391,#493> compare-numeric-and-branch
0x9c023aa610f  1391  3bc3           cmpl rax,rbx             ;; debug: position 7275
                                                             ;; debug: position 7277
0x9c023aa6111  1393  0f8e42000000   jle 1465  (0x9c023aa6159)
                  ;;; <@392,#494> -------------------- B24 (unreachable/replaced) --------------------
                  ;;; <@396,#500> -------------------- B25 --------------------
                  ;;; <@398,#508> bounds-check
0x9c023aa6117  1399  443bf0         cmpl r14,rax             ;; debug: position 7289
                                                             ;; debug: position 7294
0x9c023aa611a  1402  0f862e040000   jna 2478  (0x9c023aa654e)
                  ;;; <@400,#509> load-keyed
0x9c023aa6120  1408  418b0c83       movl rcx,[r11+rax*4]
0x9c023aa6124  1412  85c9           testl rcx,rcx
0x9c023aa6126  1414  0f8827040000   js 2483  (0x9c023aa6553)
                  ;;; <@403,#511> compare-numeric-and-branch
0x9c023aa612c  1420  83f900         cmpl rcx,0x0             ;; debug: position 7297
0x9c023aa612f  1423  0f8524000000   jnz 1465  (0x9c023aa6159)
                  ;;; <@404,#512> -------------------- B26 (unreachable/replaced) --------------------
                  ;;; <@408,#518> -------------------- B27 --------------------
                  ;;; <@410,#520> stack-check
0x9c023aa6135  1429  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023aa613c  1436  0f82c7020000   jc 2153  (0x9c023aa6409)
                  ;;; <@412,#523> add-i
0x9c023aa6142  1442  8d48ff         leal rcx,[rax-0x1]       ;; debug: position 7312
                  ;;; <@413,#523> gap
0x9c023aa6145  1445  488bf2         REX.W movq rsi,rdx
                  ;;; <@414,#526> add-i
0x9c023aa6148  1448  83c601         addl rsi,0x1             ;; debug: position 7322
0x9c023aa614b  1451  0f8007040000   jo 2488  (0x9c023aa6558)
                  ;;; <@416,#529> gap
0x9c023aa6151  1457  488bd6         REX.W movq rdx,rsi
0x9c023aa6154  1460  488bc1         REX.W movq rax,rcx
                  ;;; <@417,#529> goto
0x9c023aa6157  1463  ebb6           jmp 1391  (0x9c023aa610f)
                  ;;; <@418,#515> -------------------- B28 (unreachable/replaced) --------------------
                  ;;; <@422,#497> -------------------- B29 (unreachable/replaced) --------------------
                  ;;; <@426,#530> -------------------- B30 --------------------
                  ;;; <@427,#530> gap
0x9c023aa6159  1465  488b45b0       REX.W movq rax,[rbp-0x50]    ;; debug: position 7364
                  ;;; <@428,#536> sub-i
0x9c023aa615d  1469  2bc2           subl rax,rdx             ;; debug: position 7380
0x9c023aa615f  1471  0f80f8030000   jo 2493  (0x9c023aa655d)
                  ;;; <@430,#539> sub-i
0x9c023aa6165  1477  83e802         subl rax,0x2             ;; debug: position 7398
                  ;;; <@433,#543> branch
0x9c023aa6168  1480  85d2           testl rdx,rdx            ;; debug: position 7411
0x9c023aa616a  1482  0f8411000000   jz 1505  (0x9c023aa6181)
                  ;;; <@434,#547> -------------------- B31 (unreachable/replaced) --------------------
                  ;;; <@438,#568> -------------------- B32 (unreachable/replaced) --------------------
                  ;;; <@442,#544> -------------------- B33 (unreachable/replaced) --------------------
                  ;;; <@446,#550> -------------------- B34 --------------------
                  ;;; <@447,#550> gap
0x9c023aa6170  1488  488b5da0       REX.W movq rbx,[rbp-0x60]    ;; debug: position 7429
                  ;;; <@448,#563> bounds-check
0x9c023aa6174  1492  443bf3         cmpl r14,rbx             ;; debug: position 7440
0x9c023aa6177  1495  0f86e5030000   jna 2498  (0x9c023aa6562)
                  ;;; <@450,#564> store-keyed
0x9c023aa617d  1501  4189049b       movl [r11+rbx*4],rax
                  ;;; <@454,#571> -------------------- B35 --------------------
                  ;;; <@455,#571> gap
0x9c023aa6181  1505  488b45a8       REX.W movq rax,[rbp-0x58]    ;; debug: position 7459
                  ;;; <@456,#589> smi-tag
0x9c023aa6185  1509  8bd8           movl rbx,rax
0x9c023aa6187  1511  48c1e320       REX.W shlq rbx,32
                  ;;; <@457,#589> gap
0x9c023aa618b  1515  488bc3         REX.W movq rax,rbx
                  ;;; <@458,#574> return
0x9c023aa618e  1518  488be5         REX.W movq rsp,rbp
0x9c023aa6191  1521  5d             pop rbp
0x9c023aa6192  1522  c21800         ret 0x18
                  ;;; <@32,#577> -------------------- Deferred tagged-to-i --------------------
0x9c023aa6195  1525  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 6489
0x9c023aa6199  1529  4d3950ff       REX.W cmpq [r8-0x1],r10
0x9c023aa619d  1533  7520           jnz 1567  (0x9c023aa61bf)
0x9c023aa619f  1535  f2410f104007   movsd xmm0,[r8+0x7]
0x9c023aa61a5  1541  f2440f2cc0     cvttsd2sil r8,xmm0
0x9c023aa61aa  1546  0f57c9         xorps xmm1,xmm1
0x9c023aa61ad  1549  f2410f2ac8     cvtsi2sd xmm1,r8
0x9c023aa61b2  1554  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023aa61b6  1558  7507           jnz 1567  (0x9c023aa61bf)
                  Deferred TaggedToI: NaN
0x9c023aa61b8  1560  7a05           jpe 1567  (0x9c023aa61bf)
0x9c023aa61ba  1562  e950faffff     jmp 111  (0x9c023aa5c0f)
0x9c023aa61bf  1567  e8b200c6ff     call 0x9c023706276       ;; deoptimization bailout 63
0x9c023aa61c4  1572  e946faffff     jmp 111  (0x9c023aa5c0f)
                  ;;; <@52,#579> -------------------- Deferred tagged-to-i --------------------
0x9c023aa61c9  1577  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 6520
0x9c023aa61cd  1581  4d3953ff       REX.W cmpq [r11-0x1],r10
0x9c023aa61d1  1585  7520           jnz 1619  (0x9c023aa61f3)
0x9c023aa61d3  1587  f2410f104307   movsd xmm0,[r11+0x7]
0x9c023aa61d9  1593  f2440f2cd8     cvttsd2sil r11,xmm0
0x9c023aa61de  1598  0f57c9         xorps xmm1,xmm1
0x9c023aa61e1  1601  f2410f2acb     cvtsi2sd xmm1,r11
0x9c023aa61e6  1606  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023aa61ea  1610  7507           jnz 1619  (0x9c023aa61f3)
                  Deferred TaggedToI: NaN
0x9c023aa61ec  1612  7a05           jpe 1619  (0x9c023aa61f3)
0x9c023aa61ee  1614  e988faffff     jmp 219  (0x9c023aa5c7b)
0x9c023aa61f3  1619  e88800c6ff     call 0x9c023706280       ;; deoptimization bailout 64
0x9c023aa61f8  1624  e97efaffff     jmp 219  (0x9c023aa5c7b)
                  ;;; <@74,#581> -------------------- Deferred tagged-to-i --------------------
0x9c023aa61fd  1629  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2205
0x9c023aa6201  1633  4c3956ff       REX.W cmpq [rsi-0x1],r10
0x9c023aa6205  1637  751d           jnz 1668  (0x9c023aa6224)
0x9c023aa6207  1639  f20f104607     movsd xmm0,[rsi+0x7]
0x9c023aa620c  1644  f20f2cf0       cvttsd2sil rsi,xmm0
0x9c023aa6210  1648  0f57c9         xorps xmm1,xmm1
0x9c023aa6213  1651  f20f2ace       cvtsi2sd xmm1,rsi
0x9c023aa6217  1655  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023aa621b  1659  7507           jnz 1668  (0x9c023aa6224)
                  Deferred TaggedToI: NaN
0x9c023aa621d  1661  7a05           jpe 1668  (0x9c023aa6224)
0x9c023aa621f  1663  e9e0faffff     jmp 356  (0x9c023aa5d04)
0x9c023aa6224  1668  e86100c6ff     call 0x9c02370628a       ;; deoptimization bailout 65
0x9c023aa6229  1673  e9d6faffff     jmp 356  (0x9c023aa5d04)
                  ;;; <@116,#582> -------------------- Deferred tagged-to-i --------------------
0x9c023aa622e  1678  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2258
0x9c023aa6232  1682  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023aa6236  1686  752a           jnz 1730  (0x9c023aa6262)
0x9c023aa6238  1688  f20f104007     movsd xmm0,[rax+0x7]
0x9c023aa623d  1693  f20f2cc0       cvttsd2sil rax,xmm0
0x9c023aa6241  1697  0f57c9         xorps xmm1,xmm1
0x9c023aa6244  1700  f20f2ac8       cvtsi2sd xmm1,rax
0x9c023aa6248  1704  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023aa624c  1708  7514           jnz 1730  (0x9c023aa6262)
                  Deferred TaggedToI: NaN
0x9c023aa624e  1710  7a12           jpe 1730  (0x9c023aa6262)
0x9c023aa6250  1712  85c0           testl rax,rax
0x9c023aa6252  1714  7509           jnz 1725  (0x9c023aa625d)
0x9c023aa6254  1716  660f50c0       movmskpd rax,xmm0
0x9c023aa6258  1720  83e001         andl rax,0x1
0x9c023aa625b  1723  7505           jnz 1730  (0x9c023aa6262)
0x9c023aa625d  1725  e9f4faffff     jmp 438  (0x9c023aa5d56)
0x9c023aa6262  1730  e82d00c6ff     call 0x9c023706294       ;; deoptimization bailout 66
0x9c023aa6267  1735  e9eafaffff     jmp 438  (0x9c023aa5d56)
                  ;;; <@130,#586> -------------------- Deferred tagged-to-i --------------------
0x9c023aa626c  1740  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2394
0x9c023aa6270  1744  4c3952ff       REX.W cmpq [rdx-0x1],r10
0x9c023aa6274  1748  751d           jnz 1779  (0x9c023aa6293)
0x9c023aa6276  1750  f20f104207     movsd xmm0,[rdx+0x7]
0x9c023aa627b  1755  f20f2cd0       cvttsd2sil rdx,xmm0
0x9c023aa627f  1759  0f57c9         xorps xmm1,xmm1
0x9c023aa6282  1762  f20f2aca       cvtsi2sd xmm1,rdx
0x9c023aa6286  1766  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023aa628a  1770  7507           jnz 1779  (0x9c023aa6293)
                  Deferred TaggedToI: NaN
0x9c023aa628c  1772  7a05           jpe 1779  (0x9c023aa6293)
0x9c023aa628e  1774  e9fefaffff     jmp 497  (0x9c023aa5d91)
0x9c023aa6293  1779  e80600c6ff     call 0x9c02370629e       ;; deoptimization bailout 67
0x9c023aa6298  1784  e9f4faffff     jmp 497  (0x9c023aa5d91)
                  ;;; <@144,#588> -------------------- Deferred tagged-to-i --------------------
0x9c023aa629d  1789  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2484
0x9c023aa62a1  1793  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023aa62a5  1797  752a           jnz 1841  (0x9c023aa62d1)
0x9c023aa62a7  1799  f20f104007     movsd xmm0,[rax+0x7]
0x9c023aa62ac  1804  f20f2cc0       cvttsd2sil rax,xmm0
0x9c023aa62b0  1808  0f57c9         xorps xmm1,xmm1
0x9c023aa62b3  1811  f20f2ac8       cvtsi2sd xmm1,rax
0x9c023aa62b7  1815  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023aa62bb  1819  7514           jnz 1841  (0x9c023aa62d1)
                  Deferred TaggedToI: NaN
0x9c023aa62bd  1821  7a12           jpe 1841  (0x9c023aa62d1)
0x9c023aa62bf  1823  85c0           testl rax,rax
0x9c023aa62c1  1825  7509           jnz 1836  (0x9c023aa62cc)
0x9c023aa62c3  1827  660f50c0       movmskpd rax,xmm0
0x9c023aa62c7  1831  83e001         andl rax,0x1
0x9c023aa62ca  1834  7505           jnz 1841  (0x9c023aa62d1)
0x9c023aa62cc  1836  e9fafaffff     jmp 555  (0x9c023aa5dcb)
0x9c023aa62d1  1841  e8d2ffc5ff     call 0x9c0237062a8       ;; deoptimization bailout 68
0x9c023aa62d6  1846  e9f0faffff     jmp 555  (0x9c023aa5dcb)
                  ;;; <@176,#585> -------------------- Deferred tagged-to-i --------------------
0x9c023aa62db  1851  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2513
0x9c023aa62df  1855  4d3950ff       REX.W cmpq [r8-0x1],r10
0x9c023aa62e3  1859  752b           jnz 1904  (0x9c023aa6310)
0x9c023aa62e5  1861  f2410f104007   movsd xmm0,[r8+0x7]
0x9c023aa62eb  1867  f24c0f2cc0     REX.W cvttsd2siq r8,xmm0
0x9c023aa62f0  1872  4983f801       REX.W cmpq r8,0x1
0x9c023aa62f4  1876  7112           jno 1896  (0x9c023aa6308)
0x9c023aa62f6  1878  4883ec08       REX.W subq rsp,0x8
0x9c023aa62fa  1882  f20f110424     movsd [rsp],xmm0
0x9c023aa62ff  1887  e83ce4f9ff     call 0x9c023a44740       ;; code: STUB, DoubleToIStub, minor: 266756
0x9c023aa6304  1892  4883c408       REX.W addq rsp,0x8
0x9c023aa6308  1896  458bc0         movl r8,r8
0x9c023aa630b  1899  e938fbffff     jmp 680  (0x9c023aa5e48)
0x9c023aa6310  1904  4d3b45a8       REX.W cmpq r8,[r13-0x58]
0x9c023aa6314  1908  7508           jnz 1918  (0x9c023aa631e)
0x9c023aa6316  1910  4533c0         xorl r8,r8
0x9c023aa6319  1913  e92afbffff     jmp 680  (0x9c023aa5e48)
0x9c023aa631e  1918  4d3b45c0       REX.W cmpq r8,[r13-0x40]
0x9c023aa6322  1922  750b           jnz 1935  (0x9c023aa632f)
0x9c023aa6324  1924  41b801000000   movl r8,0x1
0x9c023aa632a  1930  e919fbffff     jmp 680  (0x9c023aa5e48)
0x9c023aa632f  1935  4d3b45c8       REX.W cmpq r8,[r13-0x38]
                  Deferred TaggedToI: cannot truncate
0x9c023aa6333  1939  0f852e020000   jnz 2503  (0x9c023aa6567)
0x9c023aa6339  1945  4533c0         xorl r8,r8
0x9c023aa633c  1948  e907fbffff     jmp 680  (0x9c023aa5e48)
0x9c023aa6341  1953  e902fbffff     jmp 680  (0x9c023aa5e48)
                  ;;; <@256,#220> -------------------- Deferred stack-check --------------------
0x9c023aa6346  1958  50             push rax                 ;; debug: position 6772
0x9c023aa6347  1959  51             push rcx
0x9c023aa6348  1960  52             push rdx
0x9c023aa6349  1961  53             push rbx
0x9c023aa634a  1962  56             push rsi
0x9c023aa634b  1963  57             push rdi
0x9c023aa634c  1964  4150           push r8
0x9c023aa634e  1966  4151           push r9
0x9c023aa6350  1968  4153           push r11
0x9c023aa6352  1970  4156           push r14
0x9c023aa6354  1972  4157           push r15
0x9c023aa6356  1974  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023aa635b  1979  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023aa635f  1983  33c0           xorl rax,rax
0x9c023aa6361  1985  498d9d78f8e4fd REX.W leaq rbx,[r13-0x21b0788]
0x9c023aa6368  1992  e853fef5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023aa636d  1997  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023aa6372  2002  415f           pop r15
0x9c023aa6374  2004  415e           pop r14
0x9c023aa6376  2006  415b           pop r11
0x9c023aa6378  2008  4159           pop r9
0x9c023aa637a  2010  4158           pop r8
0x9c023aa637c  2012  5f             pop rdi
0x9c023aa637d  2013  5e             pop rsi
0x9c023aa637e  2014  5b             pop rbx
0x9c023aa637f  2015  5a             pop rdx
0x9c023aa6380  2016  59             pop rcx
0x9c023aa6381  2017  58             pop rax
0x9c023aa6382  2018  e9f1fbffff     jmp 984  (0x9c023aa5f78)
                  ;;; <@290,#287> -------------------- Deferred stack-check --------------------
0x9c023aa6387  2023  50             push rax                 ;; debug: position 6897
0x9c023aa6388  2024  51             push rcx
0x9c023aa6389  2025  52             push rdx
0x9c023aa638a  2026  53             push rbx
0x9c023aa638b  2027  56             push rsi
0x9c023aa638c  2028  57             push rdi
0x9c023aa638d  2029  4150           push r8
0x9c023aa638f  2031  4151           push r9
0x9c023aa6391  2033  4153           push r11
0x9c023aa6393  2035  4156           push r14
0x9c023aa6395  2037  4157           push r15
0x9c023aa6397  2039  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023aa639c  2044  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023aa63a0  2048  33c0           xorl rax,rax
0x9c023aa63a2  2050  498d9d78f8e4fd REX.W leaq rbx,[r13-0x21b0788]
0x9c023aa63a9  2057  e812fef5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023aa63ae  2062  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023aa63b3  2067  415f           pop r15
0x9c023aa63b5  2069  415e           pop r14
0x9c023aa63b7  2071  415b           pop r11
0x9c023aa63b9  2073  4159           pop r9
0x9c023aa63bb  2075  4158           pop r8
0x9c023aa63bd  2077  5f             pop rdi
0x9c023aa63be  2078  5e             pop rsi
0x9c023aa63bf  2079  5b             pop rbx
0x9c023aa63c0  2080  5a             pop rdx
0x9c023aa63c1  2081  59             pop rcx
0x9c023aa63c2  2082  58             pop rax
0x9c023aa63c3  2083  e9fffbffff     jmp 1063  (0x9c023aa5fc7)
                  ;;; <@314,#339> -------------------- Deferred stack-check --------------------
0x9c023aa63c8  2088  50             push rax                 ;; debug: position 6979
0x9c023aa63c9  2089  51             push rcx
0x9c023aa63ca  2090  52             push rdx
0x9c023aa63cb  2091  53             push rbx
0x9c023aa63cc  2092  56             push rsi
0x9c023aa63cd  2093  57             push rdi
0x9c023aa63ce  2094  4150           push r8
0x9c023aa63d0  2096  4151           push r9
0x9c023aa63d2  2098  4153           push r11
0x9c023aa63d4  2100  4156           push r14
0x9c023aa63d6  2102  4157           push r15
0x9c023aa63d8  2104  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023aa63dd  2109  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023aa63e1  2113  33c0           xorl rax,rax
0x9c023aa63e3  2115  498d9d78f8e4fd REX.W leaq rbx,[r13-0x21b0788]
0x9c023aa63ea  2122  e8d1fdf5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023aa63ef  2127  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023aa63f4  2132  415f           pop r15
0x9c023aa63f6  2134  415e           pop r14
0x9c023aa63f8  2136  415b           pop r11
0x9c023aa63fa  2138  4159           pop r9
0x9c023aa63fc  2140  4158           pop r8
0x9c023aa63fe  2142  5f             pop rdi
0x9c023aa63ff  2143  5e             pop rsi
0x9c023aa6400  2144  5b             pop rbx
0x9c023aa6401  2145  5a             pop rdx
0x9c023aa6402  2146  59             pop rcx
0x9c023aa6403  2147  58             pop rax
0x9c023aa6404  2148  e907fcffff     jmp 1136  (0x9c023aa6010)
                  ;;; <@410,#520> -------------------- Deferred stack-check --------------------
0x9c023aa6409  2153  50             push rax                 ;; debug: position 7297
0x9c023aa640a  2154  51             push rcx
0x9c023aa640b  2155  52             push rdx
0x9c023aa640c  2156  53             push rbx
0x9c023aa640d  2157  56             push rsi
0x9c023aa640e  2158  57             push rdi
0x9c023aa640f  2159  4150           push r8
0x9c023aa6411  2161  4151           push r9
0x9c023aa6413  2163  4153           push r11
0x9c023aa6415  2165  4156           push r14
0x9c023aa6417  2167  4157           push r15
0x9c023aa6419  2169  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023aa641e  2174  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023aa6422  2178  33c0           xorl rax,rax
0x9c023aa6424  2180  498d9d78f8e4fd REX.W leaq rbx,[r13-0x21b0788]
0x9c023aa642b  2187  e890fdf5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023aa6430  2192  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023aa6435  2197  415f           pop r15
0x9c023aa6437  2199  415e           pop r14
0x9c023aa6439  2201  415b           pop r11
0x9c023aa643b  2203  4159           pop r9
0x9c023aa643d  2205  4158           pop r8
0x9c023aa643f  2207  5f             pop rdi
0x9c023aa6440  2208  5e             pop rsi
0x9c023aa6441  2209  5b             pop rbx
0x9c023aa6442  2210  5a             pop rdx
0x9c023aa6443  2211  59             pop rcx
0x9c023aa6444  2212  58             pop rax
0x9c023aa6445  2213  e9f8fcffff     jmp 1442  (0x9c023aa6142)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x9c023aa644a  2218  e8bbfbc5ff     call 0x9c02370600a       ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x9c023aa644f  2223  e8c0fbc5ff     call 0x9c023706014       ;; deoptimization bailout 2
                  ;;; jump table entry 2: deoptimization bailout 3.
0x9c023aa6454  2228  e8c5fbc5ff     call 0x9c02370601e       ;; deoptimization bailout 3
                  ;;; jump table entry 3: deoptimization bailout 4.
0x9c023aa6459  2233  e8cafbc5ff     call 0x9c023706028       ;; deoptimization bailout 4
                  ;;; jump table entry 4: deoptimization bailout 5.
0x9c023aa645e  2238  e8cffbc5ff     call 0x9c023706032       ;; deoptimization bailout 5
                  ;;; jump table entry 5: deoptimization bailout 6.
0x9c023aa6463  2243  e8d4fbc5ff     call 0x9c02370603c       ;; deoptimization bailout 6
                  ;;; jump table entry 6: deoptimization bailout 7.
0x9c023aa6468  2248  e8d9fbc5ff     call 0x9c023706046       ;; deoptimization bailout 7
                  ;;; jump table entry 7: deoptimization bailout 8.
0x9c023aa646d  2253  e8defbc5ff     call 0x9c023706050       ;; deoptimization bailout 8
                  ;;; jump table entry 8: deoptimization bailout 9.
0x9c023aa6472  2258  e8e3fbc5ff     call 0x9c02370605a       ;; deoptimization bailout 9
                  ;;; jump table entry 9: deoptimization bailout 10.
0x9c023aa6477  2263  e8e8fbc5ff     call 0x9c023706064       ;; deoptimization bailout 10
                  ;;; jump table entry 10: deoptimization bailout 11.
0x9c023aa647c  2268  e8edfbc5ff     call 0x9c02370606e       ;; deoptimization bailout 11
                  ;;; jump table entry 11: deoptimization bailout 12.
0x9c023aa6481  2273  e8f2fbc5ff     call 0x9c023706078       ;; deoptimization bailout 12
                  ;;; jump table entry 12: deoptimization bailout 13.
0x9c023aa6486  2278  e8f7fbc5ff     call 0x9c023706082       ;; deoptimization bailout 13
                  ;;; jump table entry 13: deoptimization bailout 14.
0x9c023aa648b  2283  e8fcfbc5ff     call 0x9c02370608c       ;; deoptimization bailout 14
                  ;;; jump table entry 14: deoptimization bailout 15.
0x9c023aa6490  2288  e801fcc5ff     call 0x9c023706096       ;; deoptimization bailout 15
                  ;;; jump table entry 15: deoptimization bailout 17.
0x9c023aa6495  2293  e810fcc5ff     call 0x9c0237060aa       ;; deoptimization bailout 17
                  ;;; jump table entry 16: deoptimization bailout 18.
0x9c023aa649a  2298  e815fcc5ff     call 0x9c0237060b4       ;; deoptimization bailout 18
                  ;;; jump table entry 17: deoptimization bailout 19.
0x9c023aa649f  2303  e81afcc5ff     call 0x9c0237060be       ;; deoptimization bailout 19
                  ;;; jump table entry 18: deoptimization bailout 20.
0x9c023aa64a4  2308  e81ffcc5ff     call 0x9c0237060c8       ;; deoptimization bailout 20
                  ;;; jump table entry 19: deoptimization bailout 21.
0x9c023aa64a9  2313  e824fcc5ff     call 0x9c0237060d2       ;; deoptimization bailout 21
                  ;;; jump table entry 20: deoptimization bailout 22.
0x9c023aa64ae  2318  e829fcc5ff     call 0x9c0237060dc       ;; deoptimization bailout 22
                  ;;; jump table entry 21: deoptimization bailout 23.
0x9c023aa64b3  2323  e82efcc5ff     call 0x9c0237060e6       ;; deoptimization bailout 23
                  ;;; jump table entry 22: deoptimization bailout 24.
0x9c023aa64b8  2328  e833fcc5ff     call 0x9c0237060f0       ;; deoptimization bailout 24
                  ;;; jump table entry 23: deoptimization bailout 25.
0x9c023aa64bd  2333  e838fcc5ff     call 0x9c0237060fa       ;; deoptimization bailout 25
                  ;;; jump table entry 24: deoptimization bailout 26.
0x9c023aa64c2  2338  e83dfcc5ff     call 0x9c023706104       ;; deoptimization bailout 26
                  ;;; jump table entry 25: deoptimization bailout 27.
0x9c023aa64c7  2343  e842fcc5ff     call 0x9c02370610e       ;; deoptimization bailout 27
                  ;;; jump table entry 26: deoptimization bailout 28.
0x9c023aa64cc  2348  e847fcc5ff     call 0x9c023706118       ;; deoptimization bailout 28
                  ;;; jump table entry 27: deoptimization bailout 29.
0x9c023aa64d1  2353  e84cfcc5ff     call 0x9c023706122       ;; deoptimization bailout 29
                  ;;; jump table entry 28: deoptimization bailout 30.
0x9c023aa64d6  2358  e851fcc5ff     call 0x9c02370612c       ;; deoptimization bailout 30
                  ;;; jump table entry 29: deoptimization bailout 31.
0x9c023aa64db  2363  e856fcc5ff     call 0x9c023706136       ;; deoptimization bailout 31
                  ;;; jump table entry 30: deoptimization bailout 32.
0x9c023aa64e0  2368  e85bfcc5ff     call 0x9c023706140       ;; deoptimization bailout 32
                  ;;; jump table entry 31: deoptimization bailout 33.
0x9c023aa64e5  2373  e860fcc5ff     call 0x9c02370614a       ;; deoptimization bailout 33
                  ;;; jump table entry 32: deoptimization bailout 34.
0x9c023aa64ea  2378  e865fcc5ff     call 0x9c023706154       ;; deoptimization bailout 34
                  ;;; jump table entry 33: deoptimization bailout 35.
0x9c023aa64ef  2383  e86afcc5ff     call 0x9c02370615e       ;; deoptimization bailout 35
                  ;;; jump table entry 34: deoptimization bailout 36.
0x9c023aa64f4  2388  e86ffcc5ff     call 0x9c023706168       ;; deoptimization bailout 36
                  ;;; jump table entry 35: deoptimization bailout 37.
0x9c023aa64f9  2393  e874fcc5ff     call 0x9c023706172       ;; deoptimization bailout 37
                  ;;; jump table entry 36: deoptimization bailout 39.
0x9c023aa64fe  2398  e883fcc5ff     call 0x9c023706186       ;; deoptimization bailout 39
                  ;;; jump table entry 37: deoptimization bailout 40.
0x9c023aa6503  2403  e888fcc5ff     call 0x9c023706190       ;; deoptimization bailout 40
                  ;;; jump table entry 38: deoptimization bailout 42.
0x9c023aa6508  2408  e897fcc5ff     call 0x9c0237061a4       ;; deoptimization bailout 42
                  ;;; jump table entry 39: deoptimization bailout 43.
0x9c023aa650d  2413  e89cfcc5ff     call 0x9c0237061ae       ;; deoptimization bailout 43
                  ;;; jump table entry 40: deoptimization bailout 44.
0x9c023aa6512  2418  e8a1fcc5ff     call 0x9c0237061b8       ;; deoptimization bailout 44
                  ;;; jump table entry 41: deoptimization bailout 46.
0x9c023aa6517  2423  e8b0fcc5ff     call 0x9c0237061cc       ;; deoptimization bailout 46
                  ;;; jump table entry 42: deoptimization bailout 47.
0x9c023aa651c  2428  e8b5fcc5ff     call 0x9c0237061d6       ;; deoptimization bailout 47
                  ;;; jump table entry 43: deoptimization bailout 48.
0x9c023aa6521  2433  e8bafcc5ff     call 0x9c0237061e0       ;; deoptimization bailout 48
                  ;;; jump table entry 44: deoptimization bailout 49.
0x9c023aa6526  2438  e8bffcc5ff     call 0x9c0237061ea       ;; deoptimization bailout 49
                  ;;; jump table entry 45: deoptimization bailout 50.
0x9c023aa652b  2443  e8c4fcc5ff     call 0x9c0237061f4       ;; deoptimization bailout 50
                  ;;; jump table entry 46: deoptimization bailout 51.
0x9c023aa6530  2448  e8c9fcc5ff     call 0x9c0237061fe       ;; deoptimization bailout 51
                  ;;; jump table entry 47: deoptimization bailout 52.
0x9c023aa6535  2453  e8cefcc5ff     call 0x9c023706208       ;; deoptimization bailout 52
                  ;;; jump table entry 48: deoptimization bailout 53.
0x9c023aa653a  2458  e8d3fcc5ff     call 0x9c023706212       ;; deoptimization bailout 53
                  ;;; jump table entry 49: deoptimization bailout 54.
0x9c023aa653f  2463  e8d8fcc5ff     call 0x9c02370621c       ;; deoptimization bailout 54
                  ;;; jump table entry 50: deoptimization bailout 55.
0x9c023aa6544  2468  e8ddfcc5ff     call 0x9c023706226       ;; deoptimization bailout 55
                  ;;; jump table entry 51: deoptimization bailout 56.
0x9c023aa6549  2473  e8e2fcc5ff     call 0x9c023706230       ;; deoptimization bailout 56
                  ;;; jump table entry 52: deoptimization bailout 57.
0x9c023aa654e  2478  e8e7fcc5ff     call 0x9c02370623a       ;; deoptimization bailout 57
                  ;;; jump table entry 53: deoptimization bailout 58.
0x9c023aa6553  2483  e8ecfcc5ff     call 0x9c023706244       ;; deoptimization bailout 58
                  ;;; jump table entry 54: deoptimization bailout 60.
0x9c023aa6558  2488  e8fbfcc5ff     call 0x9c023706258       ;; deoptimization bailout 60
                  ;;; jump table entry 55: deoptimization bailout 61.
0x9c023aa655d  2493  e800fdc5ff     call 0x9c023706262       ;; deoptimization bailout 61
                  ;;; jump table entry 56: deoptimization bailout 62.
0x9c023aa6562  2498  e805fdc5ff     call 0x9c02370626c       ;; deoptimization bailout 62
                  ;;; jump table entry 57: deoptimization bailout 69.
0x9c023aa6567  2503  e846fdc5ff     call 0x9c0237062b2       ;; deoptimization bailout 69
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 70)
 index  ast id    argc     pc             
     0       3       0     35
     1       3       0     -1
     2       3       0     -1
     3       3       0     -1
     4       3       0     -1
     5       3       0     -1
     6       3       0     -1
     7       3       0     -1
     8       3       0     -1
     9       3       0     -1
    10       3       0     -1
    11       3       0     -1
    12       3       0     -1
    13       3       0     -1
    14       3       0     -1
    15       3       0     -1
    16      16       0    412
    17      19       0     -1
    18      28       0     -1
    19      54       0     -1
    20      63       0     -1
    21      63       0     -1
    22      63       0     -1
    23      81       0     -1
    24      81       0     -1
    25      81       0     -1
    26      75       0     -1
    27      75       0     -1
    28      75       0     -1
    29      75       0     -1
    30      75       0     -1
    31      75       0     -1
    32      75       0     -1
    33      75       0     -1
    34      75       0     -1
    35     137       0     -1
    36     137       0     -1
    37     137       0     -1
    38     163       0    984
    39     163       0     -1
    40     163       0     -1
    41     241       0   1063
    42     241       0     -1
    43     241       0     -1
    44     295       0     -1
    45     299       0   1136
    46     299       0     -1
    47     299       0     -1
    48     299       0     -1
    49     299       0     -1
    50     299       0     -1
    51     428       0     -1
    52     428       0     -1
    53     428       0     -1
    54     468       0     -1
    55     468       0     -1
    56     486       0     -1
    57     514       0     -1
    58     514       0     -1
    59     489       0   1442
    60     489       0     -1
    61     537       0     -1
    62     570       0     -1
    63       3       0     -1
    64       3       0     -1
    65       2       0     -1
    66      19       0     -1
    67      28       0     -1
    68      54       0     -1
    69      63       0     -1

Safepoints (size = 80)
0x9c023aa5bc3    35  0000000001 (sp -> fp)       0
0x9c023aa5d3c   412  0000010001 (sp -> fp)      16
0x9c023aa636d  1997  0000100001 | rcx | rdx (sp -> fp)      38
0x9c023aa63ae  2062  0000100001 (sp -> fp)      41
0x9c023aa63ef  2127  0000100001 (sp -> fp)      45
0x9c023aa6430  2192  0000000001 (sp -> fp)      59

RelocInfo (size = 4209)
0x9c023aa5baa  position  (6452)
0x9c023aa5baa  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x9c023aa5baa  comment  (;;; <@2,#1> context)
0x9c023aa5bae  comment  (;;; <@3,#1> gap)
0x9c023aa5bb2  comment  (;;; <@12,#9> -------------------- B1 --------------------)
0x9c023aa5bb2  comment  (;;; <@13,#9> gap)
0x9c023aa5bb5  comment  (;;; <@14,#11> stack-check)
0x9c023aa5bbf  code target (BUILTIN)  (0x9c023a25e60)
0x9c023aa5bc3  comment  (;;; <@16,#11> lazy-bailout)
0x9c023aa5bc3  comment  (;;; <@17,#11> gap)
0x9c023aa5bc7  comment  (;;; <@18,#12> load-context-slot)
0x9c023aa5bc7  position  (6479)
0x9c023aa5bce  comment  (;;; <@20,#13> load-context-slot)
0x9c023aa5bce  position  (6484)
0x9c023aa5bd5  comment  (;;; <@22,#15> check-non-smi)
0x9c023aa5bd5  position  (6489)
0x9c023aa5bde  comment  (;;; <@24,#16> check-maps)
0x9c023aa5be0  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aa5bf2  comment  (;;; <@26,#17> load-named-field)
0x9c023aa5bf6  comment  (;;; <@28,#18> load-named-field)
0x9c023aa5bf9  comment  (;;; <@30,#19> load-named-field)
0x9c023aa5bfd  comment  (;;; <@31,#19> gap)
0x9c023aa5c01  comment  (;;; <@32,#577> tagged-to-i)
0x9c023aa5c0f  comment  (;;; <@33,#577> gap)
0x9c023aa5c13  comment  (;;; <@34,#20> bounds-check)
0x9c023aa5c1c  comment  (;;; <@36,#21> load-keyed)
0x9c023aa5c28  comment  (;;; <@38,#22> check-non-smi)
0x9c023aa5c31  comment  (;;; <@40,#23> check-maps)
0x9c023aa5c33  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aa5c45  comment  (;;; <@42,#24> load-named-field)
0x9c023aa5c49  comment  (;;; <@44,#25> load-named-field)
0x9c023aa5c4c  comment  (;;; <@46,#26> load-named-field)
0x9c023aa5c50  comment  (;;; <@48,#27> bounds-check)
0x9c023aa5c58  comment  (;;; <@50,#28> load-keyed)
0x9c023aa5c65  comment  (;;; <@51,#28> gap)
0x9c023aa5c6d  comment  (;;; <@52,#579> tagged-to-i)
0x9c023aa5c6d  position  (6520)
0x9c023aa5c7b  comment  (;;; <@53,#579> gap)
0x9c023aa5c7f  comment  (;;; <@54,#37> bounds-check)
0x9c023aa5c88  comment  (;;; <@56,#38> load-keyed)
0x9c023aa5c94  comment  (;;; <@58,#44> bounds-check)
0x9c023aa5c9c  comment  (;;; <@60,#45> load-keyed)
0x9c023aa5ca7  comment  (;;; <@61,#45> gap)
0x9c023aa5cae  comment  (;;; <@62,#49> add-i)
0x9c023aa5cae  position  (6606)
0x9c023aa5cb6  comment  (;;; <@63,#49> gap)
0x9c023aa5cbd  comment  (;;; <@64,#52> sub-i)
0x9c023aa5cbd  position  (6615)
0x9c023aa5cc6  comment  (;;; <@65,#52> gap)
0x9c023aa5cca  comment  (;;; <@66,#55> load-context-slot)
0x9c023aa5cca  position  (6631)
0x9c023aa5cd1  comment  (;;; <@67,#55> gap)
0x9c023aa5cd5  comment  (;;; <@68,#56> check-value)
0x9c023aa5cd7  embedded object  (0x364e0635fca1 <JS Function alloc (SharedFunctionInfo 0xc1217b4f389)>)
0x9c023aa5ce8  comment  (;;; <@70,#59> constant-t)
0x9c023aa5ce8  position  (2106)
0x9c023aa5cea  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aa5cf2  comment  (;;; <@72,#62> load-context-slot)
0x9c023aa5cf2  position  (2205)
0x9c023aa5cf6  comment  (;;; <@74,#581> tagged-to-i)
0x9c023aa5d04  position  (2203)
0x9c023aa5d04  comment  (;;; <@77,#63> compare-numeric-and-branch)
0x9c023aa5d0c  comment  (;;; <@78,#67> -------------------- B2 (unreachable/replaced) --------------------)
0x9c023aa5d0c  comment  (;;; <@82,#78> -------------------- B3 (unreachable/replaced) --------------------)
0x9c023aa5d0c  comment  (;;; <@86,#64> -------------------- B4 (unreachable/replaced) --------------------)
0x9c023aa5d0c  position  (2229)
0x9c023aa5d0c  comment  (;;; <@90,#70> -------------------- B5 --------------------)
0x9c023aa5d0c  comment  (;;; <@92,#59> constant-t)
0x9c023aa5d0c  position  (2106)
0x9c023aa5d0e  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aa5d16  comment  (;;; <@94,#71> load-context-slot)
0x9c023aa5d16  position  (2229)
0x9c023aa5d1a  comment  (;;; <@96,#72> push-argument)
0x9c023aa5d1a  position  (2236)
0x9c023aa5d1c  embedded object  (0x364e06304121 <undefined>)
0x9c023aa5d26  comment  (;;; <@98,#580> smi-tag)
0x9c023aa5d2c  comment  (;;; <@100,#73> push-argument)
0x9c023aa5d2d  comment  (;;; <@102,#59> constant-t)
0x9c023aa5d2d  position  (2106)
0x9c023aa5d2f  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aa5d37  comment  (;;; <@104,#74> call-function)
0x9c023aa5d37  position  (2236)
0x9c023aa5d38  code target (STUB)  (0x9c023a28d20)
0x9c023aa5d3c  comment  (;;; <@106,#75> lazy-bailout)
0x9c023aa5d3c  position  (2258)
0x9c023aa5d3c  comment  (;;; <@110,#81> -------------------- B6 --------------------)
0x9c023aa5d3c  comment  (;;; <@112,#59> constant-t)
0x9c023aa5d3c  position  (2106)
0x9c023aa5d3e  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aa5d46  comment  (;;; <@114,#82> load-context-slot)
0x9c023aa5d46  position  (2258)
0x9c023aa5d4a  comment  (;;; <@116,#582> tagged-to-i)
0x9c023aa5d56  comment  (;;; <@118,#83> sub-i)
0x9c023aa5d56  position  (2271)
0x9c023aa5d5f  comment  (;;; <@120,#583> smi-tag)
0x9c023aa5d65  comment  (;;; <@122,#59> constant-t)
0x9c023aa5d65  position  (2106)
0x9c023aa5d67  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aa5d6f  comment  (;;; <@124,#85> store-context-slot)
0x9c023aa5d6f  position  (2271)
0x9c023aa5d73  comment  (;;; <@126,#59> constant-t)
0x9c023aa5d73  position  (2106)
0x9c023aa5d75  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aa5d7d  comment  (;;; <@128,#87> load-context-slot)
0x9c023aa5d7d  position  (2378)
0x9c023aa5d81  comment  (;;; <@129,#87> gap)
0x9c023aa5d84  comment  (;;; <@130,#586> tagged-to-i)
0x9c023aa5d84  position  (2394)
0x9c023aa5d91  comment  (;;; <@131,#586> gap)
0x9c023aa5d94  comment  (;;; <@132,#90> add-i)
0x9c023aa5d94  position  (2398)
0x9c023aa5d9d  comment  (;;; <@134,#587> smi-tag)
0x9c023aa5da3  comment  (;;; <@136,#59> constant-t)
0x9c023aa5da3  position  (2106)
0x9c023aa5da5  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aa5dad  comment  (;;; <@138,#92> store-context-slot)
0x9c023aa5dad  position  (2398)
0x9c023aa5db1  comment  (;;; <@140,#59> constant-t)
0x9c023aa5db1  position  (2106)
0x9c023aa5db3  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aa5dbb  comment  (;;; <@142,#94> load-context-slot)
0x9c023aa5dbb  position  (2484)
0x9c023aa5dbf  comment  (;;; <@144,#588> tagged-to-i)
0x9c023aa5dcb  comment  (;;; <@145,#588> gap)
0x9c023aa5dd2  comment  (;;; <@146,#97> add-i)
0x9c023aa5ddb  comment  (;;; <@148,#590> smi-tag)
0x9c023aa5de1  comment  (;;; <@150,#59> constant-t)
0x9c023aa5de1  position  (2106)
0x9c023aa5de3  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aa5deb  comment  (;;; <@152,#98> store-context-slot)
0x9c023aa5deb  position  (2484)
0x9c023aa5def  comment  (;;; <@154,#59> constant-t)
0x9c023aa5def  position  (2106)
0x9c023aa5df1  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aa5df9  comment  (;;; <@156,#101> load-named-field)
0x9c023aa5df9  position  (2497)
0x9c023aa5dfd  comment  (;;; <@158,#102> load-context-slot)
0x9c023aa5e04  comment  (;;; <@160,#105> check-non-smi)
0x9c023aa5e04  position  (2513)
0x9c023aa5e0e  comment  (;;; <@162,#106> check-maps)
0x9c023aa5e10  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aa5e22  comment  (;;; <@164,#108> check-maps)
0x9c023aa5e22  comment  (;;; <@166,#110> check-maps)
0x9c023aa5e22  comment  (;;; <@168,#111> load-named-field)
0x9c023aa5e26  comment  (;;; <@170,#112> load-named-field)
0x9c023aa5e2a  comment  (;;; <@172,#113> load-named-field)
0x9c023aa5e2e  comment  (;;; <@174,#114> bounds-check)
0x9c023aa5e37  comment  (;;; <@175,#114> gap)
0x9c023aa5e3a  comment  (;;; <@176,#585> tagged-to-i)
0x9c023aa5e48  comment  (;;; <@178,#115> store-keyed)
0x9c023aa5e4c  comment  (;;; <@180,#118> load-context-slot)
0x9c023aa5e4c  position  (2528)
0x9c023aa5e53  comment  (;;; <@182,#120> check-non-smi)
0x9c023aa5e53  position  (2545)
0x9c023aa5e5c  comment  (;;; <@184,#121> check-maps)
0x9c023aa5e5e  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aa5e70  comment  (;;; <@186,#126> load-named-field)
0x9c023aa5e74  comment  (;;; <@188,#127> load-named-field)
0x9c023aa5e77  comment  (;;; <@190,#128> load-named-field)
0x9c023aa5e7b  comment  (;;; <@192,#129> bounds-check)
0x9c023aa5e83  comment  (;;; <@193,#129> gap)
0x9c023aa5e87  comment  (;;; <@194,#130> store-keyed)
0x9c023aa5e8a  position  (2565)
0x9c023aa5e8a  position  (6637)
0x9c023aa5e8a  comment  (;;; <@198,#136> -------------------- B7 --------------------)
0x9c023aa5e8a  comment  (;;; <@199,#136> gap)
0x9c023aa5e8e  comment  (;;; <@200,#138> load-context-slot)
0x9c023aa5e8e  position  (6659)
0x9c023aa5e95  comment  (;;; <@202,#140> check-non-smi)
0x9c023aa5e95  position  (6664)
0x9c023aa5e9e  comment  (;;; <@204,#141> check-maps)
0x9c023aa5ea0  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aa5eb2  comment  (;;; <@206,#142> load-named-field)
0x9c023aa5eb6  comment  (;;; <@208,#143> load-named-field)
0x9c023aa5eb9  comment  (;;; <@210,#144> load-named-field)
0x9c023aa5ebd  comment  (;;; <@212,#145> bounds-check)
0x9c023aa5ec5  comment  (;;; <@214,#146> load-keyed)
0x9c023aa5ed3  comment  (;;; <@215,#146> gap)
0x9c023aa5edb  comment  (;;; <@216,#154> bounds-check)
0x9c023aa5edb  position  (6685)
0x9c023aa5ee4  comment  (;;; <@218,#155> load-keyed)
0x9c023aa5ef1  comment  (;;; <@219,#155> gap)
0x9c023aa5ef5  comment  (;;; <@220,#163> bounds-check)
0x9c023aa5ef5  position  (6706)
0x9c023aa5efe  comment  (;;; <@222,#164> load-keyed)
0x9c023aa5f0a  comment  (;;; <@224,#166> load-context-slot)
0x9c023aa5f0a  position  (6714)
0x9c023aa5f11  comment  (;;; <@225,#166> gap)
0x9c023aa5f18  comment  (;;; <@226,#169> add-i)
0x9c023aa5f18  position  (6722)
0x9c023aa5f22  comment  (;;; <@228,#172> check-non-smi)
0x9c023aa5f22  position  (6729)
0x9c023aa5f2b  comment  (;;; <@230,#173> check-maps)
0x9c023aa5f2d  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aa5f3f  comment  (;;; <@232,#178> load-named-field)
0x9c023aa5f43  comment  (;;; <@234,#179> load-named-field)
0x9c023aa5f47  comment  (;;; <@236,#180> load-named-field)
0x9c023aa5f4b  comment  (;;; <@238,#181> bounds-check)
0x9c023aa5f54  comment  (;;; <@240,#171> constant-i)
0x9c023aa5f57  comment  (;;; <@242,#182> store-keyed)
0x9c023aa5f5c  comment  (;;; <@244,#207> gap)
0x9c023aa5f5c  position  (6766)
0x9c023aa5f62  position  (6769)
0x9c023aa5f62  comment  (;;; <@246,#208> -------------------- B8 (loop header) --------------------)
0x9c023aa5f62  position  (6772)
0x9c023aa5f62  comment  (;;; <@249,#211> compare-numeric-and-branch)
0x9c023aa5f6b  comment  (;;; <@250,#212> -------------------- B9 (unreachable/replaced) --------------------)
0x9c023aa5f6b  comment  (;;; <@254,#218> -------------------- B10 --------------------)
0x9c023aa5f6b  comment  (;;; <@256,#220> stack-check)
0x9c023aa5f78  comment  (;;; <@257,#220> gap)
0x9c023aa5f7b  comment  (;;; <@258,#224> add-i)
0x9c023aa5f7b  position  (6797)
0x9c023aa5f84  comment  (;;; <@260,#236> bounds-check)
0x9c023aa5f84  position  (6805)
0x9c023aa5f8d  comment  (;;; <@261,#236> gap)
0x9c023aa5f90  comment  (;;; <@262,#171> constant-i)
0x9c023aa5f90  position  (6729)
0x9c023aa5f93  comment  (;;; <@264,#237> store-keyed)
0x9c023aa5f93  position  (6805)
0x9c023aa5f97  comment  (;;; <@266,#240> add-i)
0x9c023aa5f97  position  (6782)
0x9c023aa5f9b  comment  (;;; <@269,#243> goto)
0x9c023aa5f9d  comment  (;;; <@270,#215> -------------------- B11 (unreachable/replaced) --------------------)
0x9c023aa5f9d  position  (6843)
0x9c023aa5f9d  comment  (;;; <@274,#244> -------------------- B12 --------------------)
0x9c023aa5f9d  comment  (;;; <@276,#596> constant-d)
0x9c023aa5f9d  position  (7130)
0x9c023aa5fac  comment  (;;; <@278,#274> gap)
0x9c023aa5fac  position  (6892)
0x9c023aa5fb1  position  (6895)
0x9c023aa5fb1  comment  (;;; <@280,#275> -------------------- B13 (loop header) --------------------)
0x9c023aa5fb1  position  (6897)
0x9c023aa5fb1  comment  (;;; <@283,#278> compare-numeric-and-branch)
0x9c023aa5fba  comment  (;;; <@284,#279> -------------------- B14 (unreachable/replaced) --------------------)
0x9c023aa5fba  comment  (;;; <@288,#285> -------------------- B15 --------------------)
0x9c023aa5fba  comment  (;;; <@290,#287> stack-check)
0x9c023aa5fc7  comment  (;;; <@291,#287> gap)
0x9c023aa5fca  comment  (;;; <@292,#291> add-i)
0x9c023aa5fca  position  (6937)
0x9c023aa5fd2  comment  (;;; <@294,#298> bounds-check)
0x9c023aa5fdb  comment  (;;; <@296,#299> load-keyed)
0x9c023aa5fdf  comment  (;;; <@298,#591> uint32-to-double)
0x9c023aa5fdf  position  (7024)
0x9c023aa5fe4  comment  (;;; <@299,#591> gap)
0x9c023aa5fe8  comment  (;;; <@300,#360> add-i)
0x9c023aa5fe8  position  (7051)
0x9c023aa5ff1  comment  (;;; <@302,#326> gap)
0x9c023aa5ff1  position  (6974)
0x9c023aa5ff9  position  (6977)
0x9c023aa5ff9  comment  (;;; <@304,#327> -------------------- B16 (loop header) --------------------)
0x9c023aa5ff9  position  (6979)
0x9c023aa5ff9  comment  (;;; <@307,#330> compare-numeric-and-branch)
0x9c023aa6003  comment  (;;; <@308,#331> -------------------- B17 (unreachable/replaced) --------------------)
0x9c023aa6003  comment  (;;; <@312,#337> -------------------- B18 --------------------)
0x9c023aa6003  comment  (;;; <@314,#339> stack-check)
0x9c023aa6010  comment  (;;; <@315,#339> gap)
0x9c023aa6013  comment  (;;; <@316,#346> add-i)
0x9c023aa6013  position  (7036)
0x9c023aa601c  comment  (;;; <@318,#353> bounds-check)
0x9c023aa6025  comment  (;;; <@320,#354> load-keyed)
0x9c023aa6029  comment  (;;; <@322,#593> uint32-to-double)
0x9c023aa6029  position  (7032)
0x9c023aa602e  comment  (;;; <@324,#355> mul-d)
0x9c023aa602e  position  (7026)
0x9c023aa6032  comment  (;;; <@325,#355> gap)
0x9c023aa6035  comment  (;;; <@326,#363> add-i)
0x9c023aa6035  position  (7055)
0x9c023aa603e  comment  (;;; <@328,#366> sub-i)
0x9c023aa603e  position  (7059)
0x9c023aa6047  comment  (;;; <@330,#373> bounds-check)
0x9c023aa6050  comment  (;;; <@332,#374> load-keyed)
0x9c023aa6054  comment  (;;; <@334,#594> uint32-to-double)
0x9c023aa6054  position  (7047)
0x9c023aa6059  comment  (;;; <@336,#375> add-d)
0x9c023aa6059  position  (7041)
0x9c023aa605d  comment  (;;; <@338,#592> int32-to-double)
0x9c023aa605d  position  (7066)
0x9c023aa6064  comment  (;;; <@340,#378> add-d)
0x9c023aa6064  position  (7064)
0x9c023aa6068  comment  (;;; <@342,#595> double-to-i)
0x9c023aa6068  position  (7099)
0x9c023aa607d  code target (STUB)  (0x9c023a910a0)
0x9c023aa6087  comment  (;;; <@344,#394> bit-i)
0x9c023aa6087  position  (7102)
0x9c023aa608d  comment  (;;; <@346,#406> store-keyed)
0x9c023aa6091  comment  (;;; <@348,#410> div-d)
0x9c023aa6091  position  (7130)
0x9c023aa6098  comment  (;;; <@350,#597> double-to-i)
0x9c023aa60ad  code target (STUB)  (0x9c023a910a0)
0x9c023aa60b7  comment  (;;; <@352,#417> add-i)
0x9c023aa60b7  position  (6989)
0x9c023aa60bb  comment  (;;; <@355,#420> goto)
0x9c023aa60c0  comment  (;;; <@356,#334> -------------------- B19 (unreachable/replaced) --------------------)
0x9c023aa60c0  position  (7161)
0x9c023aa60c0  comment  (;;; <@360,#421> -------------------- B20 --------------------)
0x9c023aa60c0  comment  (;;; <@361,#421> gap)
0x9c023aa60c3  comment  (;;; <@362,#428> add-i)
0x9c023aa60c3  position  (7173)
0x9c023aa60cc  comment  (;;; <@364,#431> sub-i)
0x9c023aa60cc  position  (7182)
0x9c023aa60d5  comment  (;;; <@366,#443> bounds-check)
0x9c023aa60d5  position  (7189)
0x9c023aa60de  comment  (;;; <@368,#444> store-keyed)
0x9c023aa60e2  comment  (;;; <@370,#447> add-i)
0x9c023aa60e2  position  (6907)
0x9c023aa60e5  comment  (;;; <@373,#450> goto)
0x9c023aa60ea  comment  (;;; <@374,#282> -------------------- B21 (unreachable/replaced) --------------------)
0x9c023aa60ea  position  (7224)
0x9c023aa60ea  comment  (;;; <@378,#451> -------------------- B22 --------------------)
0x9c023aa60ea  comment  (;;; <@379,#451> gap)
0x9c023aa60ee  comment  (;;; <@380,#459> sub-i)
0x9c023aa60ee  position  (7254)
0x9c023aa60f7  comment  (;;; <@382,#462> add-i)
0x9c023aa60f7  position  (7258)
0x9c023aa6100  comment  (;;; <@383,#462> gap)
0x9c023aa6104  comment  (;;; <@384,#491> add-i)
0x9c023aa6104  position  (7282)
0x9c023aa610d  comment  (;;; <@386,#486> gap)
0x9c023aa610d  position  (7267)
0x9c023aa610f  position  (7275)
0x9c023aa610f  comment  (;;; <@388,#487> -------------------- B23 (loop header) --------------------)
0x9c023aa610f  position  (7277)
0x9c023aa610f  comment  (;;; <@391,#493> compare-numeric-and-branch)
0x9c023aa6117  comment  (;;; <@392,#494> -------------------- B24 (unreachable/replaced) --------------------)
0x9c023aa6117  position  (7289)
0x9c023aa6117  comment  (;;; <@396,#500> -------------------- B25 --------------------)
0x9c023aa6117  comment  (;;; <@398,#508> bounds-check)
0x9c023aa6117  position  (7294)
0x9c023aa6120  comment  (;;; <@400,#509> load-keyed)
0x9c023aa612c  position  (7297)
0x9c023aa612c  comment  (;;; <@403,#511> compare-numeric-and-branch)
0x9c023aa6135  comment  (;;; <@404,#512> -------------------- B26 (unreachable/replaced) --------------------)
0x9c023aa6135  comment  (;;; <@408,#518> -------------------- B27 --------------------)
0x9c023aa6135  comment  (;;; <@410,#520> stack-check)
0x9c023aa6142  comment  (;;; <@412,#523> add-i)
0x9c023aa6142  position  (7312)
0x9c023aa6145  comment  (;;; <@413,#523> gap)
0x9c023aa6148  comment  (;;; <@414,#526> add-i)
0x9c023aa6148  position  (7322)
0x9c023aa6151  comment  (;;; <@416,#529> gap)
0x9c023aa6157  comment  (;;; <@417,#529> goto)
0x9c023aa6159  comment  (;;; <@418,#515> -------------------- B28 (unreachable/replaced) --------------------)
0x9c023aa6159  comment  (;;; <@422,#497> -------------------- B29 (unreachable/replaced) --------------------)
0x9c023aa6159  position  (7364)
0x9c023aa6159  comment  (;;; <@426,#530> -------------------- B30 --------------------)
0x9c023aa6159  comment  (;;; <@427,#530> gap)
0x9c023aa615d  comment  (;;; <@428,#536> sub-i)
0x9c023aa615d  position  (7380)
0x9c023aa6165  comment  (;;; <@430,#539> sub-i)
0x9c023aa6165  position  (7398)
0x9c023aa6168  position  (7411)
0x9c023aa6168  comment  (;;; <@433,#543> branch)
0x9c023aa6170  comment  (;;; <@434,#547> -------------------- B31 (unreachable/replaced) --------------------)
0x9c023aa6170  comment  (;;; <@438,#568> -------------------- B32 (unreachable/replaced) --------------------)
0x9c023aa6170  comment  (;;; <@442,#544> -------------------- B33 (unreachable/replaced) --------------------)
0x9c023aa6170  position  (7429)
0x9c023aa6170  comment  (;;; <@446,#550> -------------------- B34 --------------------)
0x9c023aa6170  comment  (;;; <@447,#550> gap)
0x9c023aa6174  comment  (;;; <@448,#563> bounds-check)
0x9c023aa6174  position  (7440)
0x9c023aa617d  comment  (;;; <@450,#564> store-keyed)
0x9c023aa6181  position  (7459)
0x9c023aa6181  comment  (;;; <@454,#571> -------------------- B35 --------------------)
0x9c023aa6181  comment  (;;; <@455,#571> gap)
0x9c023aa6185  comment  (;;; <@456,#589> smi-tag)
0x9c023aa618b  comment  (;;; <@457,#589> gap)
0x9c023aa618e  comment  (;;; <@458,#574> return)
0x9c023aa6195  position  (6489)
0x9c023aa6195  comment  (;;; <@32,#577> -------------------- Deferred tagged-to-i --------------------)
0x9c023aa61b6  comment  (Deferred TaggedToI: lost precision)
0x9c023aa61b8  comment  (Deferred TaggedToI: NaN)
0x9c023aa61c0  runtime entry  (deoptimization bailout 63)
0x9c023aa61c9  position  (6520)
0x9c023aa61c9  comment  (;;; <@52,#579> -------------------- Deferred tagged-to-i --------------------)
0x9c023aa61ea  comment  (Deferred TaggedToI: lost precision)
0x9c023aa61ec  comment  (Deferred TaggedToI: NaN)
0x9c023aa61f4  runtime entry  (deoptimization bailout 64)
0x9c023aa61fd  position  (2205)
0x9c023aa61fd  comment  (;;; <@74,#581> -------------------- Deferred tagged-to-i --------------------)
0x9c023aa621b  comment  (Deferred TaggedToI: lost precision)
0x9c023aa621d  comment  (Deferred TaggedToI: NaN)
0x9c023aa6225  runtime entry  (deoptimization bailout 65)
0x9c023aa622e  position  (2258)
0x9c023aa622e  comment  (;;; <@116,#582> -------------------- Deferred tagged-to-i --------------------)
0x9c023aa624c  comment  (Deferred TaggedToI: lost precision)
0x9c023aa624e  comment  (Deferred TaggedToI: NaN)
0x9c023aa6263  runtime entry  (deoptimization bailout 66)
0x9c023aa626c  position  (2394)
0x9c023aa626c  comment  (;;; <@130,#586> -------------------- Deferred tagged-to-i --------------------)
0x9c023aa628a  comment  (Deferred TaggedToI: lost precision)
0x9c023aa628c  comment  (Deferred TaggedToI: NaN)
0x9c023aa6294  runtime entry  (deoptimization bailout 67)
0x9c023aa629d  position  (2484)
0x9c023aa629d  comment  (;;; <@144,#588> -------------------- Deferred tagged-to-i --------------------)
0x9c023aa62bb  comment  (Deferred TaggedToI: lost precision)
0x9c023aa62bd  comment  (Deferred TaggedToI: NaN)
0x9c023aa62d2  runtime entry  (deoptimization bailout 68)
0x9c023aa62db  position  (2513)
0x9c023aa62db  comment  (;;; <@176,#585> -------------------- Deferred tagged-to-i --------------------)
0x9c023aa6300  code target (STUB)  (0x9c023a44740)
0x9c023aa6333  comment  (Deferred TaggedToI: cannot truncate)
0x9c023aa6346  position  (6772)
0x9c023aa6346  comment  (;;; <@256,#220> -------------------- Deferred stack-check --------------------)
0x9c023aa6369  code target (STUB)  (0x9c023a061c0)
0x9c023aa6387  position  (6897)
0x9c023aa6387  comment  (;;; <@290,#287> -------------------- Deferred stack-check --------------------)
0x9c023aa63aa  code target (STUB)  (0x9c023a061c0)
0x9c023aa63c8  position  (6979)
0x9c023aa63c8  comment  (;;; <@314,#339> -------------------- Deferred stack-check --------------------)
0x9c023aa63eb  code target (STUB)  (0x9c023a061c0)
0x9c023aa6409  position  (7297)
0x9c023aa6409  comment  (;;; <@410,#520> -------------------- Deferred stack-check --------------------)
0x9c023aa642c  code target (STUB)  (0x9c023a061c0)
0x9c023aa644a  comment  (;;; -------------------- Jump table --------------------)
0x9c023aa644a  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x9c023aa644b  runtime entry  (deoptimization bailout 1)
0x9c023aa644f  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x9c023aa6450  runtime entry  (deoptimization bailout 2)
0x9c023aa6454  comment  (;;; jump table entry 2: deoptimization bailout 3.)
0x9c023aa6455  runtime entry  (deoptimization bailout 3)
0x9c023aa6459  comment  (;;; jump table entry 3: deoptimization bailout 4.)
0x9c023aa645a  runtime entry  (deoptimization bailout 4)
0x9c023aa645e  comment  (;;; jump table entry 4: deoptimization bailout 5.)
0x9c023aa645f  runtime entry  (deoptimization bailout 5)
0x9c023aa6463  comment  (;;; jump table entry 5: deoptimization bailout 6.)
0x9c023aa6464  runtime entry  (deoptimization bailout 6)
0x9c023aa6468  comment  (;;; jump table entry 6: deoptimization bailout 7.)
0x9c023aa6469  runtime entry  (deoptimization bailout 7)
0x9c023aa646d  comment  (;;; jump table entry 7: deoptimization bailout 8.)
0x9c023aa646e  runtime entry  (deoptimization bailout 8)
0x9c023aa6472  comment  (;;; jump table entry 8: deoptimization bailout 9.)
0x9c023aa6473  runtime entry  (deoptimization bailout 9)
0x9c023aa6477  comment  (;;; jump table entry 9: deoptimization bailout 10.)
0x9c023aa6478  runtime entry  (deoptimization bailout 10)
0x9c023aa647c  comment  (;;; jump table entry 10: deoptimization bailout 11.)
0x9c023aa647d  runtime entry  (deoptimization bailout 11)
0x9c023aa6481  comment  (;;; jump table entry 11: deoptimization bailout 12.)
0x9c023aa6482  runtime entry  (deoptimization bailout 12)
0x9c023aa6486  comment  (;;; jump table entry 12: deoptimization bailout 13.)
0x9c023aa6487  runtime entry  (deoptimization bailout 13)
0x9c023aa648b  comment  (;;; jump table entry 13: deoptimization bailout 14.)
0x9c023aa648c  runtime entry  (deoptimization bailout 14)
0x9c023aa6490  comment  (;;; jump table entry 14: deoptimization bailout 15.)
0x9c023aa6491  runtime entry  (deoptimization bailout 15)
0x9c023aa6495  comment  (;;; jump table entry 15: deoptimization bailout 17.)
0x9c023aa6496  runtime entry  (deoptimization bailout 17)
0x9c023aa649a  comment  (;;; jump table entry 16: deoptimization bailout 18.)
0x9c023aa649b  runtime entry  (deoptimization bailout 18)
0x9c023aa649f  comment  (;;; jump table entry 17: deoptimization bailout 19.)
0x9c023aa64a0  runtime entry  (deoptimization bailout 19)
0x9c023aa64a4  comment  (;;; jump table entry 18: deoptimization bailout 20.)
0x9c023aa64a5  runtime entry  (deoptimization bailout 20)
0x9c023aa64a9  comment  (;;; jump table entry 19: deoptimization bailout 21.)
0x9c023aa64aa  runtime entry  (deoptimization bailout 21)
0x9c023aa64ae  comment  (;;; jump table entry 20: deoptimization bailout 22.)
0x9c023aa64af  runtime entry  (deoptimization bailout 22)
0x9c023aa64b3  comment  (;;; jump table entry 21: deoptimization bailout 23.)
0x9c023aa64b4  runtime entry  (deoptimization bailout 23)
0x9c023aa64b8  comment  (;;; jump table entry 22: deoptimization bailout 24.)
0x9c023aa64b9  runtime entry  (deoptimization bailout 24)
0x9c023aa64bd  comment  (;;; jump table entry 23: deoptimization bailout 25.)
0x9c023aa64be  runtime entry  (deoptimization bailout 25)
0x9c023aa64c2  comment  (;;; jump table entry 24: deoptimization bailout 26.)
0x9c023aa64c3  runtime entry  (deoptimization bailout 26)
0x9c023aa64c7  comment  (;;; jump table entry 25: deoptimization bailout 27.)
0x9c023aa64c8  runtime entry  (deoptimization bailout 27)
0x9c023aa64cc  comment  (;;; jump table entry 26: deoptimization bailout 28.)
0x9c023aa64cd  runtime entry  (deoptimization bailout 28)
0x9c023aa64d1  comment  (;;; jump table entry 27: deoptimization bailout 29.)
0x9c023aa64d2  runtime entry  (deoptimization bailout 29)
0x9c023aa64d6  comment  (;;; jump table entry 28: deoptimization bailout 30.)
0x9c023aa64d7  runtime entry  (deoptimization bailout 30)
0x9c023aa64db  comment  (;;; jump table entry 29: deoptimization bailout 31.)
0x9c023aa64dc  runtime entry  (deoptimization bailout 31)
0x9c023aa64e0  comment  (;;; jump table entry 30: deoptimization bailout 32.)
0x9c023aa64e1  runtime entry  (deoptimization bailout 32)
0x9c023aa64e5  comment  (;;; jump table entry 31: deoptimization bailout 33.)
0x9c023aa64e6  runtime entry  (deoptimization bailout 33)
0x9c023aa64ea  comment  (;;; jump table entry 32: deoptimization bailout 34.)
0x9c023aa64eb  runtime entry  (deoptimization bailout 34)
0x9c023aa64ef  comment  (;;; jump table entry 33: deoptimization bailout 35.)
0x9c023aa64f0  runtime entry  (deoptimization bailout 35)
0x9c023aa64f4  comment  (;;; jump table entry 34: deoptimization bailout 36.)
0x9c023aa64f5  runtime entry  (deoptimization bailout 36)
0x9c023aa64f9  comment  (;;; jump table entry 35: deoptimization bailout 37.)
0x9c023aa64fa  runtime entry  (deoptimization bailout 37)
0x9c023aa64fe  comment  (;;; jump table entry 36: deoptimization bailout 39.)
0x9c023aa64ff  runtime entry  (deoptimization bailout 39)
0x9c023aa6503  comment  (;;; jump table entry 37: deoptimization bailout 40.)
0x9c023aa6504  runtime entry  (deoptimization bailout 40)
0x9c023aa6508  comment  (;;; jump table entry 38: deoptimization bailout 42.)
0x9c023aa6509  runtime entry  (deoptimization bailout 42)
0x9c023aa650d  comment  (;;; jump table entry 39: deoptimization bailout 43.)
0x9c023aa650e  runtime entry  (deoptimization bailout 43)
0x9c023aa6512  comment  (;;; jump table entry 40: deoptimization bailout 44.)
0x9c023aa6513  runtime entry  (deoptimization bailout 44)
0x9c023aa6517  comment  (;;; jump table entry 41: deoptimization bailout 46.)
0x9c023aa6518  runtime entry  (deoptimization bailout 46)
0x9c023aa651c  comment  (;;; jump table entry 42: deoptimization bailout 47.)
0x9c023aa651d  runtime entry  (deoptimization bailout 47)
0x9c023aa6521  comment  (;;; jump table entry 43: deoptimization bailout 48.)
0x9c023aa6522  runtime entry  (deoptimization bailout 48)
0x9c023aa6526  comment  (;;; jump table entry 44: deoptimization bailout 49.)
0x9c023aa6527  runtime entry  (deoptimization bailout 49)
0x9c023aa652b  comment  (;;; jump table entry 45: deoptimization bailout 50.)
0x9c023aa652c  runtime entry  (deoptimization bailout 50)
0x9c023aa6530  comment  (;;; jump table entry 46: deoptimization bailout 51.)
0x9c023aa6531  runtime entry  (deoptimization bailout 51)
0x9c023aa6535  comment  (;;; jump table entry 47: deoptimization bailout 52.)
0x9c023aa6536  runtime entry  (deoptimization bailout 52)
0x9c023aa653a  comment  (;;; jump table entry 48: deoptimization bailout 53.)
0x9c023aa653b  runtime entry  (deoptimization bailout 53)
0x9c023aa653f  comment  (;;; jump table entry 49: deoptimization bailout 54.)
0x9c023aa6540  runtime entry  (deoptimization bailout 54)
0x9c023aa6544  comment  (;;; jump table entry 50: deoptimization bailout 55.)
0x9c023aa6545  runtime entry  (deoptimization bailout 55)
0x9c023aa6549  comment  (;;; jump table entry 51: deoptimization bailout 56.)
0x9c023aa654a  runtime entry  (deoptimization bailout 56)
0x9c023aa654e  comment  (;;; jump table entry 52: deoptimization bailout 57.)
0x9c023aa654f  runtime entry  (deoptimization bailout 57)
0x9c023aa6553  comment  (;;; jump table entry 53: deoptimization bailout 58.)
0x9c023aa6554  runtime entry  (deoptimization bailout 58)
0x9c023aa6558  comment  (;;; jump table entry 54: deoptimization bailout 60.)
0x9c023aa6559  runtime entry  (deoptimization bailout 60)
0x9c023aa655d  comment  (;;; jump table entry 55: deoptimization bailout 61.)
0x9c023aa655e  runtime entry  (deoptimization bailout 61)
0x9c023aa6562  comment  (;;; jump table entry 56: deoptimization bailout 62.)
0x9c023aa6563  runtime entry  (deoptimization bailout 62)
0x9c023aa6567  comment  (;;; jump table entry 57: deoptimization bailout 69.)
0x9c023aa6568  runtime entry  (deoptimization bailout 69)
0x9c023aa656c  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (alloc) id{1,0} ---
(length){
      // there is no check for it but length has to be larger than 0
      if ( length > unallocated ) {
        extend(length)
      }
      unallocated -= length
      // save data index to data_idx and advance the break point with length
      var data_idx = brk
      brk = brk + length
      // save data_idx in address space and advance next
      var pointer = next++
      adrs[pointer] = data_idx
      heap[data_idx] = length
      return pointer
    }

--- END ---
--- Raw source ---
(length){
      // there is no check for it but length has to be larger than 0
      if ( length > unallocated ) {
        extend(length)
      }
      unallocated -= length
      // save data index to data_idx and advance the break point with length
      var data_idx = brk
      brk = brk + length
      // save data_idx in address space and advance next
      var pointer = next++
      adrs[pointer] = data_idx
      heap[data_idx] = length
      return pointer
    }


--- Optimized code ---
optimization_id = 1
source_position = 2106
kind = OPTIMIZED_FUNCTION
name = alloc
stack_slots = 2
Instructions (size = 822)
0x9c023aadbc0     0  55             push rbp
0x9c023aadbc1     1  4889e5         REX.W movq rbp,rsp
0x9c023aadbc4     4  56             push rsi
0x9c023aadbc5     5  57             push rdi
0x9c023aadbc6     6  4883ec10       REX.W subq rsp,0x10
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x9c023aadbca    10  488b45f8       REX.W movq rax,[rbp-0x8]    ;; debug: position 2106
                  ;;; <@3,#1> gap
0x9c023aadbce    14  488945e8       REX.W movq [rbp-0x18],rax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x9c023aadbd2    18  488bf0         REX.W movq rsi,rax
                  ;;; <@12,#10> stack-check
0x9c023aadbd5    21  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023aadbdc    28  7305           jnc 35  (0x9c023aadbe3)
0x9c023aadbde    30  e87d82f7ff     call StackCheck  (0x9c023a25e60)    ;; code: BUILTIN
                  ;;; <@14,#10> lazy-bailout
                  ;;; <@15,#10> gap
0x9c023aadbe3    35  488b45e8       REX.W movq rax,[rbp-0x18]
                  ;;; <@16,#12> load-context-slot
0x9c023aadbe7    39  488b5837       REX.W movq rbx,[rax+0x37]    ;; debug: position 2205
                  ;;; <@17,#12> gap
0x9c023aadbeb    43  488b5510       REX.W movq rdx,[rbp+0x10]
                  ;;; <@18,#89> check-smi
0x9c023aadbef    47  f6c201         testb rdx,0x1            ;; debug: position 2196
0x9c023aadbf2    50  0f8592020000   jnz 714  (0x9c023aade8a)
                  ;;; <@19,#89> gap
0x9c023aadbf8    56  488955e0       REX.W movq [rbp-0x20],rdx
                  ;;; <@20,#90> check-smi
0x9c023aadbfc    60  f6c301         testb rbx,0x1            ;; debug: position 2205
0x9c023aadbff    63  0f858a020000   jnz 719  (0x9c023aade8f)
                  ;;; <@23,#13> compare-numeric-and-branch
0x9c023aadc05    69  483bd3         REX.W cmpq rdx,rbx       ;; debug: position 2203
0x9c023aadc08    72  0f8e1d000000   jle 107  (0x9c023aadc2b)
                  ;;; <@24,#17> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@28,#28> -------------------- B3 (unreachable/replaced) --------------------
                  ;;; <@32,#14> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@36,#20> -------------------- B5 --------------------
                  ;;; <@38,#21> load-context-slot
0x9c023aadc0e    78  488b784f       REX.W movq rdi,[rax+0x4f]    ;; debug: position 2229
                  ;;; <@40,#22> push-argument
0x9c023aadc12    82  49ba214130064e360000 REX.W movq r10,0x364e06304121    ;; debug: position 2236
                                                             ;; object: 0x364e06304121 <undefined>
0x9c023aadc1c    92  4152           push r10
                  ;;; <@41,#22> gap
0x9c023aadc1e    94  488b5d10       REX.W movq rbx,[rbp+0x10]
                  ;;; <@42,#23> push-argument
0x9c023aadc22    98  53             push rbx
                  ;;; <@43,#23> gap
0x9c023aadc23    99  488bf0         REX.W movq rsi,rax
                  ;;; <@44,#24> call-function
0x9c023aadc26   102  e8f5b0f7ff     call 0x9c023a28d20       ;; code: STUB, CallFunctionStub, argc = 1
                  ;;; <@46,#25> lazy-bailout
                  ;;; <@50,#31> -------------------- B6 --------------------
                  ;;; <@51,#31> gap
0x9c023aadc2b   107  488b45e8       REX.W movq rax,[rbp-0x18]    ;; debug: position 2258
                  ;;; <@52,#32> load-context-slot
0x9c023aadc2f   111  488b5837       REX.W movq rbx,[rax+0x37]
                  ;;; <@54,#91> check-smi
0x9c023aadc33   115  f6c301         testb rbx,0x1
0x9c023aadc36   118  0f8558020000   jnz 724  (0x9c023aade94)
                  ;;; <@56,#33> sub-i
0x9c023aadc3c   124  482b5de0       REX.W subq rbx,[rbp-0x20]    ;; debug: position 2271
0x9c023aadc40   128  0f8053020000   jo 729  (0x9c023aade99)
                  ;;; <@57,#33> gap
0x9c023aadc46   134  488bd3         REX.W movq rdx,rbx
                  ;;; <@58,#92> dummy-use
                  ;;; <@60,#35> store-context-slot
0x9c023aadc49   137  48895037       REX.W movq [rax+0x37],rdx
                  ;;; <@62,#37> load-context-slot
0x9c023aadc4d   141  488b503f       REX.W movq rdx,[rax+0x3f]    ;; debug: position 2378
                  ;;; <@63,#37> gap
0x9c023aadc51   145  488bca         REX.W movq rcx,rdx
                  ;;; <@64,#95> check-smi
0x9c023aadc54   148  f6c101         testb rcx,0x1            ;; debug: position 2394
0x9c023aadc57   151  0f8541020000   jnz 734  (0x9c023aade9e)
                  ;;; <@65,#95> gap
0x9c023aadc5d   157  488b75e0       REX.W movq rsi,[rbp-0x20]
                  ;;; <@66,#40> add-i
0x9c023aadc61   161  4803ce         REX.W addq rcx,rsi       ;; debug: position 2398
0x9c023aadc64   164  0f8039020000   jo 739  (0x9c023aadea3)
                  ;;; <@67,#40> gap
0x9c023aadc6a   170  488bd9         REX.W movq rbx,rcx
                  ;;; <@68,#96> dummy-use
                  ;;; <@70,#42> store-context-slot
0x9c023aadc6d   173  4889583f       REX.W movq [rax+0x3f],rbx
                  ;;; <@72,#44> load-context-slot
0x9c023aadc71   177  488b5847       REX.W movq rbx,[rax+0x47]    ;; debug: position 2484
                  ;;; <@74,#97> tagged-to-i
0x9c023aadc75   181  f6c301         testb rbx,0x1
0x9c023aadc78   184  0f85d1000000   jnz 399  (0x9c023aadd4f)
0x9c023aadc7e   190  48c1eb20       REX.W shrq rbx,32
                  ;;; <@75,#97> gap
0x9c023aadc82   194  488bf3         REX.W movq rsi,rbx
                  ;;; <@76,#47> add-i
0x9c023aadc85   197  83c601         addl rsi,0x1
0x9c023aadc88   200  0f801a020000   jo 744  (0x9c023aadea8)
                  ;;; <@78,#99> smi-tag
0x9c023aadc8e   206  8bce           movl rcx,rsi
0x9c023aadc90   208  48c1e120       REX.W shlq rcx,32
                  ;;; <@80,#48> store-context-slot
0x9c023aadc94   212  48894847       REX.W movq [rax+0x47],rcx
                  ;;; <@82,#51> load-named-field
0x9c023aadc98   216  488b4017       REX.W movq rax,[rax+0x17]    ;; debug: position 2497
                  ;;; <@84,#52> load-context-slot
0x9c023aadc9c   220  488b889f000000 REX.W movq rcx,[rax+0x9f]
                  ;;; <@86,#55> check-non-smi
0x9c023aadca3   227  f6c101         testb rcx,0x1            ;; debug: position 2513
0x9c023aadca6   230  0f8401020000   jz 749  (0x9c023aadead)
                  ;;; <@88,#56> check-maps
0x9c023aadcac   236  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aadcb6   246  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023aadcba   250  0f85f2010000   jnz 754  (0x9c023aadeb2)
                  ;;; <@90,#58> check-maps
                  ;;; <@92,#60> check-maps
                  ;;; <@94,#61> load-named-field
0x9c023aadcc0   256  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@96,#62> load-named-field
0x9c023aadcc4   260  8b790b         movl rdi,[rcx+0xb]
                  ;;; <@98,#63> load-named-field
0x9c023aadcc7   263  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@100,#64> bounds-check
0x9c023aadccb   267  3bfb           cmpl rdi,rbx
0x9c023aadccd   269  0f86e4010000   jna 759  (0x9c023aadeb7)
                  ;;; <@101,#64> gap
0x9c023aadcd3   275  488bfa         REX.W movq rdi,rdx
                  ;;; <@102,#94> tagged-to-i
0x9c023aadcd6   278  40f6c701       testb rdi,0x1
0x9c023aadcda   282  0f85ad000000   jnz 461  (0x9c023aadd8d)
0x9c023aadce0   288  48c1ef20       REX.W shrq rdi,32
                  ;;; <@104,#65> store-keyed
0x9c023aadce4   292  893c99         movl [rcx+rbx*4],rdi
                  ;;; <@106,#68> load-context-slot
0x9c023aadce7   295  488b8097000000 REX.W movq rax,[rax+0x97]    ;; debug: position 2528
                  ;;; <@108,#70> check-non-smi
0x9c023aadcee   302  a801           test al,0x1              ;; debug: position 2545
0x9c023aadcf0   304  0f84c6010000   jz 764  (0x9c023aadebc)
                  ;;; <@110,#71> check-maps
0x9c023aadcf6   310  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aadd00   320  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023aadd04   324  0f85b7010000   jnz 769  (0x9c023aadec1)
                  ;;; <@112,#76> load-named-field
0x9c023aadd0a   330  488b400f       REX.W movq rax,[rax+0xf]
                  ;;; <@114,#77> load-named-field
0x9c023aadd0e   334  8b480b         movl rcx,[rax+0xb]
                  ;;; <@116,#78> load-named-field
0x9c023aadd11   337  488b400f       REX.W movq rax,[rax+0xf]
                  ;;; <@117,#78> gap
0x9c023aadd15   341  488bf2         REX.W movq rsi,rdx
                  ;;; <@118,#93> tagged-to-i
0x9c023aadd18   344  40f6c601       testb rsi,0x1
0x9c023aadd1c   348  0f85d1000000   jnz 563  (0x9c023aaddf3)
0x9c023aadd22   354  48c1ee20       REX.W shrq rsi,32
                  ;;; <@120,#79> bounds-check
0x9c023aadd26   358  3bce           cmpl rcx,rsi
0x9c023aadd28   360  0f8698010000   jna 774  (0x9c023aadec6)
                  ;;; <@121,#79> gap
0x9c023aadd2e   366  488b4d10       REX.W movq rcx,[rbp+0x10]
                  ;;; <@122,#86> tagged-to-i
0x9c023aadd32   370  f6c101         testb rcx,0x1
0x9c023aadd35   373  0f85e9000000   jnz 612  (0x9c023aade24)
0x9c023aadd3b   379  48c1e920       REX.W shrq rcx,32
                  ;;; <@124,#80> store-keyed
0x9c023aadd3f   383  890cb0         movl [rax+rsi*4],rcx
                  ;;; <@126,#98> smi-tag
0x9c023aadd42   386  8bc3           movl rax,rbx             ;; debug: position 2565
0x9c023aadd44   388  48c1e020       REX.W shlq rax,32
                  ;;; <@128,#84> return
0x9c023aadd48   392  488be5         REX.W movq rsp,rbp
0x9c023aadd4b   395  5d             pop rbp
0x9c023aadd4c   396  c21000         ret 0x10
                  ;;; <@74,#97> -------------------- Deferred tagged-to-i --------------------
0x9c023aadd4f   399  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2484
0x9c023aadd53   403  4c3953ff       REX.W cmpq [rbx-0x1],r10
0x9c023aadd57   407  752a           jnz 451  (0x9c023aadd83)
0x9c023aadd59   409  f20f104307     movsd xmm0,[rbx+0x7]
0x9c023aadd5e   414  f20f2cd8       cvttsd2sil rbx,xmm0
0x9c023aadd62   418  0f57c9         xorps xmm1,xmm1
0x9c023aadd65   421  f20f2acb       cvtsi2sd xmm1,rbx
0x9c023aadd69   425  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023aadd6d   429  7514           jnz 451  (0x9c023aadd83)
                  Deferred TaggedToI: NaN
0x9c023aadd6f   431  7a12           jpe 451  (0x9c023aadd83)
0x9c023aadd71   433  85db           testl rbx,rbx
0x9c023aadd73   435  7509           jnz 446  (0x9c023aadd7e)
0x9c023aadd75   437  660f50d8       movmskpd rbx,xmm0
0x9c023aadd79   441  83e301         andl rbx,0x1
0x9c023aadd7c   444  7505           jnz 451  (0x9c023aadd83)
0x9c023aadd7e   446  e9fffeffff     jmp 194  (0x9c023aadc82)
0x9c023aadd83   451  e80e83c5ff     call 0x9c023706096       ;; deoptimization bailout 15
0x9c023aadd88   456  e9f5feffff     jmp 194  (0x9c023aadc82)
                  ;;; <@102,#94> -------------------- Deferred tagged-to-i --------------------
0x9c023aadd8d   461  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2513
0x9c023aadd91   465  4c3957ff       REX.W cmpq [rdi-0x1],r10
0x9c023aadd95   469  7529           jnz 512  (0x9c023aaddc0)
0x9c023aadd97   471  f20f104707     movsd xmm0,[rdi+0x7]
0x9c023aadd9c   476  f2480f2cf8     REX.W cvttsd2siq rdi,xmm0
0x9c023aadda1   481  4883ff01       REX.W cmpq rdi,0x1
0x9c023aadda5   485  7112           jno 505  (0x9c023aaddb9)
0x9c023aadda7   487  4883ec08       REX.W subq rsp,0x8
0x9c023aaddab   491  f20f110424     movsd [rsp],xmm0
0x9c023aaddb0   496  e8ab97fbff     call 0x9c023a67560       ;; code: STUB, DoubleToIStub, minor: 266692
0x9c023aaddb5   501  4883c408       REX.W addq rsp,0x8
0x9c023aaddb9   505  8bff           movl rdi,rdi
0x9c023aaddbb   507  e924ffffff     jmp 292  (0x9c023aadce4)
0x9c023aaddc0   512  493b7da8       REX.W cmpq rdi,[r13-0x58]
0x9c023aaddc4   516  7507           jnz 525  (0x9c023aaddcd)
0x9c023aaddc6   518  33ff           xorl rdi,rdi
0x9c023aaddc8   520  e917ffffff     jmp 292  (0x9c023aadce4)
0x9c023aaddcd   525  493b7dc0       REX.W cmpq rdi,[r13-0x40]
0x9c023aaddd1   529  750a           jnz 541  (0x9c023aadddd)
0x9c023aaddd3   531  bf01000000     movl rdi,0x1
0x9c023aaddd8   536  e907ffffff     jmp 292  (0x9c023aadce4)
0x9c023aadddd   541  493b7dc8       REX.W cmpq rdi,[r13-0x38]
                  Deferred TaggedToI: cannot truncate
0x9c023aadde1   545  0f85e4000000   jnz 779  (0x9c023aadecb)
0x9c023aadde7   551  33ff           xorl rdi,rdi
0x9c023aadde9   553  e9f6feffff     jmp 292  (0x9c023aadce4)
0x9c023aaddee   558  e9f1feffff     jmp 292  (0x9c023aadce4)
                  ;;; <@118,#93> -------------------- Deferred tagged-to-i --------------------
0x9c023aaddf3   563  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2545
0x9c023aaddf7   567  4c3956ff       REX.W cmpq [rsi-0x1],r10
0x9c023aaddfb   571  751d           jnz 602  (0x9c023aade1a)
0x9c023aaddfd   573  f20f104607     movsd xmm0,[rsi+0x7]
0x9c023aade02   578  f20f2cf0       cvttsd2sil rsi,xmm0
0x9c023aade06   582  0f57c9         xorps xmm1,xmm1
0x9c023aade09   585  f20f2ace       cvtsi2sd xmm1,rsi
0x9c023aade0d   589  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023aade11   593  7507           jnz 602  (0x9c023aade1a)
                  Deferred TaggedToI: NaN
0x9c023aade13   595  7a05           jpe 602  (0x9c023aade1a)
0x9c023aade15   597  e90cffffff     jmp 358  (0x9c023aadd26)
0x9c023aade1a   602  e88b82c5ff     call 0x9c0237060aa       ;; deoptimization bailout 17
0x9c023aade1f   607  e902ffffff     jmp 358  (0x9c023aadd26)
                  ;;; <@122,#86> -------------------- Deferred tagged-to-i --------------------
0x9c023aade24   612  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023aade28   616  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023aade2c   620  7529           jnz 663  (0x9c023aade57)
0x9c023aade2e   622  f20f104107     movsd xmm0,[rcx+0x7]
0x9c023aade33   627  f2480f2cc8     REX.W cvttsd2siq rcx,xmm0
0x9c023aade38   632  4883f901       REX.W cmpq rcx,0x1
0x9c023aade3c   636  7112           jno 656  (0x9c023aade50)
0x9c023aade3e   638  4883ec08       REX.W subq rsp,0x8
0x9c023aade42   642  f20f110424     movsd [rsp],xmm0
0x9c023aade47   647  e83412f6ff     call 0x9c023a0f080       ;; code: STUB, DoubleToIStub, minor: 266308
0x9c023aade4c   652  4883c408       REX.W addq rsp,0x8
0x9c023aade50   656  8bc9           movl rcx,rcx
0x9c023aade52   658  e9e8feffff     jmp 383  (0x9c023aadd3f)
0x9c023aade57   663  493b4da8       REX.W cmpq rcx,[r13-0x58]
0x9c023aade5b   667  7507           jnz 676  (0x9c023aade64)
0x9c023aade5d   669  33c9           xorl rcx,rcx
0x9c023aade5f   671  e9dbfeffff     jmp 383  (0x9c023aadd3f)
0x9c023aade64   676  493b4dc0       REX.W cmpq rcx,[r13-0x40]
0x9c023aade68   680  750a           jnz 692  (0x9c023aade74)
0x9c023aade6a   682  b901000000     movl rcx,0x1
0x9c023aade6f   687  e9cbfeffff     jmp 383  (0x9c023aadd3f)
0x9c023aade74   692  493b4dc8       REX.W cmpq rcx,[r13-0x38]
                  Deferred TaggedToI: cannot truncate
0x9c023aade78   696  0f8552000000   jnz 784  (0x9c023aaded0)
0x9c023aade7e   702  33c9           xorl rcx,rcx
0x9c023aade80   704  e9bafeffff     jmp 383  (0x9c023aadd3f)
0x9c023aade85   709  e9b5feffff     jmp 383  (0x9c023aadd3f)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x9c023aade8a   714  e87b81c5ff     call 0x9c02370600a       ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x9c023aade8f   719  e88081c5ff     call 0x9c023706014       ;; deoptimization bailout 2
                  ;;; jump table entry 2: deoptimization bailout 4.
0x9c023aade94   724  e88f81c5ff     call 0x9c023706028       ;; deoptimization bailout 4
                  ;;; jump table entry 3: deoptimization bailout 5.
0x9c023aade99   729  e89481c5ff     call 0x9c023706032       ;; deoptimization bailout 5
                  ;;; jump table entry 4: deoptimization bailout 6.
0x9c023aade9e   734  e89981c5ff     call 0x9c02370603c       ;; deoptimization bailout 6
                  ;;; jump table entry 5: deoptimization bailout 7.
0x9c023aadea3   739  e89e81c5ff     call 0x9c023706046       ;; deoptimization bailout 7
                  ;;; jump table entry 6: deoptimization bailout 8.
0x9c023aadea8   744  e8a381c5ff     call 0x9c023706050       ;; deoptimization bailout 8
                  ;;; jump table entry 7: deoptimization bailout 9.
0x9c023aadead   749  e8a881c5ff     call 0x9c02370605a       ;; deoptimization bailout 9
                  ;;; jump table entry 8: deoptimization bailout 10.
0x9c023aadeb2   754  e8ad81c5ff     call 0x9c023706064       ;; deoptimization bailout 10
                  ;;; jump table entry 9: deoptimization bailout 11.
0x9c023aadeb7   759  e8b281c5ff     call 0x9c02370606e       ;; deoptimization bailout 11
                  ;;; jump table entry 10: deoptimization bailout 12.
0x9c023aadebc   764  e8b781c5ff     call 0x9c023706078       ;; deoptimization bailout 12
                  ;;; jump table entry 11: deoptimization bailout 13.
0x9c023aadec1   769  e8bc81c5ff     call 0x9c023706082       ;; deoptimization bailout 13
                  ;;; jump table entry 12: deoptimization bailout 14.
0x9c023aadec6   774  e8c181c5ff     call 0x9c02370608c       ;; deoptimization bailout 14
                  ;;; jump table entry 13: deoptimization bailout 16.
0x9c023aadecb   779  e8d081c5ff     call 0x9c0237060a0       ;; deoptimization bailout 16
                  ;;; jump table entry 14: deoptimization bailout 18.
0x9c023aaded0   784  e8df81c5ff     call 0x9c0237060b4       ;; deoptimization bailout 18
0x9c023aaded5   789  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 19)
 index  ast id    argc     pc             
     0       3       0     35
     1       3       0     -1
     2       3       0     -1
     3      16       0    107
     4      19       0     -1
     5      19       0     -1
     6      28       0     -1
     7      28       0     -1
     8      54       0     -1
     9      63       0     -1
    10      63       0     -1
    11      63       0     -1
    12      81       0     -1
    13      81       0     -1
    14      81       0     -1
    15      54       0     -1
    16      63       0     -1
    17      81       0     -1
    18      81       0     -1

Safepoints (size = 30)
0x9c023aadbe3    35  01 (sp -> fp)       0
0x9c023aadc2b   107  01 (sp -> fp)       3

RelocInfo (size = 1224)
0x9c023aadbca  position  (2106)
0x9c023aadbca  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x9c023aadbca  comment  (;;; <@2,#1> context)
0x9c023aadbce  comment  (;;; <@3,#1> gap)
0x9c023aadbd2  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x9c023aadbd2  comment  (;;; <@11,#8> gap)
0x9c023aadbd5  comment  (;;; <@12,#10> stack-check)
0x9c023aadbdf  code target (BUILTIN)  (0x9c023a25e60)
0x9c023aadbe3  comment  (;;; <@14,#10> lazy-bailout)
0x9c023aadbe3  comment  (;;; <@15,#10> gap)
0x9c023aadbe7  comment  (;;; <@16,#12> load-context-slot)
0x9c023aadbe7  position  (2205)
0x9c023aadbeb  comment  (;;; <@17,#12> gap)
0x9c023aadbef  comment  (;;; <@18,#89> check-smi)
0x9c023aadbef  position  (2196)
0x9c023aadbf8  comment  (;;; <@19,#89> gap)
0x9c023aadbfc  comment  (;;; <@20,#90> check-smi)
0x9c023aadbfc  position  (2205)
0x9c023aadc05  position  (2203)
0x9c023aadc05  comment  (;;; <@23,#13> compare-numeric-and-branch)
0x9c023aadc0e  comment  (;;; <@24,#17> -------------------- B2 (unreachable/replaced) --------------------)
0x9c023aadc0e  comment  (;;; <@28,#28> -------------------- B3 (unreachable/replaced) --------------------)
0x9c023aadc0e  comment  (;;; <@32,#14> -------------------- B4 (unreachable/replaced) --------------------)
0x9c023aadc0e  position  (2229)
0x9c023aadc0e  comment  (;;; <@36,#20> -------------------- B5 --------------------)
0x9c023aadc0e  comment  (;;; <@38,#21> load-context-slot)
0x9c023aadc12  comment  (;;; <@40,#22> push-argument)
0x9c023aadc12  position  (2236)
0x9c023aadc14  embedded object  (0x364e06304121 <undefined>)
0x9c023aadc1e  comment  (;;; <@41,#22> gap)
0x9c023aadc22  comment  (;;; <@42,#23> push-argument)
0x9c023aadc23  comment  (;;; <@43,#23> gap)
0x9c023aadc26  comment  (;;; <@44,#24> call-function)
0x9c023aadc27  code target (STUB)  (0x9c023a28d20)
0x9c023aadc2b  comment  (;;; <@46,#25> lazy-bailout)
0x9c023aadc2b  position  (2258)
0x9c023aadc2b  comment  (;;; <@50,#31> -------------------- B6 --------------------)
0x9c023aadc2b  comment  (;;; <@51,#31> gap)
0x9c023aadc2f  comment  (;;; <@52,#32> load-context-slot)
0x9c023aadc33  comment  (;;; <@54,#91> check-smi)
0x9c023aadc3c  comment  (;;; <@56,#33> sub-i)
0x9c023aadc3c  position  (2271)
0x9c023aadc46  comment  (;;; <@57,#33> gap)
0x9c023aadc49  comment  (;;; <@58,#92> dummy-use)
0x9c023aadc49  comment  (;;; <@60,#35> store-context-slot)
0x9c023aadc4d  comment  (;;; <@62,#37> load-context-slot)
0x9c023aadc4d  position  (2378)
0x9c023aadc51  comment  (;;; <@63,#37> gap)
0x9c023aadc54  comment  (;;; <@64,#95> check-smi)
0x9c023aadc54  position  (2394)
0x9c023aadc5d  comment  (;;; <@65,#95> gap)
0x9c023aadc61  comment  (;;; <@66,#40> add-i)
0x9c023aadc61  position  (2398)
0x9c023aadc6a  comment  (;;; <@67,#40> gap)
0x9c023aadc6d  comment  (;;; <@68,#96> dummy-use)
0x9c023aadc6d  comment  (;;; <@70,#42> store-context-slot)
0x9c023aadc71  comment  (;;; <@72,#44> load-context-slot)
0x9c023aadc71  position  (2484)
0x9c023aadc75  comment  (;;; <@74,#97> tagged-to-i)
0x9c023aadc82  comment  (;;; <@75,#97> gap)
0x9c023aadc85  comment  (;;; <@76,#47> add-i)
0x9c023aadc8e  comment  (;;; <@78,#99> smi-tag)
0x9c023aadc94  comment  (;;; <@80,#48> store-context-slot)
0x9c023aadc98  comment  (;;; <@82,#51> load-named-field)
0x9c023aadc98  position  (2497)
0x9c023aadc9c  comment  (;;; <@84,#52> load-context-slot)
0x9c023aadca3  comment  (;;; <@86,#55> check-non-smi)
0x9c023aadca3  position  (2513)
0x9c023aadcac  comment  (;;; <@88,#56> check-maps)
0x9c023aadcae  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aadcc0  comment  (;;; <@90,#58> check-maps)
0x9c023aadcc0  comment  (;;; <@92,#60> check-maps)
0x9c023aadcc0  comment  (;;; <@94,#61> load-named-field)
0x9c023aadcc4  comment  (;;; <@96,#62> load-named-field)
0x9c023aadcc7  comment  (;;; <@98,#63> load-named-field)
0x9c023aadccb  comment  (;;; <@100,#64> bounds-check)
0x9c023aadcd3  comment  (;;; <@101,#64> gap)
0x9c023aadcd6  comment  (;;; <@102,#94> tagged-to-i)
0x9c023aadce4  comment  (;;; <@104,#65> store-keyed)
0x9c023aadce7  comment  (;;; <@106,#68> load-context-slot)
0x9c023aadce7  position  (2528)
0x9c023aadcee  comment  (;;; <@108,#70> check-non-smi)
0x9c023aadcee  position  (2545)
0x9c023aadcf6  comment  (;;; <@110,#71> check-maps)
0x9c023aadcf8  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aadd0a  comment  (;;; <@112,#76> load-named-field)
0x9c023aadd0e  comment  (;;; <@114,#77> load-named-field)
0x9c023aadd11  comment  (;;; <@116,#78> load-named-field)
0x9c023aadd15  comment  (;;; <@117,#78> gap)
0x9c023aadd18  comment  (;;; <@118,#93> tagged-to-i)
0x9c023aadd26  comment  (;;; <@120,#79> bounds-check)
0x9c023aadd2e  comment  (;;; <@121,#79> gap)
0x9c023aadd32  comment  (;;; <@122,#86> tagged-to-i)
0x9c023aadd3f  comment  (;;; <@124,#80> store-keyed)
0x9c023aadd42  comment  (;;; <@126,#98> smi-tag)
0x9c023aadd42  position  (2565)
0x9c023aadd48  comment  (;;; <@128,#84> return)
0x9c023aadd4f  position  (2484)
0x9c023aadd4f  comment  (;;; <@74,#97> -------------------- Deferred tagged-to-i --------------------)
0x9c023aadd6d  comment  (Deferred TaggedToI: lost precision)
0x9c023aadd6f  comment  (Deferred TaggedToI: NaN)
0x9c023aadd84  runtime entry  (deoptimization bailout 15)
0x9c023aadd8d  position  (2513)
0x9c023aadd8d  comment  (;;; <@102,#94> -------------------- Deferred tagged-to-i --------------------)
0x9c023aaddb1  code target (STUB)  (0x9c023a67560)
0x9c023aadde1  comment  (Deferred TaggedToI: cannot truncate)
0x9c023aaddf3  position  (2545)
0x9c023aaddf3  comment  (;;; <@118,#93> -------------------- Deferred tagged-to-i --------------------)
0x9c023aade11  comment  (Deferred TaggedToI: lost precision)
0x9c023aade13  comment  (Deferred TaggedToI: NaN)
0x9c023aade1b  runtime entry  (deoptimization bailout 17)
0x9c023aade24  comment  (;;; <@122,#86> -------------------- Deferred tagged-to-i --------------------)
0x9c023aade48  code target (STUB)  (0x9c023a0f080)
0x9c023aade78  comment  (Deferred TaggedToI: cannot truncate)
0x9c023aade8a  comment  (;;; -------------------- Jump table --------------------)
0x9c023aade8a  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x9c023aade8b  runtime entry  (deoptimization bailout 1)
0x9c023aade8f  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x9c023aade90  runtime entry  (deoptimization bailout 2)
0x9c023aade94  comment  (;;; jump table entry 2: deoptimization bailout 4.)
0x9c023aade95  runtime entry  (deoptimization bailout 4)
0x9c023aade99  comment  (;;; jump table entry 3: deoptimization bailout 5.)
0x9c023aade9a  runtime entry  (deoptimization bailout 5)
0x9c023aade9e  comment  (;;; jump table entry 4: deoptimization bailout 6.)
0x9c023aade9f  runtime entry  (deoptimization bailout 6)
0x9c023aadea3  comment  (;;; jump table entry 5: deoptimization bailout 7.)
0x9c023aadea4  runtime entry  (deoptimization bailout 7)
0x9c023aadea8  comment  (;;; jump table entry 6: deoptimization bailout 8.)
0x9c023aadea9  runtime entry  (deoptimization bailout 8)
0x9c023aadead  comment  (;;; jump table entry 7: deoptimization bailout 9.)
0x9c023aadeae  runtime entry  (deoptimization bailout 9)
0x9c023aadeb2  comment  (;;; jump table entry 8: deoptimization bailout 10.)
0x9c023aadeb3  runtime entry  (deoptimization bailout 10)
0x9c023aadeb7  comment  (;;; jump table entry 9: deoptimization bailout 11.)
0x9c023aadeb8  runtime entry  (deoptimization bailout 11)
0x9c023aadebc  comment  (;;; jump table entry 10: deoptimization bailout 12.)
0x9c023aadebd  runtime entry  (deoptimization bailout 12)
0x9c023aadec1  comment  (;;; jump table entry 11: deoptimization bailout 13.)
0x9c023aadec2  runtime entry  (deoptimization bailout 13)
0x9c023aadec6  comment  (;;; jump table entry 12: deoptimization bailout 14.)
0x9c023aadec7  runtime entry  (deoptimization bailout 14)
0x9c023aadecb  comment  (;;; jump table entry 13: deoptimization bailout 16.)
0x9c023aadecc  runtime entry  (deoptimization bailout 16)
0x9c023aaded0  comment  (;;; jump table entry 14: deoptimization bailout 18.)
0x9c023aaded1  runtime entry  (deoptimization bailout 18)
0x9c023aaded8  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (pow) id{2,0} ---
(a,b){
return %_MathPow(((typeof(%IS_VAR(a))==='number')?a:NonNumberToNumber(a)),((typeof(%IS_VAR(b))==='number')?b:NonNumberToNumber(b)));
}

--- END ---
--- Raw source ---
(a,b){
return %_MathPow(((typeof(%IS_VAR(a))==='number')?a:NonNumberToNumber(a)),((typeof(%IS_VAR(b))==='number')?b:NonNumberToNumber(b)));
}


--- Optimized code ---
optimization_id = 2
source_position = 2172
kind = OPTIMIZED_FUNCTION
name = pow
stack_slots = 2
Instructions (size = 504)
0x9c023aae280     0  55             push rbp
0x9c023aae281     1  4889e5         REX.W movq rbp,rsp
0x9c023aae284     4  56             push rsi
0x9c023aae285     5  57             push rdi
0x9c023aae286     6  4883ec10       REX.W subq rsp,0x10
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x9c023aae28a    10  488b75f8       REX.W movq rsi,[rbp-0x8]    ;; debug: position 2172
                  ;;; <@12,#9> -------------------- B1 --------------------
                  ;;; <@14,#11> stack-check
0x9c023aae28e    14  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023aae295    21  7305           jnc 28  (0x9c023aae29c)
0x9c023aae297    23  e8c47bf7ff     call StackCheck  (0x9c023a25e60)    ;; code: BUILTIN
                  ;;; <@16,#11> lazy-bailout
                  ;;; <@18,#13> gap
0x9c023aae29c    28  488b4518       REX.W movq rax,[rbp+0x18]    ;; debug: position 2216
                  ;;; <@19,#13> typeof-is-and-branch
0x9c023aae2a0    32  a801           test al,0x1
0x9c023aae2a2    34  0f8464000000   jz 140  (0x9c023aae30c)
0x9c023aae2a8    40  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023aae2ac    44  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023aae2b0    48  0f8456000000   jz 140  (0x9c023aae30c)
                  ;;; <@20,#17> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@24,#20> -------------------- B3 --------------------
                  ;;; <@26,#24> push-argument
0x9c023aae2b6    54  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 2231
                                                             ;; debug: position 2249
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023aae2c0    64  4152           push r10
                  ;;; <@27,#24> gap
0x9c023aae2c2    66  488b4518       REX.W movq rax,[rbp+0x18]
                  ;;; <@28,#25> push-argument
0x9c023aae2c6    70  50             push rax
                  ;;; <@30,#21> constant-t
0x9c023aae2c7    71  48bf095431064e360000 REX.W movq rdi,0x364e06315409    ;; debug: position 2231
                                                             ;; object: 0x364e06315409 <JS Function NonNumberToNumber (SharedFunctionInfo 0x364e06313869)>
                  ;;; <@32,#27> call-js-function
0x9c023aae2d1    81  488b772f       REX.W movq rsi,[rdi+0x2f]    ;; debug: position 2249
0x9c023aae2d5    85  ff5717         call [rdi+0x17]
                  ;;; <@34,#28> lazy-bailout
                  ;;; <@36,#64> double-untag
0x9c023aae2d8    88  a801           test al,0x1              ;; debug: position 2273
0x9c023aae2da    90  7415           jz 113  (0x9c023aae2f1)
0x9c023aae2dc    92  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023aae2e0    96  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023aae2e4   100  f20f105007     movsd xmm2,[rax+0x7]
0x9c023aae2e9   105  0f8543010000   jnz 434  (0x9c023aae432)
0x9c023aae2ef   111  eb0f           jmp 128  (0x9c023aae300)
0x9c023aae2f1   113  4c8bd0         REX.W movq r10,rax
0x9c023aae2f4   116  49c1ea20       REX.W shrq r10,32
0x9c023aae2f8   120  0f57d2         xorps xmm2,xmm2
0x9c023aae2fb   123  f2410f2ad2     cvtsi2sd xmm2,r10
                  ;;; <@38,#33> gap
0x9c023aae300   128  0f28ca         movaps xmm1,xmm2         ;; debug: position 2249
0x9c023aae303   131  488b4518       REX.W movq rax,[rbp+0x18]
                  ;;; <@39,#33> goto
0x9c023aae307   135  e92f000000     jmp 187  (0x9c023aae33b)
                  ;;; <@40,#14> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@44,#29> -------------------- B5 --------------------
                  ;;; <@45,#29> gap
0x9c023aae30c   140  488b4518       REX.W movq rax,[rbp+0x18]
                  ;;; <@46,#63> double-untag
0x9c023aae310   144  a801           test al,0x1              ;; debug: position 2273
0x9c023aae312   146  7415           jz 169  (0x9c023aae329)
0x9c023aae314   148  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023aae318   152  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023aae31c   156  f20f105007     movsd xmm2,[rax+0x7]
0x9c023aae321   161  0f8510010000   jnz 439  (0x9c023aae437)
0x9c023aae327   167  eb0f           jmp 184  (0x9c023aae338)
0x9c023aae329   169  4c8bd0         REX.W movq r10,rax
0x9c023aae32c   172  49c1ea20       REX.W shrq r10,32
0x9c023aae330   176  0f57d2         xorps xmm2,xmm2
0x9c023aae333   179  f2410f2ad2     cvtsi2sd xmm2,r10
                  ;;; <@48,#31> gap
0x9c023aae338   184  0f28ca         movaps xmm1,xmm2         ;; debug: position 2249
                  ;;; <@50,#35> -------------------- B6 --------------------
0x9c023aae33b   187  f20f114de0     movsd [rbp-0x20],xmm1    ;; debug: position 2273
                  ;;; <@52,#36> gap
0x9c023aae340   192  488b5d10       REX.W movq rbx,[rbp+0x10]
                  ;;; <@53,#36> typeof-is-and-branch
0x9c023aae344   196  f6c301         testb rbx,0x1
0x9c023aae347   199  0f8435000000   jz 258  (0x9c023aae382)
0x9c023aae34d   205  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023aae351   209  4c3953ff       REX.W cmpq [rbx-0x1],r10
0x9c023aae355   213  0f8427000000   jz 258  (0x9c023aae382)
                  ;;; <@54,#40> -------------------- B7 (unreachable/replaced) --------------------
                  ;;; <@58,#43> -------------------- B8 --------------------
                  ;;; <@60,#47> push-argument
0x9c023aae35b   219  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 2288
                                                             ;; debug: position 2306
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023aae365   229  4152           push r10
                  ;;; <@61,#47> gap
0x9c023aae367   231  488b5d10       REX.W movq rbx,[rbp+0x10]
                  ;;; <@62,#48> push-argument
0x9c023aae36b   235  53             push rbx
                  ;;; <@64,#44> constant-t
0x9c023aae36c   236  48bf095431064e360000 REX.W movq rdi,0x364e06315409    ;; debug: position 2288
                                                             ;; object: 0x364e06315409 <JS Function NonNumberToNumber (SharedFunctionInfo 0x364e06313869)>
                  ;;; <@66,#50> call-js-function
0x9c023aae376   246  488b772f       REX.W movq rsi,[rdi+0x2f]    ;; debug: position 2306
0x9c023aae37a   250  ff5717         call [rdi+0x17]
                  ;;; <@68,#51> lazy-bailout
                  ;;; <@71,#56> goto
0x9c023aae37d   253  e904000000     jmp 262  (0x9c023aae386)
                  ;;; <@72,#37> -------------------- B9 (unreachable/replaced) --------------------
                  ;;; <@76,#52> -------------------- B10 --------------------
                  ;;; <@78,#54> gap
0x9c023aae382   258  488b4510       REX.W movq rax,[rbp+0x10]
                  ;;; <@80,#58> -------------------- B11 --------------------
0x9c023aae386   262  488945e8       REX.W movq [rbp-0x18],rax
                  ;;; <@81,#58> gap
0x9c023aae38a   266  f20f1055e0     movsd xmm2,[rbp-0x20]
0x9c023aae38f   271  488bd0         REX.W movq rdx,rax
                  ;;; <@82,#59> power
0x9c023aae392   274  f6c201         testb rdx,0x1
0x9c023aae395   277  740e           jz 293  (0x9c023aae3a5)
0x9c023aae397   279  488b4aff       REX.W movq rcx,[rdx-0x1]
0x9c023aae39b   283  80790b86       cmpb [rcx+0xb],0x86
0x9c023aae39f   287  0f8597000000   jnz 444  (0x9c023aae43c)
0x9c023aae3a5   293  e856fdffff     call 0x9c023aae100       ;; code: STUB, MathPowStub, minor: 2
                  ;;; <@84,#59> lazy-bailout
                  ;;; <@86,#65> number-tag-d
0x9c023aae3aa   298  498b9dd00a0000 REX.W movq rbx,[r13+0xad0]
0x9c023aae3b1   305  488bc3         REX.W movq rax,rbx
0x9c023aae3b4   308  4883c010       REX.W addq rax,0x10
0x9c023aae3b8   312  0f822e000000   jc 364  (0x9c023aae3ec)
0x9c023aae3be   318  493b85d80a0000 REX.W cmpq rax,[r13+0xad8]
0x9c023aae3c5   325  0f8721000000   ja 364  (0x9c023aae3ec)
0x9c023aae3cb   331  498985d00a0000 REX.W movq [r13+0xad0],rax
0x9c023aae3d2   338  48ffc3         REX.W incq rbx
0x9c023aae3d5   341  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023aae3d9   345  4c8953ff       REX.W movq [rbx-0x1],r10
0x9c023aae3dd   349  f20f115b07     movsd [rbx+0x7],xmm3
                  ;;; <@87,#65> gap
0x9c023aae3e2   354  488bc3         REX.W movq rax,rbx
                  ;;; <@88,#61> return
0x9c023aae3e5   357  488be5         REX.W movq rsp,rbp
0x9c023aae3e8   360  5d             pop rbp
0x9c023aae3e9   361  c21800         ret 0x18
                  ;;; <@86,#65> -------------------- Deferred number-tag-d --------------------
0x9c023aae3ec   364  33db           xorl rbx,rbx
0x9c023aae3ee   366  50             push rax
0x9c023aae3ef   367  51             push rcx
0x9c023aae3f0   368  52             push rdx
0x9c023aae3f1   369  53             push rbx
0x9c023aae3f2   370  56             push rsi
0x9c023aae3f3   371  57             push rdi
0x9c023aae3f4   372  4150           push r8
0x9c023aae3f6   374  4151           push r9
0x9c023aae3f8   376  4153           push r11
0x9c023aae3fa   378  4156           push r14
0x9c023aae3fc   380  4157           push r15
0x9c023aae3fe   382  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023aae403   387  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023aae407   391  33c0           xorl rax,rax
0x9c023aae409   393  498d9dd81ce5fd REX.W leaq rbx,[r13-0x21ae328]
0x9c023aae410   400  e8ab7df5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023aae415   405  4c8bd0         REX.W movq r10,rax
0x9c023aae418   408  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023aae41d   413  415f           pop r15
0x9c023aae41f   415  415e           pop r14
0x9c023aae421   417  415b           pop r11
0x9c023aae423   419  4159           pop r9
0x9c023aae425   421  4158           pop r8
0x9c023aae427   423  5f             pop rdi
0x9c023aae428   424  5e             pop rsi
0x9c023aae429   425  5b             pop rbx
0x9c023aae42a   426  5a             pop rdx
0x9c023aae42b   427  59             pop rcx
0x9c023aae42c   428  58             pop rax
0x9c023aae42d   429  498bda         REX.W movq rbx,r10
0x9c023aae430   432  ebab           jmp 349  (0x9c023aae3dd)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x9c023aae432   434  e8dd7bc5ff     call 0x9c023706014       ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x9c023aae437   439  e8e27bc5ff     call 0x9c02370601e       ;; deoptimization bailout 3
                  ;;; jump table entry 2: deoptimization bailout 5.
0x9c023aae43c   444  e8f17bc5ff     call 0x9c023706032       ;; deoptimization bailout 5
0x9c023aae441   449  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 7)
 index  ast id    argc     pc             
     0       3       0     28
     1      20       0     88
     2      23       0     -1
     3      23       0     -1
     4      43       0    253
     5      46       0     -1
     6      46       0    298

Safepoints (size = 52)
0x9c023aae29c    28  00 (sp -> fp)       0
0x9c023aae2d8    88  00 (sp -> fp)       1
0x9c023aae37d   253  00 (sp -> fp)       4
0x9c023aae415   405  00 | rbx (sp -> fp)  <none>

RelocInfo (size = 614)
0x9c023aae28a  position  (2172)
0x9c023aae28a  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x9c023aae28a  comment  (;;; <@2,#1> context)
0x9c023aae28e  comment  (;;; <@12,#9> -------------------- B1 --------------------)
0x9c023aae28e  comment  (;;; <@14,#11> stack-check)
0x9c023aae298  code target (BUILTIN)  (0x9c023a25e60)
0x9c023aae29c  comment  (;;; <@16,#11> lazy-bailout)
0x9c023aae29c  comment  (;;; <@18,#13> gap)
0x9c023aae29c  position  (2216)
0x9c023aae2a0  comment  (;;; <@19,#13> typeof-is-and-branch)
0x9c023aae2b6  comment  (;;; <@20,#17> -------------------- B2 (unreachable/replaced) --------------------)
0x9c023aae2b6  position  (2231)
0x9c023aae2b6  comment  (;;; <@24,#20> -------------------- B3 --------------------)
0x9c023aae2b6  comment  (;;; <@26,#24> push-argument)
0x9c023aae2b6  position  (2249)
0x9c023aae2b8  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023aae2c2  comment  (;;; <@27,#24> gap)
0x9c023aae2c6  comment  (;;; <@28,#25> push-argument)
0x9c023aae2c7  comment  (;;; <@30,#21> constant-t)
0x9c023aae2c7  position  (2231)
0x9c023aae2c9  embedded object  (0x364e06315409 <JS Function NonNumberToNumber (SharedFunctionInfo 0x364e06313869)>)
0x9c023aae2d1  comment  (;;; <@32,#27> call-js-function)
0x9c023aae2d1  position  (2249)
0x9c023aae2d8  comment  (;;; <@34,#28> lazy-bailout)
0x9c023aae2d8  comment  (;;; <@36,#64> double-untag)
0x9c023aae2d8  position  (2273)
0x9c023aae300  comment  (;;; <@38,#33> gap)
0x9c023aae300  position  (2249)
0x9c023aae307  comment  (;;; <@39,#33> goto)
0x9c023aae30c  comment  (;;; <@40,#14> -------------------- B4 (unreachable/replaced) --------------------)
0x9c023aae30c  comment  (;;; <@44,#29> -------------------- B5 --------------------)
0x9c023aae30c  comment  (;;; <@45,#29> gap)
0x9c023aae310  comment  (;;; <@46,#63> double-untag)
0x9c023aae310  position  (2273)
0x9c023aae338  comment  (;;; <@48,#31> gap)
0x9c023aae338  position  (2249)
0x9c023aae33b  position  (2273)
0x9c023aae33b  comment  (;;; <@50,#35> -------------------- B6 --------------------)
0x9c023aae340  comment  (;;; <@52,#36> gap)
0x9c023aae344  comment  (;;; <@53,#36> typeof-is-and-branch)
0x9c023aae35b  comment  (;;; <@54,#40> -------------------- B7 (unreachable/replaced) --------------------)
0x9c023aae35b  position  (2288)
0x9c023aae35b  comment  (;;; <@58,#43> -------------------- B8 --------------------)
0x9c023aae35b  comment  (;;; <@60,#47> push-argument)
0x9c023aae35b  position  (2306)
0x9c023aae35d  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023aae367  comment  (;;; <@61,#47> gap)
0x9c023aae36b  comment  (;;; <@62,#48> push-argument)
0x9c023aae36c  comment  (;;; <@64,#44> constant-t)
0x9c023aae36c  position  (2288)
0x9c023aae36e  embedded object  (0x364e06315409 <JS Function NonNumberToNumber (SharedFunctionInfo 0x364e06313869)>)
0x9c023aae376  comment  (;;; <@66,#50> call-js-function)
0x9c023aae376  position  (2306)
0x9c023aae37d  comment  (;;; <@68,#51> lazy-bailout)
0x9c023aae37d  comment  (;;; <@71,#56> goto)
0x9c023aae382  comment  (;;; <@72,#37> -------------------- B9 (unreachable/replaced) --------------------)
0x9c023aae382  comment  (;;; <@76,#52> -------------------- B10 --------------------)
0x9c023aae382  comment  (;;; <@78,#54> gap)
0x9c023aae386  comment  (;;; <@80,#58> -------------------- B11 --------------------)
0x9c023aae38a  comment  (;;; <@81,#58> gap)
0x9c023aae392  comment  (;;; <@82,#59> power)
0x9c023aae3a6  code target (STUB)  (0x9c023aae100)
0x9c023aae3aa  comment  (;;; <@84,#59> lazy-bailout)
0x9c023aae3aa  comment  (;;; <@86,#65> number-tag-d)
0x9c023aae3e2  comment  (;;; <@87,#65> gap)
0x9c023aae3e5  comment  (;;; <@88,#61> return)
0x9c023aae3ec  comment  (;;; <@86,#65> -------------------- Deferred number-tag-d --------------------)
0x9c023aae411  code target (STUB)  (0x9c023a061c0)
0x9c023aae432  comment  (;;; -------------------- Jump table --------------------)
0x9c023aae432  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x9c023aae433  runtime entry  (deoptimization bailout 2)
0x9c023aae437  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x9c023aae438  runtime entry  (deoptimization bailout 3)
0x9c023aae43c  comment  (;;; jump table entry 2: deoptimization bailout 5.)
0x9c023aae43d  runtime entry  (deoptimization bailout 5)
0x9c023aae444  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (floor) id{3,0} ---
(a){
a=((typeof(%IS_VAR(a))==='number')?a:NonNumberToNumber(a));
if(a<0x80000000&&a>0){
return(a>>>0);
}else{
return %MathFloor(a);
}
}

--- END ---
--- Raw source ---
(a){
a=((typeof(%IS_VAR(a))==='number')?a:NonNumberToNumber(a));
if(a<0x80000000&&a>0){
return(a>>>0);
}else{
return %MathFloor(a);
}
}


--- Optimized code ---
optimization_id = 3
source_position = 954
kind = OPTIMIZED_FUNCTION
name = floor
stack_slots = 2
Instructions (size = 667)
0x9c023aae760     0  55             push rbp
0x9c023aae761     1  4889e5         REX.W movq rbp,rsp
0x9c023aae764     4  56             push rsi
0x9c023aae765     5  57             push rdi
0x9c023aae766     6  4883ec10       REX.W subq rsp,0x10
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x9c023aae76a    10  488b45f8       REX.W movq rax,[rbp-0x8]    ;; debug: position 954
                  ;;; <@3,#1> gap
0x9c023aae76e    14  488945e8       REX.W movq [rbp-0x18],rax
                  ;;; <@10,#8> -------------------- B1 --------------------
                  ;;; <@11,#8> gap
0x9c023aae772    18  488bf0         REX.W movq rsi,rax
                  ;;; <@12,#10> stack-check
0x9c023aae775    21  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023aae77c    28  7305           jnc 35  (0x9c023aae783)
0x9c023aae77e    30  e8dd76f7ff     call StackCheck  (0x9c023a25e60)    ;; code: BUILTIN
                  ;;; <@14,#10> lazy-bailout
                  ;;; <@16,#12> gap
0x9c023aae783    35  488b4510       REX.W movq rax,[rbp+0x10]    ;; debug: position 981
                  ;;; <@17,#12> typeof-is-and-branch
0x9c023aae787    39  a801           test al,0x1
0x9c023aae789    41  0f845d000000   jz 140  (0x9c023aae7ec)
0x9c023aae78f    47  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023aae793    51  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023aae797    55  0f844f000000   jz 140  (0x9c023aae7ec)
                  ;;; <@18,#16> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@22,#19> -------------------- B3 --------------------
                  ;;; <@24,#23> push-argument
0x9c023aae79d    61  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 996
                                                             ;; debug: position 1014
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023aae7a7    71  4152           push r10
                  ;;; <@25,#23> gap
0x9c023aae7a9    73  488b4510       REX.W movq rax,[rbp+0x10]
                  ;;; <@26,#24> push-argument
0x9c023aae7ad    77  50             push rax
                  ;;; <@28,#20> constant-t
0x9c023aae7ae    78  48bf095431064e360000 REX.W movq rdi,0x364e06315409    ;; debug: position 996
                                                             ;; object: 0x364e06315409 <JS Function NonNumberToNumber (SharedFunctionInfo 0x364e06313869)>
                  ;;; <@30,#26> call-js-function
0x9c023aae7b8    88  488b772f       REX.W movq rsi,[rdi+0x2f]    ;; debug: position 1014
0x9c023aae7bc    92  ff5717         call [rdi+0x17]
                  ;;; <@32,#27> lazy-bailout
                  ;;; <@34,#66> double-untag
0x9c023aae7bf    95  a801           test al,0x1              ;; debug: position 1024
0x9c023aae7c1    97  7415           jz 120  (0x9c023aae7d8)
0x9c023aae7c3    99  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023aae7c7   103  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023aae7cb   107  f20f104807     movsd xmm1,[rax+0x7]
0x9c023aae7d0   112  0f85db010000   jnz 593  (0x9c023aae9b1)
0x9c023aae7d6   118  eb0f           jmp 135  (0x9c023aae7e7)
0x9c023aae7d8   120  4c8bd0         REX.W movq r10,rax
0x9c023aae7db   123  49c1ea20       REX.W shrq r10,32
0x9c023aae7df   127  0f57c9         xorps xmm1,xmm1
0x9c023aae7e2   130  f2410f2aca     cvtsi2sd xmm1,r10
                  ;;; <@37,#32> goto
0x9c023aae7e7   135  e92c000000     jmp 184  (0x9c023aae818)    ;; debug: position 1014
                  ;;; <@38,#13> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@42,#28> -------------------- B5 --------------------
                  ;;; <@43,#28> gap
0x9c023aae7ec   140  488b4510       REX.W movq rax,[rbp+0x10]
                  ;;; <@44,#65> double-untag
0x9c023aae7f0   144  a801           test al,0x1              ;; debug: position 1024
0x9c023aae7f2   146  7415           jz 169  (0x9c023aae809)
0x9c023aae7f4   148  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023aae7f8   152  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023aae7fc   156  f20f104807     movsd xmm1,[rax+0x7]
0x9c023aae801   161  0f85af010000   jnz 598  (0x9c023aae9b6)
0x9c023aae807   167  eb0f           jmp 184  (0x9c023aae818)
0x9c023aae809   169  4c8bd0         REX.W movq r10,rax
0x9c023aae80c   172  49c1ea20       REX.W shrq r10,32
0x9c023aae810   176  0f57c9         xorps xmm1,xmm1
0x9c023aae813   179  f2410f2aca     cvtsi2sd xmm1,r10
                  ;;; <@48,#34> -------------------- B6 --------------------
0x9c023aae818   184  f20f114de0     movsd [rbp-0x20],xmm1    ;; debug: position 1014
                                                             ;; debug: position 1024
                  ;;; <@50,#35> constant-d
0x9c023aae81d   189  48b8000000000000e041 REX.W movq rax,0x41e0000000000000
0x9c023aae827   199  66480f6ed0     REX.W movq xmm2,rax
                  ;;; <@53,#36> compare-numeric-and-branch
0x9c023aae82c   204  660f2eca       ucomisd xmm1,xmm2        ;; debug: position 1023
0x9c023aae830   208  0f8a19000000   jpe 239  (0x9c023aae84f)
0x9c023aae836   214  0f8313000000   jnc 239  (0x9c023aae84f)
                  ;;; <@54,#40> -------------------- B7 (unreachable/replaced) --------------------
                  ;;; <@58,#37> -------------------- B8 (unreachable/replaced) --------------------
                  ;;; <@62,#43> -------------------- B9 --------------------
                  ;;; <@64,#69> constant-d
0x9c023aae83c   220  0f57d2         xorps xmm2,xmm2          ;; debug: position 1038
                                                             ;; debug: position 1037
                  ;;; <@67,#45> compare-numeric-and-branch
0x9c023aae83f   223  660f2eca       ucomisd xmm1,xmm2
0x9c023aae843   227  0f8a06000000   jpe 239  (0x9c023aae84f)
0x9c023aae849   233  0f8755000000   ja 324  (0x9c023aae8a4)
                  ;;; <@68,#49> -------------------- B10 (unreachable/replaced) --------------------
                  ;;; <@72,#58> -------------------- B11 --------------------
                  ;;; <@74,#67> number-tag-d
0x9c023aae84f   239  498b9dd00a0000 REX.W movq rbx,[r13+0xad0]    ;; debug: position 1082
0x9c023aae856   246  488bc3         REX.W movq rax,rbx
0x9c023aae859   249  4883c010       REX.W addq rax,0x10
0x9c023aae85d   253  0f827e000000   jc 385  (0x9c023aae8e1)
0x9c023aae863   259  493b85d80a0000 REX.W cmpq rax,[r13+0xad8]
0x9c023aae86a   266  0f8771000000   ja 385  (0x9c023aae8e1)
0x9c023aae870   272  498985d00a0000 REX.W movq [r13+0xad0],rax
0x9c023aae877   279  48ffc3         REX.W incq rbx
0x9c023aae87a   282  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023aae87e   286  4c8953ff       REX.W movq [rbx-0x1],r10
0x9c023aae882   290  f20f114b07     movsd [rbx+0x7],xmm1
                  ;;; <@76,#59> push-argument
0x9c023aae887   295  53             push rbx
                  ;;; <@77,#59> gap
0x9c023aae888   296  488b75e8       REX.W movq rsi,[rbp-0x18]
                  ;;; <@78,#60> call-runtime
0x9c023aae88c   300  b801000000     movl rax,0x1
0x9c023aae891   305  498d9d98b9e5fd REX.W leaq rbx,[r13-0x21a4668]
0x9c023aae898   312  e8c377f5ff     call 0x9c023a06060       ;; code: STUB, CEntryStub, minor: 0
                  ;;; <@80,#61> lazy-bailout
                  ;;; <@82,#63> return
0x9c023aae89d   317  488be5         REX.W movq rsp,rbp
0x9c023aae8a0   320  5d             pop rbp
0x9c023aae8a1   321  c21000         ret 0x10
                  ;;; <@84,#46> -------------------- B12 (unreachable/replaced) --------------------
                  ;;; <@88,#52> -------------------- B13 --------------------
                  ;;; <@89,#52> gap
0x9c023aae8a4   324  f20f104de0     movsd xmm1,[rbp-0x20]    ;; debug: position 1053
                  ;;; <@90,#68> double-to-i
0x9c023aae8a9   329  f2480f2cc1     REX.W cvttsd2siq rax,xmm1    ;; debug: position 1049
0x9c023aae8ae   334  4883f801       REX.W cmpq rax,0x1
0x9c023aae8b2   338  7112           jno 358  (0x9c023aae8c6)
0x9c023aae8b4   340  4883ec08       REX.W subq rsp,0x8
0x9c023aae8b8   344  f20f110c24     movsd [rsp],xmm1
0x9c023aae8bd   349  e8defdffff     call 0x9c023aae6a0       ;; code: STUB, DoubleToIStub, minor: 266244
0x9c023aae8c2   354  4883c408       REX.W addq rsp,0x8
0x9c023aae8c6   358  8bc0           movl rax,rax
                  ;;; <@92,#54> shift-i
0x9c023aae8c8   360  c1e800         shrl rax,0               ;; debug: position 1050
                  ;;; <@94,#71> number-tag-u
0x9c023aae8cb   363  3dffffff7f     cmp rax,0x7fffffff
0x9c023aae8d0   368  0f8754000000   ja 458  (0x9c023aae92a)
0x9c023aae8d6   374  48c1e020       REX.W shlq rax,32
                  ;;; <@96,#57> return
0x9c023aae8da   378  488be5         REX.W movq rsp,rbp
0x9c023aae8dd   381  5d             pop rbp
0x9c023aae8de   382  c21000         ret 0x10
                  ;;; <@74,#67> -------------------- Deferred number-tag-d --------------------
0x9c023aae8e1   385  33db           xorl rbx,rbx             ;; debug: position 1082
0x9c023aae8e3   387  50             push rax
0x9c023aae8e4   388  51             push rcx
0x9c023aae8e5   389  52             push rdx
0x9c023aae8e6   390  53             push rbx
0x9c023aae8e7   391  56             push rsi
0x9c023aae8e8   392  57             push rdi
0x9c023aae8e9   393  4150           push r8
0x9c023aae8eb   395  4151           push r9
0x9c023aae8ed   397  4153           push r11
0x9c023aae8ef   399  4156           push r14
0x9c023aae8f1   401  4157           push r15
0x9c023aae8f3   403  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023aae8f8   408  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023aae8fc   412  33c0           xorl rax,rax
0x9c023aae8fe   414  498d9dd81ce5fd REX.W leaq rbx,[r13-0x21ae328]
0x9c023aae905   421  e8b678f5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023aae90a   426  4c8bd0         REX.W movq r10,rax
0x9c023aae90d   429  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023aae912   434  415f           pop r15
0x9c023aae914   436  415e           pop r14
0x9c023aae916   438  415b           pop r11
0x9c023aae918   440  4159           pop r9
0x9c023aae91a   442  4158           pop r8
0x9c023aae91c   444  5f             pop rdi
0x9c023aae91d   445  5e             pop rsi
0x9c023aae91e   446  5b             pop rbx
0x9c023aae91f   447  5a             pop rdx
0x9c023aae920   448  59             pop rcx
0x9c023aae921   449  58             pop rax
0x9c023aae922   450  498bda         REX.W movq rbx,r10
0x9c023aae925   453  e958ffffff     jmp 290  (0x9c023aae882)
                  ;;; <@94,#71> -------------------- Deferred number-tag-u --------------------
0x9c023aae92a   458  f2480f2ac8     REX.W cvtsi2sd xmm1,rax    ;; debug: position 1050
0x9c023aae92f   463  498b85d00a0000 REX.W movq rax,[r13+0xad0]
0x9c023aae936   470  488bd8         REX.W movq rbx,rax
0x9c023aae939   473  4883c310       REX.W addq rbx,0x10
0x9c023aae93d   477  0f8221000000   jc 516  (0x9c023aae964)
0x9c023aae943   483  493b9dd80a0000 REX.W cmpq rbx,[r13+0xad8]
0x9c023aae94a   490  0f8714000000   ja 516  (0x9c023aae964)
0x9c023aae950   496  49899dd00a0000 REX.W movq [r13+0xad0],rbx
0x9c023aae957   503  48ffc0         REX.W incq rax
0x9c023aae95a   506  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023aae95e   510  4c8950ff       REX.W movq [rax-0x1],r10
0x9c023aae962   514  eb43           jmp 583  (0x9c023aae9a7)
0x9c023aae964   516  33c0           xorl rax,rax
0x9c023aae966   518  50             push rax
0x9c023aae967   519  51             push rcx
0x9c023aae968   520  52             push rdx
0x9c023aae969   521  53             push rbx
0x9c023aae96a   522  56             push rsi
0x9c023aae96b   523  57             push rdi
0x9c023aae96c   524  4150           push r8
0x9c023aae96e   526  4151           push r9
0x9c023aae970   528  4153           push r11
0x9c023aae972   530  4156           push r14
0x9c023aae974   532  4157           push r15
0x9c023aae976   534  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023aae97b   539  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023aae97f   543  33c0           xorl rax,rax
0x9c023aae981   545  498d9dd81ce5fd REX.W leaq rbx,[r13-0x21ae328]
0x9c023aae988   552  e83378f5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023aae98d   557  4889442478     REX.W movq [rsp+0x78],rax
0x9c023aae992   562  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023aae997   567  415f           pop r15
0x9c023aae999   569  415e           pop r14
0x9c023aae99b   571  415b           pop r11
0x9c023aae99d   573  4159           pop r9
0x9c023aae99f   575  4158           pop r8
0x9c023aae9a1   577  5f             pop rdi
0x9c023aae9a2   578  5e             pop rsi
0x9c023aae9a3   579  5b             pop rbx
0x9c023aae9a4   580  5a             pop rdx
0x9c023aae9a5   581  59             pop rcx
0x9c023aae9a6   582  58             pop rax
0x9c023aae9a7   583  f20f114807     movsd [rax+0x7],xmm1
0x9c023aae9ac   588  e929ffffff     jmp 378  (0x9c023aae8da)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 2.
0x9c023aae9b1   593  e85e76c5ff     call 0x9c023706014       ;; deoptimization bailout 2
                  ;;; jump table entry 1: deoptimization bailout 3.
0x9c023aae9b6   598  e86376c5ff     call 0x9c02370601e       ;; deoptimization bailout 3
0x9c023aae9bb   603  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 5)
 index  ast id    argc     pc             
     0       3       0     35
     1      22       0     95
     2      25       0     -1
     3      25       0     -1
     4      60       0    317

Safepoints (size = 63)
0x9c023aae783    35  01 (sp -> fp)       0
0x9c023aae7bf    95  01 (sp -> fp)       1
0x9c023aae89d   317  00 (sp -> fp)       4
0x9c023aae90a   426  01 | rbx (sp -> fp)  <none>
0x9c023aae98d   557  00 | rax (sp -> fp)  <none>

RelocInfo (size = 640)
0x9c023aae76a  position  (954)
0x9c023aae76a  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x9c023aae76a  comment  (;;; <@2,#1> context)
0x9c023aae76e  comment  (;;; <@3,#1> gap)
0x9c023aae772  comment  (;;; <@10,#8> -------------------- B1 --------------------)
0x9c023aae772  comment  (;;; <@11,#8> gap)
0x9c023aae775  comment  (;;; <@12,#10> stack-check)
0x9c023aae77f  code target (BUILTIN)  (0x9c023a25e60)
0x9c023aae783  comment  (;;; <@14,#10> lazy-bailout)
0x9c023aae783  comment  (;;; <@16,#12> gap)
0x9c023aae783  position  (981)
0x9c023aae787  comment  (;;; <@17,#12> typeof-is-and-branch)
0x9c023aae79d  comment  (;;; <@18,#16> -------------------- B2 (unreachable/replaced) --------------------)
0x9c023aae79d  position  (996)
0x9c023aae79d  comment  (;;; <@22,#19> -------------------- B3 --------------------)
0x9c023aae79d  comment  (;;; <@24,#23> push-argument)
0x9c023aae79d  position  (1014)
0x9c023aae79f  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023aae7a9  comment  (;;; <@25,#23> gap)
0x9c023aae7ad  comment  (;;; <@26,#24> push-argument)
0x9c023aae7ae  comment  (;;; <@28,#20> constant-t)
0x9c023aae7ae  position  (996)
0x9c023aae7b0  embedded object  (0x364e06315409 <JS Function NonNumberToNumber (SharedFunctionInfo 0x364e06313869)>)
0x9c023aae7b8  comment  (;;; <@30,#26> call-js-function)
0x9c023aae7b8  position  (1014)
0x9c023aae7bf  comment  (;;; <@32,#27> lazy-bailout)
0x9c023aae7bf  comment  (;;; <@34,#66> double-untag)
0x9c023aae7bf  position  (1024)
0x9c023aae7e7  position  (1014)
0x9c023aae7e7  comment  (;;; <@37,#32> goto)
0x9c023aae7ec  comment  (;;; <@38,#13> -------------------- B4 (unreachable/replaced) --------------------)
0x9c023aae7ec  comment  (;;; <@42,#28> -------------------- B5 --------------------)
0x9c023aae7ec  comment  (;;; <@43,#28> gap)
0x9c023aae7f0  comment  (;;; <@44,#65> double-untag)
0x9c023aae7f0  position  (1024)
0x9c023aae818  position  (1014)
0x9c023aae818  position  (1024)
0x9c023aae818  comment  (;;; <@48,#34> -------------------- B6 --------------------)
0x9c023aae81d  comment  (;;; <@50,#35> constant-d)
0x9c023aae82c  position  (1023)
0x9c023aae82c  comment  (;;; <@53,#36> compare-numeric-and-branch)
0x9c023aae83c  comment  (;;; <@54,#40> -------------------- B7 (unreachable/replaced) --------------------)
0x9c023aae83c  comment  (;;; <@58,#37> -------------------- B8 (unreachable/replaced) --------------------)
0x9c023aae83c  position  (1038)
0x9c023aae83c  comment  (;;; <@62,#43> -------------------- B9 --------------------)
0x9c023aae83c  comment  (;;; <@64,#69> constant-d)
0x9c023aae83c  position  (1037)
0x9c023aae83f  comment  (;;; <@67,#45> compare-numeric-and-branch)
0x9c023aae84f  comment  (;;; <@68,#49> -------------------- B10 (unreachable/replaced) --------------------)
0x9c023aae84f  position  (1082)
0x9c023aae84f  comment  (;;; <@72,#58> -------------------- B11 --------------------)
0x9c023aae84f  comment  (;;; <@74,#67> number-tag-d)
0x9c023aae887  comment  (;;; <@76,#59> push-argument)
0x9c023aae888  comment  (;;; <@77,#59> gap)
0x9c023aae88c  comment  (;;; <@78,#60> call-runtime)
0x9c023aae899  code target (STUB)  (0x9c023a06060)
0x9c023aae89d  comment  (;;; <@80,#61> lazy-bailout)
0x9c023aae89d  comment  (;;; <@82,#63> return)
0x9c023aae8a4  comment  (;;; <@84,#46> -------------------- B12 (unreachable/replaced) --------------------)
0x9c023aae8a4  position  (1053)
0x9c023aae8a4  comment  (;;; <@88,#52> -------------------- B13 --------------------)
0x9c023aae8a4  comment  (;;; <@89,#52> gap)
0x9c023aae8a9  comment  (;;; <@90,#68> double-to-i)
0x9c023aae8a9  position  (1049)
0x9c023aae8be  code target (STUB)  (0x9c023aae6a0)
0x9c023aae8c8  comment  (;;; <@92,#54> shift-i)
0x9c023aae8c8  position  (1050)
0x9c023aae8cb  comment  (;;; <@94,#71> number-tag-u)
0x9c023aae8da  comment  (;;; <@96,#57> return)
0x9c023aae8e1  position  (1082)
0x9c023aae8e1  comment  (;;; <@74,#67> -------------------- Deferred number-tag-d --------------------)
0x9c023aae906  code target (STUB)  (0x9c023a061c0)
0x9c023aae92a  position  (1050)
0x9c023aae92a  comment  (;;; <@94,#71> -------------------- Deferred number-tag-u --------------------)
0x9c023aae989  code target (STUB)  (0x9c023a061c0)
0x9c023aae9b1  comment  (;;; -------------------- Jump table --------------------)
0x9c023aae9b1  comment  (;;; jump table entry 0: deoptimization bailout 2.)
0x9c023aae9b2  runtime entry  (deoptimization bailout 2)
0x9c023aae9b6  comment  (;;; jump table entry 1: deoptimization bailout 3.)
0x9c023aae9b7  runtime entry  (deoptimization bailout 3)
0x9c023aae9bc  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (subtract) id{4,0} ---
(A, B){

    var comp = compare_abs(A, B)
    if ( comp === 0 ) {
      return zero
    } else if ( comp < 0 ) {
      var T = A
      A = B
      B = T
    }

    var size_r = heap[adrs[A]]

    var R = alloc(size_r)
    var Rp = adrs[R]

    var Ap = adrs[A]
    var Bp = adrs[B]

    var size_a = heap[Ap]
    var size_b = heap[Bp]

    heap[Rp + 1] = 0 // type integer

    var r = 0
    var carry = 0

    for ( var i = 2; i < size_b; i ++ ) {
      r = heap[Ap + i] - heap[Bp + i] - carry
      if ( r < 0 ) {
        r += 0x4000000
        carry = 1
      } else {
        carry = 0
      }
      heap[Rp + i] = r
    }
    for ( ; i < size_a; i ++ ) {
      r = heap[Ap + i] - carry
      if ( r < 0 ) {
        heap[Rp + i] = r + 0x4000000
        carry = 1
      } else {
        heap[Rp + i] = r
        carry = 0
      }
    }
    heap[Rp + i] -= carry

    var trailing_zeroes = 0
    while ( heap[Rp + (--i)] === 0 && i > 1) {
      trailing_zeroes++
    }
    if ( trailing_zeroes ) heap[Rp] = size_r - trailing_zeroes

    return R
  }

--- END ---
--- FUNCTION SOURCE (compare_abs) id{4,1} ---
(A, B){
    if ( A === B ) return 0
    var Ap = adrs[A]
    var Bp = adrs[B]

    var a_size = heap[Ap]
    var b_size = heap[Bp]

    if ( a_size < b_size ) {
      return -1
    } else if ( b_size < a_size ) {
      return 1
    } else {
      for ( var i = a_size - 1; i > 1; i-- ) {
        if ( heap[Ap + i] < heap[Bp + i] ) {
          return -1
        } else if ( heap[Ap + i] > heap[Bp + i] ) {
          return 1
        }
      }
      return 0
    }
  }

--- END ---
INLINE (compare_abs) id{4,1} AS 1 AT <0:24>
--- FUNCTION SOURCE (alloc) id{4,2} ---
(length){
      // there is no check for it but length has to be larger than 0
      if ( length > unallocated ) {
        extend(length)
      }
      unallocated -= length
      // save data index to data_idx and advance the break point with length
      var data_idx = brk
      brk = brk + length
      // save data_idx in address space and advance next
      var pointer = next++
      adrs[pointer] = data_idx
      heap[data_idx] = length
      return pointer
    }

--- END ---
INLINE (alloc) id{4,2} AS 2 AT <0:204>
--- Raw source ---
(A, B){

    var comp = compare_abs(A, B)
    if ( comp === 0 ) {
      return zero
    } else if ( comp < 0 ) {
      var T = A
      A = B
      B = T
    }

    var size_r = heap[adrs[A]]

    var R = alloc(size_r)
    var Rp = adrs[R]

    var Ap = adrs[A]
    var Bp = adrs[B]

    var size_a = heap[Ap]
    var size_b = heap[Bp]

    heap[Rp + 1] = 0 // type integer

    var r = 0
    var carry = 0

    for ( var i = 2; i < size_b; i ++ ) {
      r = heap[Ap + i] - heap[Bp + i] - carry
      if ( r < 0 ) {
        r += 0x4000000
        carry = 1
      } else {
        carry = 0
      }
      heap[Rp + i] = r
    }
    for ( ; i < size_a; i ++ ) {
      r = heap[Ap + i] - carry
      if ( r < 0 ) {
        heap[Rp + i] = r + 0x4000000
        carry = 1
      } else {
        heap[Rp + i] = r
        carry = 0
      }
    }
    heap[Rp + i] -= carry

    var trailing_zeroes = 0
    while ( heap[Rp + (--i)] === 0 && i > 1) {
      trailing_zeroes++
    }
    if ( trailing_zeroes ) heap[Rp] = size_r - trailing_zeroes

    return R
  }


--- Optimized code ---
optimization_id = 4
source_position = 5380
kind = OPTIMIZED_FUNCTION
name = subtract
stack_slots = 10
Instructions (size = 3384)
0x9c023aaf720     0  55             push rbp
0x9c023aaf721     1  4889e5         REX.W movq rbp,rsp
0x9c023aaf724     4  56             push rsi
0x9c023aaf725     5  57             push rdi
0x9c023aaf726     6  4883ec50       REX.W subq rsp,0x50
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x9c023aaf72a    10  488b45f8       REX.W movq rax,[rbp-0x8]    ;; debug: position 5380
                  ;;; <@3,#1> gap
0x9c023aaf72e    14  488945e8       REX.W movq [rbp-0x18],rax
                  ;;; <@12,#9> -------------------- B1 --------------------
                  ;;; <@13,#9> gap
0x9c023aaf732    18  488bf0         REX.W movq rsi,rax
                  ;;; <@14,#11> stack-check
0x9c023aaf735    21  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023aaf73c    28  7305           jnc 35  (0x9c023aaf743)
0x9c023aaf73e    30  e81d67f7ff     call StackCheck  (0x9c023a25e60)    ;; code: BUILTIN
                  ;;; <@16,#11> lazy-bailout
                  ;;; <@17,#11> gap
0x9c023aaf743    35  488b45e8       REX.W movq rax,[rbp-0x18]
                  ;;; <@18,#12> load-context-slot
0x9c023aaf747    39  488b981f010000 REX.W movq rbx,[rax+0x11f]    ;; debug: position 5404
                  ;;; <@20,#13> check-value
0x9c023aaf74e    46  49ba59f635064e360000 REX.W movq r10,0x364e0635f659    ;; object: 0x364e0635f659 <JS Function compare_abs (SharedFunctionInfo 0xc1217b4d931)>
0x9c023aaf758    56  493bda         REX.W cmpq rbx,r10
0x9c023aaf75b    59  0f850a0b0000   jnz 2891  (0x9c023ab026b)
                  ;;; <@21,#13> gap
0x9c023aaf761    65  488b5518       REX.W movq rdx,[rbp+0x18]
                  ;;; <@22,#777> check-smi
0x9c023aaf765    69  f6c201         testb rdx,0x1            ;; debug: position 12617
0x9c023aaf768    72  0f85020b0000   jnz 2896  (0x9c023ab0270)
                  ;;; <@23,#777> gap
0x9c023aaf76e    78  488b4d10       REX.W movq rcx,[rbp+0x10]
                  ;;; <@24,#781> check-smi
0x9c023aaf772    82  f6c101         testb rcx,0x1            ;; debug: position 12623
0x9c023aaf775    85  0f85fa0a0000   jnz 2901  (0x9c023ab0275)
                  ;;; <@27,#19> compare-numeric-and-branch
0x9c023aaf77b    91  483bd1         REX.W cmpq rdx,rcx       ;; debug: position 12619
0x9c023aaf77e    94  0f84a9010000   jz 525  (0x9c023aaf92d)
                  ;;; <@28,#23> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@32,#31> -------------------- B3 --------------------
                  ;;; <@34,#16> constant-t
0x9c023aaf784   100  48ba91ef35064e360000 REX.W movq rdx,0x364e0635ef91    ;; debug: position 12649
                                                             ;; debug: position 12600
                                                             ;; object: 0x364e0635ef91 <FixedArray[49]>
                  ;;; <@36,#32> load-context-slot
0x9c023aaf78e   110  488b929f000000 REX.W movq rdx,[rdx+0x9f]    ;; debug: position 12649
                  ;;; <@38,#33> check-non-smi
0x9c023aaf795   117  f6c201         testb rdx,0x1            ;; debug: position 12654
0x9c023aaf798   120  0f84dc0a0000   jz 2906  (0x9c023ab027a)
                  ;;; <@40,#34> check-maps
0x9c023aaf79e   126  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aaf7a8   136  4c3952ff       REX.W cmpq [rdx-0x1],r10
0x9c023aaf7ac   140  0f85cd0a0000   jnz 2911  (0x9c023ab027f)
                  ;;; <@42,#35> load-named-field
0x9c023aaf7b2   146  488b520f       REX.W movq rdx,[rdx+0xf]
                  ;;; <@44,#36> load-named-field
0x9c023aaf7b6   150  8b4a0b         movl rcx,[rdx+0xb]
                  ;;; <@46,#37> load-named-field
0x9c023aaf7b9   153  488b520f       REX.W movq rdx,[rdx+0xf]
                  ;;; <@47,#37> gap
0x9c023aaf7bd   157  488b7518       REX.W movq rsi,[rbp+0x18]
                  ;;; <@48,#776> tagged-to-i
0x9c023aaf7c1   161  40f6c601       testb rsi,0x1
0x9c023aaf7c5   165  0f8520070000   jnz 1995  (0x9c023aafeeb)
0x9c023aaf7cb   171  48c1ee20       REX.W shrq rsi,32
                  ;;; <@50,#38> bounds-check
0x9c023aaf7cf   175  3bce           cmpl rcx,rsi
0x9c023aaf7d1   177  0f86ad0a0000   jna 2916  (0x9c023ab0284)
                  ;;; <@52,#39> load-keyed
0x9c023aaf7d7   183  8b34b2         movl rsi,[rdx+rsi*4]
0x9c023aaf7da   186  85f6           testl rsi,rsi
0x9c023aaf7dc   188  0f88a70a0000   js 2921  (0x9c023ab0289)
                  ;;; <@53,#39> gap
0x9c023aaf7e2   194  488b7d10       REX.W movq rdi,[rbp+0x10]
                  ;;; <@54,#780> tagged-to-i
0x9c023aaf7e6   198  40f6c701       testb rdi,0x1            ;; debug: position 12675
0x9c023aaf7ea   202  0f852c070000   jnz 2044  (0x9c023aaff1c)
0x9c023aaf7f0   208  48c1ef20       REX.W shrq rdi,32
                  ;;; <@56,#47> bounds-check
0x9c023aaf7f4   212  3bcf           cmpl rcx,rdi
0x9c023aaf7f6   214  0f86920a0000   jna 2926  (0x9c023ab028e)
                  ;;; <@58,#48> load-keyed
0x9c023aaf7fc   220  8b0cba         movl rcx,[rdx+rdi*4]
0x9c023aaf7ff   223  85c9           testl rcx,rcx
0x9c023aaf801   225  0f888c0a0000   js 2931  (0x9c023ab0293)
                  ;;; <@60,#16> constant-t
0x9c023aaf807   231  48ba91ef35064e360000 REX.W movq rdx,0x364e0635ef91    ;; debug: position 12600
                                                             ;; object: 0x364e0635ef91 <FixedArray[49]>
                  ;;; <@62,#50> load-context-slot
0x9c023aaf811   241  488b9297000000 REX.W movq rdx,[rdx+0x97]    ;; debug: position 12696
                  ;;; <@64,#52> check-non-smi
0x9c023aaf818   248  f6c201         testb rdx,0x1            ;; debug: position 12701
0x9c023aaf81b   251  0f84770a0000   jz 2936  (0x9c023ab0298)
                  ;;; <@66,#53> check-maps
0x9c023aaf821   257  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aaf82b   267  4c3952ff       REX.W cmpq [rdx-0x1],r10
0x9c023aaf82f   271  0f85680a0000   jnz 2941  (0x9c023ab029d)
                  ;;; <@68,#54> load-named-field
0x9c023aaf835   277  488b7a0f       REX.W movq rdi,[rdx+0xf]
                  ;;; <@70,#55> load-named-field
0x9c023aaf839   281  448b470b       movl r8,[rdi+0xb]
                  ;;; <@72,#56> load-named-field
0x9c023aaf83d   285  488b7f0f       REX.W movq rdi,[rdi+0xf]
                  ;;; <@74,#57> bounds-check
0x9c023aaf841   289  443bc6         cmpl r8,rsi
0x9c023aaf844   292  0f86580a0000   jna 2946  (0x9c023ab02a2)
                  ;;; <@76,#58> load-keyed
0x9c023aaf84a   298  448b0cb7       movl r9,[rdi+rsi*4]
0x9c023aaf84e   302  4585c9         testl r9,r9
0x9c023aaf851   305  0f88500a0000   js 2951  (0x9c023ab02a7)
                  ;;; <@78,#67> bounds-check
0x9c023aaf857   311  443bc1         cmpl r8,rcx              ;; debug: position 12727
0x9c023aaf85a   314  0f864c0a0000   jna 2956  (0x9c023ab02ac)
                  ;;; <@80,#68> load-keyed
0x9c023aaf860   320  448b1c8f       movl r11,[rdi+rcx*4]
0x9c023aaf864   324  4585db         testl r11,r11
0x9c023aaf867   327  0f88440a0000   js 2961  (0x9c023ab02b1)
                  ;;; <@83,#72> compare-numeric-and-branch
0x9c023aaf86d   333  453bcb         cmpl r9,r11              ;; debug: position 12748
0x9c023aaf870   336  0f8cad000000   jl 515  (0x9c023aaf923)
                  ;;; <@84,#76> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@88,#85> -------------------- B5 --------------------
                  ;;; <@91,#88> compare-numeric-and-branch
0x9c023aaf876   342  453bd9         cmpl r11,r9              ;; debug: position 12793
                                                             ;; debug: position 12800
0x9c023aaf879   345  0f8c9a000000   jl 505  (0x9c023aaf919)
                  ;;; <@92,#92> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@96,#100> -------------------- B7 --------------------
                  ;;; <@97,#100> gap
0x9c023aaf87f   351  4d8bf1         REX.W movq r14,r9        ;; debug: position 12861
                  ;;; <@98,#103> sub-i
0x9c023aaf882   354  4183ee01       subl r14,0x1             ;; debug: position 12868
0x9c023aaf886   358  0f802a0a0000   jo 2966  (0x9c023ab02b6)
                  ;;; <@102,#117> -------------------- B8 (loop header) --------------------
                  ;;; <@105,#120> compare-numeric-and-branch
0x9c023aaf88c   364  4183fe01       cmpl r14,0x1             ;; debug: position 12873
                                                             ;; debug: position 12875
0x9c023aaf890   368  0f8e7c000000   jle 498  (0x9c023aaf912)
                  ;;; <@106,#121> -------------------- B9 (unreachable/replaced) --------------------
                  ;;; <@110,#127> -------------------- B10 --------------------
                  ;;; <@112,#129> stack-check
0x9c023aaf896   374  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023aaf89d   381  0f82aa060000   jc 2093  (0x9c023aaff4d)
                  ;;; <@113,#129> gap
0x9c023aaf8a3   387  4c8bce         REX.W movq r9,rsi
                  ;;; <@114,#133> add-i
0x9c023aaf8a6   390  4503ce         addl r9,r14              ;; debug: position 12909
0x9c023aaf8a9   393  0f800c0a0000   jo 2971  (0x9c023ab02bb)
                  ;;; <@116,#140> bounds-check
0x9c023aaf8af   399  453bc1         cmpl r8,r9
0x9c023aaf8b2   402  0f86080a0000   jna 2976  (0x9c023ab02c0)
                  ;;; <@118,#141> load-keyed
0x9c023aaf8b8   408  468b0c8f       movl r9,[rdi+r9*4]
0x9c023aaf8bc   412  4585c9         testl r9,r9
0x9c023aaf8bf   415  0f88000a0000   js 2981  (0x9c023ab02c5)
                  ;;; <@119,#141> gap
0x9c023aaf8c5   421  4c8bf9         REX.W movq r15,rcx
                  ;;; <@120,#145> add-i
0x9c023aaf8c8   424  4503fe         addl r15,r14             ;; debug: position 12924
0x9c023aaf8cb   427  0f80f9090000   jo 2986  (0x9c023ab02ca)
                  ;;; <@122,#152> bounds-check
0x9c023aaf8d1   433  453bc7         cmpl r8,r15
0x9c023aaf8d4   436  0f86f5090000   jna 2991  (0x9c023ab02cf)
                  ;;; <@124,#153> load-keyed
0x9c023aaf8da   442  428b04bf       movl rax,[rdi+r15*4]
0x9c023aaf8de   446  85c0           testl rax,rax
0x9c023aaf8e0   448  0f88ee090000   js 2996  (0x9c023ab02d4)
                  ;;; <@127,#154> compare-numeric-and-branch
0x9c023aaf8e6   454  443bc8         cmpl r9,rax              ;; debug: position 12914
0x9c023aaf8e9   457  0f8c0f000000   jl 478  (0x9c023aaf8fe)
                  ;;; <@128,#158> -------------------- B11 (unreachable/replaced) --------------------
                  ;;; <@132,#166> -------------------- B12 --------------------
                  ;;; <@135,#191> compare-numeric-and-branch
0x9c023aaf8ef   463  443bc8         cmpl r9,rax              ;; debug: position 12973
                                                             ;; debug: position 12986
0x9c023aaf8f2   466  0f8f10000000   jg 488  (0x9c023aaf908)
                  ;;; <@136,#195> -------------------- B13 (unreachable/replaced) --------------------
                  ;;; <@140,#203> -------------------- B14 --------------------
                  ;;; <@142,#206> add-i
0x9c023aaf8f8   472  4183c6ff       addl r14,0xff            ;; debug: position 12880
                  ;;; <@145,#209> goto
0x9c023aaf8fc   476  eb8e           jmp 364  (0x9c023aaf88c)
                  ;;; <@146,#155> -------------------- B15 (unreachable/replaced) --------------------
                  ;;; <@150,#161> -------------------- B16 --------------------
                  ;;; <@152,#165> gap
0x9c023aaf8fe   478  b8ffffffff     movl rax,0xffffffff      ;; debug: position 12950
                  ;;; <@153,#165> goto
0x9c023aaf903   483  e927000000     jmp 527  (0x9c023aaf92f)
                  ;;; <@154,#192> -------------------- B17 (unreachable/replaced) --------------------
                  ;;; <@158,#198> -------------------- B18 --------------------
                  ;;; <@160,#202> gap
0x9c023aaf908   488  b801000000     movl rax,0x1             ;; debug: position 13022
                  ;;; <@161,#202> goto
0x9c023aaf90d   493  e91d000000     jmp 527  (0x9c023aaf92f)
                  ;;; <@162,#124> -------------------- B19 (unreachable/replaced) --------------------
                  ;;; <@166,#210> -------------------- B20 --------------------
                  ;;; <@168,#214> gap
0x9c023aaf912   498  33c0           xorl rax,rax             ;; debug: position 13055
                  ;;; <@169,#214> goto
0x9c023aaf914   500  e916000000     jmp 527  (0x9c023aaf92f)
                  ;;; <@170,#89> -------------------- B21 (unreachable/replaced) --------------------
                  ;;; <@174,#95> -------------------- B22 --------------------
                  ;;; <@176,#99> gap
0x9c023aaf919   505  b801000000     movl rax,0x1             ;; debug: position 12826
                  ;;; <@177,#99> goto
0x9c023aaf91e   510  e90c000000     jmp 527  (0x9c023aaf92f)
                  ;;; <@178,#73> -------------------- B23 (unreachable/replaced) --------------------
                  ;;; <@182,#79> -------------------- B24 --------------------
                  ;;; <@184,#83> gap
0x9c023aaf923   515  b8ffffffff     movl rax,0xffffffff      ;; debug: position 12774
                  ;;; <@185,#83> goto
0x9c023aaf928   520  e902000000     jmp 527  (0x9c023aaf92f)
                  ;;; <@186,#20> -------------------- B25 (unreachable/replaced) --------------------
                  ;;; <@190,#26> -------------------- B26 --------------------
                  ;;; <@192,#30> gap
0x9c023aaf92d   525  33c0           xorl rax,rax             ;; debug: position 12634
                  ;;; <@194,#215> -------------------- B27 --------------------
0x9c023aaf92f   527  488945e0       REX.W movq [rbp-0x20],rax    ;; debug: position 5419
                  ;;; <@197,#219> compare-numeric-and-branch
0x9c023aaf933   531  83f800         cmpl rax,0x0             ;; debug: position 5436
0x9c023aaf936   534  0f849d050000   jz 1977  (0x9c023aafed9)
                  ;;; <@198,#223> -------------------- B28 (unreachable/replaced) --------------------
                  ;;; <@202,#230> -------------------- B29 --------------------
                  ;;; <@205,#233> compare-numeric-and-branch
0x9c023aaf93c   540  83f800         cmpl rax,0x0             ;; debug: position 5480
                                                             ;; debug: position 5485
0x9c023aaf93f   543  0f8c2a000000   jl 591  (0x9c023aaf96f)
                  ;;; <@206,#237> -------------------- B30 (unreachable/replaced) --------------------
                  ;;; <@210,#245> -------------------- B31 --------------------
                  ;;; <@211,#245> gap
0x9c023aaf945   549  488b5d18       REX.W movq rbx,[rbp+0x18]    ;; debug: position 5531
                  ;;; <@212,#775> tagged-to-i
0x9c023aaf949   553  f6c301         testb rbx,0x1            ;; debug: position 5557
0x9c023aaf94c   556  0f853c060000   jnz 2158  (0x9c023aaff8e)
0x9c023aaf952   562  48c1eb20       REX.W shrq rbx,32
                  ;;; <@213,#775> gap
0x9c023aaf956   566  488b5510       REX.W movq rdx,[rbp+0x10]
                  ;;; <@214,#778> tagged-to-i
0x9c023aaf95a   570  f6c201         testb rdx,0x1
0x9c023aaf95d   573  0f855c060000   jnz 2207  (0x9c023aaffbf)
0x9c023aaf963   579  48c1ea20       REX.W shrq rdx,32
                  ;;; <@216,#247> gap
0x9c023aaf967   583  4887d3         REX.W xchgq rdx,rbx      ;; debug: position 5531
                  ;;; <@217,#247> goto
0x9c023aaf96a   586  e922000000     jmp 625  (0x9c023aaf991)
                  ;;; <@218,#234> -------------------- B32 (unreachable/replaced) --------------------
                  ;;; <@222,#240> -------------------- B33 --------------------
                  ;;; <@223,#240> gap
0x9c023aaf96f   591  488b5d18       REX.W movq rbx,[rbp+0x18]    ;; debug: position 5507
                  ;;; <@224,#774> tagged-to-i
0x9c023aaf973   595  f6c301         testb rbx,0x1            ;; debug: position 5557
0x9c023aaf976   598  0f8574060000   jnz 2256  (0x9c023aafff0)
0x9c023aaf97c   604  48c1eb20       REX.W shrq rbx,32
                  ;;; <@225,#774> gap
0x9c023aaf980   608  488b5510       REX.W movq rdx,[rbp+0x10]
                  ;;; <@226,#779> tagged-to-i
0x9c023aaf984   612  f6c201         testb rdx,0x1
0x9c023aaf987   615  0f8594060000   jnz 2305  (0x9c023ab0021)
0x9c023aaf98d   621  48c1ea20       REX.W shrq rdx,32
                  ;;; <@230,#251> -------------------- B34 --------------------
0x9c023aaf991   625  488955d0       REX.W movq [rbp-0x30],rdx    ;; debug: position 5531
                                                             ;; debug: position 5557
0x9c023aaf995   629  48895dd8       REX.W movq [rbp-0x28],rbx
                  ;;; <@231,#251> gap
0x9c023aaf999   633  488b4de8       REX.W movq rcx,[rbp-0x18]
                  ;;; <@232,#252> load-context-slot
0x9c023aaf99d   637  488bb197000000 REX.W movq rsi,[rcx+0x97]
                  ;;; <@234,#253> load-context-slot
0x9c023aaf9a4   644  488bb99f000000 REX.W movq rdi,[rcx+0x9f]    ;; debug: position 5562
                  ;;; <@236,#254> check-non-smi
0x9c023aaf9ab   651  40f6c701       testb rdi,0x1            ;; debug: position 5567
0x9c023aaf9af   655  0f8424090000   jz 3001  (0x9c023ab02d9)
                  ;;; <@238,#255> check-maps
0x9c023aaf9b5   661  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aaf9bf   671  4c3957ff       REX.W cmpq [rdi-0x1],r10
0x9c023aaf9c3   675  0f8515090000   jnz 3006  (0x9c023ab02de)
                  ;;; <@240,#256> load-named-field
0x9c023aaf9c9   681  488b7f0f       REX.W movq rdi,[rdi+0xf]
                  ;;; <@242,#257> load-named-field
0x9c023aaf9cd   685  448b470b       movl r8,[rdi+0xb]
                  ;;; <@244,#258> load-named-field
0x9c023aaf9d1   689  488b7f0f       REX.W movq rdi,[rdi+0xf]
                  ;;; <@246,#259> bounds-check
0x9c023aaf9d5   693  443bc2         cmpl r8,rdx
0x9c023aaf9d8   696  0f8605090000   jna 3011  (0x9c023ab02e3)
                  ;;; <@248,#260> load-keyed
0x9c023aaf9de   702  448b0497       movl r8,[rdi+rdx*4]
0x9c023aaf9e2   706  4585c0         testl r8,r8
0x9c023aaf9e5   709  0f88fd080000   js 3016  (0x9c023ab02e8)
                  ;;; <@250,#261> check-non-smi
0x9c023aaf9eb   715  40f6c601       testb rsi,0x1
0x9c023aaf9ef   719  0f84f8080000   jz 3021  (0x9c023ab02ed)
                  ;;; <@252,#262> check-maps
0x9c023aaf9f5   725  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aaf9ff   735  4c3956ff       REX.W cmpq [rsi-0x1],r10
0x9c023aafa03   739  0f85e9080000   jnz 3026  (0x9c023ab02f2)
                  ;;; <@254,#263> load-named-field
0x9c023aafa09   745  488b760f       REX.W movq rsi,[rsi+0xf]
                  ;;; <@256,#264> load-named-field
0x9c023aafa0d   749  8b7e0b         movl rdi,[rsi+0xb]
                  ;;; <@258,#265> load-named-field
0x9c023aafa10   752  488b760f       REX.W movq rsi,[rsi+0xf]
                  ;;; <@260,#266> bounds-check
0x9c023aafa14   756  413bf8         cmpl rdi,r8
0x9c023aafa17   759  0f86da080000   jna 3031  (0x9c023ab02f7)
                  ;;; <@262,#267> load-keyed
0x9c023aafa1d   765  468b0486       movl r8,[rsi+r8*4]
0x9c023aafa21   769  4585c0         testl r8,r8
0x9c023aafa24   772  0f88d2080000   js 3036  (0x9c023ab02fc)
                  ;;; <@263,#267> gap
0x9c023aafa2a   778  4c8945c8       REX.W movq [rbp-0x38],r8
                  ;;; <@264,#269> load-context-slot
0x9c023aafa2e   782  4c8b89af000000 REX.W movq r9,[rcx+0xaf]    ;; debug: position 5584
                  ;;; <@265,#269> gap
0x9c023aafa35   789  4c894dc0       REX.W movq [rbp-0x40],r9
                  ;;; <@266,#270> check-value
0x9c023aafa39   793  49baa1fc35064e360000 REX.W movq r10,0x364e0635fca1    ;; object: 0x364e0635fca1 <JS Function alloc (SharedFunctionInfo 0xc1217b4f389)>
0x9c023aafa43   803  4d3bca         REX.W cmpq r9,r10
0x9c023aafa46   806  0f85b5080000   jnz 3041  (0x9c023ab0301)
                  ;;; <@268,#273> constant-t
0x9c023aafa4c   812  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@270,#276> load-context-slot
0x9c023aafa56   822  488b7637       REX.W movq rsi,[rsi+0x37]    ;; debug: position 2205
                  ;;; <@272,#783> tagged-to-i
0x9c023aafa5a   826  40f6c601       testb rsi,0x1
0x9c023aafa5e   830  0f85ee050000   jnz 2354  (0x9c023ab0052)
0x9c023aafa64   836  48c1ee20       REX.W shrq rsi,32
                  ;;; <@275,#277> compare-numeric-and-branch
0x9c023aafa68   840  443bc6         cmpl r8,rsi              ;; debug: position 2203
0x9c023aafa6b   843  0f8e31000000   jle 898  (0x9c023aafaa2)
                  ;;; <@276,#281> -------------------- B35 (unreachable/replaced) --------------------
                  ;;; <@280,#292> -------------------- B36 (unreachable/replaced) --------------------
                  ;;; <@284,#278> -------------------- B37 (unreachable/replaced) --------------------
                  ;;; <@288,#284> -------------------- B38 --------------------
                  ;;; <@290,#273> constant-t
0x9c023aafa71   849  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2229
                                                             ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@292,#285> load-context-slot
0x9c023aafa7b   859  488b7e4f       REX.W movq rdi,[rsi+0x4f]    ;; debug: position 2229
                  ;;; <@294,#286> push-argument
0x9c023aafa7f   863  49ba214130064e360000 REX.W movq r10,0x364e06304121    ;; debug: position 2236
                                                             ;; object: 0x364e06304121 <undefined>
0x9c023aafa89   873  4152           push r10
                  ;;; <@296,#782> smi-tag
0x9c023aafa8b   875  418bf0         movl rsi,r8
0x9c023aafa8e   878  48c1e620       REX.W shlq rsi,32
                  ;;; <@298,#287> push-argument
0x9c023aafa92   882  56             push rsi
                  ;;; <@300,#273> constant-t
0x9c023aafa93   883  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@302,#288> call-function
0x9c023aafa9d   893  e87e92f7ff     call 0x9c023a28d20       ;; debug: position 2236
                                                             ;; code: STUB, CallFunctionStub, argc = 1
                  ;;; <@304,#289> lazy-bailout
                  ;;; <@308,#295> -------------------- B39 --------------------
                  ;;; <@310,#273> constant-t
0x9c023aafaa2   898  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2258
                                                             ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@312,#296> load-context-slot
0x9c023aafaac   908  488b4637       REX.W movq rax,[rsi+0x37]    ;; debug: position 2258
                  ;;; <@314,#784> tagged-to-i
0x9c023aafab0   912  a801           test al,0x1
0x9c023aafab2   914  0f85cb050000   jnz 2403  (0x9c023ab0083)
0x9c023aafab8   920  48c1e820       REX.W shrq rax,32
                  ;;; <@316,#297> sub-i
0x9c023aafabc   924  2b45c8         subl rax,[rbp-0x38]      ;; debug: position 2271
0x9c023aafabf   927  0f8041080000   jo 3046  (0x9c023ab0306)
                  ;;; <@318,#785> smi-tag
0x9c023aafac5   933  8bd8           movl rbx,rax
0x9c023aafac7   935  48c1e320       REX.W shlq rbx,32
                  ;;; <@320,#273> constant-t
0x9c023aafacb   939  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@322,#299> store-context-slot
0x9c023aafad5   949  48895e37       REX.W movq [rsi+0x37],rbx    ;; debug: position 2271
                  ;;; <@324,#273> constant-t
0x9c023aafad9   953  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@326,#301> load-context-slot
0x9c023aafae3   963  488b5e3f       REX.W movq rbx,[rsi+0x3f]    ;; debug: position 2378
                  ;;; <@327,#301> gap
0x9c023aafae7   967  488bd3         REX.W movq rdx,rbx
                  ;;; <@328,#788> tagged-to-i
0x9c023aafaea   970  f6c201         testb rdx,0x1            ;; debug: position 2394
0x9c023aafaed   973  0f85ce050000   jnz 2465  (0x9c023ab00c1)
0x9c023aafaf3   979  48c1ea20       REX.W shrq rdx,32
                  ;;; <@329,#788> gap
0x9c023aafaf7   983  488bca         REX.W movq rcx,rdx
                  ;;; <@330,#304> add-i
0x9c023aafafa   986  034dc8         addl rcx,[rbp-0x38]      ;; debug: position 2398
0x9c023aafafd   989  0f8008080000   jo 3051  (0x9c023ab030b)
                  ;;; <@332,#789> smi-tag
0x9c023aafb03   995  8bc1           movl rax,rcx
0x9c023aafb05   997  48c1e020       REX.W shlq rax,32
                  ;;; <@334,#273> constant-t
0x9c023aafb09  1001  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@336,#306> store-context-slot
0x9c023aafb13  1011  4889463f       REX.W movq [rsi+0x3f],rax    ;; debug: position 2398
                  ;;; <@338,#273> constant-t
0x9c023aafb17  1015  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@340,#308> load-context-slot
0x9c023aafb21  1025  488b4647       REX.W movq rax,[rsi+0x47]    ;; debug: position 2484
                  ;;; <@342,#790> tagged-to-i
0x9c023aafb25  1029  a801           test al,0x1
0x9c023aafb27  1031  0f85d2050000   jnz 2527  (0x9c023ab00ff)
0x9c023aafb2d  1037  48c1e820       REX.W shrq rax,32
                  ;;; <@343,#790> gap
0x9c023aafb31  1041  488945b8       REX.W movq [rbp-0x48],rax
0x9c023aafb35  1045  488bf8         REX.W movq rdi,rax
                  ;;; <@344,#311> add-i
0x9c023aafb38  1048  83c701         addl rdi,0x1
0x9c023aafb3b  1051  0f80cf070000   jo 3056  (0x9c023ab0310)
                  ;;; <@346,#792> smi-tag
0x9c023aafb41  1057  8bcf           movl rcx,rdi
0x9c023aafb43  1059  48c1e120       REX.W shlq rcx,32
                  ;;; <@348,#273> constant-t
0x9c023aafb47  1063  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@350,#312> store-context-slot
0x9c023aafb51  1073  48894e47       REX.W movq [rsi+0x47],rcx    ;; debug: position 2484
                  ;;; <@352,#273> constant-t
0x9c023aafb55  1077  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@354,#315> load-named-field
0x9c023aafb5f  1087  488b4e17       REX.W movq rcx,[rsi+0x17]    ;; debug: position 2497
                  ;;; <@356,#316> load-context-slot
0x9c023aafb63  1091  488bb19f000000 REX.W movq rsi,[rcx+0x9f]
                  ;;; <@358,#319> check-non-smi
0x9c023aafb6a  1098  40f6c601       testb rsi,0x1            ;; debug: position 2513
0x9c023aafb6e  1102  0f84a1070000   jz 3061  (0x9c023ab0315)
                  ;;; <@360,#320> check-maps
0x9c023aafb74  1108  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aafb7e  1118  4c3956ff       REX.W cmpq [rsi-0x1],r10
0x9c023aafb82  1122  0f8592070000   jnz 3066  (0x9c023ab031a)
                  ;;; <@362,#322> check-maps
                  ;;; <@364,#324> check-maps
                  ;;; <@366,#325> load-named-field
0x9c023aafb88  1128  488b760f       REX.W movq rsi,[rsi+0xf]
                  ;;; <@368,#326> load-named-field
0x9c023aafb8c  1132  448b460b       movl r8,[rsi+0xb]
                  ;;; <@370,#327> load-named-field
0x9c023aafb90  1136  488b760f       REX.W movq rsi,[rsi+0xf]
                  ;;; <@372,#328> bounds-check
0x9c023aafb94  1140  443bc0         cmpl r8,rax
0x9c023aafb97  1143  0f8682070000   jna 3071  (0x9c023ab031f)
                  ;;; <@373,#328> gap
0x9c023aafb9d  1149  4c8bc3         REX.W movq r8,rbx
                  ;;; <@374,#787> tagged-to-i
0x9c023aafba0  1152  41f6c001       testb r8,0x1
0x9c023aafba4  1156  0f8593050000   jnz 2589  (0x9c023ab013d)
0x9c023aafbaa  1162  49c1e820       REX.W shrq r8,32
                  ;;; <@376,#329> store-keyed
0x9c023aafbae  1166  44890486       movl [rsi+rax*4],r8
                  ;;; <@378,#332> load-context-slot
0x9c023aafbb2  1170  488b8997000000 REX.W movq rcx,[rcx+0x97]    ;; debug: position 2528
                  ;;; <@380,#334> check-non-smi
0x9c023aafbb9  1177  f6c101         testb rcx,0x1            ;; debug: position 2545
0x9c023aafbbc  1180  0f8462070000   jz 3076  (0x9c023ab0324)
                  ;;; <@382,#335> check-maps
0x9c023aafbc2  1186  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aafbcc  1196  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023aafbd0  1200  0f8553070000   jnz 3081  (0x9c023ab0329)
                  ;;; <@384,#340> load-named-field
0x9c023aafbd6  1206  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@386,#341> load-named-field
0x9c023aafbda  1210  8b710b         movl rsi,[rcx+0xb]
                  ;;; <@388,#342> load-named-field
0x9c023aafbdd  1213  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@390,#343> bounds-check
0x9c023aafbe1  1217  3bf2           cmpl rsi,rdx
0x9c023aafbe3  1219  0f8645070000   jna 3086  (0x9c023ab032e)
                  ;;; <@391,#343> gap
0x9c023aafbe9  1225  488b5dc8       REX.W movq rbx,[rbp-0x38]
                  ;;; <@392,#344> store-keyed
0x9c023aafbed  1229  891c91         movl [rcx+rdx*4],rbx
                  ;;; <@396,#350> -------------------- B40 --------------------
                  ;;; <@397,#350> gap
0x9c023aafbf0  1232  488b55e8       REX.W movq rdx,[rbp-0x18]    ;; debug: position 2565
                                                             ;; debug: position 5590
                  ;;; <@398,#352> load-context-slot
0x9c023aafbf4  1236  488b8a9f000000 REX.W movq rcx,[rdx+0x9f]    ;; debug: position 5611
                  ;;; <@400,#354> check-non-smi
0x9c023aafbfb  1243  f6c101         testb rcx,0x1            ;; debug: position 5616
0x9c023aafbfe  1246  0f842f070000   jz 3091  (0x9c023ab0333)
                  ;;; <@402,#355> check-maps
0x9c023aafc04  1252  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aafc0e  1262  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023aafc12  1266  0f8520070000   jnz 3096  (0x9c023ab0338)
                  ;;; <@404,#356> load-named-field
0x9c023aafc18  1272  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@406,#357> load-named-field
0x9c023aafc1c  1276  8b710b         movl rsi,[rcx+0xb]
                  ;;; <@408,#358> load-named-field
0x9c023aafc1f  1279  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@410,#359> bounds-check
0x9c023aafc23  1283  3bf0           cmpl rsi,rax
0x9c023aafc25  1285  0f8612070000   jna 3101  (0x9c023ab033d)
                  ;;; <@412,#360> load-keyed
0x9c023aafc2b  1291  8b3c81         movl rdi,[rcx+rax*4]
0x9c023aafc2e  1294  85ff           testl rdi,rdi
0x9c023aafc30  1296  0f880c070000   js 3106  (0x9c023ab0342)
0x9c023aafc36  1302  4863ff         REX.W movsxlq rdi,rdi
                  ;;; <@413,#360> gap
0x9c023aafc39  1305  48897da0       REX.W movq [rbp-0x60],rdi
0x9c023aafc3d  1309  4c8b45d0       REX.W movq r8,[rbp-0x30]
                  ;;; <@414,#368> bounds-check
0x9c023aafc41  1313  413bf0         cmpl rsi,r8              ;; debug: position 5638
0x9c023aafc44  1316  0f86fd060000   jna 3111  (0x9c023ab0347)
                  ;;; <@416,#369> load-keyed
0x9c023aafc4a  1322  468b0c81       movl r9,[rcx+r8*4]
0x9c023aafc4e  1326  4585c9         testl r9,r9
0x9c023aafc51  1329  0f88f5060000   js 3116  (0x9c023ab034c)
                  ;;; <@417,#369> gap
0x9c023aafc57  1335  4c8b5dd8       REX.W movq r11,[rbp-0x28]
                  ;;; <@418,#377> bounds-check
0x9c023aafc5b  1339  413bf3         cmpl rsi,r11             ;; debug: position 5659
0x9c023aafc5e  1342  0f86ed060000   jna 3121  (0x9c023ab0351)
                  ;;; <@420,#378> load-keyed
0x9c023aafc64  1348  428b3499       movl rsi,[rcx+r11*4]
0x9c023aafc68  1352  85f6           testl rsi,rsi
0x9c023aafc6a  1354  0f88e6060000   js 3126  (0x9c023ab0356)
                  ;;; <@422,#380> load-context-slot
0x9c023aafc70  1360  488b8a97000000 REX.W movq rcx,[rdx+0x97]    ;; debug: position 5680
                  ;;; <@423,#380> gap
0x9c023aafc77  1367  48894db0       REX.W movq [rbp-0x50],rcx
                  ;;; <@424,#382> check-non-smi
0x9c023aafc7b  1371  f6c101         testb rcx,0x1            ;; debug: position 5685
0x9c023aafc7e  1374  0f84d7060000   jz 3131  (0x9c023ab035b)
                  ;;; <@426,#383> check-maps
0x9c023aafc84  1380  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023aafc8e  1390  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023aafc92  1394  0f85c8060000   jnz 3136  (0x9c023ab0360)
                  ;;; <@428,#384> load-named-field
0x9c023aafc98  1400  4c8b710f       REX.W movq r14,[rcx+0xf]
                  ;;; <@430,#385> load-named-field
0x9c023aafc9c  1404  458b7e0b       movl r15,[r14+0xb]
                  ;;; <@432,#386> load-named-field
0x9c023aafca0  1408  4d8b760f       REX.W movq r14,[r14+0xf]
                  ;;; <@434,#387> bounds-check
0x9c023aafca4  1412  453bf9         cmpl r15,r9
0x9c023aafca7  1415  0f86b8060000   jna 3141  (0x9c023ab0365)
                  ;;; <@436,#388> load-keyed
0x9c023aafcad  1421  438b148e       movl rdx,[r14+r9*4]
0x9c023aafcb1  1425  85d2           testl rdx,rdx
0x9c023aafcb3  1427  0f88b1060000   js 3146  (0x9c023ab036a)
                  ;;; <@438,#397> bounds-check
0x9c023aafcb9  1433  443bfe         cmpl r15,rsi             ;; debug: position 5711
0x9c023aafcbc  1436  0f86ad060000   jna 3151  (0x9c023ab036f)
                  ;;; <@440,#398> load-keyed
0x9c023aafcc2  1442  418b04b6       movl rax,[r14+rsi*4]
0x9c023aafcc6  1446  85c0           testl rax,rax
0x9c023aafcc8  1448  0f88a6060000   js 3156  (0x9c023ab0374)
                  ;;; <@441,#398> gap
0x9c023aafcce  1454  488bcf         REX.W movq rcx,rdi
                  ;;; <@442,#403> add-i
0x9c023aafcd1  1457  83c101         addl rcx,0x1             ;; debug: position 5728
0x9c023aafcd4  1460  0f809f060000   jo 3161  (0x9c023ab0379)
                  ;;; <@444,#415> bounds-check
0x9c023aafcda  1466  443bf9         cmpl r15,rcx             ;; debug: position 5735
0x9c023aafcdd  1469  0f869b060000   jna 3166  (0x9c023ab037e)
                  ;;; <@446,#218> constant-i
0x9c023aafce3  1475  33c9           xorl rcx,rcx             ;; debug: position 5440
                  ;;; <@448,#416> store-keyed
0x9c023aafce5  1477  41894cbe04     movl [r14+rdi*4+0x4],rcx    ;; debug: position 5735
                  ;;; <@450,#442> gap
0x9c023aafcea  1482  48c745a800000000 REX.W movq [rbp-0x58],0x0    ;; debug: position 5805
0x9c023aafcf2  1490  b902000000     movl rcx,0x2
                  ;;; <@452,#443> -------------------- B41 (loop header) --------------------
                  ;;; <@455,#446> compare-numeric-and-branch
0x9c023aafcf7  1495  3bc8           cmpl rcx,rax             ;; debug: position 5808
                                                             ;; debug: position 5810
0x9c023aafcf9  1497  0f8dae000000   jge 1677  (0x9c023aafdad)
                  ;;; <@456,#447> -------------------- B42 (unreachable/replaced) --------------------
                  ;;; <@460,#453> -------------------- B43 --------------------
                  ;;; <@462,#455> stack-check
0x9c023aafcff  1503  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023aafd06  1510  0f829c040000   jc 2696  (0x9c023ab01a8)
                  ;;; <@463,#455> gap
0x9c023aafd0c  1516  4d8bc1         REX.W movq r8,r9
                  ;;; <@464,#459> add-i
0x9c023aafd0f  1519  4403c1         addl r8,rcx              ;; debug: position 5847
0x9c023aafd12  1522  0f806b060000   jo 3171  (0x9c023ab0383)
                  ;;; <@466,#466> bounds-check
0x9c023aafd18  1528  453bf8         cmpl r15,r8
0x9c023aafd1b  1531  0f8667060000   jna 3176  (0x9c023ab0388)
                  ;;; <@468,#467> load-keyed
0x9c023aafd21  1537  478b0486       movl r8,[r14+r8*4]
0x9c023aafd25  1541  4585c0         testl r8,r8
0x9c023aafd28  1544  0f885f060000   js 3181  (0x9c023ab038d)
                  ;;; <@469,#467> gap
0x9c023aafd2e  1550  4c8bde         REX.W movq r11,rsi
                  ;;; <@470,#471> add-i
0x9c023aafd31  1553  4403d9         addl r11,rcx             ;; debug: position 5862
0x9c023aafd34  1556  0f8058060000   jo 3186  (0x9c023ab0392)
                  ;;; <@472,#478> bounds-check
0x9c023aafd3a  1562  453bfb         cmpl r15,r11
0x9c023aafd3d  1565  0f8654060000   jna 3191  (0x9c023ab0397)
                  ;;; <@474,#479> load-keyed
0x9c023aafd43  1571  478b1c9e       movl r11,[r14+r11*4]
0x9c023aafd47  1575  4585db         testl r11,r11
0x9c023aafd4a  1578  0f884c060000   js 3196  (0x9c023ab039c)
                  ;;; <@476,#480> sub-i
0x9c023aafd50  1584  452bc3         subl r8,r11              ;; debug: position 5852
0x9c023aafd53  1587  0f8048060000   jo 3201  (0x9c023ab03a1)
                  ;;; <@478,#483> sub-i
0x9c023aafd59  1593  442b45a8       subl r8,[rbp-0x58]       ;; debug: position 5867
0x9c023aafd5d  1597  0f8043060000   jo 3206  (0x9c023ab03a6)
                  ;;; <@481,#488> compare-numeric-and-branch
0x9c023aafd63  1603  4183f800       cmpl r8,0x0              ;; debug: position 5888
0x9c023aafd67  1607  0f8c0b000000   jl 1624  (0x9c023aafd78)
                  ;;; <@482,#492> -------------------- B44 (unreachable/replaced) --------------------
                  ;;; <@486,#503> -------------------- B45 --------------------
                  ;;; <@488,#509> gap
0x9c023aafd6d  1613  4d8bd8         REX.W movq r11,r8        ;; debug: position 5968
0x9c023aafd70  1616  4533c0         xorl r8,r8
                  ;;; <@489,#509> goto
0x9c023aafd73  1619  e910000000     jmp 1640  (0x9c023aafd88)
                  ;;; <@490,#489> -------------------- B46 (unreachable/replaced) --------------------
                  ;;; <@494,#495> -------------------- B47 --------------------
                  ;;; <@496,#498> add-i
0x9c023aafd78  1624  4181c000000004 addl r8,0x4000000        ;; debug: position 5904
                                                             ;; debug: position 5907
                  ;;; <@498,#507> gap
0x9c023aafd7f  1631  4d8bd8         REX.W movq r11,r8        ;; debug: position 5968
0x9c023aafd82  1634  41b801000000   movl r8,0x1
                  ;;; <@500,#512> -------------------- B48 --------------------
                  ;;; <@501,#512> gap
0x9c023aafd88  1640  488b7da0       REX.W movq rdi,[rbp-0x60]    ;; debug: position 5984
                  ;;; <@502,#516> add-i
0x9c023aafd8c  1644  03f9           addl rdi,rcx             ;; debug: position 5992
0x9c023aafd8e  1646  0f8017060000   jo 3211  (0x9c023ab03ab)
                  ;;; <@504,#528> bounds-check
0x9c023aafd94  1652  443bff         cmpl r15,rdi             ;; debug: position 5999
0x9c023aafd97  1655  0f8613060000   jna 3216  (0x9c023ab03b0)
                  ;;; <@506,#529> store-keyed
0x9c023aafd9d  1661  45891cbe       movl [r14+rdi*4],r11
                  ;;; <@508,#532> add-i
0x9c023aafda1  1665  83c101         addl rcx,0x1             ;; debug: position 5820
                  ;;; <@510,#535> gap
0x9c023aafda4  1668  4c8945a8       REX.W movq [rbp-0x58],r8
                  ;;; <@511,#535> goto
0x9c023aafda8  1672  e94affffff     jmp 1495  (0x9c023aafcf7)
                  ;;; <@512,#450> -------------------- B49 (unreachable/replaced) --------------------
                  ;;; <@516,#553> -------------------- B50 --------------------
                  ;;; <@518,#555> gap
0x9c023aafdad  1677  488b45a8       REX.W movq rax,[rbp-0x58]    ;; debug: position 6011
                  ;;; <@520,#556> -------------------- B51 (loop header) --------------------
                  ;;; <@523,#559> compare-numeric-and-branch
0x9c023aafdb1  1681  3bca           cmpl rcx,rdx             ;; debug: position 6019
                                                             ;; debug: position 6021
0x9c023aafdb3  1683  0f8d68000000   jge 1793  (0x9c023aafe21)
                  ;;; <@524,#560> -------------------- B52 (unreachable/replaced) --------------------
                  ;;; <@528,#566> -------------------- B53 --------------------
                  ;;; <@530,#568> stack-check
0x9c023aafdb9  1689  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023aafdc0  1696  0f8223040000   jc 2761  (0x9c023ab01e9)
                  ;;; <@531,#568> gap
0x9c023aafdc6  1702  498bf1         REX.W movq rsi,r9
                  ;;; <@532,#572> add-i
0x9c023aafdc9  1705  03f1           addl rsi,rcx             ;; debug: position 6058
0x9c023aafdcb  1707  0f80e4050000   jo 3221  (0x9c023ab03b5)
                  ;;; <@534,#579> bounds-check
0x9c023aafdd1  1713  443bfe         cmpl r15,rsi
0x9c023aafdd4  1716  0f86e0050000   jna 3226  (0x9c023ab03ba)
                  ;;; <@536,#580> load-keyed
0x9c023aafdda  1722  418b34b6       movl rsi,[r14+rsi*4]
0x9c023aafdde  1726  85f6           testl rsi,rsi
0x9c023aafde0  1728  0f88d9050000   js 3231  (0x9c023ab03bf)
                  ;;; <@538,#582> sub-i
0x9c023aafde6  1734  2bf0           subl rsi,rax             ;; debug: position 6063
0x9c023aafde8  1736  0f80d6050000   jo 3236  (0x9c023ab03c4)
                  ;;; <@541,#587> compare-numeric-and-branch
0x9c023aafdee  1742  83fe00         cmpl rsi,0x0             ;; debug: position 6084
0x9c023aafdf1  1745  0f8c20000000   jl 1783  (0x9c023aafe17)
                  ;;; <@542,#591> -------------------- B54 (unreachable/replaced) --------------------
                  ;;; <@546,#614> -------------------- B55 --------------------
                  ;;; <@547,#614> gap
0x9c023aafdf7  1751  488b45a0       REX.W movq rax,[rbp-0x60]    ;; debug: position 6170
                  ;;; <@548,#618> add-i
0x9c023aafdfb  1755  03c1           addl rax,rcx             ;; debug: position 6178
0x9c023aafdfd  1757  0f80c6050000   jo 3241  (0x9c023ab03c9)
                  ;;; <@550,#630> bounds-check
0x9c023aafe03  1763  443bf8         cmpl r15,rax             ;; debug: position 6185
0x9c023aafe06  1766  0f86c2050000   jna 3246  (0x9c023ab03ce)
                  ;;; <@552,#631> store-keyed
0x9c023aafe0c  1772  41893486       movl [r14+rax*4],rsi
                  ;;; <@554,#638> gap
0x9c023aafe10  1776  33c0           xorl rax,rax             ;; debug: position 6203
                  ;;; <@555,#638> goto
0x9c023aafe12  1778  e905000000     jmp 1788  (0x9c023aafe1c)
                  ;;; <@556,#588> -------------------- B56 (unreachable/replaced) --------------------
                  ;;; <@560,#594> -------------------- B57 --------------------
                  ;;; <@562,#598> deoptimize
                  ;;; deoptimize: Insufficient type feedback for LHS of binary operation
0x9c023aafe17  1783  e8e664e5ff     call 0x9c023906302       ;; debug: position 6100
                                                             ;; debug: position 6108
                                                             ;; soft deoptimization bailout 77
                  ;;; <@564,#599> -------------------- B58 (unreachable/replaced) --------------------
                  ;;; <@568,#601> -------------------- B59 (unreachable/replaced) --------------------
                  ;;; <@584,#609> -------------------- B60 (unreachable/replaced) --------------------
                  ;;; <@600,#640> -------------------- B61 --------------------
                  ;;; <@602,#642> add-i
0x9c023aafe1c  1788  83c101         addl rcx,0x1             ;; debug: position 6031
                  ;;; <@605,#645> goto
0x9c023aafe1f  1791  eb90           jmp 1681  (0x9c023aafdb1)
                  ;;; <@606,#563> -------------------- B62 (unreachable/replaced) --------------------
                  ;;; <@610,#646> -------------------- B63 --------------------
                  ;;; <@611,#646> gap
0x9c023aafe21  1793  488b55a0       REX.W movq rdx,[rbp-0x60]    ;; debug: position 6223
                  ;;; <@612,#650> add-i
0x9c023aafe25  1797  03d1           addl rdx,rcx             ;; debug: position 6231
0x9c023aafe27  1799  0f80a6050000   jo 3251  (0x9c023ab03d3)
                  ;;; <@614,#657> bounds-check
0x9c023aafe2d  1805  443bfa         cmpl r15,rdx
0x9c023aafe30  1808  0f86a2050000   jna 3256  (0x9c023ab03d8)
                  ;;; <@616,#658> load-keyed
0x9c023aafe36  1814  418b3496       movl rsi,[r14+rdx*4]
0x9c023aafe3a  1818  85f6           testl rsi,rsi
0x9c023aafe3c  1820  0f889b050000   js 3261  (0x9c023ab03dd)
                  ;;; <@618,#660> sub-i
0x9c023aafe42  1826  2bf0           subl rsi,rax             ;; debug: position 6239
                  ;;; <@620,#672> store-keyed
0x9c023aafe44  1828  41893496       movl [r14+rdx*4],rsi
                  ;;; <@622,#694> gap
0x9c023aafe48  1832  33c0           xorl rax,rax             ;; debug: position 6278
                  ;;; <@624,#695> -------------------- B64 (loop header) --------------------
                  ;;; <@625,#695> gap
0x9c023aafe4a  1834  488bd1         REX.W movq rdx,rcx       ;; debug: position 6286
                  ;;; <@626,#699> add-i
0x9c023aafe4d  1837  83c2ff         addl rdx,0xff            ;; debug: position 6299
0x9c023aafe50  1840  0f808c050000   jo 3266  (0x9c023ab03e2)
                  ;;; <@627,#699> gap
0x9c023aafe56  1846  488b75a0       REX.W movq rsi,[rbp-0x60]
                  ;;; <@628,#701> add-i
0x9c023aafe5a  1850  03f2           addl rsi,rdx             ;; debug: position 6294
0x9c023aafe5c  1852  0f8085050000   jo 3271  (0x9c023ab03e7)
                  ;;; <@630,#708> bounds-check
0x9c023aafe62  1858  443bfe         cmpl r15,rsi
0x9c023aafe65  1861  0f8681050000   jna 3276  (0x9c023ab03ec)
                  ;;; <@632,#709> load-keyed
0x9c023aafe6b  1867  418b0cb6       movl rcx,[r14+rsi*4]
0x9c023aafe6f  1871  85c9           testl rcx,rcx
0x9c023aafe71  1873  0f887a050000   js 3281  (0x9c023ab03f1)
                  ;;; <@635,#711> compare-numeric-and-branch
0x9c023aafe77  1879  83f900         cmpl rcx,0x0             ;; debug: position 6303
0x9c023aafe7a  1882  0f852a000000   jnz 1930  (0x9c023aafeaa)
                  ;;; <@636,#712> -------------------- B65 (unreachable/replaced) --------------------
                  ;;; <@640,#718> -------------------- B66 --------------------
                  ;;; <@643,#721> compare-numeric-and-branch
0x9c023aafe80  1888  83fa01         cmpl rdx,0x1             ;; debug: position 6312
                                                             ;; debug: position 6314
0x9c023aafe83  1891  0f8e21000000   jle 1930  (0x9c023aafeaa)
                  ;;; <@644,#722> -------------------- B67 (unreachable/replaced) --------------------
                  ;;; <@648,#728> -------------------- B68 --------------------
                  ;;; <@650,#730> stack-check
0x9c023aafe89  1897  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023aafe90  1904  0f8294030000   jc 2826  (0x9c023ab022a)
                  ;;; <@651,#730> gap
0x9c023aafe96  1910  488bc8         REX.W movq rcx,rax
                  ;;; <@652,#732> add-i
0x9c023aafe99  1913  83c101         addl rcx,0x1             ;; debug: position 6327
0x9c023aafe9c  1916  0f8054050000   jo 3286  (0x9c023ab03f6)
                  ;;; <@654,#735> gap
0x9c023aafea2  1922  488bc1         REX.W movq rax,rcx
0x9c023aafea5  1925  488bca         REX.W movq rcx,rdx
                  ;;; <@655,#735> goto
0x9c023aafea8  1928  eba0           jmp 1834  (0x9c023aafe4a)
                  ;;; <@656,#725> -------------------- B69 (unreachable/replaced) --------------------
                  ;;; <@660,#715> -------------------- B70 (unreachable/replaced) --------------------
                  ;;; <@664,#736> -------------------- B71 --------------------
                  ;;; <@667,#738> branch
0x9c023aafeaa  1930  85c0           testl rax,rax            ;; debug: position 6360
0x9c023aafeac  1932  0f8413000000   jz 1957  (0x9c023aafec5)
                  ;;; <@668,#742> -------------------- B72 (unreachable/replaced) --------------------
                  ;;; <@672,#766> -------------------- B73 (unreachable/replaced) --------------------
                  ;;; <@676,#739> -------------------- B74 (unreachable/replaced) --------------------
                  ;;; <@680,#745> -------------------- B75 --------------------
                  ;;; <@682,#750> sub-i
0x9c023aafeb2  1938  2bd8           subl rbx,rax             ;; debug: position 6378
                                                             ;; debug: position 6396
                  ;;; <@683,#750> gap
0x9c023aafeb4  1940  488b45a0       REX.W movq rax,[rbp-0x60]
                  ;;; <@684,#761> bounds-check
0x9c023aafeb8  1944  443bf8         cmpl r15,rax
0x9c023aafebb  1947  0f863a050000   jna 3291  (0x9c023ab03fb)
                  ;;; <@686,#762> store-keyed
0x9c023aafec1  1953  41891c86       movl [r14+rax*4],rbx
                  ;;; <@690,#769> -------------------- B76 --------------------
                  ;;; <@691,#769> gap
0x9c023aafec5  1957  488b45b8       REX.W movq rax,[rbp-0x48]    ;; debug: position 6426
                  ;;; <@692,#791> smi-tag
0x9c023aafec9  1961  8bd8           movl rbx,rax
0x9c023aafecb  1963  48c1e320       REX.W shlq rbx,32
                  ;;; <@693,#791> gap
0x9c023aafecf  1967  488bc3         REX.W movq rax,rbx
                  ;;; <@694,#772> return
0x9c023aafed2  1970  488be5         REX.W movq rsp,rbp
0x9c023aafed5  1973  5d             pop rbp
0x9c023aafed6  1974  c21800         ret 0x18
                  ;;; <@696,#220> -------------------- B77 (unreachable/replaced) --------------------
                  ;;; <@700,#226> -------------------- B78 --------------------
                  ;;; <@701,#226> gap
0x9c023aafed9  1977  488b45e8       REX.W movq rax,[rbp-0x18]    ;; debug: position 5459
                  ;;; <@702,#227> load-context-slot
0x9c023aafedd  1981  488b80b7000000 REX.W movq rax,[rax+0xb7]
                  ;;; <@704,#229> return
0x9c023aafee4  1988  488be5         REX.W movq rsp,rbp
0x9c023aafee7  1991  5d             pop rbp
0x9c023aafee8  1992  c21800         ret 0x18
                  ;;; <@48,#776> -------------------- Deferred tagged-to-i --------------------
0x9c023aafeeb  1995  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 12654
0x9c023aafeef  1999  4c3956ff       REX.W cmpq [rsi-0x1],r10
0x9c023aafef3  2003  751d           jnz 2034  (0x9c023aaff12)
0x9c023aafef5  2005  f20f104607     movsd xmm0,[rsi+0x7]
0x9c023aafefa  2010  f20f2cf0       cvttsd2sil rsi,xmm0
0x9c023aafefe  2014  0f57c9         xorps xmm1,xmm1
0x9c023aaff01  2017  f20f2ace       cvtsi2sd xmm1,rsi
0x9c023aaff05  2021  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023aaff09  2025  7507           jnz 2034  (0x9c023aaff12)
                  Deferred TaggedToI: NaN
0x9c023aaff0b  2027  7a05           jpe 2034  (0x9c023aaff12)
0x9c023aaff0d  2029  e9bdf8ffff     jmp 175  (0x9c023aaf7cf)
0x9c023aaff12  2034  e85964c5ff     call 0x9c023706370       ;; deoptimization bailout 88
0x9c023aaff17  2039  e9b3f8ffff     jmp 175  (0x9c023aaf7cf)
                  ;;; <@54,#780> -------------------- Deferred tagged-to-i --------------------
0x9c023aaff1c  2044  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 12675
0x9c023aaff20  2048  4c3957ff       REX.W cmpq [rdi-0x1],r10
0x9c023aaff24  2052  751d           jnz 2083  (0x9c023aaff43)
0x9c023aaff26  2054  f20f104707     movsd xmm0,[rdi+0x7]
0x9c023aaff2b  2059  f20f2cf8       cvttsd2sil rdi,xmm0
0x9c023aaff2f  2063  0f57c9         xorps xmm1,xmm1
0x9c023aaff32  2066  f20f2acf       cvtsi2sd xmm1,rdi
0x9c023aaff36  2070  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023aaff3a  2074  7507           jnz 2083  (0x9c023aaff43)
                  Deferred TaggedToI: NaN
0x9c023aaff3c  2076  7a05           jpe 2083  (0x9c023aaff43)
0x9c023aaff3e  2078  e9b1f8ffff     jmp 212  (0x9c023aaf7f4)
0x9c023aaff43  2083  e83264c5ff     call 0x9c02370637a       ;; deoptimization bailout 89
0x9c023aaff48  2088  e9a7f8ffff     jmp 212  (0x9c023aaf7f4)
                  ;;; <@112,#129> -------------------- Deferred stack-check --------------------
0x9c023aaff4d  2093  50             push rax                 ;; debug: position 12875
0x9c023aaff4e  2094  51             push rcx
0x9c023aaff4f  2095  52             push rdx
0x9c023aaff50  2096  53             push rbx
0x9c023aaff51  2097  56             push rsi
0x9c023aaff52  2098  57             push rdi
0x9c023aaff53  2099  4150           push r8
0x9c023aaff55  2101  4151           push r9
0x9c023aaff57  2103  4153           push r11
0x9c023aaff59  2105  4156           push r14
0x9c023aaff5b  2107  4157           push r15
0x9c023aaff5d  2109  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023aaff62  2114  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023aaff66  2118  33c0           xorl rax,rax
0x9c023aaff68  2120  498d9d78f8e4fd REX.W leaq rbx,[r13-0x21b0788]
0x9c023aaff6f  2127  e84c62f5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023aaff74  2132  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023aaff79  2137  415f           pop r15
0x9c023aaff7b  2139  415e           pop r14
0x9c023aaff7d  2141  415b           pop r11
0x9c023aaff7f  2143  4159           pop r9
0x9c023aaff81  2145  4158           pop r8
0x9c023aaff83  2147  5f             pop rdi
0x9c023aaff84  2148  5e             pop rsi
0x9c023aaff85  2149  5b             pop rbx
0x9c023aaff86  2150  5a             pop rdx
0x9c023aaff87  2151  59             pop rcx
0x9c023aaff88  2152  58             pop rax
0x9c023aaff89  2153  e915f9ffff     jmp 387  (0x9c023aaf8a3)
                  ;;; <@212,#775> -------------------- Deferred tagged-to-i --------------------
0x9c023aaff8e  2158  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 5557
0x9c023aaff92  2162  4c3953ff       REX.W cmpq [rbx-0x1],r10
0x9c023aaff96  2166  751d           jnz 2197  (0x9c023aaffb5)
0x9c023aaff98  2168  f20f104307     movsd xmm0,[rbx+0x7]
0x9c023aaff9d  2173  f20f2cd8       cvttsd2sil rbx,xmm0
0x9c023aaffa1  2177  0f57c9         xorps xmm1,xmm1
0x9c023aaffa4  2180  f20f2acb       cvtsi2sd xmm1,rbx
0x9c023aaffa8  2184  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023aaffac  2188  7507           jnz 2197  (0x9c023aaffb5)
                  Deferred TaggedToI: NaN
0x9c023aaffae  2190  7a05           jpe 2197  (0x9c023aaffb5)
0x9c023aaffb0  2192  e9a1f9ffff     jmp 566  (0x9c023aaf956)
0x9c023aaffb5  2197  e8ca63c5ff     call 0x9c023706384       ;; deoptimization bailout 90
0x9c023aaffba  2202  e997f9ffff     jmp 566  (0x9c023aaf956)
                  ;;; <@214,#778> -------------------- Deferred tagged-to-i --------------------
0x9c023aaffbf  2207  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023aaffc3  2211  4c3952ff       REX.W cmpq [rdx-0x1],r10
0x9c023aaffc7  2215  751d           jnz 2246  (0x9c023aaffe6)
0x9c023aaffc9  2217  f20f104207     movsd xmm0,[rdx+0x7]
0x9c023aaffce  2222  f20f2cd0       cvttsd2sil rdx,xmm0
0x9c023aaffd2  2226  0f57c9         xorps xmm1,xmm1
0x9c023aaffd5  2229  f20f2aca       cvtsi2sd xmm1,rdx
0x9c023aaffd9  2233  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023aaffdd  2237  7507           jnz 2246  (0x9c023aaffe6)
                  Deferred TaggedToI: NaN
0x9c023aaffdf  2239  7a05           jpe 2246  (0x9c023aaffe6)
0x9c023aaffe1  2241  e981f9ffff     jmp 583  (0x9c023aaf967)
0x9c023aaffe6  2246  e8a363c5ff     call 0x9c02370638e       ;; deoptimization bailout 91
0x9c023aaffeb  2251  e977f9ffff     jmp 583  (0x9c023aaf967)
                  ;;; <@224,#774> -------------------- Deferred tagged-to-i --------------------
0x9c023aafff0  2256  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023aafff4  2260  4c3953ff       REX.W cmpq [rbx-0x1],r10
0x9c023aafff8  2264  751d           jnz 2295  (0x9c023ab0017)
0x9c023aafffa  2266  f20f104307     movsd xmm0,[rbx+0x7]
0x9c023aaffff  2271  f20f2cd8       cvttsd2sil rbx,xmm0
0x9c023ab0003  2275  0f57c9         xorps xmm1,xmm1
0x9c023ab0006  2278  f20f2acb       cvtsi2sd xmm1,rbx
0x9c023ab000a  2282  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab000e  2286  7507           jnz 2295  (0x9c023ab0017)
                  Deferred TaggedToI: NaN
0x9c023ab0010  2288  7a05           jpe 2295  (0x9c023ab0017)
0x9c023ab0012  2290  e969f9ffff     jmp 608  (0x9c023aaf980)
0x9c023ab0017  2295  e87c63c5ff     call 0x9c023706398       ;; deoptimization bailout 92
0x9c023ab001c  2300  e95ff9ffff     jmp 608  (0x9c023aaf980)
                  ;;; <@226,#779> -------------------- Deferred tagged-to-i --------------------
0x9c023ab0021  2305  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023ab0025  2309  4c3952ff       REX.W cmpq [rdx-0x1],r10
0x9c023ab0029  2313  751d           jnz 2344  (0x9c023ab0048)
0x9c023ab002b  2315  f20f104207     movsd xmm0,[rdx+0x7]
0x9c023ab0030  2320  f20f2cd0       cvttsd2sil rdx,xmm0
0x9c023ab0034  2324  0f57c9         xorps xmm1,xmm1
0x9c023ab0037  2327  f20f2aca       cvtsi2sd xmm1,rdx
0x9c023ab003b  2331  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab003f  2335  7507           jnz 2344  (0x9c023ab0048)
                  Deferred TaggedToI: NaN
0x9c023ab0041  2337  7a05           jpe 2344  (0x9c023ab0048)
0x9c023ab0043  2339  e949f9ffff     jmp 625  (0x9c023aaf991)
0x9c023ab0048  2344  e85563c5ff     call 0x9c0237063a2       ;; deoptimization bailout 93
0x9c023ab004d  2349  e93ff9ffff     jmp 625  (0x9c023aaf991)
                  ;;; <@272,#783> -------------------- Deferred tagged-to-i --------------------
0x9c023ab0052  2354  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2205
0x9c023ab0056  2358  4c3956ff       REX.W cmpq [rsi-0x1],r10
0x9c023ab005a  2362  751d           jnz 2393  (0x9c023ab0079)
0x9c023ab005c  2364  f20f104607     movsd xmm0,[rsi+0x7]
0x9c023ab0061  2369  f20f2cf0       cvttsd2sil rsi,xmm0
0x9c023ab0065  2373  0f57c9         xorps xmm1,xmm1
0x9c023ab0068  2376  f20f2ace       cvtsi2sd xmm1,rsi
0x9c023ab006c  2380  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab0070  2384  7507           jnz 2393  (0x9c023ab0079)
                  Deferred TaggedToI: NaN
0x9c023ab0072  2386  7a05           jpe 2393  (0x9c023ab0079)
0x9c023ab0074  2388  e9eff9ffff     jmp 840  (0x9c023aafa68)
0x9c023ab0079  2393  e82e63c5ff     call 0x9c0237063ac       ;; deoptimization bailout 94
0x9c023ab007e  2398  e9e5f9ffff     jmp 840  (0x9c023aafa68)
                  ;;; <@314,#784> -------------------- Deferred tagged-to-i --------------------
0x9c023ab0083  2403  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2258
0x9c023ab0087  2407  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab008b  2411  752a           jnz 2455  (0x9c023ab00b7)
0x9c023ab008d  2413  f20f104007     movsd xmm0,[rax+0x7]
0x9c023ab0092  2418  f20f2cc0       cvttsd2sil rax,xmm0
0x9c023ab0096  2422  0f57c9         xorps xmm1,xmm1
0x9c023ab0099  2425  f20f2ac8       cvtsi2sd xmm1,rax
0x9c023ab009d  2429  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab00a1  2433  7514           jnz 2455  (0x9c023ab00b7)
                  Deferred TaggedToI: NaN
0x9c023ab00a3  2435  7a12           jpe 2455  (0x9c023ab00b7)
0x9c023ab00a5  2437  85c0           testl rax,rax
0x9c023ab00a7  2439  7509           jnz 2450  (0x9c023ab00b2)
0x9c023ab00a9  2441  660f50c0       movmskpd rax,xmm0
0x9c023ab00ad  2445  83e001         andl rax,0x1
0x9c023ab00b0  2448  7505           jnz 2455  (0x9c023ab00b7)
0x9c023ab00b2  2450  e905faffff     jmp 924  (0x9c023aafabc)
0x9c023ab00b7  2455  e8fa62c5ff     call 0x9c0237063b6       ;; deoptimization bailout 95
0x9c023ab00bc  2460  e9fbf9ffff     jmp 924  (0x9c023aafabc)
                  ;;; <@328,#788> -------------------- Deferred tagged-to-i --------------------
0x9c023ab00c1  2465  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2394
0x9c023ab00c5  2469  4c3952ff       REX.W cmpq [rdx-0x1],r10
0x9c023ab00c9  2473  752a           jnz 2517  (0x9c023ab00f5)
0x9c023ab00cb  2475  f20f104207     movsd xmm0,[rdx+0x7]
0x9c023ab00d0  2480  f20f2cd0       cvttsd2sil rdx,xmm0
0x9c023ab00d4  2484  0f57c9         xorps xmm1,xmm1
0x9c023ab00d7  2487  f20f2aca       cvtsi2sd xmm1,rdx
0x9c023ab00db  2491  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab00df  2495  7514           jnz 2517  (0x9c023ab00f5)
                  Deferred TaggedToI: NaN
0x9c023ab00e1  2497  7a12           jpe 2517  (0x9c023ab00f5)
0x9c023ab00e3  2499  85d2           testl rdx,rdx
0x9c023ab00e5  2501  7509           jnz 2512  (0x9c023ab00f0)
0x9c023ab00e7  2503  660f50d0       movmskpd rdx,xmm0
0x9c023ab00eb  2507  83e201         andl rdx,0x1
0x9c023ab00ee  2510  7505           jnz 2517  (0x9c023ab00f5)
0x9c023ab00f0  2512  e902faffff     jmp 983  (0x9c023aafaf7)
0x9c023ab00f5  2517  e8c662c5ff     call 0x9c0237063c0       ;; deoptimization bailout 96
0x9c023ab00fa  2522  e9f8f9ffff     jmp 983  (0x9c023aafaf7)
                  ;;; <@342,#790> -------------------- Deferred tagged-to-i --------------------
0x9c023ab00ff  2527  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2484
0x9c023ab0103  2531  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab0107  2535  752a           jnz 2579  (0x9c023ab0133)
0x9c023ab0109  2537  f20f104007     movsd xmm0,[rax+0x7]
0x9c023ab010e  2542  f20f2cc0       cvttsd2sil rax,xmm0
0x9c023ab0112  2546  0f57c9         xorps xmm1,xmm1
0x9c023ab0115  2549  f20f2ac8       cvtsi2sd xmm1,rax
0x9c023ab0119  2553  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab011d  2557  7514           jnz 2579  (0x9c023ab0133)
                  Deferred TaggedToI: NaN
0x9c023ab011f  2559  7a12           jpe 2579  (0x9c023ab0133)
0x9c023ab0121  2561  85c0           testl rax,rax
0x9c023ab0123  2563  7509           jnz 2574  (0x9c023ab012e)
0x9c023ab0125  2565  660f50c0       movmskpd rax,xmm0
0x9c023ab0129  2569  83e001         andl rax,0x1
0x9c023ab012c  2572  7505           jnz 2579  (0x9c023ab0133)
0x9c023ab012e  2574  e9fef9ffff     jmp 1041  (0x9c023aafb31)
0x9c023ab0133  2579  e89262c5ff     call 0x9c0237063ca       ;; deoptimization bailout 97
0x9c023ab0138  2584  e9f4f9ffff     jmp 1041  (0x9c023aafb31)
                  ;;; <@374,#787> -------------------- Deferred tagged-to-i --------------------
0x9c023ab013d  2589  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2513
0x9c023ab0141  2593  4d3950ff       REX.W cmpq [r8-0x1],r10
0x9c023ab0145  2597  752b           jnz 2642  (0x9c023ab0172)
0x9c023ab0147  2599  f2410f104007   movsd xmm0,[r8+0x7]
0x9c023ab014d  2605  f24c0f2cc0     REX.W cvttsd2siq r8,xmm0
0x9c023ab0152  2610  4983f801       REX.W cmpq r8,0x1
0x9c023ab0156  2614  7112           jno 2634  (0x9c023ab016a)
0x9c023ab0158  2616  4883ec08       REX.W subq rsp,0x8
0x9c023ab015c  2620  f20f110424     movsd [rsp],xmm0
0x9c023ab0161  2625  e8da45f9ff     call 0x9c023a44740       ;; code: STUB, DoubleToIStub, minor: 266756
0x9c023ab0166  2630  4883c408       REX.W addq rsp,0x8
0x9c023ab016a  2634  458bc0         movl r8,r8
0x9c023ab016d  2637  e93cfaffff     jmp 1166  (0x9c023aafbae)
0x9c023ab0172  2642  4d3b45a8       REX.W cmpq r8,[r13-0x58]
0x9c023ab0176  2646  7508           jnz 2656  (0x9c023ab0180)
0x9c023ab0178  2648  4533c0         xorl r8,r8
0x9c023ab017b  2651  e92efaffff     jmp 1166  (0x9c023aafbae)
0x9c023ab0180  2656  4d3b45c0       REX.W cmpq r8,[r13-0x40]
0x9c023ab0184  2660  750b           jnz 2673  (0x9c023ab0191)
0x9c023ab0186  2662  41b801000000   movl r8,0x1
0x9c023ab018c  2668  e91dfaffff     jmp 1166  (0x9c023aafbae)
0x9c023ab0191  2673  4d3b45c8       REX.W cmpq r8,[r13-0x38]
                  Deferred TaggedToI: cannot truncate
0x9c023ab0195  2677  0f8565020000   jnz 3296  (0x9c023ab0400)
0x9c023ab019b  2683  4533c0         xorl r8,r8
0x9c023ab019e  2686  e90bfaffff     jmp 1166  (0x9c023aafbae)
0x9c023ab01a3  2691  e906faffff     jmp 1166  (0x9c023aafbae)
                  ;;; <@462,#455> -------------------- Deferred stack-check --------------------
0x9c023ab01a8  2696  50             push rax                 ;; debug: position 5810
0x9c023ab01a9  2697  51             push rcx
0x9c023ab01aa  2698  52             push rdx
0x9c023ab01ab  2699  53             push rbx
0x9c023ab01ac  2700  56             push rsi
0x9c023ab01ad  2701  57             push rdi
0x9c023ab01ae  2702  4150           push r8
0x9c023ab01b0  2704  4151           push r9
0x9c023ab01b2  2706  4153           push r11
0x9c023ab01b4  2708  4156           push r14
0x9c023ab01b6  2710  4157           push r15
0x9c023ab01b8  2712  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023ab01bd  2717  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023ab01c1  2721  33c0           xorl rax,rax
0x9c023ab01c3  2723  498d9d78f8e4fd REX.W leaq rbx,[r13-0x21b0788]
0x9c023ab01ca  2730  e8f15ff5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023ab01cf  2735  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023ab01d4  2740  415f           pop r15
0x9c023ab01d6  2742  415e           pop r14
0x9c023ab01d8  2744  415b           pop r11
0x9c023ab01da  2746  4159           pop r9
0x9c023ab01dc  2748  4158           pop r8
0x9c023ab01de  2750  5f             pop rdi
0x9c023ab01df  2751  5e             pop rsi
0x9c023ab01e0  2752  5b             pop rbx
0x9c023ab01e1  2753  5a             pop rdx
0x9c023ab01e2  2754  59             pop rcx
0x9c023ab01e3  2755  58             pop rax
0x9c023ab01e4  2756  e923fbffff     jmp 1516  (0x9c023aafd0c)
                  ;;; <@530,#568> -------------------- Deferred stack-check --------------------
0x9c023ab01e9  2761  50             push rax                 ;; debug: position 6021
0x9c023ab01ea  2762  51             push rcx
0x9c023ab01eb  2763  52             push rdx
0x9c023ab01ec  2764  53             push rbx
0x9c023ab01ed  2765  56             push rsi
0x9c023ab01ee  2766  57             push rdi
0x9c023ab01ef  2767  4150           push r8
0x9c023ab01f1  2769  4151           push r9
0x9c023ab01f3  2771  4153           push r11
0x9c023ab01f5  2773  4156           push r14
0x9c023ab01f7  2775  4157           push r15
0x9c023ab01f9  2777  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023ab01fe  2782  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023ab0202  2786  33c0           xorl rax,rax
0x9c023ab0204  2788  498d9d78f8e4fd REX.W leaq rbx,[r13-0x21b0788]
0x9c023ab020b  2795  e8b05ff5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023ab0210  2800  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023ab0215  2805  415f           pop r15
0x9c023ab0217  2807  415e           pop r14
0x9c023ab0219  2809  415b           pop r11
0x9c023ab021b  2811  4159           pop r9
0x9c023ab021d  2813  4158           pop r8
0x9c023ab021f  2815  5f             pop rdi
0x9c023ab0220  2816  5e             pop rsi
0x9c023ab0221  2817  5b             pop rbx
0x9c023ab0222  2818  5a             pop rdx
0x9c023ab0223  2819  59             pop rcx
0x9c023ab0224  2820  58             pop rax
0x9c023ab0225  2821  e99cfbffff     jmp 1702  (0x9c023aafdc6)
                  ;;; <@650,#730> -------------------- Deferred stack-check --------------------
0x9c023ab022a  2826  50             push rax                 ;; debug: position 6314
0x9c023ab022b  2827  51             push rcx
0x9c023ab022c  2828  52             push rdx
0x9c023ab022d  2829  53             push rbx
0x9c023ab022e  2830  56             push rsi
0x9c023ab022f  2831  57             push rdi
0x9c023ab0230  2832  4150           push r8
0x9c023ab0232  2834  4151           push r9
0x9c023ab0234  2836  4153           push r11
0x9c023ab0236  2838  4156           push r14
0x9c023ab0238  2840  4157           push r15
0x9c023ab023a  2842  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023ab023f  2847  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023ab0243  2851  33c0           xorl rax,rax
0x9c023ab0245  2853  498d9d78f8e4fd REX.W leaq rbx,[r13-0x21b0788]
0x9c023ab024c  2860  e86f5ff5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023ab0251  2865  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023ab0256  2870  415f           pop r15
0x9c023ab0258  2872  415e           pop r14
0x9c023ab025a  2874  415b           pop r11
0x9c023ab025c  2876  4159           pop r9
0x9c023ab025e  2878  4158           pop r8
0x9c023ab0260  2880  5f             pop rdi
0x9c023ab0261  2881  5e             pop rsi
0x9c023ab0262  2882  5b             pop rbx
0x9c023ab0263  2883  5a             pop rdx
0x9c023ab0264  2884  59             pop rcx
0x9c023ab0265  2885  58             pop rax
0x9c023ab0266  2886  e92bfcffff     jmp 1910  (0x9c023aafe96)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x9c023ab026b  2891  e89a5dc5ff     call 0x9c02370600a       ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x9c023ab0270  2896  e89f5dc5ff     call 0x9c023706014       ;; deoptimization bailout 2
                  ;;; jump table entry 2: deoptimization bailout 3.
0x9c023ab0275  2901  e8a45dc5ff     call 0x9c02370601e       ;; deoptimization bailout 3
                  ;;; jump table entry 3: deoptimization bailout 4.
0x9c023ab027a  2906  e8a95dc5ff     call 0x9c023706028       ;; deoptimization bailout 4
                  ;;; jump table entry 4: deoptimization bailout 5.
0x9c023ab027f  2911  e8ae5dc5ff     call 0x9c023706032       ;; deoptimization bailout 5
                  ;;; jump table entry 5: deoptimization bailout 6.
0x9c023ab0284  2916  e8b35dc5ff     call 0x9c02370603c       ;; deoptimization bailout 6
                  ;;; jump table entry 6: deoptimization bailout 7.
0x9c023ab0289  2921  e8b85dc5ff     call 0x9c023706046       ;; deoptimization bailout 7
                  ;;; jump table entry 7: deoptimization bailout 8.
0x9c023ab028e  2926  e8bd5dc5ff     call 0x9c023706050       ;; deoptimization bailout 8
                  ;;; jump table entry 8: deoptimization bailout 9.
0x9c023ab0293  2931  e8c25dc5ff     call 0x9c02370605a       ;; deoptimization bailout 9
                  ;;; jump table entry 9: deoptimization bailout 10.
0x9c023ab0298  2936  e8c75dc5ff     call 0x9c023706064       ;; deoptimization bailout 10
                  ;;; jump table entry 10: deoptimization bailout 11.
0x9c023ab029d  2941  e8cc5dc5ff     call 0x9c02370606e       ;; deoptimization bailout 11
                  ;;; jump table entry 11: deoptimization bailout 12.
0x9c023ab02a2  2946  e8d15dc5ff     call 0x9c023706078       ;; deoptimization bailout 12
                  ;;; jump table entry 12: deoptimization bailout 13.
0x9c023ab02a7  2951  e8d65dc5ff     call 0x9c023706082       ;; deoptimization bailout 13
                  ;;; jump table entry 13: deoptimization bailout 14.
0x9c023ab02ac  2956  e8db5dc5ff     call 0x9c02370608c       ;; deoptimization bailout 14
                  ;;; jump table entry 14: deoptimization bailout 15.
0x9c023ab02b1  2961  e8e05dc5ff     call 0x9c023706096       ;; deoptimization bailout 15
                  ;;; jump table entry 15: deoptimization bailout 16.
0x9c023ab02b6  2966  e8e55dc5ff     call 0x9c0237060a0       ;; deoptimization bailout 16
                  ;;; jump table entry 16: deoptimization bailout 18.
0x9c023ab02bb  2971  e8f45dc5ff     call 0x9c0237060b4       ;; deoptimization bailout 18
                  ;;; jump table entry 17: deoptimization bailout 19.
0x9c023ab02c0  2976  e8f95dc5ff     call 0x9c0237060be       ;; deoptimization bailout 19
                  ;;; jump table entry 18: deoptimization bailout 20.
0x9c023ab02c5  2981  e8fe5dc5ff     call 0x9c0237060c8       ;; deoptimization bailout 20
                  ;;; jump table entry 19: deoptimization bailout 21.
0x9c023ab02ca  2986  e8035ec5ff     call 0x9c0237060d2       ;; deoptimization bailout 21
                  ;;; jump table entry 20: deoptimization bailout 22.
0x9c023ab02cf  2991  e8085ec5ff     call 0x9c0237060dc       ;; deoptimization bailout 22
                  ;;; jump table entry 21: deoptimization bailout 23.
0x9c023ab02d4  2996  e80d5ec5ff     call 0x9c0237060e6       ;; deoptimization bailout 23
                  ;;; jump table entry 22: deoptimization bailout 24.
0x9c023ab02d9  3001  e8125ec5ff     call 0x9c0237060f0       ;; deoptimization bailout 24
                  ;;; jump table entry 23: deoptimization bailout 25.
0x9c023ab02de  3006  e8175ec5ff     call 0x9c0237060fa       ;; deoptimization bailout 25
                  ;;; jump table entry 24: deoptimization bailout 26.
0x9c023ab02e3  3011  e81c5ec5ff     call 0x9c023706104       ;; deoptimization bailout 26
                  ;;; jump table entry 25: deoptimization bailout 27.
0x9c023ab02e8  3016  e8215ec5ff     call 0x9c02370610e       ;; deoptimization bailout 27
                  ;;; jump table entry 26: deoptimization bailout 28.
0x9c023ab02ed  3021  e8265ec5ff     call 0x9c023706118       ;; deoptimization bailout 28
                  ;;; jump table entry 27: deoptimization bailout 29.
0x9c023ab02f2  3026  e82b5ec5ff     call 0x9c023706122       ;; deoptimization bailout 29
                  ;;; jump table entry 28: deoptimization bailout 30.
0x9c023ab02f7  3031  e8305ec5ff     call 0x9c02370612c       ;; deoptimization bailout 30
                  ;;; jump table entry 29: deoptimization bailout 31.
0x9c023ab02fc  3036  e8355ec5ff     call 0x9c023706136       ;; deoptimization bailout 31
                  ;;; jump table entry 30: deoptimization bailout 32.
0x9c023ab0301  3041  e83a5ec5ff     call 0x9c023706140       ;; deoptimization bailout 32
                  ;;; jump table entry 31: deoptimization bailout 34.
0x9c023ab0306  3046  e8495ec5ff     call 0x9c023706154       ;; deoptimization bailout 34
                  ;;; jump table entry 32: deoptimization bailout 35.
0x9c023ab030b  3051  e84e5ec5ff     call 0x9c02370615e       ;; deoptimization bailout 35
                  ;;; jump table entry 33: deoptimization bailout 36.
0x9c023ab0310  3056  e8535ec5ff     call 0x9c023706168       ;; deoptimization bailout 36
                  ;;; jump table entry 34: deoptimization bailout 37.
0x9c023ab0315  3061  e8585ec5ff     call 0x9c023706172       ;; deoptimization bailout 37
                  ;;; jump table entry 35: deoptimization bailout 38.
0x9c023ab031a  3066  e85d5ec5ff     call 0x9c02370617c       ;; deoptimization bailout 38
                  ;;; jump table entry 36: deoptimization bailout 39.
0x9c023ab031f  3071  e8625ec5ff     call 0x9c023706186       ;; deoptimization bailout 39
                  ;;; jump table entry 37: deoptimization bailout 40.
0x9c023ab0324  3076  e8675ec5ff     call 0x9c023706190       ;; deoptimization bailout 40
                  ;;; jump table entry 38: deoptimization bailout 41.
0x9c023ab0329  3081  e86c5ec5ff     call 0x9c02370619a       ;; deoptimization bailout 41
                  ;;; jump table entry 39: deoptimization bailout 42.
0x9c023ab032e  3086  e8715ec5ff     call 0x9c0237061a4       ;; deoptimization bailout 42
                  ;;; jump table entry 40: deoptimization bailout 43.
0x9c023ab0333  3091  e8765ec5ff     call 0x9c0237061ae       ;; deoptimization bailout 43
                  ;;; jump table entry 41: deoptimization bailout 44.
0x9c023ab0338  3096  e87b5ec5ff     call 0x9c0237061b8       ;; deoptimization bailout 44
                  ;;; jump table entry 42: deoptimization bailout 45.
0x9c023ab033d  3101  e8805ec5ff     call 0x9c0237061c2       ;; deoptimization bailout 45
                  ;;; jump table entry 43: deoptimization bailout 46.
0x9c023ab0342  3106  e8855ec5ff     call 0x9c0237061cc       ;; deoptimization bailout 46
                  ;;; jump table entry 44: deoptimization bailout 47.
0x9c023ab0347  3111  e88a5ec5ff     call 0x9c0237061d6       ;; deoptimization bailout 47
                  ;;; jump table entry 45: deoptimization bailout 48.
0x9c023ab034c  3116  e88f5ec5ff     call 0x9c0237061e0       ;; deoptimization bailout 48
                  ;;; jump table entry 46: deoptimization bailout 49.
0x9c023ab0351  3121  e8945ec5ff     call 0x9c0237061ea       ;; deoptimization bailout 49
                  ;;; jump table entry 47: deoptimization bailout 50.
0x9c023ab0356  3126  e8995ec5ff     call 0x9c0237061f4       ;; deoptimization bailout 50
                  ;;; jump table entry 48: deoptimization bailout 51.
0x9c023ab035b  3131  e89e5ec5ff     call 0x9c0237061fe       ;; deoptimization bailout 51
                  ;;; jump table entry 49: deoptimization bailout 52.
0x9c023ab0360  3136  e8a35ec5ff     call 0x9c023706208       ;; deoptimization bailout 52
                  ;;; jump table entry 50: deoptimization bailout 53.
0x9c023ab0365  3141  e8a85ec5ff     call 0x9c023706212       ;; deoptimization bailout 53
                  ;;; jump table entry 51: deoptimization bailout 54.
0x9c023ab036a  3146  e8ad5ec5ff     call 0x9c02370621c       ;; deoptimization bailout 54
                  ;;; jump table entry 52: deoptimization bailout 55.
0x9c023ab036f  3151  e8b25ec5ff     call 0x9c023706226       ;; deoptimization bailout 55
                  ;;; jump table entry 53: deoptimization bailout 56.
0x9c023ab0374  3156  e8b75ec5ff     call 0x9c023706230       ;; deoptimization bailout 56
                  ;;; jump table entry 54: deoptimization bailout 57.
0x9c023ab0379  3161  e8bc5ec5ff     call 0x9c02370623a       ;; deoptimization bailout 57
                  ;;; jump table entry 55: deoptimization bailout 58.
0x9c023ab037e  3166  e8c15ec5ff     call 0x9c023706244       ;; deoptimization bailout 58
                  ;;; jump table entry 56: deoptimization bailout 60.
0x9c023ab0383  3171  e8d05ec5ff     call 0x9c023706258       ;; deoptimization bailout 60
                  ;;; jump table entry 57: deoptimization bailout 61.
0x9c023ab0388  3176  e8d55ec5ff     call 0x9c023706262       ;; deoptimization bailout 61
                  ;;; jump table entry 58: deoptimization bailout 62.
0x9c023ab038d  3181  e8da5ec5ff     call 0x9c02370626c       ;; deoptimization bailout 62
                  ;;; jump table entry 59: deoptimization bailout 63.
0x9c023ab0392  3186  e8df5ec5ff     call 0x9c023706276       ;; deoptimization bailout 63
                  ;;; jump table entry 60: deoptimization bailout 64.
0x9c023ab0397  3191  e8e45ec5ff     call 0x9c023706280       ;; deoptimization bailout 64
                  ;;; jump table entry 61: deoptimization bailout 65.
0x9c023ab039c  3196  e8e95ec5ff     call 0x9c02370628a       ;; deoptimization bailout 65
                  ;;; jump table entry 62: deoptimization bailout 66.
0x9c023ab03a1  3201  e8ee5ec5ff     call 0x9c023706294       ;; deoptimization bailout 66
                  ;;; jump table entry 63: deoptimization bailout 67.
0x9c023ab03a6  3206  e8f35ec5ff     call 0x9c02370629e       ;; deoptimization bailout 67
                  ;;; jump table entry 64: deoptimization bailout 68.
0x9c023ab03ab  3211  e8f85ec5ff     call 0x9c0237062a8       ;; deoptimization bailout 68
                  ;;; jump table entry 65: deoptimization bailout 69.
0x9c023ab03b0  3216  e8fd5ec5ff     call 0x9c0237062b2       ;; deoptimization bailout 69
                  ;;; jump table entry 66: deoptimization bailout 71.
0x9c023ab03b5  3221  e80c5fc5ff     call 0x9c0237062c6       ;; deoptimization bailout 71
                  ;;; jump table entry 67: deoptimization bailout 72.
0x9c023ab03ba  3226  e8115fc5ff     call 0x9c0237062d0       ;; deoptimization bailout 72
                  ;;; jump table entry 68: deoptimization bailout 73.
0x9c023ab03bf  3231  e8165fc5ff     call 0x9c0237062da       ;; deoptimization bailout 73
                  ;;; jump table entry 69: deoptimization bailout 74.
0x9c023ab03c4  3236  e81b5fc5ff     call 0x9c0237062e4       ;; deoptimization bailout 74
                  ;;; jump table entry 70: deoptimization bailout 75.
0x9c023ab03c9  3241  e8205fc5ff     call 0x9c0237062ee       ;; deoptimization bailout 75
                  ;;; jump table entry 71: deoptimization bailout 76.
0x9c023ab03ce  3246  e8255fc5ff     call 0x9c0237062f8       ;; deoptimization bailout 76
                  ;;; jump table entry 72: deoptimization bailout 78.
0x9c023ab03d3  3251  e8345fc5ff     call 0x9c02370630c       ;; deoptimization bailout 78
                  ;;; jump table entry 73: deoptimization bailout 79.
0x9c023ab03d8  3256  e8395fc5ff     call 0x9c023706316       ;; deoptimization bailout 79
                  ;;; jump table entry 74: deoptimization bailout 80.
0x9c023ab03dd  3261  e83e5fc5ff     call 0x9c023706320       ;; deoptimization bailout 80
                  ;;; jump table entry 75: deoptimization bailout 81.
0x9c023ab03e2  3266  e8435fc5ff     call 0x9c02370632a       ;; deoptimization bailout 81
                  ;;; jump table entry 76: deoptimization bailout 82.
0x9c023ab03e7  3271  e8485fc5ff     call 0x9c023706334       ;; deoptimization bailout 82
                  ;;; jump table entry 77: deoptimization bailout 83.
0x9c023ab03ec  3276  e84d5fc5ff     call 0x9c02370633e       ;; deoptimization bailout 83
                  ;;; jump table entry 78: deoptimization bailout 84.
0x9c023ab03f1  3281  e8525fc5ff     call 0x9c023706348       ;; deoptimization bailout 84
                  ;;; jump table entry 79: deoptimization bailout 86.
0x9c023ab03f6  3286  e8615fc5ff     call 0x9c02370635c       ;; deoptimization bailout 86
                  ;;; jump table entry 80: deoptimization bailout 87.
0x9c023ab03fb  3291  e8665fc5ff     call 0x9c023706366       ;; deoptimization bailout 87
                  ;;; jump table entry 81: deoptimization bailout 98.
0x9c023ab0400  3296  e8cf5fc5ff     call 0x9c0237063d4       ;; deoptimization bailout 98
0x9c023ab0405  3301  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 99)
 index  ast id    argc     pc             
     0       3       0     35
     1       3       0     -1
     2       2       0     -1
     3       2       0     -1
     4      14       0     -1
     5      14       0     -1
     6      14       0     -1
     7      14       0     -1
     8      14       0     -1
     9      14       0     -1
    10      14       0     -1
    11      14       0     -1
    12      14       0     -1
    13      14       0     -1
    14      14       0     -1
    15      14       0     -1
    16     210       0     -1
    17     123       0    387
    18     123       0     -1
    19     123       0     -1
    20     123       0     -1
    21     123       0     -1
    22     156       0     -1
    23     156       0     -1
    24      65       0     -1
    25      65       0     -1
    26      65       0     -1
    27      65       0     -1
    28      65       0     -1
    29      65       0     -1
    30      65       0     -1
    31      65       0     -1
    32      65       0     -1
    33      16       0    898
    34      19       0     -1
    35      28       0     -1
    36      54       0     -1
    37      63       0     -1
    38      63       0     -1
    39      63       0     -1
    40      81       0     -1
    41      81       0     -1
    42      81       0     -1
    43     100       0     -1
    44     100       0     -1
    45     100       0     -1
    46     100       0     -1
    47     100       0     -1
    48     100       0     -1
    49     100       0     -1
    50     100       0     -1
    51     100       0     -1
    52     100       0     -1
    53     100       0     -1
    54     100       0     -1
    55     100       0     -1
    56     100       0     -1
    57     100       0     -1
    58     194       0     -1
    59     242       0   1516
    60     242       0     -1
    61     242       0     -1
    62     242       0     -1
    63     242       0     -1
    64     242       0     -1
    65     242       0     -1
    66     242       0     -1
    67     242       0     -1
    68     328       0     -1
    69     337       0     -1
    70     352       0   1702
    71     352       0     -1
    72     352       0     -1
    73     352       0     -1
    74     352       0     -1
    75     454       0     -1
    76     434       0     -1
    77     453       0     -1
    78     349       0     -1
    79     461       0     -1
    80     461       0     -1
    81     486       0     -1
    82     486       0     -1
    83     500       0     -1
    84     500       0     -1
    85     489       0   1910
    86     489       0     -1
    87     540       0     -1
    88      14       0     -1
    89      14       0     -1
    90      65       0     -1
    91      65       0     -1
    92      65       0     -1
    93      65       0     -1
    94       2       0     -1
    95      19       0     -1
    96      28       0     -1
    97      54       0     -1
    98      63       0     -1

Safepoints (size = 80)
0x9c023aaf743    35  0000000001 (sp -> fp)       0
0x9c023aafaa2   898  0000100001 (sp -> fp)      33
0x9c023aaff74  2132  0000000001 | rdx | rbx (sp -> fp)      17
0x9c023ab01cf  2735  0010000001 (sp -> fp)      59
0x9c023ab0210  2800  0010000001 (sp -> fp)      70
0x9c023ab0251  2865  0010000001 (sp -> fp)      85

RelocInfo (size = 5981)
0x9c023aaf72a  position  (5380)
0x9c023aaf72a  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x9c023aaf72a  comment  (;;; <@2,#1> context)
0x9c023aaf72e  comment  (;;; <@3,#1> gap)
0x9c023aaf732  comment  (;;; <@12,#9> -------------------- B1 --------------------)
0x9c023aaf732  comment  (;;; <@13,#9> gap)
0x9c023aaf735  comment  (;;; <@14,#11> stack-check)
0x9c023aaf73f  code target (BUILTIN)  (0x9c023a25e60)
0x9c023aaf743  comment  (;;; <@16,#11> lazy-bailout)
0x9c023aaf743  comment  (;;; <@17,#11> gap)
0x9c023aaf747  comment  (;;; <@18,#12> load-context-slot)
0x9c023aaf747  position  (5404)
0x9c023aaf74e  comment  (;;; <@20,#13> check-value)
0x9c023aaf750  embedded object  (0x364e0635f659 <JS Function compare_abs (SharedFunctionInfo 0xc1217b4d931)>)
0x9c023aaf761  comment  (;;; <@21,#13> gap)
0x9c023aaf765  comment  (;;; <@22,#777> check-smi)
0x9c023aaf765  position  (12617)
0x9c023aaf76e  comment  (;;; <@23,#777> gap)
0x9c023aaf772  comment  (;;; <@24,#781> check-smi)
0x9c023aaf772  position  (12623)
0x9c023aaf77b  position  (12619)
0x9c023aaf77b  comment  (;;; <@27,#19> compare-numeric-and-branch)
0x9c023aaf784  comment  (;;; <@28,#23> -------------------- B2 (unreachable/replaced) --------------------)
0x9c023aaf784  position  (12649)
0x9c023aaf784  comment  (;;; <@32,#31> -------------------- B3 --------------------)
0x9c023aaf784  comment  (;;; <@34,#16> constant-t)
0x9c023aaf784  position  (12600)
0x9c023aaf786  embedded object  (0x364e0635ef91 <FixedArray[49]>)
0x9c023aaf78e  comment  (;;; <@36,#32> load-context-slot)
0x9c023aaf78e  position  (12649)
0x9c023aaf795  comment  (;;; <@38,#33> check-non-smi)
0x9c023aaf795  position  (12654)
0x9c023aaf79e  comment  (;;; <@40,#34> check-maps)
0x9c023aaf7a0  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aaf7b2  comment  (;;; <@42,#35> load-named-field)
0x9c023aaf7b6  comment  (;;; <@44,#36> load-named-field)
0x9c023aaf7b9  comment  (;;; <@46,#37> load-named-field)
0x9c023aaf7bd  comment  (;;; <@47,#37> gap)
0x9c023aaf7c1  comment  (;;; <@48,#776> tagged-to-i)
0x9c023aaf7cf  comment  (;;; <@50,#38> bounds-check)
0x9c023aaf7d7  comment  (;;; <@52,#39> load-keyed)
0x9c023aaf7e2  comment  (;;; <@53,#39> gap)
0x9c023aaf7e6  comment  (;;; <@54,#780> tagged-to-i)
0x9c023aaf7e6  position  (12675)
0x9c023aaf7f4  comment  (;;; <@56,#47> bounds-check)
0x9c023aaf7fc  comment  (;;; <@58,#48> load-keyed)
0x9c023aaf807  comment  (;;; <@60,#16> constant-t)
0x9c023aaf807  position  (12600)
0x9c023aaf809  embedded object  (0x364e0635ef91 <FixedArray[49]>)
0x9c023aaf811  comment  (;;; <@62,#50> load-context-slot)
0x9c023aaf811  position  (12696)
0x9c023aaf818  comment  (;;; <@64,#52> check-non-smi)
0x9c023aaf818  position  (12701)
0x9c023aaf821  comment  (;;; <@66,#53> check-maps)
0x9c023aaf823  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aaf835  comment  (;;; <@68,#54> load-named-field)
0x9c023aaf839  comment  (;;; <@70,#55> load-named-field)
0x9c023aaf83d  comment  (;;; <@72,#56> load-named-field)
0x9c023aaf841  comment  (;;; <@74,#57> bounds-check)
0x9c023aaf84a  comment  (;;; <@76,#58> load-keyed)
0x9c023aaf857  comment  (;;; <@78,#67> bounds-check)
0x9c023aaf857  position  (12727)
0x9c023aaf860  comment  (;;; <@80,#68> load-keyed)
0x9c023aaf86d  position  (12748)
0x9c023aaf86d  comment  (;;; <@83,#72> compare-numeric-and-branch)
0x9c023aaf876  comment  (;;; <@84,#76> -------------------- B4 (unreachable/replaced) --------------------)
0x9c023aaf876  position  (12793)
0x9c023aaf876  comment  (;;; <@88,#85> -------------------- B5 --------------------)
0x9c023aaf876  position  (12800)
0x9c023aaf876  comment  (;;; <@91,#88> compare-numeric-and-branch)
0x9c023aaf87f  comment  (;;; <@92,#92> -------------------- B6 (unreachable/replaced) --------------------)
0x9c023aaf87f  position  (12861)
0x9c023aaf87f  comment  (;;; <@96,#100> -------------------- B7 --------------------)
0x9c023aaf87f  comment  (;;; <@97,#100> gap)
0x9c023aaf882  comment  (;;; <@98,#103> sub-i)
0x9c023aaf882  position  (12868)
0x9c023aaf88c  position  (12873)
0x9c023aaf88c  comment  (;;; <@102,#117> -------------------- B8 (loop header) --------------------)
0x9c023aaf88c  position  (12875)
0x9c023aaf88c  comment  (;;; <@105,#120> compare-numeric-and-branch)
0x9c023aaf896  comment  (;;; <@106,#121> -------------------- B9 (unreachable/replaced) --------------------)
0x9c023aaf896  comment  (;;; <@110,#127> -------------------- B10 --------------------)
0x9c023aaf896  comment  (;;; <@112,#129> stack-check)
0x9c023aaf8a3  comment  (;;; <@113,#129> gap)
0x9c023aaf8a6  comment  (;;; <@114,#133> add-i)
0x9c023aaf8a6  position  (12909)
0x9c023aaf8af  comment  (;;; <@116,#140> bounds-check)
0x9c023aaf8b8  comment  (;;; <@118,#141> load-keyed)
0x9c023aaf8c5  comment  (;;; <@119,#141> gap)
0x9c023aaf8c8  comment  (;;; <@120,#145> add-i)
0x9c023aaf8c8  position  (12924)
0x9c023aaf8d1  comment  (;;; <@122,#152> bounds-check)
0x9c023aaf8da  comment  (;;; <@124,#153> load-keyed)
0x9c023aaf8e6  position  (12914)
0x9c023aaf8e6  comment  (;;; <@127,#154> compare-numeric-and-branch)
0x9c023aaf8ef  comment  (;;; <@128,#158> -------------------- B11 (unreachable/replaced) --------------------)
0x9c023aaf8ef  position  (12973)
0x9c023aaf8ef  comment  (;;; <@132,#166> -------------------- B12 --------------------)
0x9c023aaf8ef  position  (12986)
0x9c023aaf8ef  comment  (;;; <@135,#191> compare-numeric-and-branch)
0x9c023aaf8f8  comment  (;;; <@136,#195> -------------------- B13 (unreachable/replaced) --------------------)
0x9c023aaf8f8  position  (12880)
0x9c023aaf8f8  comment  (;;; <@140,#203> -------------------- B14 --------------------)
0x9c023aaf8f8  comment  (;;; <@142,#206> add-i)
0x9c023aaf8fc  comment  (;;; <@145,#209> goto)
0x9c023aaf8fe  comment  (;;; <@146,#155> -------------------- B15 (unreachable/replaced) --------------------)
0x9c023aaf8fe  position  (12950)
0x9c023aaf8fe  comment  (;;; <@150,#161> -------------------- B16 --------------------)
0x9c023aaf8fe  comment  (;;; <@152,#165> gap)
0x9c023aaf903  comment  (;;; <@153,#165> goto)
0x9c023aaf908  comment  (;;; <@154,#192> -------------------- B17 (unreachable/replaced) --------------------)
0x9c023aaf908  position  (13022)
0x9c023aaf908  comment  (;;; <@158,#198> -------------------- B18 --------------------)
0x9c023aaf908  comment  (;;; <@160,#202> gap)
0x9c023aaf90d  comment  (;;; <@161,#202> goto)
0x9c023aaf912  comment  (;;; <@162,#124> -------------------- B19 (unreachable/replaced) --------------------)
0x9c023aaf912  position  (13055)
0x9c023aaf912  comment  (;;; <@166,#210> -------------------- B20 --------------------)
0x9c023aaf912  comment  (;;; <@168,#214> gap)
0x9c023aaf914  comment  (;;; <@169,#214> goto)
0x9c023aaf919  comment  (;;; <@170,#89> -------------------- B21 (unreachable/replaced) --------------------)
0x9c023aaf919  position  (12826)
0x9c023aaf919  comment  (;;; <@174,#95> -------------------- B22 --------------------)
0x9c023aaf919  comment  (;;; <@176,#99> gap)
0x9c023aaf91e  comment  (;;; <@177,#99> goto)
0x9c023aaf923  comment  (;;; <@178,#73> -------------------- B23 (unreachable/replaced) --------------------)
0x9c023aaf923  position  (12774)
0x9c023aaf923  comment  (;;; <@182,#79> -------------------- B24 --------------------)
0x9c023aaf923  comment  (;;; <@184,#83> gap)
0x9c023aaf928  comment  (;;; <@185,#83> goto)
0x9c023aaf92d  comment  (;;; <@186,#20> -------------------- B25 (unreachable/replaced) --------------------)
0x9c023aaf92d  position  (12634)
0x9c023aaf92d  comment  (;;; <@190,#26> -------------------- B26 --------------------)
0x9c023aaf92d  comment  (;;; <@192,#30> gap)
0x9c023aaf92f  position  (5419)
0x9c023aaf92f  comment  (;;; <@194,#215> -------------------- B27 --------------------)
0x9c023aaf933  position  (5436)
0x9c023aaf933  comment  (;;; <@197,#219> compare-numeric-and-branch)
0x9c023aaf93c  comment  (;;; <@198,#223> -------------------- B28 (unreachable/replaced) --------------------)
0x9c023aaf93c  position  (5480)
0x9c023aaf93c  comment  (;;; <@202,#230> -------------------- B29 --------------------)
0x9c023aaf93c  position  (5485)
0x9c023aaf93c  comment  (;;; <@205,#233> compare-numeric-and-branch)
0x9c023aaf945  comment  (;;; <@206,#237> -------------------- B30 (unreachable/replaced) --------------------)
0x9c023aaf945  position  (5531)
0x9c023aaf945  comment  (;;; <@210,#245> -------------------- B31 --------------------)
0x9c023aaf945  comment  (;;; <@211,#245> gap)
0x9c023aaf949  comment  (;;; <@212,#775> tagged-to-i)
0x9c023aaf949  position  (5557)
0x9c023aaf956  comment  (;;; <@213,#775> gap)
0x9c023aaf95a  comment  (;;; <@214,#778> tagged-to-i)
0x9c023aaf967  comment  (;;; <@216,#247> gap)
0x9c023aaf967  position  (5531)
0x9c023aaf96a  comment  (;;; <@217,#247> goto)
0x9c023aaf96f  comment  (;;; <@218,#234> -------------------- B32 (unreachable/replaced) --------------------)
0x9c023aaf96f  position  (5507)
0x9c023aaf96f  comment  (;;; <@222,#240> -------------------- B33 --------------------)
0x9c023aaf96f  comment  (;;; <@223,#240> gap)
0x9c023aaf973  comment  (;;; <@224,#774> tagged-to-i)
0x9c023aaf973  position  (5557)
0x9c023aaf980  comment  (;;; <@225,#774> gap)
0x9c023aaf984  comment  (;;; <@226,#779> tagged-to-i)
0x9c023aaf991  position  (5531)
0x9c023aaf991  position  (5557)
0x9c023aaf991  comment  (;;; <@230,#251> -------------------- B34 --------------------)
0x9c023aaf999  comment  (;;; <@231,#251> gap)
0x9c023aaf99d  comment  (;;; <@232,#252> load-context-slot)
0x9c023aaf9a4  comment  (;;; <@234,#253> load-context-slot)
0x9c023aaf9a4  position  (5562)
0x9c023aaf9ab  comment  (;;; <@236,#254> check-non-smi)
0x9c023aaf9ab  position  (5567)
0x9c023aaf9b5  comment  (;;; <@238,#255> check-maps)
0x9c023aaf9b7  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aaf9c9  comment  (;;; <@240,#256> load-named-field)
0x9c023aaf9cd  comment  (;;; <@242,#257> load-named-field)
0x9c023aaf9d1  comment  (;;; <@244,#258> load-named-field)
0x9c023aaf9d5  comment  (;;; <@246,#259> bounds-check)
0x9c023aaf9de  comment  (;;; <@248,#260> load-keyed)
0x9c023aaf9eb  comment  (;;; <@250,#261> check-non-smi)
0x9c023aaf9f5  comment  (;;; <@252,#262> check-maps)
0x9c023aaf9f7  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aafa09  comment  (;;; <@254,#263> load-named-field)
0x9c023aafa0d  comment  (;;; <@256,#264> load-named-field)
0x9c023aafa10  comment  (;;; <@258,#265> load-named-field)
0x9c023aafa14  comment  (;;; <@260,#266> bounds-check)
0x9c023aafa1d  comment  (;;; <@262,#267> load-keyed)
0x9c023aafa2a  comment  (;;; <@263,#267> gap)
0x9c023aafa2e  comment  (;;; <@264,#269> load-context-slot)
0x9c023aafa2e  position  (5584)
0x9c023aafa35  comment  (;;; <@265,#269> gap)
0x9c023aafa39  comment  (;;; <@266,#270> check-value)
0x9c023aafa3b  embedded object  (0x364e0635fca1 <JS Function alloc (SharedFunctionInfo 0xc1217b4f389)>)
0x9c023aafa4c  comment  (;;; <@268,#273> constant-t)
0x9c023aafa4c  position  (2106)
0x9c023aafa4e  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aafa56  comment  (;;; <@270,#276> load-context-slot)
0x9c023aafa56  position  (2205)
0x9c023aafa5a  comment  (;;; <@272,#783> tagged-to-i)
0x9c023aafa68  position  (2203)
0x9c023aafa68  comment  (;;; <@275,#277> compare-numeric-and-branch)
0x9c023aafa71  comment  (;;; <@276,#281> -------------------- B35 (unreachable/replaced) --------------------)
0x9c023aafa71  comment  (;;; <@280,#292> -------------------- B36 (unreachable/replaced) --------------------)
0x9c023aafa71  comment  (;;; <@284,#278> -------------------- B37 (unreachable/replaced) --------------------)
0x9c023aafa71  position  (2229)
0x9c023aafa71  comment  (;;; <@288,#284> -------------------- B38 --------------------)
0x9c023aafa71  comment  (;;; <@290,#273> constant-t)
0x9c023aafa71  position  (2106)
0x9c023aafa73  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aafa7b  comment  (;;; <@292,#285> load-context-slot)
0x9c023aafa7b  position  (2229)
0x9c023aafa7f  comment  (;;; <@294,#286> push-argument)
0x9c023aafa7f  position  (2236)
0x9c023aafa81  embedded object  (0x364e06304121 <undefined>)
0x9c023aafa8b  comment  (;;; <@296,#782> smi-tag)
0x9c023aafa92  comment  (;;; <@298,#287> push-argument)
0x9c023aafa93  comment  (;;; <@300,#273> constant-t)
0x9c023aafa93  position  (2106)
0x9c023aafa95  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aafa9d  comment  (;;; <@302,#288> call-function)
0x9c023aafa9d  position  (2236)
0x9c023aafa9e  code target (STUB)  (0x9c023a28d20)
0x9c023aafaa2  comment  (;;; <@304,#289> lazy-bailout)
0x9c023aafaa2  position  (2258)
0x9c023aafaa2  comment  (;;; <@308,#295> -------------------- B39 --------------------)
0x9c023aafaa2  comment  (;;; <@310,#273> constant-t)
0x9c023aafaa2  position  (2106)
0x9c023aafaa4  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aafaac  comment  (;;; <@312,#296> load-context-slot)
0x9c023aafaac  position  (2258)
0x9c023aafab0  comment  (;;; <@314,#784> tagged-to-i)
0x9c023aafabc  comment  (;;; <@316,#297> sub-i)
0x9c023aafabc  position  (2271)
0x9c023aafac5  comment  (;;; <@318,#785> smi-tag)
0x9c023aafacb  comment  (;;; <@320,#273> constant-t)
0x9c023aafacb  position  (2106)
0x9c023aafacd  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aafad5  comment  (;;; <@322,#299> store-context-slot)
0x9c023aafad5  position  (2271)
0x9c023aafad9  comment  (;;; <@324,#273> constant-t)
0x9c023aafad9  position  (2106)
0x9c023aafadb  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aafae3  comment  (;;; <@326,#301> load-context-slot)
0x9c023aafae3  position  (2378)
0x9c023aafae7  comment  (;;; <@327,#301> gap)
0x9c023aafaea  comment  (;;; <@328,#788> tagged-to-i)
0x9c023aafaea  position  (2394)
0x9c023aafaf7  comment  (;;; <@329,#788> gap)
0x9c023aafafa  comment  (;;; <@330,#304> add-i)
0x9c023aafafa  position  (2398)
0x9c023aafb03  comment  (;;; <@332,#789> smi-tag)
0x9c023aafb09  comment  (;;; <@334,#273> constant-t)
0x9c023aafb09  position  (2106)
0x9c023aafb0b  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aafb13  comment  (;;; <@336,#306> store-context-slot)
0x9c023aafb13  position  (2398)
0x9c023aafb17  comment  (;;; <@338,#273> constant-t)
0x9c023aafb17  position  (2106)
0x9c023aafb19  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aafb21  comment  (;;; <@340,#308> load-context-slot)
0x9c023aafb21  position  (2484)
0x9c023aafb25  comment  (;;; <@342,#790> tagged-to-i)
0x9c023aafb31  comment  (;;; <@343,#790> gap)
0x9c023aafb38  comment  (;;; <@344,#311> add-i)
0x9c023aafb41  comment  (;;; <@346,#792> smi-tag)
0x9c023aafb47  comment  (;;; <@348,#273> constant-t)
0x9c023aafb47  position  (2106)
0x9c023aafb49  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aafb51  comment  (;;; <@350,#312> store-context-slot)
0x9c023aafb51  position  (2484)
0x9c023aafb55  comment  (;;; <@352,#273> constant-t)
0x9c023aafb55  position  (2106)
0x9c023aafb57  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023aafb5f  comment  (;;; <@354,#315> load-named-field)
0x9c023aafb5f  position  (2497)
0x9c023aafb63  comment  (;;; <@356,#316> load-context-slot)
0x9c023aafb6a  comment  (;;; <@358,#319> check-non-smi)
0x9c023aafb6a  position  (2513)
0x9c023aafb74  comment  (;;; <@360,#320> check-maps)
0x9c023aafb76  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aafb88  comment  (;;; <@362,#322> check-maps)
0x9c023aafb88  comment  (;;; <@364,#324> check-maps)
0x9c023aafb88  comment  (;;; <@366,#325> load-named-field)
0x9c023aafb8c  comment  (;;; <@368,#326> load-named-field)
0x9c023aafb90  comment  (;;; <@370,#327> load-named-field)
0x9c023aafb94  comment  (;;; <@372,#328> bounds-check)
0x9c023aafb9d  comment  (;;; <@373,#328> gap)
0x9c023aafba0  comment  (;;; <@374,#787> tagged-to-i)
0x9c023aafbae  comment  (;;; <@376,#329> store-keyed)
0x9c023aafbb2  comment  (;;; <@378,#332> load-context-slot)
0x9c023aafbb2  position  (2528)
0x9c023aafbb9  comment  (;;; <@380,#334> check-non-smi)
0x9c023aafbb9  position  (2545)
0x9c023aafbc2  comment  (;;; <@382,#335> check-maps)
0x9c023aafbc4  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aafbd6  comment  (;;; <@384,#340> load-named-field)
0x9c023aafbda  comment  (;;; <@386,#341> load-named-field)
0x9c023aafbdd  comment  (;;; <@388,#342> load-named-field)
0x9c023aafbe1  comment  (;;; <@390,#343> bounds-check)
0x9c023aafbe9  comment  (;;; <@391,#343> gap)
0x9c023aafbed  comment  (;;; <@392,#344> store-keyed)
0x9c023aafbf0  position  (2565)
0x9c023aafbf0  position  (5590)
0x9c023aafbf0  comment  (;;; <@396,#350> -------------------- B40 --------------------)
0x9c023aafbf0  comment  (;;; <@397,#350> gap)
0x9c023aafbf4  comment  (;;; <@398,#352> load-context-slot)
0x9c023aafbf4  position  (5611)
0x9c023aafbfb  comment  (;;; <@400,#354> check-non-smi)
0x9c023aafbfb  position  (5616)
0x9c023aafc04  comment  (;;; <@402,#355> check-maps)
0x9c023aafc06  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aafc18  comment  (;;; <@404,#356> load-named-field)
0x9c023aafc1c  comment  (;;; <@406,#357> load-named-field)
0x9c023aafc1f  comment  (;;; <@408,#358> load-named-field)
0x9c023aafc23  comment  (;;; <@410,#359> bounds-check)
0x9c023aafc2b  comment  (;;; <@412,#360> load-keyed)
0x9c023aafc39  comment  (;;; <@413,#360> gap)
0x9c023aafc41  comment  (;;; <@414,#368> bounds-check)
0x9c023aafc41  position  (5638)
0x9c023aafc4a  comment  (;;; <@416,#369> load-keyed)
0x9c023aafc57  comment  (;;; <@417,#369> gap)
0x9c023aafc5b  comment  (;;; <@418,#377> bounds-check)
0x9c023aafc5b  position  (5659)
0x9c023aafc64  comment  (;;; <@420,#378> load-keyed)
0x9c023aafc70  comment  (;;; <@422,#380> load-context-slot)
0x9c023aafc70  position  (5680)
0x9c023aafc77  comment  (;;; <@423,#380> gap)
0x9c023aafc7b  comment  (;;; <@424,#382> check-non-smi)
0x9c023aafc7b  position  (5685)
0x9c023aafc84  comment  (;;; <@426,#383> check-maps)
0x9c023aafc86  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023aafc98  comment  (;;; <@428,#384> load-named-field)
0x9c023aafc9c  comment  (;;; <@430,#385> load-named-field)
0x9c023aafca0  comment  (;;; <@432,#386> load-named-field)
0x9c023aafca4  comment  (;;; <@434,#387> bounds-check)
0x9c023aafcad  comment  (;;; <@436,#388> load-keyed)
0x9c023aafcb9  comment  (;;; <@438,#397> bounds-check)
0x9c023aafcb9  position  (5711)
0x9c023aafcc2  comment  (;;; <@440,#398> load-keyed)
0x9c023aafcce  comment  (;;; <@441,#398> gap)
0x9c023aafcd1  comment  (;;; <@442,#403> add-i)
0x9c023aafcd1  position  (5728)
0x9c023aafcda  comment  (;;; <@444,#415> bounds-check)
0x9c023aafcda  position  (5735)
0x9c023aafce3  comment  (;;; <@446,#218> constant-i)
0x9c023aafce3  position  (5440)
0x9c023aafce5  comment  (;;; <@448,#416> store-keyed)
0x9c023aafce5  position  (5735)
0x9c023aafcea  comment  (;;; <@450,#442> gap)
0x9c023aafcea  position  (5805)
0x9c023aafcf7  position  (5808)
0x9c023aafcf7  comment  (;;; <@452,#443> -------------------- B41 (loop header) --------------------)
0x9c023aafcf7  position  (5810)
0x9c023aafcf7  comment  (;;; <@455,#446> compare-numeric-and-branch)
0x9c023aafcff  comment  (;;; <@456,#447> -------------------- B42 (unreachable/replaced) --------------------)
0x9c023aafcff  comment  (;;; <@460,#453> -------------------- B43 --------------------)
0x9c023aafcff  comment  (;;; <@462,#455> stack-check)
0x9c023aafd0c  comment  (;;; <@463,#455> gap)
0x9c023aafd0f  comment  (;;; <@464,#459> add-i)
0x9c023aafd0f  position  (5847)
0x9c023aafd18  comment  (;;; <@466,#466> bounds-check)
0x9c023aafd21  comment  (;;; <@468,#467> load-keyed)
0x9c023aafd2e  comment  (;;; <@469,#467> gap)
0x9c023aafd31  comment  (;;; <@470,#471> add-i)
0x9c023aafd31  position  (5862)
0x9c023aafd3a  comment  (;;; <@472,#478> bounds-check)
0x9c023aafd43  comment  (;;; <@474,#479> load-keyed)
0x9c023aafd50  comment  (;;; <@476,#480> sub-i)
0x9c023aafd50  position  (5852)
0x9c023aafd59  comment  (;;; <@478,#483> sub-i)
0x9c023aafd59  position  (5867)
0x9c023aafd63  position  (5888)
0x9c023aafd63  comment  (;;; <@481,#488> compare-numeric-and-branch)
0x9c023aafd6d  comment  (;;; <@482,#492> -------------------- B44 (unreachable/replaced) --------------------)
0x9c023aafd6d  position  (5968)
0x9c023aafd6d  comment  (;;; <@486,#503> -------------------- B45 --------------------)
0x9c023aafd6d  comment  (;;; <@488,#509> gap)
0x9c023aafd73  comment  (;;; <@489,#509> goto)
0x9c023aafd78  comment  (;;; <@490,#489> -------------------- B46 (unreachable/replaced) --------------------)
0x9c023aafd78  position  (5904)
0x9c023aafd78  comment  (;;; <@494,#495> -------------------- B47 --------------------)
0x9c023aafd78  comment  (;;; <@496,#498> add-i)
0x9c023aafd78  position  (5907)
0x9c023aafd7f  comment  (;;; <@498,#507> gap)
0x9c023aafd7f  position  (5968)
0x9c023aafd88  position  (5984)
0x9c023aafd88  comment  (;;; <@500,#512> -------------------- B48 --------------------)
0x9c023aafd88  comment  (;;; <@501,#512> gap)
0x9c023aafd8c  comment  (;;; <@502,#516> add-i)
0x9c023aafd8c  position  (5992)
0x9c023aafd94  comment  (;;; <@504,#528> bounds-check)
0x9c023aafd94  position  (5999)
0x9c023aafd9d  comment  (;;; <@506,#529> store-keyed)
0x9c023aafda1  comment  (;;; <@508,#532> add-i)
0x9c023aafda1  position  (5820)
0x9c023aafda4  comment  (;;; <@510,#535> gap)
0x9c023aafda8  comment  (;;; <@511,#535> goto)
0x9c023aafdad  comment  (;;; <@512,#450> -------------------- B49 (unreachable/replaced) --------------------)
0x9c023aafdad  position  (6011)
0x9c023aafdad  comment  (;;; <@516,#553> -------------------- B50 --------------------)
0x9c023aafdad  comment  (;;; <@518,#555> gap)
0x9c023aafdb1  position  (6019)
0x9c023aafdb1  comment  (;;; <@520,#556> -------------------- B51 (loop header) --------------------)
0x9c023aafdb1  position  (6021)
0x9c023aafdb1  comment  (;;; <@523,#559> compare-numeric-and-branch)
0x9c023aafdb9  comment  (;;; <@524,#560> -------------------- B52 (unreachable/replaced) --------------------)
0x9c023aafdb9  comment  (;;; <@528,#566> -------------------- B53 --------------------)
0x9c023aafdb9  comment  (;;; <@530,#568> stack-check)
0x9c023aafdc6  comment  (;;; <@531,#568> gap)
0x9c023aafdc9  comment  (;;; <@532,#572> add-i)
0x9c023aafdc9  position  (6058)
0x9c023aafdd1  comment  (;;; <@534,#579> bounds-check)
0x9c023aafdda  comment  (;;; <@536,#580> load-keyed)
0x9c023aafde6  comment  (;;; <@538,#582> sub-i)
0x9c023aafde6  position  (6063)
0x9c023aafdee  position  (6084)
0x9c023aafdee  comment  (;;; <@541,#587> compare-numeric-and-branch)
0x9c023aafdf7  comment  (;;; <@542,#591> -------------------- B54 (unreachable/replaced) --------------------)
0x9c023aafdf7  position  (6170)
0x9c023aafdf7  comment  (;;; <@546,#614> -------------------- B55 --------------------)
0x9c023aafdf7  comment  (;;; <@547,#614> gap)
0x9c023aafdfb  comment  (;;; <@548,#618> add-i)
0x9c023aafdfb  position  (6178)
0x9c023aafe03  comment  (;;; <@550,#630> bounds-check)
0x9c023aafe03  position  (6185)
0x9c023aafe0c  comment  (;;; <@552,#631> store-keyed)
0x9c023aafe10  comment  (;;; <@554,#638> gap)
0x9c023aafe10  position  (6203)
0x9c023aafe12  comment  (;;; <@555,#638> goto)
0x9c023aafe17  comment  (;;; <@556,#588> -------------------- B56 (unreachable/replaced) --------------------)
0x9c023aafe17  position  (6100)
0x9c023aafe17  comment  (;;; <@560,#594> -------------------- B57 --------------------)
0x9c023aafe17  comment  (;;; <@562,#598> deoptimize)
0x9c023aafe17  position  (6108)
0x9c023aafe17  comment  (;;; deoptimize: Insufficient type feedback for LHS of binary operation)
0x9c023aafe18  runtime entry
0x9c023aafe1c  comment  (;;; <@564,#599> -------------------- B58 (unreachable/replaced) --------------------)
0x9c023aafe1c  comment  (;;; <@568,#601> -------------------- B59 (unreachable/replaced) --------------------)
0x9c023aafe1c  comment  (;;; <@584,#609> -------------------- B60 (unreachable/replaced) --------------------)
0x9c023aafe1c  position  (6031)
0x9c023aafe1c  comment  (;;; <@600,#640> -------------------- B61 --------------------)
0x9c023aafe1c  comment  (;;; <@602,#642> add-i)
0x9c023aafe1f  comment  (;;; <@605,#645> goto)
0x9c023aafe21  comment  (;;; <@606,#563> -------------------- B62 (unreachable/replaced) --------------------)
0x9c023aafe21  position  (6223)
0x9c023aafe21  comment  (;;; <@610,#646> -------------------- B63 --------------------)
0x9c023aafe21  comment  (;;; <@611,#646> gap)
0x9c023aafe25  comment  (;;; <@612,#650> add-i)
0x9c023aafe25  position  (6231)
0x9c023aafe2d  comment  (;;; <@614,#657> bounds-check)
0x9c023aafe36  comment  (;;; <@616,#658> load-keyed)
0x9c023aafe42  comment  (;;; <@618,#660> sub-i)
0x9c023aafe42  position  (6239)
0x9c023aafe44  comment  (;;; <@620,#672> store-keyed)
0x9c023aafe48  comment  (;;; <@622,#694> gap)
0x9c023aafe48  position  (6278)
0x9c023aafe4a  position  (6286)
0x9c023aafe4a  comment  (;;; <@624,#695> -------------------- B64 (loop header) --------------------)
0x9c023aafe4a  comment  (;;; <@625,#695> gap)
0x9c023aafe4d  comment  (;;; <@626,#699> add-i)
0x9c023aafe4d  position  (6299)
0x9c023aafe56  comment  (;;; <@627,#699> gap)
0x9c023aafe5a  comment  (;;; <@628,#701> add-i)
0x9c023aafe5a  position  (6294)
0x9c023aafe62  comment  (;;; <@630,#708> bounds-check)
0x9c023aafe6b  comment  (;;; <@632,#709> load-keyed)
0x9c023aafe77  position  (6303)
0x9c023aafe77  comment  (;;; <@635,#711> compare-numeric-and-branch)
0x9c023aafe80  comment  (;;; <@636,#712> -------------------- B65 (unreachable/replaced) --------------------)
0x9c023aafe80  position  (6312)
0x9c023aafe80  comment  (;;; <@640,#718> -------------------- B66 --------------------)
0x9c023aafe80  position  (6314)
0x9c023aafe80  comment  (;;; <@643,#721> compare-numeric-and-branch)
0x9c023aafe89  comment  (;;; <@644,#722> -------------------- B67 (unreachable/replaced) --------------------)
0x9c023aafe89  comment  (;;; <@648,#728> -------------------- B68 --------------------)
0x9c023aafe89  comment  (;;; <@650,#730> stack-check)
0x9c023aafe96  comment  (;;; <@651,#730> gap)
0x9c023aafe99  comment  (;;; <@652,#732> add-i)
0x9c023aafe99  position  (6327)
0x9c023aafea2  comment  (;;; <@654,#735> gap)
0x9c023aafea8  comment  (;;; <@655,#735> goto)
0x9c023aafeaa  comment  (;;; <@656,#725> -------------------- B69 (unreachable/replaced) --------------------)
0x9c023aafeaa  comment  (;;; <@660,#715> -------------------- B70 (unreachable/replaced) --------------------)
0x9c023aafeaa  position  (6360)
0x9c023aafeaa  comment  (;;; <@664,#736> -------------------- B71 --------------------)
0x9c023aafeaa  comment  (;;; <@667,#738> branch)
0x9c023aafeb2  comment  (;;; <@668,#742> -------------------- B72 (unreachable/replaced) --------------------)
0x9c023aafeb2  comment  (;;; <@672,#766> -------------------- B73 (unreachable/replaced) --------------------)
0x9c023aafeb2  comment  (;;; <@676,#739> -------------------- B74 (unreachable/replaced) --------------------)
0x9c023aafeb2  position  (6378)
0x9c023aafeb2  comment  (;;; <@680,#745> -------------------- B75 --------------------)
0x9c023aafeb2  comment  (;;; <@682,#750> sub-i)
0x9c023aafeb2  position  (6396)
0x9c023aafeb4  comment  (;;; <@683,#750> gap)
0x9c023aafeb8  comment  (;;; <@684,#761> bounds-check)
0x9c023aafec1  comment  (;;; <@686,#762> store-keyed)
0x9c023aafec5  position  (6426)
0x9c023aafec5  comment  (;;; <@690,#769> -------------------- B76 --------------------)
0x9c023aafec5  comment  (;;; <@691,#769> gap)
0x9c023aafec9  comment  (;;; <@692,#791> smi-tag)
0x9c023aafecf  comment  (;;; <@693,#791> gap)
0x9c023aafed2  comment  (;;; <@694,#772> return)
0x9c023aafed9  comment  (;;; <@696,#220> -------------------- B77 (unreachable/replaced) --------------------)
0x9c023aafed9  position  (5459)
0x9c023aafed9  comment  (;;; <@700,#226> -------------------- B78 --------------------)
0x9c023aafed9  comment  (;;; <@701,#226> gap)
0x9c023aafedd  comment  (;;; <@702,#227> load-context-slot)
0x9c023aafee4  comment  (;;; <@704,#229> return)
0x9c023aafeeb  position  (12654)
0x9c023aafeeb  comment  (;;; <@48,#776> -------------------- Deferred tagged-to-i --------------------)
0x9c023aaff09  comment  (Deferred TaggedToI: lost precision)
0x9c023aaff0b  comment  (Deferred TaggedToI: NaN)
0x9c023aaff13  runtime entry  (deoptimization bailout 88)
0x9c023aaff1c  position  (12675)
0x9c023aaff1c  comment  (;;; <@54,#780> -------------------- Deferred tagged-to-i --------------------)
0x9c023aaff3a  comment  (Deferred TaggedToI: lost precision)
0x9c023aaff3c  comment  (Deferred TaggedToI: NaN)
0x9c023aaff44  runtime entry  (deoptimization bailout 89)
0x9c023aaff4d  position  (12875)
0x9c023aaff4d  comment  (;;; <@112,#129> -------------------- Deferred stack-check --------------------)
0x9c023aaff70  code target (STUB)  (0x9c023a061c0)
0x9c023aaff8e  position  (5557)
0x9c023aaff8e  comment  (;;; <@212,#775> -------------------- Deferred tagged-to-i --------------------)
0x9c023aaffac  comment  (Deferred TaggedToI: lost precision)
0x9c023aaffae  comment  (Deferred TaggedToI: NaN)
0x9c023aaffb6  runtime entry  (deoptimization bailout 90)
0x9c023aaffbf  comment  (;;; <@214,#778> -------------------- Deferred tagged-to-i --------------------)
0x9c023aaffdd  comment  (Deferred TaggedToI: lost precision)
0x9c023aaffdf  comment  (Deferred TaggedToI: NaN)
0x9c023aaffe7  runtime entry  (deoptimization bailout 91)
0x9c023aafff0  comment  (;;; <@224,#774> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab000e  comment  (Deferred TaggedToI: lost precision)
0x9c023ab0010  comment  (Deferred TaggedToI: NaN)
0x9c023ab0018  runtime entry  (deoptimization bailout 92)
0x9c023ab0021  comment  (;;; <@226,#779> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab003f  comment  (Deferred TaggedToI: lost precision)
0x9c023ab0041  comment  (Deferred TaggedToI: NaN)
0x9c023ab0049  runtime entry  (deoptimization bailout 93)
0x9c023ab0052  position  (2205)
0x9c023ab0052  comment  (;;; <@272,#783> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab0070  comment  (Deferred TaggedToI: lost precision)
0x9c023ab0072  comment  (Deferred TaggedToI: NaN)
0x9c023ab007a  runtime entry  (deoptimization bailout 94)
0x9c023ab0083  position  (2258)
0x9c023ab0083  comment  (;;; <@314,#784> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab00a1  comment  (Deferred TaggedToI: lost precision)
0x9c023ab00a3  comment  (Deferred TaggedToI: NaN)
0x9c023ab00b8  runtime entry  (deoptimization bailout 95)
0x9c023ab00c1  position  (2394)
0x9c023ab00c1  comment  (;;; <@328,#788> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab00df  comment  (Deferred TaggedToI: lost precision)
0x9c023ab00e1  comment  (Deferred TaggedToI: NaN)
0x9c023ab00f6  runtime entry  (deoptimization bailout 96)
0x9c023ab00ff  position  (2484)
0x9c023ab00ff  comment  (;;; <@342,#790> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab011d  comment  (Deferred TaggedToI: lost precision)
0x9c023ab011f  comment  (Deferred TaggedToI: NaN)
0x9c023ab0134  runtime entry  (deoptimization bailout 97)
0x9c023ab013d  position  (2513)
0x9c023ab013d  comment  (;;; <@374,#787> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab0162  code target (STUB)  (0x9c023a44740)
0x9c023ab0195  comment  (Deferred TaggedToI: cannot truncate)
0x9c023ab01a8  position  (5810)
0x9c023ab01a8  comment  (;;; <@462,#455> -------------------- Deferred stack-check --------------------)
0x9c023ab01cb  code target (STUB)  (0x9c023a061c0)
0x9c023ab01e9  position  (6021)
0x9c023ab01e9  comment  (;;; <@530,#568> -------------------- Deferred stack-check --------------------)
0x9c023ab020c  code target (STUB)  (0x9c023a061c0)
0x9c023ab022a  position  (6314)
0x9c023ab022a  comment  (;;; <@650,#730> -------------------- Deferred stack-check --------------------)
0x9c023ab024d  code target (STUB)  (0x9c023a061c0)
0x9c023ab026b  comment  (;;; -------------------- Jump table --------------------)
0x9c023ab026b  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x9c023ab026c  runtime entry  (deoptimization bailout 1)
0x9c023ab0270  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x9c023ab0271  runtime entry  (deoptimization bailout 2)
0x9c023ab0275  comment  (;;; jump table entry 2: deoptimization bailout 3.)
0x9c023ab0276  runtime entry  (deoptimization bailout 3)
0x9c023ab027a  comment  (;;; jump table entry 3: deoptimization bailout 4.)
0x9c023ab027b  runtime entry  (deoptimization bailout 4)
0x9c023ab027f  comment  (;;; jump table entry 4: deoptimization bailout 5.)
0x9c023ab0280  runtime entry  (deoptimization bailout 5)
0x9c023ab0284  comment  (;;; jump table entry 5: deoptimization bailout 6.)
0x9c023ab0285  runtime entry  (deoptimization bailout 6)
0x9c023ab0289  comment  (;;; jump table entry 6: deoptimization bailout 7.)
0x9c023ab028a  runtime entry  (deoptimization bailout 7)
0x9c023ab028e  comment  (;;; jump table entry 7: deoptimization bailout 8.)
0x9c023ab028f  runtime entry  (deoptimization bailout 8)
0x9c023ab0293  comment  (;;; jump table entry 8: deoptimization bailout 9.)
0x9c023ab0294  runtime entry  (deoptimization bailout 9)
0x9c023ab0298  comment  (;;; jump table entry 9: deoptimization bailout 10.)
0x9c023ab0299  runtime entry  (deoptimization bailout 10)
0x9c023ab029d  comment  (;;; jump table entry 10: deoptimization bailout 11.)
0x9c023ab029e  runtime entry  (deoptimization bailout 11)
0x9c023ab02a2  comment  (;;; jump table entry 11: deoptimization bailout 12.)
0x9c023ab02a3  runtime entry  (deoptimization bailout 12)
0x9c023ab02a7  comment  (;;; jump table entry 12: deoptimization bailout 13.)
0x9c023ab02a8  runtime entry  (deoptimization bailout 13)
0x9c023ab02ac  comment  (;;; jump table entry 13: deoptimization bailout 14.)
0x9c023ab02ad  runtime entry  (deoptimization bailout 14)
0x9c023ab02b1  comment  (;;; jump table entry 14: deoptimization bailout 15.)
0x9c023ab02b2  runtime entry  (deoptimization bailout 15)
0x9c023ab02b6  comment  (;;; jump table entry 15: deoptimization bailout 16.)
0x9c023ab02b7  runtime entry  (deoptimization bailout 16)
0x9c023ab02bb  comment  (;;; jump table entry 16: deoptimization bailout 18.)
0x9c023ab02bc  runtime entry  (deoptimization bailout 18)
0x9c023ab02c0  comment  (;;; jump table entry 17: deoptimization bailout 19.)
0x9c023ab02c1  runtime entry  (deoptimization bailout 19)
0x9c023ab02c5  comment  (;;; jump table entry 18: deoptimization bailout 20.)
0x9c023ab02c6  runtime entry  (deoptimization bailout 20)
0x9c023ab02ca  comment  (;;; jump table entry 19: deoptimization bailout 21.)
0x9c023ab02cb  runtime entry  (deoptimization bailout 21)
0x9c023ab02cf  comment  (;;; jump table entry 20: deoptimization bailout 22.)
0x9c023ab02d0  runtime entry  (deoptimization bailout 22)
0x9c023ab02d4  comment  (;;; jump table entry 21: deoptimization bailout 23.)
0x9c023ab02d5  runtime entry  (deoptimization bailout 23)
0x9c023ab02d9  comment  (;;; jump table entry 22: deoptimization bailout 24.)
0x9c023ab02da  runtime entry  (deoptimization bailout 24)
0x9c023ab02de  comment  (;;; jump table entry 23: deoptimization bailout 25.)
0x9c023ab02df  runtime entry  (deoptimization bailout 25)
0x9c023ab02e3  comment  (;;; jump table entry 24: deoptimization bailout 26.)
0x9c023ab02e4  runtime entry  (deoptimization bailout 26)
0x9c023ab02e8  comment  (;;; jump table entry 25: deoptimization bailout 27.)
0x9c023ab02e9  runtime entry  (deoptimization bailout 27)
0x9c023ab02ed  comment  (;;; jump table entry 26: deoptimization bailout 28.)
0x9c023ab02ee  runtime entry  (deoptimization bailout 28)
0x9c023ab02f2  comment  (;;; jump table entry 27: deoptimization bailout 29.)
0x9c023ab02f3  runtime entry  (deoptimization bailout 29)
0x9c023ab02f7  comment  (;;; jump table entry 28: deoptimization bailout 30.)
0x9c023ab02f8  runtime entry  (deoptimization bailout 30)
0x9c023ab02fc  comment  (;;; jump table entry 29: deoptimization bailout 31.)
0x9c023ab02fd  runtime entry  (deoptimization bailout 31)
0x9c023ab0301  comment  (;;; jump table entry 30: deoptimization bailout 32.)
0x9c023ab0302  runtime entry  (deoptimization bailout 32)
0x9c023ab0306  comment  (;;; jump table entry 31: deoptimization bailout 34.)
0x9c023ab0307  runtime entry  (deoptimization bailout 34)
0x9c023ab030b  comment  (;;; jump table entry 32: deoptimization bailout 35.)
0x9c023ab030c  runtime entry  (deoptimization bailout 35)
0x9c023ab0310  comment  (;;; jump table entry 33: deoptimization bailout 36.)
0x9c023ab0311  runtime entry  (deoptimization bailout 36)
0x9c023ab0315  comment  (;;; jump table entry 34: deoptimization bailout 37.)
0x9c023ab0316  runtime entry  (deoptimization bailout 37)
0x9c023ab031a  comment  (;;; jump table entry 35: deoptimization bailout 38.)
0x9c023ab031b  runtime entry  (deoptimization bailout 38)
0x9c023ab031f  comment  (;;; jump table entry 36: deoptimization bailout 39.)
0x9c023ab0320  runtime entry  (deoptimization bailout 39)
0x9c023ab0324  comment  (;;; jump table entry 37: deoptimization bailout 40.)
0x9c023ab0325  runtime entry  (deoptimization bailout 40)
0x9c023ab0329  comment  (;;; jump table entry 38: deoptimization bailout 41.)
0x9c023ab032a  runtime entry  (deoptimization bailout 41)
0x9c023ab032e  comment  (;;; jump table entry 39: deoptimization bailout 42.)
0x9c023ab032f  runtime entry  (deoptimization bailout 42)
0x9c023ab0333  comment  (;;; jump table entry 40: deoptimization bailout 43.)
0x9c023ab0334  runtime entry  (deoptimization bailout 43)
0x9c023ab0338  comment  (;;; jump table entry 41: deoptimization bailout 44.)
0x9c023ab0339  runtime entry  (deoptimization bailout 44)
0x9c023ab033d  comment  (;;; jump table entry 42: deoptimization bailout 45.)
0x9c023ab033e  runtime entry  (deoptimization bailout 45)
0x9c023ab0342  comment  (;;; jump table entry 43: deoptimization bailout 46.)
0x9c023ab0343  runtime entry  (deoptimization bailout 46)
0x9c023ab0347  comment  (;;; jump table entry 44: deoptimization bailout 47.)
0x9c023ab0348  runtime entry  (deoptimization bailout 47)
0x9c023ab034c  comment  (;;; jump table entry 45: deoptimization bailout 48.)
0x9c023ab034d  runtime entry  (deoptimization bailout 48)
0x9c023ab0351  comment  (;;; jump table entry 46: deoptimization bailout 49.)
0x9c023ab0352  runtime entry  (deoptimization bailout 49)
0x9c023ab0356  comment  (;;; jump table entry 47: deoptimization bailout 50.)
0x9c023ab0357  runtime entry  (deoptimization bailout 50)
0x9c023ab035b  comment  (;;; jump table entry 48: deoptimization bailout 51.)
0x9c023ab035c  runtime entry  (deoptimization bailout 51)
0x9c023ab0360  comment  (;;; jump table entry 49: deoptimization bailout 52.)
0x9c023ab0361  runtime entry  (deoptimization bailout 52)
0x9c023ab0365  comment  (;;; jump table entry 50: deoptimization bailout 53.)
0x9c023ab0366  runtime entry  (deoptimization bailout 53)
0x9c023ab036a  comment  (;;; jump table entry 51: deoptimization bailout 54.)
0x9c023ab036b  runtime entry  (deoptimization bailout 54)
0x9c023ab036f  comment  (;;; jump table entry 52: deoptimization bailout 55.)
0x9c023ab0370  runtime entry  (deoptimization bailout 55)
0x9c023ab0374  comment  (;;; jump table entry 53: deoptimization bailout 56.)
0x9c023ab0375  runtime entry  (deoptimization bailout 56)
0x9c023ab0379  comment  (;;; jump table entry 54: deoptimization bailout 57.)
0x9c023ab037a  runtime entry  (deoptimization bailout 57)
0x9c023ab037e  comment  (;;; jump table entry 55: deoptimization bailout 58.)
0x9c023ab037f  runtime entry  (deoptimization bailout 58)
0x9c023ab0383  comment  (;;; jump table entry 56: deoptimization bailout 60.)
0x9c023ab0384  runtime entry  (deoptimization bailout 60)
0x9c023ab0388  comment  (;;; jump table entry 57: deoptimization bailout 61.)
0x9c023ab0389  runtime entry  (deoptimization bailout 61)
0x9c023ab038d  comment  (;;; jump table entry 58: deoptimization bailout 62.)
0x9c023ab038e  runtime entry  (deoptimization bailout 62)
0x9c023ab0392  comment  (;;; jump table entry 59: deoptimization bailout 63.)
0x9c023ab0393  runtime entry  (deoptimization bailout 63)
0x9c023ab0397  comment  (;;; jump table entry 60: deoptimization bailout 64.)
0x9c023ab0398  runtime entry  (deoptimization bailout 64)
0x9c023ab039c  comment  (;;; jump table entry 61: deoptimization bailout 65.)
0x9c023ab039d  runtime entry  (deoptimization bailout 65)
0x9c023ab03a1  comment  (;;; jump table entry 62: deoptimization bailout 66.)
0x9c023ab03a2  runtime entry  (deoptimization bailout 66)
0x9c023ab03a6  comment  (;;; jump table entry 63: deoptimization bailout 67.)
0x9c023ab03a7  runtime entry  (deoptimization bailout 67)
0x9c023ab03ab  comment  (;;; jump table entry 64: deoptimization bailout 68.)
0x9c023ab03ac  runtime entry  (deoptimization bailout 68)
0x9c023ab03b0  comment  (;;; jump table entry 65: deoptimization bailout 69.)
0x9c023ab03b1  runtime entry  (deoptimization bailout 69)
0x9c023ab03b5  comment  (;;; jump table entry 66: deoptimization bailout 71.)
0x9c023ab03b6  runtime entry  (deoptimization bailout 71)
0x9c023ab03ba  comment  (;;; jump table entry 67: deoptimization bailout 72.)
0x9c023ab03bb  runtime entry  (deoptimization bailout 72)
0x9c023ab03bf  comment  (;;; jump table entry 68: deoptimization bailout 73.)
0x9c023ab03c0  runtime entry  (deoptimization bailout 73)
0x9c023ab03c4  comment  (;;; jump table entry 69: deoptimization bailout 74.)
0x9c023ab03c5  runtime entry  (deoptimization bailout 74)
0x9c023ab03c9  comment  (;;; jump table entry 70: deoptimization bailout 75.)
0x9c023ab03ca  runtime entry  (deoptimization bailout 75)
0x9c023ab03ce  comment  (;;; jump table entry 71: deoptimization bailout 76.)
0x9c023ab03cf  runtime entry  (deoptimization bailout 76)
0x9c023ab03d3  comment  (;;; jump table entry 72: deoptimization bailout 78.)
0x9c023ab03d4  runtime entry  (deoptimization bailout 78)
0x9c023ab03d8  comment  (;;; jump table entry 73: deoptimization bailout 79.)
0x9c023ab03d9  runtime entry  (deoptimization bailout 79)
0x9c023ab03dd  comment  (;;; jump table entry 74: deoptimization bailout 80.)
0x9c023ab03de  runtime entry  (deoptimization bailout 80)
0x9c023ab03e2  comment  (;;; jump table entry 75: deoptimization bailout 81.)
0x9c023ab03e3  runtime entry  (deoptimization bailout 81)
0x9c023ab03e7  comment  (;;; jump table entry 76: deoptimization bailout 82.)
0x9c023ab03e8  runtime entry  (deoptimization bailout 82)
0x9c023ab03ec  comment  (;;; jump table entry 77: deoptimization bailout 83.)
0x9c023ab03ed  runtime entry  (deoptimization bailout 83)
0x9c023ab03f1  comment  (;;; jump table entry 78: deoptimization bailout 84.)
0x9c023ab03f2  runtime entry  (deoptimization bailout 84)
0x9c023ab03f6  comment  (;;; jump table entry 79: deoptimization bailout 86.)
0x9c023ab03f7  runtime entry  (deoptimization bailout 86)
0x9c023ab03fb  comment  (;;; jump table entry 80: deoptimization bailout 87.)
0x9c023ab03fc  runtime entry  (deoptimization bailout 87)
0x9c023ab0400  comment  (;;; jump table entry 81: deoptimization bailout 98.)
0x9c023ab0401  runtime entry  (deoptimization bailout 98)
0x9c023ab0408  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (divide) id{5,0} ---
(A, B){
    var Bp = adrs[B]
    var size_b = heap[Bp]
    var most_significant_digit_b = heap[Bp + size_b - 1]
    if ( most_significant_digit_b < half_base ) {

      var shifted = ceil(logn(half_base / most_significant_digit_b) / LN2) 
      var As = left_shift(A, shifted)
      var Bs = left_shift(B, shifted)

      var m = heap[adrs[As]]

      var n = heap[adrs[Bs]]

      if ( m < n ) {
        return [zero, A]
      }

      if ( m === n ) {
        var c = compare_abs(As, Bs)
        if ( c < 0 ) return [zero, A]
        if ( c === 0 ) return [one, zero]
        return [one, subtract(A, B)]
      }

      if ( m === n + 1 ) {
        var qr = sub(As, Bs)
        return [qr[0], right_shift(qr[1], shifted)]
      }

      var powerdiff = (m - n - 1) * 26
      var A_p = right_shift(As, powerdiff)
      var t3 = sub(A_p, Bs)
      var t4 = divide(add(left_shift(t3[1], powerdiff), subtract(As, left_shift(A_p, powerdiff))), Bs)

      return [add(left_shift(t3[0], powerdiff), t4[0]), right_shift(t4[1], shifted)]

    } else {

      var m = heap[adrs[A]]

      var n = heap[adrs[B]]

      if ( m < n ) {
        return [zero, A]
      }

      if ( m === n ) {
        var c = compare_abs(A, B)
        if ( c < 0 ) return [zero, A]
        if ( c === 0 ) return [one, zero]
        return [one, subtract(A, B)]
      }

      if ( m === n + 1 ) {
        return sub(A, B)
      }

      var powerdiff = (m - n - 1) * 26
      var A_p = right_shift(A, powerdiff)

      var t3 = sub(A_p, B)
      var t4 = divide(add(left_shift(t3[1], powerdiff), subtract(A, left_shift(A_p, powerdiff))), B)

      return [add(left_shift(t3[0], powerdiff), t4[0]), t4[1]]
    }
  }

--- END ---
--- FUNCTION SOURCE (ceil) id{5,1} ---
(a){
return-MathFloor(-a);
}

--- END ---
INLINE (ceil) id{5,1} AS 1 AT <0:183>
--- Raw source ---
(A, B){
    var Bp = adrs[B]
    var size_b = heap[Bp]
    var most_significant_digit_b = heap[Bp + size_b - 1]
    if ( most_significant_digit_b < half_base ) {

      var shifted = ceil(logn(half_base / most_significant_digit_b) / LN2) 
      var As = left_shift(A, shifted)
      var Bs = left_shift(B, shifted)

      var m = heap[adrs[As]]

      var n = heap[adrs[Bs]]

      if ( m < n ) {
        return [zero, A]
      }

      if ( m === n ) {
        var c = compare_abs(As, Bs)
        if ( c < 0 ) return [zero, A]
        if ( c === 0 ) return [one, zero]
        return [one, subtract(A, B)]
      }

      if ( m === n + 1 ) {
        var qr = sub(As, Bs)
        return [qr[0], right_shift(qr[1], shifted)]
      }

      var powerdiff = (m - n - 1) * 26
      var A_p = right_shift(As, powerdiff)
      var t3 = sub(A_p, Bs)
      var t4 = divide(add(left_shift(t3[1], powerdiff), subtract(As, left_shift(A_p, powerdiff))), Bs)

      return [add(left_shift(t3[0], powerdiff), t4[0]), right_shift(t4[1], shifted)]

    } else {

      var m = heap[adrs[A]]

      var n = heap[adrs[B]]

      if ( m < n ) {
        return [zero, A]
      }

      if ( m === n ) {
        var c = compare_abs(A, B)
        if ( c < 0 ) return [zero, A]
        if ( c === 0 ) return [one, zero]
        return [one, subtract(A, B)]
      }

      if ( m === n + 1 ) {
        return sub(A, B)
      }

      var powerdiff = (m - n - 1) * 26
      var A_p = right_shift(A, powerdiff)

      var t3 = sub(A_p, B)
      var t4 = divide(add(left_shift(t3[1], powerdiff), subtract(A, left_shift(A_p, powerdiff))), B)

      return [add(left_shift(t3[0], powerdiff), t4[0]), t4[1]]
    }
  }


--- Optimized code ---
optimization_id = 5
source_position = 10888
kind = OPTIMIZED_FUNCTION
name = divide
stack_slots = 28
Instructions (size = 4874)
0x9c023ab1300     0  55             push rbp
0x9c023ab1301     1  4889e5         REX.W movq rbp,rsp
0x9c023ab1304     4  56             push rsi
0x9c023ab1305     5  57             push rdi
0x9c023ab1306     6  4881ece0000000 REX.W subq rsp,0xe0
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x9c023ab130d    13  488b45f8       REX.W movq rax,[rbp-0x8]    ;; debug: position 10888
                  ;;; <@3,#1> gap
0x9c023ab1311    17  488945e8       REX.W movq [rbp-0x18],rax
                  ;;; <@12,#9> -------------------- B1 --------------------
                  ;;; <@13,#9> gap
0x9c023ab1315    21  488bf0         REX.W movq rsi,rax
                  ;;; <@14,#11> stack-check
0x9c023ab1318    24  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023ab131f    31  7305           jnc 38  (0x9c023ab1326)
0x9c023ab1321    33  e83a4bf7ff     call StackCheck  (0x9c023a25e60)    ;; code: BUILTIN
                  ;;; <@16,#11> lazy-bailout
                  ;;; <@17,#11> gap
0x9c023ab1326    38  488b45e8       REX.W movq rax,[rbp-0x18]
                  ;;; <@18,#12> load-context-slot
0x9c023ab132a    42  488b989f000000 REX.W movq rbx,[rax+0x9f]    ;; debug: position 10909
                  ;;; <@20,#14> check-non-smi
0x9c023ab1331    49  f6c301         testb rbx,0x1            ;; debug: position 10914
0x9c023ab1334    52  0f84350f0000   jz 3951  (0x9c023ab226f)
                  ;;; <@22,#15> check-maps
0x9c023ab133a    58  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab1344    68  4c3953ff       REX.W cmpq [rbx-0x1],r10
0x9c023ab1348    72  0f85260f0000   jnz 3956  (0x9c023ab2274)
                  ;;; <@24,#16> load-named-field
0x9c023ab134e    78  488b5b0f       REX.W movq rbx,[rbx+0xf]
                  ;;; <@26,#17> load-named-field
0x9c023ab1352    82  8b530b         movl rdx,[rbx+0xb]
                  ;;; <@28,#18> load-named-field
0x9c023ab1355    85  488b5b0f       REX.W movq rbx,[rbx+0xf]
                  ;;; <@29,#18> gap
0x9c023ab1359    89  488b4d10       REX.W movq rcx,[rbp+0x10]
                  ;;; <@30,#885> tagged-to-i
0x9c023ab135d    93  f6c101         testb rcx,0x1
0x9c023ab1360    96  0f850e0e0000   jnz 3700  (0x9c023ab2174)
0x9c023ab1366   102  48c1e920       REX.W shrq rcx,32
                  ;;; <@32,#19> bounds-check
0x9c023ab136a   106  3bd1           cmpl rdx,rcx
0x9c023ab136c   108  0f86070f0000   jna 3961  (0x9c023ab2279)
                  ;;; <@34,#20> load-keyed
0x9c023ab1372   114  8b0c8b         movl rcx,[rbx+rcx*4]
0x9c023ab1375   117  85c9           testl rcx,rcx
0x9c023ab1377   119  0f88010f0000   js 3966  (0x9c023ab227e)
                  ;;; <@36,#22> load-context-slot
0x9c023ab137d   125  488bb097000000 REX.W movq rsi,[rax+0x97]    ;; debug: position 10934
                  ;;; <@38,#24> check-non-smi
0x9c023ab1384   132  40f6c601       testb rsi,0x1            ;; debug: position 10939
0x9c023ab1388   136  0f84f50e0000   jz 3971  (0x9c023ab2283)
                  ;;; <@40,#25> check-maps
0x9c023ab138e   142  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab1398   152  4c3956ff       REX.W cmpq [rsi-0x1],r10
0x9c023ab139c   156  0f85e60e0000   jnz 3976  (0x9c023ab2288)
                  ;;; <@42,#26> load-named-field
0x9c023ab13a2   162  488b7e0f       REX.W movq rdi,[rsi+0xf]
                  ;;; <@44,#27> load-named-field
0x9c023ab13a6   166  448b470b       movl r8,[rdi+0xb]
                  ;;; <@46,#28> load-named-field
0x9c023ab13aa   170  488b7f0f       REX.W movq rdi,[rdi+0xf]
                  ;;; <@48,#29> bounds-check
0x9c023ab13ae   174  443bc1         cmpl r8,rcx
0x9c023ab13b1   177  0f86d60e0000   jna 3981  (0x9c023ab228d)
                  ;;; <@50,#30> load-keyed
0x9c023ab13b7   183  448b0c8f       movl r9,[rdi+rcx*4]
0x9c023ab13bb   187  4585c9         testl r9,r9
0x9c023ab13be   190  0f88ce0e0000   js 3986  (0x9c023ab2292)
                  ;;; <@52,#35> add-i
0x9c023ab13c4   196  4103c9         addl rcx,r9              ;; debug: position 10986
0x9c023ab13c7   199  0f80ca0e0000   jo 3991  (0x9c023ab2297)
                  ;;; <@54,#38> sub-i
0x9c023ab13cd   205  83e901         subl rcx,0x1             ;; debug: position 10995
0x9c023ab13d0   208  0f80c60e0000   jo 3996  (0x9c023ab229c)
                  ;;; <@56,#45> bounds-check
0x9c023ab13d6   214  443bc1         cmpl r8,rcx
0x9c023ab13d9   217  0f86c20e0000   jna 4001  (0x9c023ab22a1)
                  ;;; <@58,#46> load-keyed
0x9c023ab13df   223  448b1c8f       movl r11,[rdi+rcx*4]
0x9c023ab13e3   227  4585db         testl r11,r11
0x9c023ab13e6   230  0f88ba0e0000   js 4006  (0x9c023ab22a6)
                  ;;; <@60,#49> load-context-slot
0x9c023ab13ec   236  4c8b7077       REX.W movq r14,[rax+0x77]    ;; debug: position 11036
                  ;;; <@61,#49> gap
0x9c023ab13f0   240  4d8bfe         REX.W movq r15,r14
                  ;;; <@62,#887> tagged-to-i
0x9c023ab13f3   243  41f6c701       testb r15,0x1
0x9c023ab13f7   247  0f85a80d0000   jnz 3749  (0x9c023ab21a5)
0x9c023ab13fd   253  49c1ef20       REX.W shrq r15,32
                  ;;; <@65,#50> compare-numeric-and-branch
0x9c023ab1401   257  453bdf         cmpl r11,r15             ;; debug: position 11034
0x9c023ab1404   260  0f8ced040000   jl 1527  (0x9c023ab18f7)
                  ;;; <@66,#54> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@70,#520> -------------------- B3 --------------------
                  ;;; <@71,#520> gap
0x9c023ab140a   266  488b4d18       REX.W movq rcx,[rbp+0x18]    ;; debug: position 11949
                  ;;; <@72,#881> tagged-to-i
0x9c023ab140e   270  f6c101         testb rcx,0x1            ;; debug: position 11959
0x9c023ab1411   273  0f85c20d0000   jnz 3801  (0x9c023ab21d9)
0x9c023ab1417   279  48c1e920       REX.W shrq rcx,32
                  ;;; <@74,#528> bounds-check
0x9c023ab141b   283  3bd1           cmpl rdx,rcx
0x9c023ab141d   285  0f86880e0000   jna 4011  (0x9c023ab22ab)
                  ;;; <@76,#529> load-keyed
0x9c023ab1423   291  8b148b         movl rdx,[rbx+rcx*4]
0x9c023ab1426   294  85d2           testl rdx,rdx
0x9c023ab1428   296  0f88820e0000   js 4016  (0x9c023ab22b0)
                  ;;; <@78,#535> bounds-check
0x9c023ab142e   302  443bc2         cmpl r8,rdx
0x9c023ab1431   305  0f867e0e0000   jna 4021  (0x9c023ab22b5)
                  ;;; <@80,#536> load-keyed
0x9c023ab1437   311  8b1c97         movl rbx,[rdi+rdx*4]
0x9c023ab143a   314  85db           testl rbx,rbx
0x9c023ab143c   316  0f88780e0000   js 4026  (0x9c023ab22ba)
                  ;;; <@83,#557> compare-numeric-and-branch
0x9c023ab1442   322  413bd9         cmpl rbx,r9              ;; debug: position 12006
0x9c023ab1445   325  0f8c25040000   jl 1392  (0x9c023ab1870)
                  ;;; <@84,#561> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@88,#587> -------------------- B5 --------------------
                  ;;; <@91,#590> compare-numeric-and-branch
0x9c023ab144b   331  413bd9         cmpl rbx,r9              ;; debug: position 12059
                                                             ;; debug: position 12061
0x9c023ab144e   334  0f84f6030000   jz 1354  (0x9c023ab184a)
                  ;;; <@92,#594> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@96,#708> -------------------- B7 --------------------
                  ;;; <@97,#708> gap
0x9c023ab1454   340  498bd1         REX.W movq rdx,r9        ;; debug: position 12242
                  ;;; <@98,#712> add-i
0x9c023ab1457   343  83c201         addl rdx,0x1             ;; debug: position 12250
0x9c023ab145a   346  0f805f0e0000   jo 4031  (0x9c023ab22bf)
                  ;;; <@101,#714> compare-numeric-and-branch
0x9c023ab1460   352  3bda           cmpl rbx,rdx             ;; debug: position 12244
0x9c023ab1462   354  0f84a1030000   jz 1289  (0x9c023ab1809)
                  ;;; <@102,#718> -------------------- B8 (unreachable/replaced) --------------------
                  ;;; <@106,#732> -------------------- B9 --------------------
                  ;;; <@107,#732> gap
0x9c023ab1468   360  488bd3         REX.W movq rdx,rbx       ;; debug: position 12315
                  ;;; <@108,#735> sub-i
0x9c023ab146b   363  412bd1         subl rdx,r9              ;; debug: position 12317
0x9c023ab146e   366  0f80500e0000   jo 4036  (0x9c023ab22c4)
                  ;;; <@109,#735> gap
0x9c023ab1474   372  488bda         REX.W movq rbx,rdx
                  ;;; <@110,#738> sub-i
0x9c023ab1477   375  83eb01         subl rbx,0x1             ;; debug: position 12321
0x9c023ab147a   378  0f80490e0000   jo 4041  (0x9c023ab22c9)
                  ;;; <@112,#741> mul-i
0x9c023ab1480   384  6bdb1a         imull rbx,rbx,0x1a       ;; debug: position 12326
0x9c023ab1483   387  0f80450e0000   jo 4046  (0x9c023ab22ce)
                  ;;; <@113,#741> gap
0x9c023ab1489   393  48895de0       REX.W movq [rbp-0x20],rbx
                  ;;; <@114,#744> load-context-slot
0x9c023ab148d   397  488bb807010000 REX.W movq rdi,[rax+0x107]    ;; debug: position 12347
                  ;;; <@116,#745> check-value
0x9c023ab1494   404  49bae9f435064e360000 REX.W movq r10,0x364e0635f4e9    ;; object: 0x364e0635f4e9 <JS Function right_shift (SharedFunctionInfo 0xc1217b4d5e1)>
0x9c023ab149e   414  493bfa         REX.W cmpq rdi,r10
0x9c023ab14a1   417  0f852c0e0000   jnz 4051  (0x9c023ab22d3)
                  ;;; <@118,#748> push-argument
0x9c023ab14a7   423  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 12362
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab14b1   433  4152           push r10
                  ;;; <@119,#748> gap
0x9c023ab14b3   435  488b5518       REX.W movq rdx,[rbp+0x18]
                  ;;; <@120,#749> push-argument
0x9c023ab14b7   439  52             push rdx
                  ;;; <@122,#891> smi-tag
0x9c023ab14b8   440  8bcb           movl rcx,rbx
0x9c023ab14ba   442  48c1e120       REX.W shlq rcx,32
                  ;;; <@123,#891> gap
0x9c023ab14be   446  48894dd8       REX.W movq [rbp-0x28],rcx
                  ;;; <@124,#750> push-argument
0x9c023ab14c2   450  51             push rcx
                  ;;; <@125,#750> gap
0x9c023ab14c3   451  488bf0         REX.W movq rsi,rax
                  ;;; <@126,#751> invoke-function
0x9c023ab14c6   454  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab14ca   458  ff5717         call [rdi+0x17]
                  ;;; <@127,#751> gap
0x9c023ab14cd   461  488945d0       REX.W movq [rbp-0x30],rax
                  ;;; <@128,#752> lazy-bailout
                  ;;; <@129,#752> gap
0x9c023ab14d1   465  488b5de8       REX.W movq rbx,[rbp-0x18]
                  ;;; <@130,#754> load-context-slot
0x9c023ab14d5   469  488bbb0f010000 REX.W movq rdi,[rbx+0x10f]    ;; debug: position 12389
                  ;;; <@132,#755> check-value
0x9c023ab14dc   476  49ba31f535064e360000 REX.W movq r10,0x364e0635f531    ;; object: 0x364e0635f531 <JS Function sub (SharedFunctionInfo 0xc1217b4d701)>
0x9c023ab14e6   486  493bfa         REX.W cmpq rdi,r10
0x9c023ab14e9   489  0f85e90d0000   jnz 4056  (0x9c023ab22d8)
                  ;;; <@134,#758> push-argument
0x9c023ab14ef   495  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 12398
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab14f9   505  4152           push r10
                  ;;; <@136,#759> push-argument
0x9c023ab14fb   507  50             push rax
                  ;;; <@137,#759> gap
0x9c023ab14fc   508  488b5510       REX.W movq rdx,[rbp+0x10]
                  ;;; <@138,#760> push-argument
0x9c023ab1500   512  52             push rdx
                  ;;; <@139,#760> gap
0x9c023ab1501   513  488bf3         REX.W movq rsi,rbx
                  ;;; <@140,#761> invoke-function
0x9c023ab1504   516  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1508   520  ff5717         call [rdi+0x17]
                  ;;; <@141,#761> gap
0x9c023ab150b   523  488945c8       REX.W movq [rbp-0x38],rax
                  ;;; <@142,#762> lazy-bailout
                  ;;; <@143,#762> gap
0x9c023ab150f   527  488b5de8       REX.W movq rbx,[rbp-0x18]
                  ;;; <@144,#764> load-context-slot
0x9c023ab1513   531  488b9317010000 REX.W movq rdx,[rbx+0x117]    ;; debug: position 12416
                  ;;; <@145,#764> gap
0x9c023ab151a   538  488955c0       REX.W movq [rbp-0x40],rdx
                  ;;; <@146,#765> check-value
0x9c023ab151e   542  49baa1f535064e360000 REX.W movq r10,0x364e0635f5a1    ;; object: 0x364e0635f5a1 <JS Function divide (SharedFunctionInfo 0xc1217b4d899)>
0x9c023ab1528   552  493bd2         REX.W cmpq rdx,r10
0x9c023ab152b   555  0f85ac0d0000   jnz 4061  (0x9c023ab22dd)
                  ;;; <@148,#766> load-context-slot
0x9c023ab1531   561  488b8be7000000 REX.W movq rcx,[rbx+0xe7]    ;; debug: position 12423
                  ;;; <@149,#766> gap
0x9c023ab1538   568  48894db8       REX.W movq [rbp-0x48],rcx
                  ;;; <@150,#767> check-value
0x9c023ab153c   572  49bac9f335064e360000 REX.W movq r10,0x364e0635f3c9    ;; object: 0x364e0635f3c9 <JS Function add (SharedFunctionInfo 0xc1217b4d301)>
0x9c023ab1546   582  493bca         REX.W cmpq rcx,r10
0x9c023ab1549   585  0f85930d0000   jnz 4066  (0x9c023ab22e2)
                  ;;; <@152,#768> load-context-slot
0x9c023ab154f   591  488bbbff000000 REX.W movq rdi,[rbx+0xff]    ;; debug: position 12427
                  ;;; <@154,#769> check-value
0x9c023ab1556   598  49baa1f435064e360000 REX.W movq r10,0x364e0635f4a1    ;; object: 0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>
0x9c023ab1560   608  493bfa         REX.W cmpq rdi,r10
0x9c023ab1563   611  0f857e0d0000   jnz 4071  (0x9c023ab22e7)
                  ;;; <@156,#772> check-non-smi
0x9c023ab1569   617  a801           test al,0x1              ;; debug: position 12441
0x9c023ab156b   619  0f847b0d0000   jz 4076  (0x9c023ab22ec)
                  ;;; <@158,#773> check-maps
0x9c023ab1571   625  49ba517ec05ecb2c0000 REX.W movq r10,0x2ccb5ec07e51    ;; object: 0x2ccb5ec07e51 <Map(elements=0)>
0x9c023ab157b   635  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab157f   639  0f856c0d0000   jnz 4081  (0x9c023ab22f1)
                  ;;; <@160,#774> load-named-field
0x9c023ab1585   645  488b700f       REX.W movq rsi,[rax+0xf]
                  ;;; <@162,#775> load-named-field
0x9c023ab1589   649  448b401b       movl r8,[rax+0x1b]
                  ;;; <@164,#776> bounds-check
0x9c023ab158d   653  4183f801       cmpl r8,0x1
0x9c023ab1591   657  0f865f0d0000   jna 4086  (0x9c023ab22f6)
                  ;;; <@166,#777> load-keyed
0x9c023ab1597   663  8b761b         movl rsi,[rsi+0x1b]
                  ;;; <@168,#780> push-argument
0x9c023ab159a   666  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 12445
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab15a4   676  4152           push r10
                  ;;; <@170,#892> smi-tag
0x9c023ab15a6   678  448bc6         movl r8,rsi
0x9c023ab15a9   681  49c1e020       REX.W shlq r8,32
                  ;;; <@172,#781> push-argument
0x9c023ab15ad   685  4150           push r8
                  ;;; <@174,#782> push-argument
0x9c023ab15af   687  ff75d8         push [rbp-0x28]
                  ;;; <@175,#782> gap
0x9c023ab15b2   690  488bf3         REX.W movq rsi,rbx
                  ;;; <@176,#783> invoke-function
0x9c023ab15b5   693  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab15b9   697  ff5717         call [rdi+0x17]
                  ;;; <@177,#783> gap
0x9c023ab15bc   700  488945b0       REX.W movq [rbp-0x50],rax
                  ;;; <@178,#784> lazy-bailout
                  ;;; <@179,#784> gap
0x9c023ab15c0   704  488b5de8       REX.W movq rbx,[rbp-0x18]
                  ;;; <@180,#785> load-context-slot
0x9c023ab15c4   708  488b93ef000000 REX.W movq rdx,[rbx+0xef]    ;; debug: position 12457
                  ;;; <@181,#785> gap
0x9c023ab15cb   715  488955a8       REX.W movq [rbp-0x58],rdx
                  ;;; <@182,#786> check-value
0x9c023ab15cf   719  49ba11f435064e360000 REX.W movq r10,0x364e0635f411    ;; object: 0x364e0635f411 <JS Function subtract (SharedFunctionInfo 0xc1217b4d3b9)>
0x9c023ab15d9   729  493bd2         REX.W cmpq rdx,r10
0x9c023ab15dc   732  0f85190d0000   jnz 4091  (0x9c023ab22fb)
                  ;;; <@184,#787> load-context-slot
0x9c023ab15e2   738  488bbbff000000 REX.W movq rdi,[rbx+0xff]    ;; debug: position 12469
                  ;;; <@186,#788> check-value
0x9c023ab15e9   745  49baa1f435064e360000 REX.W movq r10,0x364e0635f4a1    ;; object: 0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>
0x9c023ab15f3   755  493bfa         REX.W cmpq rdi,r10
0x9c023ab15f6   758  0f85040d0000   jnz 4096  (0x9c023ab2300)
                  ;;; <@188,#792> push-argument
0x9c023ab15fc   764  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 12485
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1606   774  4152           push r10
                  ;;; <@190,#793> push-argument
0x9c023ab1608   776  ff75d0         push [rbp-0x30]
                  ;;; <@192,#794> push-argument
0x9c023ab160b   779  ff75d8         push [rbp-0x28]
                  ;;; <@193,#794> gap
0x9c023ab160e   782  488bf3         REX.W movq rsi,rbx
                  ;;; <@194,#795> invoke-function
0x9c023ab1611   785  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1615   789  ff5717         call [rdi+0x17]
                  ;;; <@196,#796> lazy-bailout
                  ;;; <@198,#798> push-argument
0x9c023ab1618   792  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1622   802  4152           push r10
                  ;;; <@200,#799> push-argument
0x9c023ab1624   804  ff7518         push [rbp+0x18]
                  ;;; <@202,#800> push-argument
0x9c023ab1627   807  50             push rax
                  ;;; <@203,#800> gap
0x9c023ab1628   808  488b75e8       REX.W movq rsi,[rbp-0x18]
0x9c023ab162c   812  488b7da8       REX.W movq rdi,[rbp-0x58]
                  ;;; <@204,#801> invoke-function
0x9c023ab1630   816  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1634   820  ff5717         call [rdi+0x17]
                  ;;; <@206,#802> lazy-bailout
                  ;;; <@208,#804> push-argument
0x9c023ab1637   823  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1641   833  4152           push r10
                  ;;; <@210,#805> push-argument
0x9c023ab1643   835  ff75b0         push [rbp-0x50]
                  ;;; <@212,#806> push-argument
0x9c023ab1646   838  50             push rax
                  ;;; <@213,#806> gap
0x9c023ab1647   839  488b75e8       REX.W movq rsi,[rbp-0x18]
0x9c023ab164b   843  488b7db8       REX.W movq rdi,[rbp-0x48]
                  ;;; <@214,#807> invoke-function
0x9c023ab164f   847  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1653   851  ff5717         call [rdi+0x17]
                  ;;; <@216,#808> lazy-bailout
                  ;;; <@218,#810> push-argument
0x9c023ab1656   854  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 12499
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1660   864  4152           push r10
                  ;;; <@220,#811> push-argument
0x9c023ab1662   866  50             push rax
                  ;;; <@222,#812> push-argument
0x9c023ab1663   867  ff7510         push [rbp+0x10]
                  ;;; <@223,#812> gap
0x9c023ab1666   870  488b75e8       REX.W movq rsi,[rbp-0x18]
0x9c023ab166a   874  488b7dc0       REX.W movq rdi,[rbp-0x40]
                  ;;; <@224,#813> invoke-function
0x9c023ab166e   878  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1672   882  e889fcffff     call 0  (0x9c023ab1300)    ;; code: OPTIMIZED_FUNCTION
                  ;;; <@225,#813> gap
0x9c023ab1677   887  488945a0       REX.W movq [rbp-0x60],rax
                  ;;; <@226,#814> lazy-bailout
                  ;;; <@228,#817> push-argument
0x9c023ab167b   891  49bae9f535064e360000 REX.W movq r10,0x364e0635f5e9    ;; debug: position 12516
                                                             ;; object: 0x364e0635f5e9 <FixedArray[12]>
0x9c023ab1685   901  4152           push r10
                  ;;; <@230,#819> push-argument
0x9c023ab1687   903  49ba000000000b000000 REX.W movq r10,0xb00000000
0x9c023ab1691   913  4152           push r10
                  ;;; <@232,#821> push-argument
0x9c023ab1693   915  49ba0141d035a6260000 REX.W movq r10,0x26a635d04101    ;; object: 0x26a635d04101 <FixedArray[0]>
0x9c023ab169d   925  4152           push r10
                  ;;; <@234,#823> push-argument
0x9c023ab169f   927  4f8d1464       REX.W leaq r10,[r12+r12*2]
0x9c023ab16a3   931  4152           push r10
                  ;;; <@235,#823> gap
0x9c023ab16a5   933  488b75e8       REX.W movq rsi,[rbp-0x18]
                  ;;; <@236,#824> call-runtime
0x9c023ab16a9   937  b804000000     movl rax,0x4
0x9c023ab16ae   942  498d9d5851e7fd REX.W leaq rbx,[r13-0x218aea8]
0x9c023ab16b5   949  e8a649f5ff     call 0x9c023a06060       ;; code: STUB, CEntryStub, minor: 0
                  ;;; <@237,#824> gap
0x9c023ab16ba   954  48894598       REX.W movq [rbp-0x68],rax
                  ;;; <@238,#824> lazy-bailout
                  ;;; <@240,#825> check-maps
0x9c023ab16be   958  49ba517ec05ecb2c0000 REX.W movq r10,0x2ccb5ec07e51    ;; object: 0x2ccb5ec07e51 <Map(elements=0)>
0x9c023ab16c8   968  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab16cc   972  0f85330c0000   jnz 4101  (0x9c023ab2305)
                  ;;; <@241,#825> gap
0x9c023ab16d2   978  488b5de8       REX.W movq rbx,[rbp-0x18]
                  ;;; <@242,#827> load-context-slot
0x9c023ab16d6   982  488b93e7000000 REX.W movq rdx,[rbx+0xe7]    ;; debug: position 12517
                  ;;; <@243,#827> gap
0x9c023ab16dd   989  48895590       REX.W movq [rbp-0x70],rdx
                  ;;; <@244,#828> check-value
0x9c023ab16e1   993  49bac9f335064e360000 REX.W movq r10,0x364e0635f3c9    ;; object: 0x364e0635f3c9 <JS Function add (SharedFunctionInfo 0xc1217b4d301)>
0x9c023ab16eb  1003  493bd2         REX.W cmpq rdx,r10
0x9c023ab16ee  1006  0f85160c0000   jnz 4106  (0x9c023ab230a)
                  ;;; <@246,#829> load-context-slot
0x9c023ab16f4  1012  488bbbff000000 REX.W movq rdi,[rbx+0xff]    ;; debug: position 12521
                  ;;; <@248,#830> check-value
0x9c023ab16fb  1019  49baa1f435064e360000 REX.W movq r10,0x364e0635f4a1    ;; object: 0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>
0x9c023ab1705  1029  493bfa         REX.W cmpq rdi,r10
0x9c023ab1708  1032  0f85010c0000   jnz 4111  (0x9c023ab230f)
                  ;;; <@249,#830> gap
0x9c023ab170e  1038  488b4dc8       REX.W movq rcx,[rbp-0x38]
                  ;;; <@250,#834> check-maps
0x9c023ab1712  1042  49ba517ec05ecb2c0000 REX.W movq r10,0x2ccb5ec07e51    ;; debug: position 12535
                                                             ;; object: 0x2ccb5ec07e51 <Map(elements=0)>
0x9c023ab171c  1052  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023ab1720  1056  0f85ee0b0000   jnz 4116  (0x9c023ab2314)
                  ;;; <@252,#835> load-named-field
0x9c023ab1726  1062  488b710f       REX.W movq rsi,[rcx+0xf]
                  ;;; <@254,#836> load-named-field
0x9c023ab172a  1066  448b411b       movl r8,[rcx+0x1b]
                  ;;; <@256,#837> bounds-check
0x9c023ab172e  1070  4183f800       cmpl r8,0x0
0x9c023ab1732  1074  0f86e10b0000   jna 4121  (0x9c023ab2319)
                  ;;; <@258,#838> load-keyed
0x9c023ab1738  1080  8b4e13         movl rcx,[rsi+0x13]
                  ;;; <@260,#841> push-argument
0x9c023ab173b  1083  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 12539
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1745  1093  4152           push r10
                  ;;; <@262,#895> smi-tag
0x9c023ab1747  1095  8bf1           movl rsi,rcx
0x9c023ab1749  1097  48c1e620       REX.W shlq rsi,32
                  ;;; <@264,#842> push-argument
0x9c023ab174d  1101  56             push rsi
                  ;;; <@266,#843> push-argument
0x9c023ab174e  1102  ff75d8         push [rbp-0x28]
                  ;;; <@267,#843> gap
0x9c023ab1751  1105  488bf3         REX.W movq rsi,rbx
                  ;;; <@268,#844> invoke-function
0x9c023ab1754  1108  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1758  1112  ff5717         call [rdi+0x17]
                  ;;; <@270,#845> lazy-bailout
                  ;;; <@271,#845> gap
0x9c023ab175b  1115  488b5da0       REX.W movq rbx,[rbp-0x60]
                  ;;; <@272,#848> check-non-smi
0x9c023ab175f  1119  f6c301         testb rbx,0x1            ;; debug: position 12554
0x9c023ab1762  1122  0f84b60b0000   jz 4126  (0x9c023ab231e)
                  ;;; <@274,#849> check-maps
0x9c023ab1768  1128  49ba517ec05ecb2c0000 REX.W movq r10,0x2ccb5ec07e51    ;; object: 0x2ccb5ec07e51 <Map(elements=0)>
0x9c023ab1772  1138  4c3953ff       REX.W cmpq [rbx-0x1],r10
0x9c023ab1776  1142  0f85a70b0000   jnz 4131  (0x9c023ab2323)
                  ;;; <@276,#850> load-named-field
0x9c023ab177c  1148  488b530f       REX.W movq rdx,[rbx+0xf]
                  ;;; <@278,#851> load-named-field
0x9c023ab1780  1152  8b4b1b         movl rcx,[rbx+0x1b]
                  ;;; <@280,#852> bounds-check
0x9c023ab1783  1155  83f900         cmpl rcx,0x0
0x9c023ab1786  1158  0f869c0b0000   jna 4136  (0x9c023ab2328)
                  ;;; <@282,#853> load-keyed
0x9c023ab178c  1164  8b5213         movl rdx,[rdx+0x13]
                  ;;; <@284,#855> push-argument
0x9c023ab178f  1167  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1799  1177  4152           push r10
                  ;;; <@286,#856> push-argument
0x9c023ab179b  1179  50             push rax
                  ;;; <@288,#896> smi-tag
0x9c023ab179c  1180  8bc2           movl rax,rdx
0x9c023ab179e  1182  48c1e020       REX.W shlq rax,32
                  ;;; <@290,#857> push-argument
0x9c023ab17a2  1186  50             push rax
                  ;;; <@291,#857> gap
0x9c023ab17a3  1187  488b75e8       REX.W movq rsi,[rbp-0x18]
0x9c023ab17a7  1191  488b7d90       REX.W movq rdi,[rbp-0x70]
                  ;;; <@292,#858> invoke-function
0x9c023ab17ab  1195  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab17af  1199  ff5717         call [rdi+0x17]
                  ;;; <@294,#859> lazy-bailout
                  ;;; <@295,#859> gap
0x9c023ab17b2  1202  488b5d98       REX.W movq rbx,[rbp-0x68]
                  ;;; <@296,#860> load-named-field
0x9c023ab17b6  1206  488b530f       REX.W movq rdx,[rbx+0xf]
                  ;;; <@297,#860> gap
0x9c023ab17ba  1210  488bc8         REX.W movq rcx,rax
                  ;;; <@298,#897> check-smi
0x9c023ab17bd  1213  f6c101         testb rcx,0x1
0x9c023ab17c0  1216  0f85670b0000   jnz 4141  (0x9c023ab232d)
                  ;;; <@300,#862> store-keyed
0x9c023ab17c6  1222  48894a0f       REX.W movq [rdx+0xf],rcx
                  ;;; <@301,#862> gap
0x9c023ab17ca  1226  488b45a0       REX.W movq rax,[rbp-0x60]
                  ;;; <@302,#867> check-maps
0x9c023ab17ce  1230  49ba517ec05ecb2c0000 REX.W movq r10,0x2ccb5ec07e51    ;; debug: position 12562
                                                             ;; object: 0x2ccb5ec07e51 <Map(elements=0)>
0x9c023ab17d8  1240  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab17dc  1244  0f85500b0000   jnz 4146  (0x9c023ab2332)
                  ;;; <@304,#868> load-named-field
0x9c023ab17e2  1250  488b480f       REX.W movq rcx,[rax+0xf]
                  ;;; <@306,#869> load-named-field
0x9c023ab17e6  1254  8b701b         movl rsi,[rax+0x1b]
                  ;;; <@308,#870> bounds-check
0x9c023ab17e9  1257  83fe01         cmpl rsi,0x1
0x9c023ab17ec  1260  0f86450b0000   jna 4151  (0x9c023ab2337)
                  ;;; <@310,#871> load-keyed
0x9c023ab17f2  1266  8b411b         movl rax,[rcx+0x1b]
                  ;;; <@312,#898> smi-tag
0x9c023ab17f5  1269  8bc8           movl rcx,rax
0x9c023ab17f7  1271  48c1e120       REX.W shlq rcx,32
                  ;;; <@314,#874> store-keyed
0x9c023ab17fb  1275  48894a17       REX.W movq [rdx+0x17],rcx
                  ;;; <@315,#874> gap
0x9c023ab17ff  1279  488bc3         REX.W movq rax,rbx
                  ;;; <@316,#877> return
0x9c023ab1802  1282  488be5         REX.W movq rsp,rbp
0x9c023ab1805  1285  5d             pop rbp
0x9c023ab1806  1286  c21800         ret 0x18
                  ;;; <@318,#715> -------------------- B10 (unreachable/replaced) --------------------
                  ;;; <@322,#721> -------------------- B11 --------------------
                  ;;; <@323,#721> gap
0x9c023ab1809  1289  488b45e8       REX.W movq rax,[rbp-0x18]    ;; debug: position 12273
                  ;;; <@324,#722> load-context-slot
0x9c023ab180d  1293  488bb80f010000 REX.W movq rdi,[rax+0x10f]
                  ;;; <@326,#723> check-value
0x9c023ab1814  1300  49ba31f535064e360000 REX.W movq r10,0x364e0635f531    ;; object: 0x364e0635f531 <JS Function sub (SharedFunctionInfo 0xc1217b4d701)>
0x9c023ab181e  1310  493bfa         REX.W cmpq rdi,r10
0x9c023ab1821  1313  0f85150b0000   jnz 4156  (0x9c023ab233c)
                  ;;; <@328,#725> push-argument
0x9c023ab1827  1319  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 12280
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1831  1329  4152           push r10
                  ;;; <@330,#726> push-argument
0x9c023ab1833  1331  ff7518         push [rbp+0x18]
                  ;;; <@332,#727> push-argument
0x9c023ab1836  1334  ff7510         push [rbp+0x10]
                  ;;; <@333,#727> gap
0x9c023ab1839  1337  488bf0         REX.W movq rsi,rax
                  ;;; <@334,#728> invoke-function
0x9c023ab183c  1340  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1840  1344  ff5717         call [rdi+0x17]
                  ;;; <@336,#729> lazy-bailout
                  ;;; <@338,#731> return
0x9c023ab1843  1347  488be5         REX.W movq rsp,rbp
0x9c023ab1846  1350  5d             pop rbp
0x9c023ab1847  1351  c21800         ret 0x18
                  ;;; <@340,#591> -------------------- B12 (unreachable/replaced) --------------------
                  ;;; <@344,#597> -------------------- B13 --------------------
                  ;;; <@346,#598> load-context-slot
0x9c023ab184a  1354  488bb81f010000 REX.W movq rdi,[rax+0x11f]    ;; debug: position 12087
                  ;;; <@348,#599> push-argument
0x9c023ab1851  1361  49ba214130064e360000 REX.W movq r10,0x364e06304121    ;; debug: position 12102
                                                             ;; object: 0x364e06304121 <undefined>
0x9c023ab185b  1371  4152           push r10
                  ;;; <@350,#600> push-argument
0x9c023ab185d  1373  ff7518         push [rbp+0x18]
                  ;;; <@352,#601> push-argument
0x9c023ab1860  1376  ff7510         push [rbp+0x10]
                  ;;; <@353,#601> gap
0x9c023ab1863  1379  488bf0         REX.W movq rsi,rax
                  ;;; <@354,#602> call-function
0x9c023ab1866  1382  e8b575f7ff     call 0x9c023a28e20       ;; code: STUB, CallFunctionStub, argc = 2
                  ;;; <@356,#603> lazy-bailout
                  ;;; <@358,#607> deoptimize
                  ;;; deoptimize: Insufficient type feedback for combined type of binary operation
0x9c023ab186b  1387  e8b649e5ff     call 0x9c023906226       ;; debug: position 12120
                                                             ;; soft deoptimization bailout 55
                  ;;; <@360,#608> -------------------- B14 (unreachable/replaced) --------------------
                  ;;; <@370,#615> -------------------- B15 (unreachable/replaced) --------------------
                  ;;; <@374,#641> -------------------- B16 (unreachable/replaced) --------------------
                  ;;; <@378,#645> -------------------- B17 (unreachable/replaced) --------------------
                  ;;; <@388,#652> -------------------- B18 (unreachable/replaced) --------------------
                  ;;; <@392,#679> -------------------- B19 (unreachable/replaced) --------------------
                  ;;; <@448,#649> -------------------- B20 (unreachable/replaced) --------------------
                  ;;; <@452,#655> -------------------- B21 (unreachable/replaced) --------------------
                  ;;; <@494,#612> -------------------- B22 (unreachable/replaced) --------------------
                  ;;; <@498,#618> -------------------- B23 (unreachable/replaced) --------------------
                  ;;; <@538,#558> -------------------- B24 (unreachable/replaced) --------------------
                  ;;; <@542,#564> -------------------- B25 --------------------
                  ;;; <@544,#566> push-argument
0x9c023ab1870  1392  49bae9f535064e360000 REX.W movq r10,0x364e0635f5e9    ;; debug: position 12029
                                                             ;; object: 0x364e0635f5e9 <FixedArray[12]>
0x9c023ab187a  1402  4152           push r10
                  ;;; <@546,#568> push-argument
0x9c023ab187c  1404  49ba0000000007000000 REX.W movq r10,0x700000000
0x9c023ab1886  1414  4152           push r10
                  ;;; <@548,#570> push-argument
0x9c023ab1888  1416  49ba0141d035a6260000 REX.W movq r10,0x26a635d04101    ;; object: 0x26a635d04101 <FixedArray[0]>
0x9c023ab1892  1426  4152           push r10
                  ;;; <@550,#572> push-argument
0x9c023ab1894  1428  4f8d1464       REX.W leaq r10,[r12+r12*2]
0x9c023ab1898  1432  4152           push r10
                  ;;; <@551,#572> gap
0x9c023ab189a  1434  488b75e8       REX.W movq rsi,[rbp-0x18]
                  ;;; <@552,#573> call-runtime
0x9c023ab189e  1438  b804000000     movl rax,0x4
0x9c023ab18a3  1443  498d9d5851e7fd REX.W leaq rbx,[r13-0x218aea8]
0x9c023ab18aa  1450  e8b147f5ff     call 0x9c023a06060       ;; code: STUB, CEntryStub, minor: 0
                  ;;; <@554,#573> lazy-bailout
                  ;;; <@556,#574> check-maps
0x9c023ab18af  1455  49ba517ec05ecb2c0000 REX.W movq r10,0x2ccb5ec07e51    ;; object: 0x2ccb5ec07e51 <Map(elements=0)>
0x9c023ab18b9  1465  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab18bd  1469  0f857e0a0000   jnz 4161  (0x9c023ab2341)
                  ;;; <@557,#574> gap
0x9c023ab18c3  1475  488b5de8       REX.W movq rbx,[rbp-0x18]
                  ;;; <@558,#576> load-context-slot
0x9c023ab18c7  1479  488b9bb7000000 REX.W movq rbx,[rbx+0xb7]    ;; debug: position 12030
                  ;;; <@560,#577> load-named-field
0x9c023ab18ce  1486  488b500f       REX.W movq rdx,[rax+0xf]
                  ;;; <@562,#919> check-smi
0x9c023ab18d2  1490  f6c301         testb rbx,0x1
0x9c023ab18d5  1493  0f856b0a0000   jnz 4166  (0x9c023ab2346)
                  ;;; <@564,#579> store-keyed
0x9c023ab18db  1499  48895a0f       REX.W movq [rdx+0xf],rbx
                  ;;; <@565,#579> gap
0x9c023ab18df  1503  488b5d18       REX.W movq rbx,[rbp+0x18]
                  ;;; <@566,#880> check-smi
0x9c023ab18e3  1507  f6c301         testb rbx,0x1            ;; debug: position 12036
0x9c023ab18e6  1510  0f855f0a0000   jnz 4171  (0x9c023ab234b)
                  ;;; <@568,#583> store-keyed
0x9c023ab18ec  1516  48895a17       REX.W movq [rdx+0x17],rbx
                  ;;; <@570,#586> return
0x9c023ab18f0  1520  488be5         REX.W movq rsp,rbp
0x9c023ab18f3  1523  5d             pop rbp
0x9c023ab18f4  1524  c21800         ret 0x18
                  ;;; <@572,#51> -------------------- B26 --------------------
0x9c023ab18f7  1527  488bd8         REX.W movq rbx,rax       ;; debug: position 11034
                  ;;; <@576,#57> -------------------- B27 --------------------
                  ;;; <@578,#58> load-context-slot
0x9c023ab18fa  1530  488b433f       REX.W movq rax,[rbx+0x3f]    ;; debug: position 11071
                  ;;; <@579,#58> gap
0x9c023ab18fe  1534  488945c8       REX.W movq [rbp-0x38],rax
                  ;;; <@580,#59> check-value
0x9c023ab1902  1538  49ba89ad32064e360000 REX.W movq r10,0x364e0632ad89    ;; object: 0x364e0632ad89 <JS Function ceil (SharedFunctionInfo 0x364e06329bd9)>
0x9c023ab190c  1548  493bc2         REX.W cmpq rax,r10
0x9c023ab190f  1551  0f853b0a0000   jnz 4176  (0x9c023ab2350)
                  ;;; <@582,#60> load-context-slot
0x9c023ab1915  1557  488b534f       REX.W movq rdx,[rbx+0x4f]    ;; debug: position 11076
                  ;;; <@583,#60> gap
0x9c023ab1919  1561  488955a0       REX.W movq [rbp-0x60],rdx
                  ;;; <@584,#61> check-value
0x9c023ab191d  1565  49ba29af32064e360000 REX.W movq r10,0x364e0632af29    ;; object: 0x364e0632af29 <JS Function log (SharedFunctionInfo 0x364e06329ea1)>
0x9c023ab1927  1575  493bd2         REX.W cmpq rdx,r10
0x9c023ab192a  1578  0f85250a0000   jnz 4181  (0x9c023ab2355)
                  ;;; <@586,#886> int32-to-double
0x9c023ab1930  1584  0f57c9         xorps xmm1,xmm1          ;; debug: position 11093
0x9c023ab1933  1587  f2410f2acb     cvtsi2sd xmm1,r11
                  ;;; <@588,#921> double-untag
0x9c023ab1938  1592  41f6c601       testb r14,0x1            ;; debug: position 11081
0x9c023ab193c  1596  7425           jz 1635  (0x9c023ab1963)
0x9c023ab193e  1598  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023ab1942  1602  4d3956ff       REX.W cmpq [r14-0x1],r10
0x9c023ab1946  1606  f2410f105607   movsd xmm2,[r14+0x7]
0x9c023ab194c  1612  7502           jnz 1616  (0x9c023ab1950)
0x9c023ab194e  1614  eb22           jmp 1650  (0x9c023ab1972)
0x9c023ab1950  1616  4d3b75a8       REX.W cmpq r14,[r13-0x58]
0x9c023ab1954  1620  0f85000a0000   jnz 4186  (0x9c023ab235a)
0x9c023ab195a  1626  0f57d2         xorps xmm2,xmm2
0x9c023ab195d  1629  f20f5ed2       divsd xmm2,xmm2
0x9c023ab1961  1633  eb0f           jmp 1650  (0x9c023ab1972)
0x9c023ab1963  1635  4d8bd6         REX.W movq r10,r14
0x9c023ab1966  1638  49c1ea20       REX.W shrq r10,32
0x9c023ab196a  1642  0f57d2         xorps xmm2,xmm2
0x9c023ab196d  1645  f2410f2ad2     cvtsi2sd xmm2,r10
                  ;;; <@590,#64> div-d
0x9c023ab1972  1650  f20f5ed1       divsd xmm2,xmm1          ;; debug: position 11091
0x9c023ab1976  1654  0f28d2         movaps xmm2,xmm2
                  ;;; <@591,#64> gap
0x9c023ab1979  1657  f20f119518ffffff movsd [rbp-0xe8],xmm2
0x9c023ab1981  1665  0f28ca         movaps xmm1,xmm2
                  ;;; <@592,#66> math-log
0x9c023ab1984  1668  0f57c0         xorps xmm0,xmm0
0x9c023ab1987  1671  660f2ec8       ucomisd xmm1,xmm0
0x9c023ab198b  1675  7718           ja 1701  (0x9c023ab19a5)
0x9c023ab198d  1677  730b           jnc 1690  (0x9c023ab199a)
0x9c023ab198f  1679  f2410f108d60a553fe movsd xmm1,[r13-0x1ac5aa0]
0x9c023ab1998  1688  eb27           jmp 1729  (0x9c023ab19c1)
0x9c023ab199a  1690  f2410f108d58a553fe movsd xmm1,[r13-0x1ac5aa8]
0x9c023ab19a3  1699  eb1c           jmp 1729  (0x9c023ab19c1)
0x9c023ab19a5  1701  d9ed           fldln2
0x9c023ab19a7  1703  4883ec08       REX.W subq rsp,0x8
0x9c023ab19ab  1707  f20f110c24     movsd [rsp],xmm1
0x9c023ab19b0  1712  dd0424         fld_d [rsp]
0x9c023ab19b3  1715  d9f1           fyl2x
0x9c023ab19b5  1717  dd1c24         fstp_d [rsp]
0x9c023ab19b8  1720  f20f100c24     movsd xmm1,[rsp]
0x9c023ab19bd  1725  4883c408       REX.W addq rsp,0x8
                  ;;; <@593,#66> gap
0x9c023ab19c1  1729  f20f118d10ffffff movsd [rbp-0xf0],xmm1
                  ;;; <@594,#66> lazy-bailout
                  ;;; <@595,#66> gap
0x9c023ab19c9  1737  488b45e8       REX.W movq rax,[rbp-0x18]
                  ;;; <@596,#67> load-context-slot
0x9c023ab19cd  1741  488b585f       REX.W movq rbx,[rax+0x5f]    ;; debug: position 11121
                  ;;; <@598,#922> double-untag
0x9c023ab19d1  1745  f6c301         testb rbx,0x1
0x9c023ab19d4  1748  7424           jz 1786  (0x9c023ab19fa)
0x9c023ab19d6  1750  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023ab19da  1754  4c3953ff       REX.W cmpq [rbx-0x1],r10
0x9c023ab19de  1758  f20f104b07     movsd xmm1,[rbx+0x7]
0x9c023ab19e3  1763  7502           jnz 1767  (0x9c023ab19e7)
0x9c023ab19e5  1765  eb22           jmp 1801  (0x9c023ab1a09)
0x9c023ab19e7  1767  493b5da8       REX.W cmpq rbx,[r13-0x58]
0x9c023ab19eb  1771  0f856e090000   jnz 4191  (0x9c023ab235f)
0x9c023ab19f1  1777  0f57c9         xorps xmm1,xmm1
0x9c023ab19f4  1780  f20f5ec9       divsd xmm1,xmm1
0x9c023ab19f8  1784  eb0f           jmp 1801  (0x9c023ab1a09)
0x9c023ab19fa  1786  4c8bd3         REX.W movq r10,rbx
0x9c023ab19fd  1789  49c1ea20       REX.W shrq r10,32
0x9c023ab1a01  1793  0f57c9         xorps xmm1,xmm1
0x9c023ab1a04  1796  f2410f2aca     cvtsi2sd xmm1,r10
                  ;;; <@599,#922> gap
0x9c023ab1a09  1801  f20f109510ffffff movsd xmm2,[rbp-0xf0]
                  ;;; <@600,#68> div-d
0x9c023ab1a11  1809  f20f5ed1       divsd xmm2,xmm1          ;; debug: position 11119
0x9c023ab1a15  1813  0f28d2         movaps xmm2,xmm2
                  ;;; <@602,#923> constant-d
0x9c023ab1a18  1816  48bb000000000000f0bf REX.W movq rbx,0xbff0000000000000    ;; debug: position 754
0x9c023ab1a22  1826  66480f6ecb     REX.W movq xmm1,rbx
                  ;;; <@603,#923> gap
0x9c023ab1a27  1831  0f28da         movaps xmm3,xmm2
                  ;;; <@604,#76> mul-d
0x9c023ab1a2a  1834  f20f59d9       mulsd xmm3,xmm1
                  ;;; <@606,#78> math-floor
0x9c023ab1a2e  1838  0f57c0         xorps xmm0,xmm0
0x9c023ab1a31  1841  660f2ed8       ucomisd xmm3,xmm0
0x9c023ab1a35  1845  0f8a29090000   jpe 4196  (0x9c023ab2364)
0x9c023ab1a3b  1851  7225           jc 1890  (0x9c023ab1a62)
0x9c023ab1a3d  1853  7714           ja 1875  (0x9c023ab1a53)
0x9c023ab1a3f  1855  660f50db       movmskpd rbx,xmm3
0x9c023ab1a43  1859  f6c301         testb rbx,0x1
0x9c023ab1a46  1862  0f8518090000   jnz 4196  (0x9c023ab2364)
0x9c023ab1a4c  1868  33db           xorl rbx,rbx
0x9c023ab1a4e  1870  e929000000     jmp 1916  (0x9c023ab1a7c)
0x9c023ab1a53  1875  f20f2cdb       cvttsd2sil rbx,xmm3
0x9c023ab1a57  1879  83fb01         cmpl rbx,0x1
0x9c023ab1a5a  1882  0f8004090000   jo 4196  (0x9c023ab2364)
0x9c023ab1a60  1888  eb1a           jmp 1916  (0x9c023ab1a7c)
0x9c023ab1a62  1890  f20f2cdb       cvttsd2sil rbx,xmm3
0x9c023ab1a66  1894  0f57c0         xorps xmm0,xmm0
0x9c023ab1a69  1897  f20f2ac3       cvtsi2sd xmm0,rbx
0x9c023ab1a6d  1901  660f2ed8       ucomisd xmm3,xmm0
0x9c023ab1a71  1905  7409           jz 1916  (0x9c023ab1a7c)
0x9c023ab1a73  1907  83eb01         subl rbx,0x1
0x9c023ab1a76  1910  0f80e8080000   jo 4196  (0x9c023ab2364)
                  ;;; <@608,#80> mul-i
0x9c023ab1a7c  1916  448bd3         movl r10,rbx             ;; debug: position 743
0x9c023ab1a7f  1919  f7db           negl rbx
0x9c023ab1a81  1921  0f80e2080000   jo 4201  (0x9c023ab2369)
0x9c023ab1a87  1927  85db           testl rbx,rbx
0x9c023ab1a89  1929  7505           jnz 1936  (0x9c023ab1a90)
0x9c023ab1a8b  1931  e80448c5ff     call 0x9c023706294       ;; deoptimization bailout 66
                  ;;; <@609,#80> gap
0x9c023ab1a90  1936  48895d98       REX.W movq [rbp-0x68],rbx
                  ;;; <@612,#85> -------------------- B28 --------------------
                  ;;; <@614,#87> load-context-slot
0x9c023ab1a94  1940  488bb8ff000000 REX.W movq rdi,[rax+0xff]    ;; debug: position 11119
                                                             ;; debug: position 11142
                  ;;; <@616,#88> check-value
0x9c023ab1a9b  1947  49baa1f435064e360000 REX.W movq r10,0x364e0635f4a1    ;; object: 0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>
0x9c023ab1aa5  1957  493bfa         REX.W cmpq rdi,r10
0x9c023ab1aa8  1960  0f85c0080000   jnz 4206  (0x9c023ab236e)
                  ;;; <@618,#91> push-argument
0x9c023ab1aae  1966  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 11156
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1ab8  1976  4152           push r10
                  ;;; <@620,#92> push-argument
0x9c023ab1aba  1978  ff7518         push [rbp+0x18]
                  ;;; <@622,#927> smi-tag
0x9c023ab1abd  1981  8bd3           movl rdx,rbx
0x9c023ab1abf  1983  48c1e220       REX.W shlq rdx,32
                  ;;; <@623,#927> gap
0x9c023ab1ac3  1987  48895588       REX.W movq [rbp-0x78],rdx
                  ;;; <@624,#93> push-argument
0x9c023ab1ac7  1991  52             push rdx
                  ;;; <@625,#93> gap
0x9c023ab1ac8  1992  488bf0         REX.W movq rsi,rax
                  ;;; <@626,#94> invoke-function
0x9c023ab1acb  1995  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1acf  1999  ff5717         call [rdi+0x17]
                  ;;; <@627,#94> gap
0x9c023ab1ad2  2002  48894580       REX.W movq [rbp-0x80],rax
                  ;;; <@628,#95> lazy-bailout
                  ;;; <@629,#95> gap
0x9c023ab1ad6  2006  488b5de8       REX.W movq rbx,[rbp-0x18]
                  ;;; <@630,#97> load-context-slot
0x9c023ab1ada  2010  488bbbff000000 REX.W movq rdi,[rbx+0xff]    ;; debug: position 11180
                  ;;; <@632,#98> check-value
0x9c023ab1ae1  2017  49baa1f435064e360000 REX.W movq r10,0x364e0635f4a1    ;; object: 0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>
0x9c023ab1aeb  2027  493bfa         REX.W cmpq rdi,r10
0x9c023ab1aee  2030  0f857f080000   jnz 4211  (0x9c023ab2373)
                  ;;; <@634,#101> push-argument
0x9c023ab1af4  2036  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 11194
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1afe  2046  4152           push r10
                  ;;; <@636,#102> push-argument
0x9c023ab1b00  2048  ff7510         push [rbp+0x10]
                  ;;; <@638,#103> push-argument
0x9c023ab1b03  2051  ff7588         push [rbp-0x78]
                  ;;; <@639,#103> gap
0x9c023ab1b06  2054  488bf3         REX.W movq rsi,rbx
                  ;;; <@640,#104> invoke-function
0x9c023ab1b09  2057  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1b0d  2061  ff5717         call [rdi+0x17]
                  ;;; <@641,#104> gap
0x9c023ab1b10  2064  48898578ffffff REX.W movq [rbp-0x88],rax
                  ;;; <@642,#105> lazy-bailout
                  ;;; <@643,#105> gap
0x9c023ab1b17  2071  488b5de8       REX.W movq rbx,[rbp-0x18]
                  ;;; <@644,#107> load-context-slot
0x9c023ab1b1b  2075  488b9397000000 REX.W movq rdx,[rbx+0x97]    ;; debug: position 11218
                  ;;; <@646,#108> load-context-slot
0x9c023ab1b22  2082  488b8b9f000000 REX.W movq rcx,[rbx+0x9f]    ;; debug: position 11223
                  ;;; <@648,#110> check-non-smi
0x9c023ab1b29  2089  f6c101         testb rcx,0x1            ;; debug: position 11228
0x9c023ab1b2c  2092  0f8446080000   jz 4216  (0x9c023ab2378)
                  ;;; <@650,#111> check-maps
0x9c023ab1b32  2098  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab1b3c  2108  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023ab1b40  2112  0f8537080000   jnz 4221  (0x9c023ab237d)
                  ;;; <@652,#112> load-named-field
0x9c023ab1b46  2118  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@654,#113> load-named-field
0x9c023ab1b4a  2122  8b710b         movl rsi,[rcx+0xb]
                  ;;; <@656,#114> load-named-field
0x9c023ab1b4d  2125  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@657,#114> gap
0x9c023ab1b51  2129  488b7d80       REX.W movq rdi,[rbp-0x80]
                  ;;; <@658,#928> tagged-to-i
0x9c023ab1b55  2133  40f6c701       testb rdi,0x1
0x9c023ab1b59  2137  0f85ab060000   jnz 3850  (0x9c023ab220a)
0x9c023ab1b5f  2143  48c1ef20       REX.W shrq rdi,32
                  ;;; <@660,#115> bounds-check
0x9c023ab1b63  2147  3bf7           cmpl rsi,rdi
0x9c023ab1b65  2149  0f8617080000   jna 4226  (0x9c023ab2382)
                  ;;; <@662,#116> load-keyed
0x9c023ab1b6b  2155  8b3cb9         movl rdi,[rcx+rdi*4]
0x9c023ab1b6e  2158  85ff           testl rdi,rdi
0x9c023ab1b70  2160  0f8811080000   js 4231  (0x9c023ab2387)
                  ;;; <@664,#117> check-non-smi
0x9c023ab1b76  2166  f6c201         testb rdx,0x1
0x9c023ab1b79  2169  0f840d080000   jz 4236  (0x9c023ab238c)
                  ;;; <@666,#118> check-maps
0x9c023ab1b7f  2175  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab1b89  2185  4c3952ff       REX.W cmpq [rdx-0x1],r10
0x9c023ab1b8d  2189  0f85fe070000   jnz 4241  (0x9c023ab2391)
                  ;;; <@668,#119> load-named-field
0x9c023ab1b93  2195  488b520f       REX.W movq rdx,[rdx+0xf]
                  ;;; <@670,#120> load-named-field
0x9c023ab1b97  2199  448b420b       movl r8,[rdx+0xb]
                  ;;; <@672,#121> load-named-field
0x9c023ab1b9b  2203  488b520f       REX.W movq rdx,[rdx+0xf]
                  ;;; <@674,#122> bounds-check
0x9c023ab1b9f  2207  443bc7         cmpl r8,rdi
0x9c023ab1ba2  2210  0f86ee070000   jna 4246  (0x9c023ab2396)
                  ;;; <@676,#123> load-keyed
0x9c023ab1ba8  2216  8b3cba         movl rdi,[rdx+rdi*4]
0x9c023ab1bab  2219  85ff           testl rdi,rdi
0x9c023ab1bad  2221  0f88e8070000   js 4251  (0x9c023ab239b)
                  ;;; <@677,#123> gap
0x9c023ab1bb3  2227  4c8bc8         REX.W movq r9,rax
                  ;;; <@678,#929> tagged-to-i
0x9c023ab1bb6  2230  41f6c101       testb r9,0x1             ;; debug: position 11258
0x9c023ab1bba  2234  0f857b060000   jnz 3899  (0x9c023ab223b)
0x9c023ab1bc0  2240  49c1e920       REX.W shrq r9,32
                  ;;; <@680,#133> bounds-check
0x9c023ab1bc4  2244  413bf1         cmpl rsi,r9
0x9c023ab1bc7  2247  0f86d3070000   jna 4256  (0x9c023ab23a0)
                  ;;; <@682,#134> load-keyed
0x9c023ab1bcd  2253  428b3489       movl rsi,[rcx+r9*4]
0x9c023ab1bd1  2257  85f6           testl rsi,rsi
0x9c023ab1bd3  2259  0f88cc070000   js 4261  (0x9c023ab23a5)
                  ;;; <@684,#140> bounds-check
0x9c023ab1bd9  2265  443bc6         cmpl r8,rsi
0x9c023ab1bdc  2268  0f86c8070000   jna 4266  (0x9c023ab23aa)
                  ;;; <@686,#141> load-keyed
0x9c023ab1be2  2274  8b0cb2         movl rcx,[rdx+rsi*4]
0x9c023ab1be5  2277  85c9           testl rcx,rcx
0x9c023ab1be7  2279  0f88c2070000   js 4271  (0x9c023ab23af)
                  ;;; <@689,#145> compare-numeric-and-branch
0x9c023ab1bed  2285  3bf9           cmpl rdi,rcx             ;; debug: position 11277
0x9c023ab1bef  2287  0f8c02050000   jl 3575  (0x9c023ab20f7)
                  ;;; <@690,#149> -------------------- B29 (unreachable/replaced) --------------------
                  ;;; <@694,#175> -------------------- B30 --------------------
                  ;;; <@697,#178> compare-numeric-and-branch
0x9c023ab1bf5  2293  3bf9           cmpl rdi,rcx             ;; debug: position 11330
                                                             ;; debug: position 11332
0x9c023ab1bf7  2295  0f84cd040000   jz 3530  (0x9c023ab20ca)
                  ;;; <@698,#182> -------------------- B31 (unreachable/replaced) --------------------
                  ;;; <@702,#298> -------------------- B32 --------------------
                  ;;; <@703,#298> gap
0x9c023ab1bfd  2301  488bd1         REX.W movq rdx,rcx       ;; debug: position 11515
                  ;;; <@704,#302> add-i
0x9c023ab1c00  2304  83c201         addl rdx,0x1             ;; debug: position 11523
0x9c023ab1c03  2307  0f80ab070000   jo 4276  (0x9c023ab23b4)
                  ;;; <@707,#304> compare-numeric-and-branch
0x9c023ab1c09  2313  3bfa           cmpl rdi,rdx             ;; debug: position 11517
0x9c023ab1c0b  2315  0f8439040000   jz 3402  (0x9c023ab204a)
                  ;;; <@708,#308> -------------------- B33 (unreachable/replaced) --------------------
                  ;;; <@712,#361> -------------------- B34 --------------------
                  ;;; <@713,#361> gap
0x9c023ab1c11  2321  488bd7         REX.W movq rdx,rdi       ;; debug: position 11644
                  ;;; <@714,#364> sub-i
0x9c023ab1c14  2324  2bd1           subl rdx,rcx             ;; debug: position 11646
0x9c023ab1c16  2326  0f809d070000   jo 4281  (0x9c023ab23b9)
                  ;;; <@715,#364> gap
0x9c023ab1c1c  2332  488bca         REX.W movq rcx,rdx
                  ;;; <@716,#367> sub-i
0x9c023ab1c1f  2335  83e901         subl rcx,0x1             ;; debug: position 11650
0x9c023ab1c22  2338  0f8096070000   jo 4286  (0x9c023ab23be)
                  ;;; <@718,#370> mul-i
0x9c023ab1c28  2344  6bc91a         imull rcx,rcx,0x1a       ;; debug: position 11655
0x9c023ab1c2b  2347  0f8092070000   jo 4291  (0x9c023ab23c3)
                  ;;; <@719,#370> gap
0x9c023ab1c31  2353  48898d70ffffff REX.W movq [rbp-0x90],rcx
                  ;;; <@720,#373> load-context-slot
0x9c023ab1c38  2360  488bbb07010000 REX.W movq rdi,[rbx+0x107]    ;; debug: position 11676
                  ;;; <@722,#374> check-value
0x9c023ab1c3f  2367  49bae9f435064e360000 REX.W movq r10,0x364e0635f4e9    ;; object: 0x364e0635f4e9 <JS Function right_shift (SharedFunctionInfo 0xc1217b4d5e1)>
0x9c023ab1c49  2377  493bfa         REX.W cmpq rdi,r10
0x9c023ab1c4c  2380  0f8576070000   jnz 4296  (0x9c023ab23c8)
                  ;;; <@724,#378> push-argument
0x9c023ab1c52  2386  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 11692
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1c5c  2396  4152           push r10
                  ;;; <@726,#379> push-argument
0x9c023ab1c5e  2398  ff7580         push [rbp-0x80]
                  ;;; <@728,#933> smi-tag
0x9c023ab1c61  2401  8bd1           movl rdx,rcx
0x9c023ab1c63  2403  48c1e220       REX.W shlq rdx,32
                  ;;; <@729,#933> gap
0x9c023ab1c67  2407  48899568ffffff REX.W movq [rbp-0x98],rdx
                  ;;; <@730,#380> push-argument
0x9c023ab1c6e  2414  52             push rdx
                  ;;; <@731,#380> gap
0x9c023ab1c6f  2415  488bf3         REX.W movq rsi,rbx
                  ;;; <@732,#381> invoke-function
0x9c023ab1c72  2418  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1c76  2422  ff5717         call [rdi+0x17]
                  ;;; <@733,#381> gap
0x9c023ab1c79  2425  48898560ffffff REX.W movq [rbp-0xa0],rax
                  ;;; <@734,#382> lazy-bailout
                  ;;; <@735,#382> gap
0x9c023ab1c80  2432  488b5de8       REX.W movq rbx,[rbp-0x18]
                  ;;; <@736,#384> load-context-slot
0x9c023ab1c84  2436  488bbb0f010000 REX.W movq rdi,[rbx+0x10f]    ;; debug: position 11718
                  ;;; <@738,#385> check-value
0x9c023ab1c8b  2443  49ba31f535064e360000 REX.W movq r10,0x364e0635f531    ;; object: 0x364e0635f531 <JS Function sub (SharedFunctionInfo 0xc1217b4d701)>
0x9c023ab1c95  2453  493bfa         REX.W cmpq rdi,r10
0x9c023ab1c98  2456  0f852f070000   jnz 4301  (0x9c023ab23cd)
                  ;;; <@740,#389> push-argument
0x9c023ab1c9e  2462  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 11727
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1ca8  2472  4152           push r10
                  ;;; <@742,#390> push-argument
0x9c023ab1caa  2474  50             push rax
                  ;;; <@744,#391> push-argument
0x9c023ab1cab  2475  ffb578ffffff   push [rbp-0x88]
                  ;;; <@745,#391> gap
0x9c023ab1cb1  2481  488bf3         REX.W movq rsi,rbx
                  ;;; <@746,#392> invoke-function
0x9c023ab1cb4  2484  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1cb8  2488  ff5717         call [rdi+0x17]
                  ;;; <@747,#392> gap
0x9c023ab1cbb  2491  48898558ffffff REX.W movq [rbp-0xa8],rax
                  ;;; <@748,#393> lazy-bailout
                  ;;; <@749,#393> gap
0x9c023ab1cc2  2498  488b5de8       REX.W movq rbx,[rbp-0x18]
                  ;;; <@750,#395> load-context-slot
0x9c023ab1cc6  2502  488b9317010000 REX.W movq rdx,[rbx+0x117]    ;; debug: position 11746
                  ;;; <@751,#395> gap
0x9c023ab1ccd  2509  48899550ffffff REX.W movq [rbp-0xb0],rdx
                  ;;; <@752,#396> check-value
0x9c023ab1cd4  2516  49baa1f535064e360000 REX.W movq r10,0x364e0635f5a1    ;; object: 0x364e0635f5a1 <JS Function divide (SharedFunctionInfo 0xc1217b4d899)>
0x9c023ab1cde  2526  493bd2         REX.W cmpq rdx,r10
0x9c023ab1ce1  2529  0f85eb060000   jnz 4306  (0x9c023ab23d2)
                  ;;; <@754,#397> load-context-slot
0x9c023ab1ce7  2535  488b8be7000000 REX.W movq rcx,[rbx+0xe7]    ;; debug: position 11753
                  ;;; <@755,#397> gap
0x9c023ab1cee  2542  48898d48ffffff REX.W movq [rbp-0xb8],rcx
                  ;;; <@756,#398> check-value
0x9c023ab1cf5  2549  49bac9f335064e360000 REX.W movq r10,0x364e0635f3c9    ;; object: 0x364e0635f3c9 <JS Function add (SharedFunctionInfo 0xc1217b4d301)>
0x9c023ab1cff  2559  493bca         REX.W cmpq rcx,r10
0x9c023ab1d02  2562  0f85cf060000   jnz 4311  (0x9c023ab23d7)
                  ;;; <@758,#399> load-context-slot
0x9c023ab1d08  2568  488bbbff000000 REX.W movq rdi,[rbx+0xff]    ;; debug: position 11757
                  ;;; <@760,#400> check-value
0x9c023ab1d0f  2575  49baa1f435064e360000 REX.W movq r10,0x364e0635f4a1    ;; object: 0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>
0x9c023ab1d19  2585  493bfa         REX.W cmpq rdi,r10
0x9c023ab1d1c  2588  0f85ba060000   jnz 4316  (0x9c023ab23dc)
                  ;;; <@762,#403> check-non-smi
0x9c023ab1d22  2594  a801           test al,0x1              ;; debug: position 11771
0x9c023ab1d24  2596  0f84b7060000   jz 4321  (0x9c023ab23e1)
                  ;;; <@764,#404> check-maps
0x9c023ab1d2a  2602  49ba517ec05ecb2c0000 REX.W movq r10,0x2ccb5ec07e51    ;; object: 0x2ccb5ec07e51 <Map(elements=0)>
0x9c023ab1d34  2612  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab1d38  2616  0f85a8060000   jnz 4326  (0x9c023ab23e6)
                  ;;; <@766,#405> load-named-field
0x9c023ab1d3e  2622  488b700f       REX.W movq rsi,[rax+0xf]
                  ;;; <@768,#406> load-named-field
0x9c023ab1d42  2626  448b401b       movl r8,[rax+0x1b]
                  ;;; <@770,#407> bounds-check
0x9c023ab1d46  2630  4183f801       cmpl r8,0x1
0x9c023ab1d4a  2634  0f869b060000   jna 4331  (0x9c023ab23eb)
                  ;;; <@772,#408> load-keyed
0x9c023ab1d50  2640  8b761b         movl rsi,[rsi+0x1b]
                  ;;; <@774,#411> push-argument
0x9c023ab1d53  2643  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 11775
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1d5d  2653  4152           push r10
                  ;;; <@776,#934> smi-tag
0x9c023ab1d5f  2655  448bc6         movl r8,rsi
0x9c023ab1d62  2658  49c1e020       REX.W shlq r8,32
                  ;;; <@778,#412> push-argument
0x9c023ab1d66  2662  4150           push r8
                  ;;; <@780,#413> push-argument
0x9c023ab1d68  2664  ffb568ffffff   push [rbp-0x98]
                  ;;; <@781,#413> gap
0x9c023ab1d6e  2670  488bf3         REX.W movq rsi,rbx
                  ;;; <@782,#414> invoke-function
0x9c023ab1d71  2673  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1d75  2677  ff5717         call [rdi+0x17]
                  ;;; <@783,#414> gap
0x9c023ab1d78  2680  48898540ffffff REX.W movq [rbp-0xc0],rax
                  ;;; <@784,#415> lazy-bailout
                  ;;; <@785,#415> gap
0x9c023ab1d7f  2687  488b5de8       REX.W movq rbx,[rbp-0x18]
                  ;;; <@786,#416> load-context-slot
0x9c023ab1d83  2691  488b93ef000000 REX.W movq rdx,[rbx+0xef]    ;; debug: position 11787
                  ;;; <@787,#416> gap
0x9c023ab1d8a  2698  48899538ffffff REX.W movq [rbp-0xc8],rdx
                  ;;; <@788,#417> check-value
0x9c023ab1d91  2705  49ba11f435064e360000 REX.W movq r10,0x364e0635f411    ;; object: 0x364e0635f411 <JS Function subtract (SharedFunctionInfo 0xc1217b4d3b9)>
0x9c023ab1d9b  2715  493bd2         REX.W cmpq rdx,r10
0x9c023ab1d9e  2718  0f854c060000   jnz 4336  (0x9c023ab23f0)
                  ;;; <@790,#419> load-context-slot
0x9c023ab1da4  2724  488bbbff000000 REX.W movq rdi,[rbx+0xff]    ;; debug: position 11800
                  ;;; <@792,#420> check-value
0x9c023ab1dab  2731  49baa1f435064e360000 REX.W movq r10,0x364e0635f4a1    ;; object: 0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>
0x9c023ab1db5  2741  493bfa         REX.W cmpq rdi,r10
0x9c023ab1db8  2744  0f8537060000   jnz 4341  (0x9c023ab23f5)
                  ;;; <@794,#424> push-argument
0x9c023ab1dbe  2750  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 11816
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1dc8  2760  4152           push r10
                  ;;; <@796,#425> push-argument
0x9c023ab1dca  2762  ffb560ffffff   push [rbp-0xa0]
                  ;;; <@798,#426> push-argument
0x9c023ab1dd0  2768  ffb568ffffff   push [rbp-0x98]
                  ;;; <@799,#426> gap
0x9c023ab1dd6  2774  488bf3         REX.W movq rsi,rbx
                  ;;; <@800,#427> invoke-function
0x9c023ab1dd9  2777  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1ddd  2781  ff5717         call [rdi+0x17]
                  ;;; <@802,#428> lazy-bailout
                  ;;; <@804,#430> push-argument
0x9c023ab1de0  2784  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1dea  2794  4152           push r10
                  ;;; <@806,#431> push-argument
0x9c023ab1dec  2796  ff7580         push [rbp-0x80]
                  ;;; <@808,#432> push-argument
0x9c023ab1def  2799  50             push rax
                  ;;; <@809,#432> gap
0x9c023ab1df0  2800  488b75e8       REX.W movq rsi,[rbp-0x18]
0x9c023ab1df4  2804  488bbd38ffffff REX.W movq rdi,[rbp-0xc8]
                  ;;; <@810,#433> invoke-function
0x9c023ab1dfb  2811  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1dff  2815  ff5717         call [rdi+0x17]
                  ;;; <@812,#434> lazy-bailout
                  ;;; <@814,#436> push-argument
0x9c023ab1e02  2818  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1e0c  2828  4152           push r10
                  ;;; <@816,#437> push-argument
0x9c023ab1e0e  2830  ffb540ffffff   push [rbp-0xc0]
                  ;;; <@818,#438> push-argument
0x9c023ab1e14  2836  50             push rax
                  ;;; <@819,#438> gap
0x9c023ab1e15  2837  488b75e8       REX.W movq rsi,[rbp-0x18]
0x9c023ab1e19  2841  488bbd48ffffff REX.W movq rdi,[rbp-0xb8]
                  ;;; <@820,#439> invoke-function
0x9c023ab1e20  2848  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1e24  2852  ff5717         call [rdi+0x17]
                  ;;; <@822,#440> lazy-bailout
                  ;;; <@824,#443> push-argument
0x9c023ab1e27  2855  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 11830
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1e31  2865  4152           push r10
                  ;;; <@826,#444> push-argument
0x9c023ab1e33  2867  50             push rax
                  ;;; <@828,#445> push-argument
0x9c023ab1e34  2868  ffb578ffffff   push [rbp-0x88]
                  ;;; <@829,#445> gap
0x9c023ab1e3a  2874  488b75e8       REX.W movq rsi,[rbp-0x18]
0x9c023ab1e3e  2878  488bbd50ffffff REX.W movq rdi,[rbp-0xb0]
                  ;;; <@830,#446> invoke-function
0x9c023ab1e45  2885  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1e49  2889  e8b2f4ffff     call 0  (0x9c023ab1300)    ;; code: OPTIMIZED_FUNCTION
                  ;;; <@831,#446> gap
0x9c023ab1e4e  2894  48898530ffffff REX.W movq [rbp-0xd0],rax
                  ;;; <@832,#447> lazy-bailout
                  ;;; <@834,#450> push-argument
0x9c023ab1e55  2901  49bae9f535064e360000 REX.W movq r10,0x364e0635f5e9    ;; debug: position 11848
                                                             ;; object: 0x364e0635f5e9 <FixedArray[12]>
0x9c023ab1e5f  2911  4152           push r10
                  ;;; <@836,#452> push-argument
0x9c023ab1e61  2913  49ba0000000006000000 REX.W movq r10,0x600000000
0x9c023ab1e6b  2923  4152           push r10
                  ;;; <@838,#454> push-argument
0x9c023ab1e6d  2925  49ba0141d035a6260000 REX.W movq r10,0x26a635d04101    ;; object: 0x26a635d04101 <FixedArray[0]>
0x9c023ab1e77  2935  4152           push r10
                  ;;; <@840,#456> push-argument
0x9c023ab1e79  2937  4f8d1464       REX.W leaq r10,[r12+r12*2]
0x9c023ab1e7d  2941  4152           push r10
                  ;;; <@841,#456> gap
0x9c023ab1e7f  2943  488b75e8       REX.W movq rsi,[rbp-0x18]
                  ;;; <@842,#457> call-runtime
0x9c023ab1e83  2947  b804000000     movl rax,0x4
0x9c023ab1e88  2952  498d9d5851e7fd REX.W leaq rbx,[r13-0x218aea8]
0x9c023ab1e8f  2959  e8cc41f5ff     call 0x9c023a06060       ;; code: STUB, CEntryStub, minor: 0
                  ;;; <@843,#457> gap
0x9c023ab1e94  2964  48898528ffffff REX.W movq [rbp-0xd8],rax
                  ;;; <@844,#457> lazy-bailout
                  ;;; <@846,#458> check-maps
0x9c023ab1e9b  2971  49ba517ec05ecb2c0000 REX.W movq r10,0x2ccb5ec07e51    ;; object: 0x2ccb5ec07e51 <Map(elements=0)>
0x9c023ab1ea5  2981  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab1ea9  2985  0f854b050000   jnz 4346  (0x9c023ab23fa)
                  ;;; <@847,#458> gap
0x9c023ab1eaf  2991  488b5de8       REX.W movq rbx,[rbp-0x18]
                  ;;; <@848,#460> load-context-slot
0x9c023ab1eb3  2995  488b93e7000000 REX.W movq rdx,[rbx+0xe7]    ;; debug: position 11849
                  ;;; <@849,#460> gap
0x9c023ab1eba  3002  48899520ffffff REX.W movq [rbp-0xe0],rdx
                  ;;; <@850,#461> check-value
0x9c023ab1ec1  3009  49bac9f335064e360000 REX.W movq r10,0x364e0635f3c9    ;; object: 0x364e0635f3c9 <JS Function add (SharedFunctionInfo 0xc1217b4d301)>
0x9c023ab1ecb  3019  493bd2         REX.W cmpq rdx,r10
0x9c023ab1ece  3022  0f852b050000   jnz 4351  (0x9c023ab23ff)
                  ;;; <@852,#462> load-context-slot
0x9c023ab1ed4  3028  488bbbff000000 REX.W movq rdi,[rbx+0xff]    ;; debug: position 11853
                  ;;; <@854,#463> check-value
0x9c023ab1edb  3035  49baa1f435064e360000 REX.W movq r10,0x364e0635f4a1    ;; object: 0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>
0x9c023ab1ee5  3045  493bfa         REX.W cmpq rdi,r10
0x9c023ab1ee8  3048  0f8516050000   jnz 4356  (0x9c023ab2404)
                  ;;; <@855,#463> gap
0x9c023ab1eee  3054  488b8d58ffffff REX.W movq rcx,[rbp-0xa8]
                  ;;; <@856,#467> check-maps
0x9c023ab1ef5  3061  49ba517ec05ecb2c0000 REX.W movq r10,0x2ccb5ec07e51    ;; debug: position 11867
                                                             ;; object: 0x2ccb5ec07e51 <Map(elements=0)>
0x9c023ab1eff  3071  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023ab1f03  3075  0f8500050000   jnz 4361  (0x9c023ab2409)
                  ;;; <@858,#468> load-named-field
0x9c023ab1f09  3081  488b710f       REX.W movq rsi,[rcx+0xf]
                  ;;; <@860,#469> load-named-field
0x9c023ab1f0d  3085  448b411b       movl r8,[rcx+0x1b]
                  ;;; <@862,#470> bounds-check
0x9c023ab1f11  3089  4183f800       cmpl r8,0x0
0x9c023ab1f15  3093  0f86f3040000   jna 4366  (0x9c023ab240e)
                  ;;; <@864,#471> load-keyed
0x9c023ab1f1b  3099  8b4e13         movl rcx,[rsi+0x13]
                  ;;; <@866,#474> push-argument
0x9c023ab1f1e  3102  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 11871
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1f28  3112  4152           push r10
                  ;;; <@868,#937> smi-tag
0x9c023ab1f2a  3114  8bf1           movl rsi,rcx
0x9c023ab1f2c  3116  48c1e620       REX.W shlq rsi,32
                  ;;; <@870,#475> push-argument
0x9c023ab1f30  3120  56             push rsi
                  ;;; <@872,#476> push-argument
0x9c023ab1f31  3121  ffb568ffffff   push [rbp-0x98]
                  ;;; <@873,#476> gap
0x9c023ab1f37  3127  488bf3         REX.W movq rsi,rbx
                  ;;; <@874,#477> invoke-function
0x9c023ab1f3a  3130  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1f3e  3134  ff5717         call [rdi+0x17]
                  ;;; <@876,#478> lazy-bailout
                  ;;; <@877,#478> gap
0x9c023ab1f41  3137  488b9d30ffffff REX.W movq rbx,[rbp-0xd0]
                  ;;; <@878,#481> check-non-smi
0x9c023ab1f48  3144  f6c301         testb rbx,0x1            ;; debug: position 11886
0x9c023ab1f4b  3147  0f84c2040000   jz 4371  (0x9c023ab2413)
                  ;;; <@880,#482> check-maps
0x9c023ab1f51  3153  49ba517ec05ecb2c0000 REX.W movq r10,0x2ccb5ec07e51    ;; object: 0x2ccb5ec07e51 <Map(elements=0)>
0x9c023ab1f5b  3163  4c3953ff       REX.W cmpq [rbx-0x1],r10
0x9c023ab1f5f  3167  0f85b3040000   jnz 4376  (0x9c023ab2418)
                  ;;; <@882,#483> load-named-field
0x9c023ab1f65  3173  488b530f       REX.W movq rdx,[rbx+0xf]
                  ;;; <@884,#484> load-named-field
0x9c023ab1f69  3177  8b4b1b         movl rcx,[rbx+0x1b]
                  ;;; <@886,#485> bounds-check
0x9c023ab1f6c  3180  83f900         cmpl rcx,0x0
0x9c023ab1f6f  3183  0f86a8040000   jna 4381  (0x9c023ab241d)
                  ;;; <@888,#486> load-keyed
0x9c023ab1f75  3189  8b5213         movl rdx,[rdx+0x13]
                  ;;; <@890,#488> push-argument
0x9c023ab1f78  3192  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab1f82  3202  4152           push r10
                  ;;; <@892,#489> push-argument
0x9c023ab1f84  3204  50             push rax
                  ;;; <@894,#938> smi-tag
0x9c023ab1f85  3205  8bc2           movl rax,rdx
0x9c023ab1f87  3207  48c1e020       REX.W shlq rax,32
                  ;;; <@896,#490> push-argument
0x9c023ab1f8b  3211  50             push rax
                  ;;; <@897,#490> gap
0x9c023ab1f8c  3212  488b75e8       REX.W movq rsi,[rbp-0x18]
0x9c023ab1f90  3216  488bbd20ffffff REX.W movq rdi,[rbp-0xe0]
                  ;;; <@898,#491> invoke-function
0x9c023ab1f97  3223  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab1f9b  3227  ff5717         call [rdi+0x17]
                  ;;; <@900,#492> lazy-bailout
                  ;;; <@901,#492> gap
0x9c023ab1f9e  3230  488b9d28ffffff REX.W movq rbx,[rbp-0xd8]
                  ;;; <@902,#493> load-named-field
0x9c023ab1fa5  3237  488b530f       REX.W movq rdx,[rbx+0xf]
                  ;;; <@903,#493> gap
0x9c023ab1fa9  3241  488bc8         REX.W movq rcx,rax
                  ;;; <@904,#939> check-smi
0x9c023ab1fac  3244  f6c101         testb rcx,0x1
0x9c023ab1faf  3247  0f856d040000   jnz 4386  (0x9c023ab2422)
                  ;;; <@906,#495> store-keyed
0x9c023ab1fb5  3253  48894a0f       REX.W movq [rdx+0xf],rcx
                  ;;; <@907,#495> gap
0x9c023ab1fb9  3257  488b45e8       REX.W movq rax,[rbp-0x18]
                  ;;; <@908,#497> load-context-slot
0x9c023ab1fbd  3261  488bb807010000 REX.W movq rdi,[rax+0x107]    ;; debug: position 11891
                  ;;; <@910,#498> check-value
0x9c023ab1fc4  3268  49bae9f435064e360000 REX.W movq r10,0x364e0635f4e9    ;; object: 0x364e0635f4e9 <JS Function right_shift (SharedFunctionInfo 0xc1217b4d5e1)>
0x9c023ab1fce  3278  493bfa         REX.W cmpq rdi,r10
0x9c023ab1fd1  3281  0f8550040000   jnz 4391  (0x9c023ab2427)
                  ;;; <@911,#498> gap
0x9c023ab1fd7  3287  488b9530ffffff REX.W movq rdx,[rbp-0xd0]
                  ;;; <@912,#502> check-maps
0x9c023ab1fde  3294  49ba517ec05ecb2c0000 REX.W movq r10,0x2ccb5ec07e51    ;; debug: position 11906
                                                             ;; object: 0x2ccb5ec07e51 <Map(elements=0)>
0x9c023ab1fe8  3304  4c3952ff       REX.W cmpq [rdx-0x1],r10
0x9c023ab1fec  3308  0f853a040000   jnz 4396  (0x9c023ab242c)
                  ;;; <@914,#503> load-named-field
0x9c023ab1ff2  3314  488b4a0f       REX.W movq rcx,[rdx+0xf]
                  ;;; <@916,#504> load-named-field
0x9c023ab1ff6  3318  8b721b         movl rsi,[rdx+0x1b]
                  ;;; <@918,#505> bounds-check
0x9c023ab1ff9  3321  83fe01         cmpl rsi,0x1
0x9c023ab1ffc  3324  0f862f040000   jna 4401  (0x9c023ab2431)
                  ;;; <@920,#506> load-keyed
0x9c023ab2002  3330  8b511b         movl rdx,[rcx+0x1b]
                  ;;; <@922,#509> push-argument
0x9c023ab2005  3333  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 11910
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab200f  3343  4152           push r10
                  ;;; <@924,#940> smi-tag
0x9c023ab2011  3345  8bca           movl rcx,rdx
0x9c023ab2013  3347  48c1e120       REX.W shlq rcx,32
                  ;;; <@926,#510> push-argument
0x9c023ab2017  3351  51             push rcx
                  ;;; <@928,#511> push-argument
0x9c023ab2018  3352  ff7588         push [rbp-0x78]
                  ;;; <@929,#511> gap
0x9c023ab201b  3355  488bf0         REX.W movq rsi,rax
                  ;;; <@930,#512> invoke-function
0x9c023ab201e  3358  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab2022  3362  ff5717         call [rdi+0x17]
                  ;;; <@932,#513> lazy-bailout
                  ;;; <@933,#513> gap
0x9c023ab2025  3365  488b9d28ffffff REX.W movq rbx,[rbp-0xd8]
                  ;;; <@934,#514> load-named-field
0x9c023ab202c  3372  488b530f       REX.W movq rdx,[rbx+0xf]
                  ;;; <@935,#514> gap
0x9c023ab2030  3376  488bc8         REX.W movq rcx,rax
                  ;;; <@936,#941> check-smi
0x9c023ab2033  3379  f6c101         testb rcx,0x1
0x9c023ab2036  3382  0f85fa030000   jnz 4406  (0x9c023ab2436)
                  ;;; <@938,#516> store-keyed
0x9c023ab203c  3388  48894a17       REX.W movq [rdx+0x17],rcx
                  ;;; <@939,#516> gap
0x9c023ab2040  3392  488bc3         REX.W movq rax,rbx
                  ;;; <@940,#519> return
0x9c023ab2043  3395  488be5         REX.W movq rsp,rbp
0x9c023ab2046  3398  5d             pop rbp
0x9c023ab2047  3399  c21800         ret 0x18
                  ;;; <@942,#305> -------------------- B35 --------------------
0x9c023ab204a  3402  488bc3         REX.W movq rax,rbx       ;; debug: position 11517
                  ;;; <@946,#311> -------------------- B36 --------------------
                  ;;; <@948,#312> load-context-slot
0x9c023ab204d  3405  488bb80f010000 REX.W movq rdi,[rax+0x10f]    ;; debug: position 11548
                  ;;; <@950,#315> push-argument
0x9c023ab2054  3412  49ba214130064e360000 REX.W movq r10,0x364e06304121    ;; debug: position 11556
                                                             ;; object: 0x364e06304121 <undefined>
0x9c023ab205e  3422  4152           push r10
                  ;;; <@952,#316> push-argument
0x9c023ab2060  3424  ff7580         push [rbp-0x80]
                  ;;; <@954,#317> push-argument
0x9c023ab2063  3427  ffb578ffffff   push [rbp-0x88]
                  ;;; <@955,#317> gap
0x9c023ab2069  3433  488bf0         REX.W movq rsi,rax
                  ;;; <@956,#318> call-function
0x9c023ab206c  3436  e8af6df7ff     call 0x9c023a28e20       ;; code: STUB, CallFunctionStub, argc = 2
                  ;;; <@957,#318> gap
0x9c023ab2071  3441  48898558ffffff REX.W movq [rbp-0xa8],rax
                  ;;; <@958,#319> lazy-bailout
                  ;;; <@960,#322> push-argument
0x9c023ab2078  3448  49bae9f535064e360000 REX.W movq r10,0x364e0635f5e9    ;; debug: position 11575
                                                             ;; object: 0x364e0635f5e9 <FixedArray[12]>
0x9c023ab2082  3458  4152           push r10
                  ;;; <@962,#324> push-argument
0x9c023ab2084  3460  4f8d14a4       REX.W leaq r10,[r12+r12*4]
0x9c023ab2088  3464  4152           push r10
                  ;;; <@964,#326> push-argument
0x9c023ab208a  3466  49ba0141d035a6260000 REX.W movq r10,0x26a635d04101    ;; object: 0x26a635d04101 <FixedArray[0]>
0x9c023ab2094  3476  4152           push r10
                  ;;; <@966,#328> push-argument
0x9c023ab2096  3478  4f8d1464       REX.W leaq r10,[r12+r12*2]
0x9c023ab209a  3482  4152           push r10
                  ;;; <@967,#328> gap
0x9c023ab209c  3484  488b75e8       REX.W movq rsi,[rbp-0x18]
                  ;;; <@968,#329> call-runtime
0x9c023ab20a0  3488  b804000000     movl rax,0x4
0x9c023ab20a5  3493  498d9d5851e7fd REX.W leaq rbx,[r13-0x218aea8]
0x9c023ab20ac  3500  e8af3ff5ff     call 0x9c023a06060       ;; code: STUB, CEntryStub, minor: 0
                  ;;; <@970,#329> lazy-bailout
                  ;;; <@972,#330> check-maps
0x9c023ab20b1  3505  49ba517ec05ecb2c0000 REX.W movq r10,0x2ccb5ec07e51    ;; object: 0x2ccb5ec07e51 <Map(elements=0)>
0x9c023ab20bb  3515  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab20bf  3519  0f8576030000   jnz 4411  (0x9c023ab243b)
                  ;;; <@974,#334> deoptimize
                  ;;; deoptimize: Insufficient type feedback for keyed load
0x9c023ab20c5  3525  e80e44e5ff     call 0x9c0239064d8       ;; debug: position 11579
                                                             ;; soft deoptimization bailout 124
                  ;;; <@976,#335> -------------------- B37 (unreachable/replaced) --------------------
                  ;;; <@1000,#346> -------------------- B38 (unreachable/replaced) --------------------
                  ;;; <@1032,#179> -------------------- B39 (unreachable/replaced) --------------------
                  ;;; <@1036,#185> -------------------- B40 --------------------
                  ;;; <@1037,#185> gap
0x9c023ab20ca  3530  488b45e8       REX.W movq rax,[rbp-0x18]    ;; debug: position 11358
                  ;;; <@1038,#186> load-context-slot
0x9c023ab20ce  3534  488bb81f010000 REX.W movq rdi,[rax+0x11f]
                  ;;; <@1040,#189> push-argument
0x9c023ab20d5  3541  49ba214130064e360000 REX.W movq r10,0x364e06304121    ;; debug: position 11374
                                                             ;; object: 0x364e06304121 <undefined>
0x9c023ab20df  3551  4152           push r10
                  ;;; <@1042,#190> push-argument
0x9c023ab20e1  3553  ff7580         push [rbp-0x80]
                  ;;; <@1044,#191> push-argument
0x9c023ab20e4  3556  ffb578ffffff   push [rbp-0x88]
                  ;;; <@1045,#191> gap
0x9c023ab20ea  3562  488bf0         REX.W movq rsi,rax
                  ;;; <@1046,#192> call-function
0x9c023ab20ed  3565  e82e6df7ff     call 0x9c023a28e20       ;; code: STUB, CallFunctionStub, argc = 2
                  ;;; <@1048,#193> lazy-bailout
                  ;;; <@1050,#197> deoptimize
                  ;;; deoptimize: Insufficient type feedback for combined type of binary operation
0x9c023ab20f2  3570  e8f543e5ff     call 0x9c0239064ec       ;; debug: position 11393
                                                             ;; soft deoptimization bailout 126
                  ;;; <@1052,#198> -------------------- B41 (unreachable/replaced) --------------------
                  ;;; <@1062,#205> -------------------- B42 (unreachable/replaced) --------------------
                  ;;; <@1066,#231> -------------------- B43 (unreachable/replaced) --------------------
                  ;;; <@1070,#235> -------------------- B44 (unreachable/replaced) --------------------
                  ;;; <@1080,#242> -------------------- B45 (unreachable/replaced) --------------------
                  ;;; <@1084,#269> -------------------- B46 (unreachable/replaced) --------------------
                  ;;; <@1140,#239> -------------------- B47 (unreachable/replaced) --------------------
                  ;;; <@1144,#245> -------------------- B48 (unreachable/replaced) --------------------
                  ;;; <@1186,#202> -------------------- B49 (unreachable/replaced) --------------------
                  ;;; <@1190,#208> -------------------- B50 (unreachable/replaced) --------------------
                  ;;; <@1230,#146> -------------------- B51 (unreachable/replaced) --------------------
                  ;;; <@1234,#152> -------------------- B52 --------------------
                  ;;; <@1236,#154> push-argument
0x9c023ab20f7  3575  49bae9f535064e360000 REX.W movq r10,0x364e0635f5e9    ;; debug: position 11300
                                                             ;; object: 0x364e0635f5e9 <FixedArray[12]>
0x9c023ab2101  3585  4152           push r10
                  ;;; <@1238,#156> push-argument
0x9c023ab2103  3587  4154           push r12
                  ;;; <@1240,#158> push-argument
0x9c023ab2105  3589  49ba0141d035a6260000 REX.W movq r10,0x26a635d04101    ;; object: 0x26a635d04101 <FixedArray[0]>
0x9c023ab210f  3599  4152           push r10
                  ;;; <@1242,#160> push-argument
0x9c023ab2111  3601  4f8d1464       REX.W leaq r10,[r12+r12*2]
0x9c023ab2115  3605  4152           push r10
                  ;;; <@1243,#160> gap
0x9c023ab2117  3607  488b75e8       REX.W movq rsi,[rbp-0x18]
                  ;;; <@1244,#161> call-runtime
0x9c023ab211b  3611  b804000000     movl rax,0x4
0x9c023ab2120  3616  498d9d5851e7fd REX.W leaq rbx,[r13-0x218aea8]
0x9c023ab2127  3623  e8343ff5ff     call 0x9c023a06060       ;; code: STUB, CEntryStub, minor: 0
                  ;;; <@1246,#161> lazy-bailout
                  ;;; <@1248,#162> check-maps
0x9c023ab212c  3628  49ba517ec05ecb2c0000 REX.W movq r10,0x2ccb5ec07e51    ;; object: 0x2ccb5ec07e51 <Map(elements=0)>
0x9c023ab2136  3638  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab213a  3642  0f8500030000   jnz 4416  (0x9c023ab2440)
                  ;;; <@1249,#162> gap
0x9c023ab2140  3648  488b5de8       REX.W movq rbx,[rbp-0x18]
                  ;;; <@1250,#164> load-context-slot
0x9c023ab2144  3652  488b9bb7000000 REX.W movq rbx,[rbx+0xb7]    ;; debug: position 11301
                  ;;; <@1252,#165> load-named-field
0x9c023ab214b  3659  488b500f       REX.W movq rdx,[rax+0xf]
                  ;;; <@1254,#968> check-smi
0x9c023ab214f  3663  f6c301         testb rbx,0x1
0x9c023ab2152  3666  0f85ed020000   jnz 4421  (0x9c023ab2445)
                  ;;; <@1256,#167> store-keyed
0x9c023ab2158  3672  48895a0f       REX.W movq [rdx+0xf],rbx
                  ;;; <@1257,#167> gap
0x9c023ab215c  3676  488b5d18       REX.W movq rbx,[rbp+0x18]
                  ;;; <@1258,#883> check-smi
0x9c023ab2160  3680  f6c301         testb rbx,0x1            ;; debug: position 11307
0x9c023ab2163  3683  0f85e1020000   jnz 4426  (0x9c023ab244a)
                  ;;; <@1260,#171> store-keyed
0x9c023ab2169  3689  48895a17       REX.W movq [rdx+0x17],rbx
                  ;;; <@1262,#174> return
0x9c023ab216d  3693  488be5         REX.W movq rsp,rbp
0x9c023ab2170  3696  5d             pop rbp
0x9c023ab2171  3697  c21800         ret 0x18
                  ;;; <@30,#885> -------------------- Deferred tagged-to-i --------------------
0x9c023ab2174  3700  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 10914
0x9c023ab2178  3704  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023ab217c  3708  751d           jnz 3739  (0x9c023ab219b)
0x9c023ab217e  3710  f20f104107     movsd xmm0,[rcx+0x7]
0x9c023ab2183  3715  f20f2cc8       cvttsd2sil rcx,xmm0
0x9c023ab2187  3719  0f57c9         xorps xmm1,xmm1
0x9c023ab218a  3722  f20f2ac9       cvtsi2sd xmm1,rcx
0x9c023ab218e  3726  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab2192  3730  7507           jnz 3739  (0x9c023ab219b)
                  Deferred TaggedToI: NaN
0x9c023ab2194  3732  7a05           jpe 3739  (0x9c023ab219b)
0x9c023ab2196  3734  e9cff1ffff     jmp 106  (0x9c023ab136a)
0x9c023ab219b  3739  e87e43c5ff     call 0x9c02370651e       ;; deoptimization bailout 131
0x9c023ab21a0  3744  e9c5f1ffff     jmp 106  (0x9c023ab136a)
                  ;;; <@62,#887> -------------------- Deferred tagged-to-i --------------------
0x9c023ab21a5  3749  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 11036
0x9c023ab21a9  3753  4d3957ff       REX.W cmpq [r15-0x1],r10
0x9c023ab21ad  3757  7520           jnz 3791  (0x9c023ab21cf)
0x9c023ab21af  3759  f2410f104707   movsd xmm0,[r15+0x7]
0x9c023ab21b5  3765  f2440f2cf8     cvttsd2sil r15,xmm0
0x9c023ab21ba  3770  0f57c9         xorps xmm1,xmm1
0x9c023ab21bd  3773  f2410f2acf     cvtsi2sd xmm1,r15
0x9c023ab21c2  3778  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab21c6  3782  7507           jnz 3791  (0x9c023ab21cf)
                  Deferred TaggedToI: NaN
0x9c023ab21c8  3784  7a05           jpe 3791  (0x9c023ab21cf)
0x9c023ab21ca  3786  e932f2ffff     jmp 257  (0x9c023ab1401)
0x9c023ab21cf  3791  e85443c5ff     call 0x9c023706528       ;; deoptimization bailout 132
0x9c023ab21d4  3796  e928f2ffff     jmp 257  (0x9c023ab1401)
                  ;;; <@72,#881> -------------------- Deferred tagged-to-i --------------------
0x9c023ab21d9  3801  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 11959
0x9c023ab21dd  3805  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023ab21e1  3809  751d           jnz 3840  (0x9c023ab2200)
0x9c023ab21e3  3811  f20f104107     movsd xmm0,[rcx+0x7]
0x9c023ab21e8  3816  f20f2cc8       cvttsd2sil rcx,xmm0
0x9c023ab21ec  3820  0f57c9         xorps xmm1,xmm1
0x9c023ab21ef  3823  f20f2ac9       cvtsi2sd xmm1,rcx
0x9c023ab21f3  3827  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab21f7  3831  7507           jnz 3840  (0x9c023ab2200)
                  Deferred TaggedToI: NaN
0x9c023ab21f9  3833  7a05           jpe 3840  (0x9c023ab2200)
0x9c023ab21fb  3835  e91bf2ffff     jmp 283  (0x9c023ab141b)
0x9c023ab2200  3840  e82d43c5ff     call 0x9c023706532       ;; deoptimization bailout 133
0x9c023ab2205  3845  e911f2ffff     jmp 283  (0x9c023ab141b)
                  ;;; <@658,#928> -------------------- Deferred tagged-to-i --------------------
0x9c023ab220a  3850  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 11228
0x9c023ab220e  3854  4c3957ff       REX.W cmpq [rdi-0x1],r10
0x9c023ab2212  3858  751d           jnz 3889  (0x9c023ab2231)
0x9c023ab2214  3860  f20f104707     movsd xmm0,[rdi+0x7]
0x9c023ab2219  3865  f20f2cf8       cvttsd2sil rdi,xmm0
0x9c023ab221d  3869  0f57c9         xorps xmm1,xmm1
0x9c023ab2220  3872  f20f2acf       cvtsi2sd xmm1,rdi
0x9c023ab2224  3876  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab2228  3880  7507           jnz 3889  (0x9c023ab2231)
                  Deferred TaggedToI: NaN
0x9c023ab222a  3882  7a05           jpe 3889  (0x9c023ab2231)
0x9c023ab222c  3884  e932f9ffff     jmp 2147  (0x9c023ab1b63)
0x9c023ab2231  3889  e80643c5ff     call 0x9c02370653c       ;; deoptimization bailout 134
0x9c023ab2236  3894  e928f9ffff     jmp 2147  (0x9c023ab1b63)
                  ;;; <@678,#929> -------------------- Deferred tagged-to-i --------------------
0x9c023ab223b  3899  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 11258
0x9c023ab223f  3903  4d3951ff       REX.W cmpq [r9-0x1],r10
0x9c023ab2243  3907  7520           jnz 3941  (0x9c023ab2265)
0x9c023ab2245  3909  f2410f104107   movsd xmm0,[r9+0x7]
0x9c023ab224b  3915  f2440f2cc8     cvttsd2sil r9,xmm0
0x9c023ab2250  3920  0f57c9         xorps xmm1,xmm1
0x9c023ab2253  3923  f2410f2ac9     cvtsi2sd xmm1,r9
0x9c023ab2258  3928  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab225c  3932  7507           jnz 3941  (0x9c023ab2265)
                  Deferred TaggedToI: NaN
0x9c023ab225e  3934  7a05           jpe 3941  (0x9c023ab2265)
0x9c023ab2260  3936  e95ff9ffff     jmp 2244  (0x9c023ab1bc4)
0x9c023ab2265  3941  e8dc42c5ff     call 0x9c023706546       ;; deoptimization bailout 135
0x9c023ab226a  3946  e955f9ffff     jmp 2244  (0x9c023ab1bc4)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x9c023ab226f  3951  e8963dc5ff     call 0x9c02370600a       ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x9c023ab2274  3956  e89b3dc5ff     call 0x9c023706014       ;; deoptimization bailout 2
                  ;;; jump table entry 2: deoptimization bailout 3.
0x9c023ab2279  3961  e8a03dc5ff     call 0x9c02370601e       ;; deoptimization bailout 3
                  ;;; jump table entry 3: deoptimization bailout 4.
0x9c023ab227e  3966  e8a53dc5ff     call 0x9c023706028       ;; deoptimization bailout 4
                  ;;; jump table entry 4: deoptimization bailout 5.
0x9c023ab2283  3971  e8aa3dc5ff     call 0x9c023706032       ;; deoptimization bailout 5
                  ;;; jump table entry 5: deoptimization bailout 6.
0x9c023ab2288  3976  e8af3dc5ff     call 0x9c02370603c       ;; deoptimization bailout 6
                  ;;; jump table entry 6: deoptimization bailout 7.
0x9c023ab228d  3981  e8b43dc5ff     call 0x9c023706046       ;; deoptimization bailout 7
                  ;;; jump table entry 7: deoptimization bailout 8.
0x9c023ab2292  3986  e8b93dc5ff     call 0x9c023706050       ;; deoptimization bailout 8
                  ;;; jump table entry 8: deoptimization bailout 9.
0x9c023ab2297  3991  e8be3dc5ff     call 0x9c02370605a       ;; deoptimization bailout 9
                  ;;; jump table entry 9: deoptimization bailout 10.
0x9c023ab229c  3996  e8c33dc5ff     call 0x9c023706064       ;; deoptimization bailout 10
                  ;;; jump table entry 10: deoptimization bailout 11.
0x9c023ab22a1  4001  e8c83dc5ff     call 0x9c02370606e       ;; deoptimization bailout 11
                  ;;; jump table entry 11: deoptimization bailout 12.
0x9c023ab22a6  4006  e8cd3dc5ff     call 0x9c023706078       ;; deoptimization bailout 12
                  ;;; jump table entry 12: deoptimization bailout 13.
0x9c023ab22ab  4011  e8d23dc5ff     call 0x9c023706082       ;; deoptimization bailout 13
                  ;;; jump table entry 13: deoptimization bailout 14.
0x9c023ab22b0  4016  e8d73dc5ff     call 0x9c02370608c       ;; deoptimization bailout 14
                  ;;; jump table entry 14: deoptimization bailout 15.
0x9c023ab22b5  4021  e8dc3dc5ff     call 0x9c023706096       ;; deoptimization bailout 15
                  ;;; jump table entry 15: deoptimization bailout 16.
0x9c023ab22ba  4026  e8e13dc5ff     call 0x9c0237060a0       ;; deoptimization bailout 16
                  ;;; jump table entry 16: deoptimization bailout 17.
0x9c023ab22bf  4031  e8e63dc5ff     call 0x9c0237060aa       ;; deoptimization bailout 17
                  ;;; jump table entry 17: deoptimization bailout 18.
0x9c023ab22c4  4036  e8eb3dc5ff     call 0x9c0237060b4       ;; deoptimization bailout 18
                  ;;; jump table entry 18: deoptimization bailout 19.
0x9c023ab22c9  4041  e8f03dc5ff     call 0x9c0237060be       ;; deoptimization bailout 19
                  ;;; jump table entry 19: deoptimization bailout 20.
0x9c023ab22ce  4046  e8f53dc5ff     call 0x9c0237060c8       ;; deoptimization bailout 20
                  ;;; jump table entry 20: deoptimization bailout 21.
0x9c023ab22d3  4051  e8fa3dc5ff     call 0x9c0237060d2       ;; deoptimization bailout 21
                  ;;; jump table entry 21: deoptimization bailout 23.
0x9c023ab22d8  4056  e8093ec5ff     call 0x9c0237060e6       ;; deoptimization bailout 23
                  ;;; jump table entry 22: deoptimization bailout 25.
0x9c023ab22dd  4061  e8183ec5ff     call 0x9c0237060fa       ;; deoptimization bailout 25
                  ;;; jump table entry 23: deoptimization bailout 26.
0x9c023ab22e2  4066  e81d3ec5ff     call 0x9c023706104       ;; deoptimization bailout 26
                  ;;; jump table entry 24: deoptimization bailout 27.
0x9c023ab22e7  4071  e8223ec5ff     call 0x9c02370610e       ;; deoptimization bailout 27
                  ;;; jump table entry 25: deoptimization bailout 28.
0x9c023ab22ec  4076  e8273ec5ff     call 0x9c023706118       ;; deoptimization bailout 28
                  ;;; jump table entry 26: deoptimization bailout 29.
0x9c023ab22f1  4081  e82c3ec5ff     call 0x9c023706122       ;; deoptimization bailout 29
                  ;;; jump table entry 27: deoptimization bailout 30.
0x9c023ab22f6  4086  e8313ec5ff     call 0x9c02370612c       ;; deoptimization bailout 30
                  ;;; jump table entry 28: deoptimization bailout 32.
0x9c023ab22fb  4091  e8403ec5ff     call 0x9c023706140       ;; deoptimization bailout 32
                  ;;; jump table entry 29: deoptimization bailout 33.
0x9c023ab2300  4096  e8453ec5ff     call 0x9c02370614a       ;; deoptimization bailout 33
                  ;;; jump table entry 30: deoptimization bailout 39.
0x9c023ab2305  4101  e87c3ec5ff     call 0x9c023706186       ;; deoptimization bailout 39
                  ;;; jump table entry 31: deoptimization bailout 40.
0x9c023ab230a  4106  e8813ec5ff     call 0x9c023706190       ;; deoptimization bailout 40
                  ;;; jump table entry 32: deoptimization bailout 41.
0x9c023ab230f  4111  e8863ec5ff     call 0x9c02370619a       ;; deoptimization bailout 41
                  ;;; jump table entry 33: deoptimization bailout 42.
0x9c023ab2314  4116  e88b3ec5ff     call 0x9c0237061a4       ;; deoptimization bailout 42
                  ;;; jump table entry 34: deoptimization bailout 43.
0x9c023ab2319  4121  e8903ec5ff     call 0x9c0237061ae       ;; deoptimization bailout 43
                  ;;; jump table entry 35: deoptimization bailout 45.
0x9c023ab231e  4126  e89f3ec5ff     call 0x9c0237061c2       ;; deoptimization bailout 45
                  ;;; jump table entry 36: deoptimization bailout 46.
0x9c023ab2323  4131  e8a43ec5ff     call 0x9c0237061cc       ;; deoptimization bailout 46
                  ;;; jump table entry 37: deoptimization bailout 47.
0x9c023ab2328  4136  e8a93ec5ff     call 0x9c0237061d6       ;; deoptimization bailout 47
                  ;;; jump table entry 38: deoptimization bailout 49.
0x9c023ab232d  4141  e8b83ec5ff     call 0x9c0237061ea       ;; deoptimization bailout 49
                  ;;; jump table entry 39: deoptimization bailout 50.
0x9c023ab2332  4146  e8bd3ec5ff     call 0x9c0237061f4       ;; deoptimization bailout 50
                  ;;; jump table entry 40: deoptimization bailout 51.
0x9c023ab2337  4151  e8c23ec5ff     call 0x9c0237061fe       ;; deoptimization bailout 51
                  ;;; jump table entry 41: deoptimization bailout 52.
0x9c023ab233c  4156  e8c73ec5ff     call 0x9c023706208       ;; deoptimization bailout 52
                  ;;; jump table entry 42: deoptimization bailout 57.
0x9c023ab2341  4161  e8f43ec5ff     call 0x9c02370623a       ;; deoptimization bailout 57
                  ;;; jump table entry 43: deoptimization bailout 58.
0x9c023ab2346  4166  e8f93ec5ff     call 0x9c023706244       ;; deoptimization bailout 58
                  ;;; jump table entry 44: deoptimization bailout 59.
0x9c023ab234b  4171  e8fe3ec5ff     call 0x9c02370624e       ;; deoptimization bailout 59
                  ;;; jump table entry 45: deoptimization bailout 60.
0x9c023ab2350  4176  e8033fc5ff     call 0x9c023706258       ;; deoptimization bailout 60
                  ;;; jump table entry 46: deoptimization bailout 61.
0x9c023ab2355  4181  e8083fc5ff     call 0x9c023706262       ;; deoptimization bailout 61
                  ;;; jump table entry 47: deoptimization bailout 62.
0x9c023ab235a  4186  e80d3fc5ff     call 0x9c02370626c       ;; deoptimization bailout 62
                  ;;; jump table entry 48: deoptimization bailout 64.
0x9c023ab235f  4191  e81c3fc5ff     call 0x9c023706280       ;; deoptimization bailout 64
                  ;;; jump table entry 49: deoptimization bailout 65.
0x9c023ab2364  4196  e8213fc5ff     call 0x9c02370628a       ;; deoptimization bailout 65
                  ;;; jump table entry 50: deoptimization bailout 66.
0x9c023ab2369  4201  e8263fc5ff     call 0x9c023706294       ;; deoptimization bailout 66
                  ;;; jump table entry 51: deoptimization bailout 67.
0x9c023ab236e  4206  e82b3fc5ff     call 0x9c02370629e       ;; deoptimization bailout 67
                  ;;; jump table entry 52: deoptimization bailout 69.
0x9c023ab2373  4211  e83a3fc5ff     call 0x9c0237062b2       ;; deoptimization bailout 69
                  ;;; jump table entry 53: deoptimization bailout 71.
0x9c023ab2378  4216  e8493fc5ff     call 0x9c0237062c6       ;; deoptimization bailout 71
                  ;;; jump table entry 54: deoptimization bailout 72.
0x9c023ab237d  4221  e84e3fc5ff     call 0x9c0237062d0       ;; deoptimization bailout 72
                  ;;; jump table entry 55: deoptimization bailout 73.
0x9c023ab2382  4226  e8533fc5ff     call 0x9c0237062da       ;; deoptimization bailout 73
                  ;;; jump table entry 56: deoptimization bailout 74.
0x9c023ab2387  4231  e8583fc5ff     call 0x9c0237062e4       ;; deoptimization bailout 74
                  ;;; jump table entry 57: deoptimization bailout 75.
0x9c023ab238c  4236  e85d3fc5ff     call 0x9c0237062ee       ;; deoptimization bailout 75
                  ;;; jump table entry 58: deoptimization bailout 76.
0x9c023ab2391  4241  e8623fc5ff     call 0x9c0237062f8       ;; deoptimization bailout 76
                  ;;; jump table entry 59: deoptimization bailout 77.
0x9c023ab2396  4246  e8673fc5ff     call 0x9c023706302       ;; deoptimization bailout 77
                  ;;; jump table entry 60: deoptimization bailout 78.
0x9c023ab239b  4251  e86c3fc5ff     call 0x9c02370630c       ;; deoptimization bailout 78
                  ;;; jump table entry 61: deoptimization bailout 79.
0x9c023ab23a0  4256  e8713fc5ff     call 0x9c023706316       ;; deoptimization bailout 79
                  ;;; jump table entry 62: deoptimization bailout 80.
0x9c023ab23a5  4261  e8763fc5ff     call 0x9c023706320       ;; deoptimization bailout 80
                  ;;; jump table entry 63: deoptimization bailout 81.
0x9c023ab23aa  4266  e87b3fc5ff     call 0x9c02370632a       ;; deoptimization bailout 81
                  ;;; jump table entry 64: deoptimization bailout 82.
0x9c023ab23af  4271  e8803fc5ff     call 0x9c023706334       ;; deoptimization bailout 82
                  ;;; jump table entry 65: deoptimization bailout 83.
0x9c023ab23b4  4276  e8853fc5ff     call 0x9c02370633e       ;; deoptimization bailout 83
                  ;;; jump table entry 66: deoptimization bailout 84.
0x9c023ab23b9  4281  e88a3fc5ff     call 0x9c023706348       ;; deoptimization bailout 84
                  ;;; jump table entry 67: deoptimization bailout 85.
0x9c023ab23be  4286  e88f3fc5ff     call 0x9c023706352       ;; deoptimization bailout 85
                  ;;; jump table entry 68: deoptimization bailout 86.
0x9c023ab23c3  4291  e8943fc5ff     call 0x9c02370635c       ;; deoptimization bailout 86
                  ;;; jump table entry 69: deoptimization bailout 87.
0x9c023ab23c8  4296  e8993fc5ff     call 0x9c023706366       ;; deoptimization bailout 87
                  ;;; jump table entry 70: deoptimization bailout 89.
0x9c023ab23cd  4301  e8a83fc5ff     call 0x9c02370637a       ;; deoptimization bailout 89
                  ;;; jump table entry 71: deoptimization bailout 91.
0x9c023ab23d2  4306  e8b73fc5ff     call 0x9c02370638e       ;; deoptimization bailout 91
                  ;;; jump table entry 72: deoptimization bailout 92.
0x9c023ab23d7  4311  e8bc3fc5ff     call 0x9c023706398       ;; deoptimization bailout 92
                  ;;; jump table entry 73: deoptimization bailout 93.
0x9c023ab23dc  4316  e8c13fc5ff     call 0x9c0237063a2       ;; deoptimization bailout 93
                  ;;; jump table entry 74: deoptimization bailout 94.
0x9c023ab23e1  4321  e8c63fc5ff     call 0x9c0237063ac       ;; deoptimization bailout 94
                  ;;; jump table entry 75: deoptimization bailout 95.
0x9c023ab23e6  4326  e8cb3fc5ff     call 0x9c0237063b6       ;; deoptimization bailout 95
                  ;;; jump table entry 76: deoptimization bailout 96.
0x9c023ab23eb  4331  e8d03fc5ff     call 0x9c0237063c0       ;; deoptimization bailout 96
                  ;;; jump table entry 77: deoptimization bailout 98.
0x9c023ab23f0  4336  e8df3fc5ff     call 0x9c0237063d4       ;; deoptimization bailout 98
                  ;;; jump table entry 78: deoptimization bailout 99.
0x9c023ab23f5  4341  e8e43fc5ff     call 0x9c0237063de       ;; deoptimization bailout 99
                  ;;; jump table entry 79: deoptimization bailout 105.
0x9c023ab23fa  4346  e81b40c5ff     call 0x9c02370641a       ;; deoptimization bailout 105
                  ;;; jump table entry 80: deoptimization bailout 106.
0x9c023ab23ff  4351  e82040c5ff     call 0x9c023706424       ;; deoptimization bailout 106
                  ;;; jump table entry 81: deoptimization bailout 107.
0x9c023ab2404  4356  e82540c5ff     call 0x9c02370642e       ;; deoptimization bailout 107
                  ;;; jump table entry 82: deoptimization bailout 108.
0x9c023ab2409  4361  e82a40c5ff     call 0x9c023706438       ;; deoptimization bailout 108
                  ;;; jump table entry 83: deoptimization bailout 109.
0x9c023ab240e  4366  e82f40c5ff     call 0x9c023706442       ;; deoptimization bailout 109
                  ;;; jump table entry 84: deoptimization bailout 111.
0x9c023ab2413  4371  e83e40c5ff     call 0x9c023706456       ;; deoptimization bailout 111
                  ;;; jump table entry 85: deoptimization bailout 112.
0x9c023ab2418  4376  e84340c5ff     call 0x9c023706460       ;; deoptimization bailout 112
                  ;;; jump table entry 86: deoptimization bailout 113.
0x9c023ab241d  4381  e84840c5ff     call 0x9c02370646a       ;; deoptimization bailout 113
                  ;;; jump table entry 87: deoptimization bailout 115.
0x9c023ab2422  4386  e85740c5ff     call 0x9c02370647e       ;; deoptimization bailout 115
                  ;;; jump table entry 88: deoptimization bailout 116.
0x9c023ab2427  4391  e85c40c5ff     call 0x9c023706488       ;; deoptimization bailout 116
                  ;;; jump table entry 89: deoptimization bailout 117.
0x9c023ab242c  4396  e86140c5ff     call 0x9c023706492       ;; deoptimization bailout 117
                  ;;; jump table entry 90: deoptimization bailout 118.
0x9c023ab2431  4401  e86640c5ff     call 0x9c02370649c       ;; deoptimization bailout 118
                  ;;; jump table entry 91: deoptimization bailout 120.
0x9c023ab2436  4406  e87540c5ff     call 0x9c0237064b0       ;; deoptimization bailout 120
                  ;;; jump table entry 92: deoptimization bailout 123.
0x9c023ab243b  4411  e88e40c5ff     call 0x9c0237064ce       ;; deoptimization bailout 123
                  ;;; jump table entry 93: deoptimization bailout 128.
0x9c023ab2440  4416  e8bb40c5ff     call 0x9c023706500       ;; deoptimization bailout 128
                  ;;; jump table entry 94: deoptimization bailout 129.
0x9c023ab2445  4421  e8c040c5ff     call 0x9c02370650a       ;; deoptimization bailout 129
                  ;;; jump table entry 95: deoptimization bailout 130.
0x9c023ab244a  4426  e8c540c5ff     call 0x9c023706514       ;; deoptimization bailout 130
0x9c023ab244f  4431  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 136)
 index  ast id    argc     pc             
     0       3       0     38
     1       3       0     -1
     2       3       0     -1
     3       3       0     -1
     4       3       0     -1
     5       3       0     -1
     6       3       0     -1
     7       3       0     -1
     8       3       0     -1
     9       3       0     -1
    10       3       0     -1
    11      51       0     -1
    12      51       0     -1
    13     810       0     -1
    14     810       0     -1
    15     810       0     -1
    16     810       0     -1
    17     632       0     -1
    18     657       0     -1
    19     666       0     -1
    20     666       0     -1
    21     666       0     -1
    22     694       0    465
    23     694       0     -1
    24     712       0    527
    25     712       0     -1
    26     712       0     -1
    27     712       0     -1
    28     712       0     -1
    29     712       0     -1
    30     712       0     -1
    31     739       0    704
    32     739       0     -1
    33     739       0     -1
    34     752       0    792
    35     755       0    823
    36     758       0    854
    37     763       0    891
    38     763       0    958
    39     763       0     -1
    40     763       0     -1
    41     763       0     -1
    42     763       0     -1
    43     763       0     -1
    44     784       0   1115
    45     784       0     -1
    46     784       0     -1
    47     784       0     -1
    48     794       0   1202
    49     794       0     -1
    50     806       0     -1
    51     806       0     -1
    52     656       0     -1
    53     652       0   1347
    54     573       0   1387
    55     573       0     -1
    56     553       0   1455
    57     553       0     -1
    58     553       0     -1
    59     550       0     -1
    60     809       0     -1
    61     809       0     -1
    62     809       0     -1
    63      82       0   1737
    64      82       0     -1
    65       2       0     -1
    66       2       0     -1
    67      93       0     -1
    68     111       0   2006
    69     111       0     -1
    70     129       0   2071
    71     129       0     -1
    72     129       0     -1
    73     129       0     -1
    74     129       0     -1
    75     129       0     -1
    76     129       0     -1
    77     129       0     -1
    78     129       0     -1
    79     129       0     -1
    80     129       0     -1
    81     129       0     -1
    82     129       0     -1
    83     275       0     -1
    84     334       0     -1
    85     343       0     -1
    86     343       0     -1
    87     343       0     -1
    88     371       0   2432
    89     371       0     -1
    90     389       0   2498
    91     389       0     -1
    92     389       0     -1
    93     389       0     -1
    94     389       0     -1
    95     389       0     -1
    96     389       0     -1
    97     416       0   2687
    98     416       0     -1
    99     416       0     -1
   100     429       0   2784
   101     432       0   2818
   102     435       0   2855
   103     440       0   2901
   104     440       0   2971
   105     440       0     -1
   106     440       0     -1
   107     440       0     -1
   108     440       0     -1
   109     440       0     -1
   110     461       0   3137
   111     461       0     -1
   112     461       0     -1
   113     461       0     -1
   114     471       0   3230
   115     471       0     -1
   116     490       0     -1
   117     490       0     -1
   118     490       0     -1
   119     485       0   3365
   120     485       0     -1
   121     299       0   3448
   122     299       0   3505
   123     299       0     -1
   124     299       0     -1
   125     216       0   3570
   126     216       0     -1
   127     196       0   3628
   128     196       0     -1
   129     196       0     -1
   130     193       0     -1
   131       3       0     -1
   132      51       0     -1
   133     810       0     -1
   134     129       0     -1
   135     129       0     -1

Safepoints (size = 442)
0x9c023ab1326    38  0000000000000000000000000001 (sp -> fp)       0
0x9c023ab14cd   461  0000000000000000000000000001 (sp -> fp)      22
0x9c023ab150b   523  0000000000000000000000001001 (sp -> fp)      24
0x9c023ab15bc   700  0000000000000000000001111001 (sp -> fp)      31
0x9c023ab1618   792  0000000000000000000111110001 (sp -> fp)      34
0x9c023ab1637   823  0000000000000000000011110001 (sp -> fp)      35
0x9c023ab1656   854  0000000000000000000000110001 (sp -> fp)      36
0x9c023ab1677   887  0000000000000000000000010001 (sp -> fp)      37
0x9c023ab16ba   954  0000000000000000001000010001 (sp -> fp)      38
0x9c023ab175b  1115  0000000000000000111000000001 (sp -> fp)      44
0x9c023ab17b2  1202  0000000000000000011000000000 (sp -> fp)      48
0x9c023ab1843  1347  0000000000000000000000000000 (sp -> fp)      53
0x9c023ab186b  1387  0000000000000000000000000001 (sp -> fp)      54
0x9c023ab18af  1455  0000000000000000000000000001 (sp -> fp)      56
0x9c023ab1ad2  2002  0000000000000000000000000001 (sp -> fp)      68
0x9c023ab1b10  2064  0000000000000010000000000001 (sp -> fp)      70
0x9c023ab1c79  2425  0000000000000110000000000001 (sp -> fp)      88
0x9c023ab1cbb  2491  0000000000100110000000000001 (sp -> fp)      90
0x9c023ab1d78  2680  0000000111100110000000000001 (sp -> fp)      97
0x9c023ab1de0  2784  0000011111000110000000000001 (sp -> fp)     100
0x9c023ab1e02  2818  0000001111000100000000000001 (sp -> fp)     101
0x9c023ab1e27  2855  0000000011000100000000000001 (sp -> fp)     102
0x9c023ab1e4e  2894  0000000001000000000000000001 (sp -> fp)     103
0x9c023ab1e94  2964  0000100001000000000000000001 (sp -> fp)     104
0x9c023ab1f41  3137  0011100000000000000000000001 (sp -> fp)     110
0x9c023ab1f9e  3230  0001100000000000000000000001 (sp -> fp)     114
0x9c023ab2025  3365  0001000000000000000000000000 (sp -> fp)     119
0x9c023ab2071  3441  0000000000000000000000000001 (sp -> fp)     121
0x9c023ab20b1  3505  0000000001000000000000000001 (sp -> fp)     122
0x9c023ab20f2  3570  0000000000000000000000000001 (sp -> fp)     125
0x9c023ab212c  3628  0000000000000000000000000001 (sp -> fp)     127

RelocInfo (size = 7872)
0x9c023ab130d  position  (10888)
0x9c023ab130d  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x9c023ab130d  comment  (;;; <@2,#1> context)
0x9c023ab1311  comment  (;;; <@3,#1> gap)
0x9c023ab1315  comment  (;;; <@12,#9> -------------------- B1 --------------------)
0x9c023ab1315  comment  (;;; <@13,#9> gap)
0x9c023ab1318  comment  (;;; <@14,#11> stack-check)
0x9c023ab1322  code target (BUILTIN)  (0x9c023a25e60)
0x9c023ab1326  comment  (;;; <@16,#11> lazy-bailout)
0x9c023ab1326  comment  (;;; <@17,#11> gap)
0x9c023ab132a  comment  (;;; <@18,#12> load-context-slot)
0x9c023ab132a  position  (10909)
0x9c023ab1331  comment  (;;; <@20,#14> check-non-smi)
0x9c023ab1331  position  (10914)
0x9c023ab133a  comment  (;;; <@22,#15> check-maps)
0x9c023ab133c  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab134e  comment  (;;; <@24,#16> load-named-field)
0x9c023ab1352  comment  (;;; <@26,#17> load-named-field)
0x9c023ab1355  comment  (;;; <@28,#18> load-named-field)
0x9c023ab1359  comment  (;;; <@29,#18> gap)
0x9c023ab135d  comment  (;;; <@30,#885> tagged-to-i)
0x9c023ab136a  comment  (;;; <@32,#19> bounds-check)
0x9c023ab1372  comment  (;;; <@34,#20> load-keyed)
0x9c023ab137d  comment  (;;; <@36,#22> load-context-slot)
0x9c023ab137d  position  (10934)
0x9c023ab1384  comment  (;;; <@38,#24> check-non-smi)
0x9c023ab1384  position  (10939)
0x9c023ab138e  comment  (;;; <@40,#25> check-maps)
0x9c023ab1390  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab13a2  comment  (;;; <@42,#26> load-named-field)
0x9c023ab13a6  comment  (;;; <@44,#27> load-named-field)
0x9c023ab13aa  comment  (;;; <@46,#28> load-named-field)
0x9c023ab13ae  comment  (;;; <@48,#29> bounds-check)
0x9c023ab13b7  comment  (;;; <@50,#30> load-keyed)
0x9c023ab13c4  comment  (;;; <@52,#35> add-i)
0x9c023ab13c4  position  (10986)
0x9c023ab13cd  comment  (;;; <@54,#38> sub-i)
0x9c023ab13cd  position  (10995)
0x9c023ab13d6  comment  (;;; <@56,#45> bounds-check)
0x9c023ab13df  comment  (;;; <@58,#46> load-keyed)
0x9c023ab13ec  comment  (;;; <@60,#49> load-context-slot)
0x9c023ab13ec  position  (11036)
0x9c023ab13f0  comment  (;;; <@61,#49> gap)
0x9c023ab13f3  comment  (;;; <@62,#887> tagged-to-i)
0x9c023ab1401  position  (11034)
0x9c023ab1401  comment  (;;; <@65,#50> compare-numeric-and-branch)
0x9c023ab140a  comment  (;;; <@66,#54> -------------------- B2 (unreachable/replaced) --------------------)
0x9c023ab140a  position  (11949)
0x9c023ab140a  comment  (;;; <@70,#520> -------------------- B3 --------------------)
0x9c023ab140a  comment  (;;; <@71,#520> gap)
0x9c023ab140e  comment  (;;; <@72,#881> tagged-to-i)
0x9c023ab140e  position  (11959)
0x9c023ab141b  comment  (;;; <@74,#528> bounds-check)
0x9c023ab1423  comment  (;;; <@76,#529> load-keyed)
0x9c023ab142e  comment  (;;; <@78,#535> bounds-check)
0x9c023ab1437  comment  (;;; <@80,#536> load-keyed)
0x9c023ab1442  position  (12006)
0x9c023ab1442  comment  (;;; <@83,#557> compare-numeric-and-branch)
0x9c023ab144b  comment  (;;; <@84,#561> -------------------- B4 (unreachable/replaced) --------------------)
0x9c023ab144b  position  (12059)
0x9c023ab144b  comment  (;;; <@88,#587> -------------------- B5 --------------------)
0x9c023ab144b  position  (12061)
0x9c023ab144b  comment  (;;; <@91,#590> compare-numeric-and-branch)
0x9c023ab1454  comment  (;;; <@92,#594> -------------------- B6 (unreachable/replaced) --------------------)
0x9c023ab1454  position  (12242)
0x9c023ab1454  comment  (;;; <@96,#708> -------------------- B7 --------------------)
0x9c023ab1454  comment  (;;; <@97,#708> gap)
0x9c023ab1457  comment  (;;; <@98,#712> add-i)
0x9c023ab1457  position  (12250)
0x9c023ab1460  position  (12244)
0x9c023ab1460  comment  (;;; <@101,#714> compare-numeric-and-branch)
0x9c023ab1468  comment  (;;; <@102,#718> -------------------- B8 (unreachable/replaced) --------------------)
0x9c023ab1468  position  (12315)
0x9c023ab1468  comment  (;;; <@106,#732> -------------------- B9 --------------------)
0x9c023ab1468  comment  (;;; <@107,#732> gap)
0x9c023ab146b  comment  (;;; <@108,#735> sub-i)
0x9c023ab146b  position  (12317)
0x9c023ab1474  comment  (;;; <@109,#735> gap)
0x9c023ab1477  comment  (;;; <@110,#738> sub-i)
0x9c023ab1477  position  (12321)
0x9c023ab1480  comment  (;;; <@112,#741> mul-i)
0x9c023ab1480  position  (12326)
0x9c023ab1489  comment  (;;; <@113,#741> gap)
0x9c023ab148d  comment  (;;; <@114,#744> load-context-slot)
0x9c023ab148d  position  (12347)
0x9c023ab1494  comment  (;;; <@116,#745> check-value)
0x9c023ab1496  embedded object  (0x364e0635f4e9 <JS Function right_shift (SharedFunctionInfo 0xc1217b4d5e1)>)
0x9c023ab14a7  comment  (;;; <@118,#748> push-argument)
0x9c023ab14a7  position  (12362)
0x9c023ab14a9  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab14b3  comment  (;;; <@119,#748> gap)
0x9c023ab14b7  comment  (;;; <@120,#749> push-argument)
0x9c023ab14b8  comment  (;;; <@122,#891> smi-tag)
0x9c023ab14be  comment  (;;; <@123,#891> gap)
0x9c023ab14c2  comment  (;;; <@124,#750> push-argument)
0x9c023ab14c3  comment  (;;; <@125,#750> gap)
0x9c023ab14c6  comment  (;;; <@126,#751> invoke-function)
0x9c023ab14cd  comment  (;;; <@127,#751> gap)
0x9c023ab14d1  comment  (;;; <@128,#752> lazy-bailout)
0x9c023ab14d1  comment  (;;; <@129,#752> gap)
0x9c023ab14d5  comment  (;;; <@130,#754> load-context-slot)
0x9c023ab14d5  position  (12389)
0x9c023ab14dc  comment  (;;; <@132,#755> check-value)
0x9c023ab14de  embedded object  (0x364e0635f531 <JS Function sub (SharedFunctionInfo 0xc1217b4d701)>)
0x9c023ab14ef  comment  (;;; <@134,#758> push-argument)
0x9c023ab14ef  position  (12398)
0x9c023ab14f1  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab14fb  comment  (;;; <@136,#759> push-argument)
0x9c023ab14fc  comment  (;;; <@137,#759> gap)
0x9c023ab1500  comment  (;;; <@138,#760> push-argument)
0x9c023ab1501  comment  (;;; <@139,#760> gap)
0x9c023ab1504  comment  (;;; <@140,#761> invoke-function)
0x9c023ab150b  comment  (;;; <@141,#761> gap)
0x9c023ab150f  comment  (;;; <@142,#762> lazy-bailout)
0x9c023ab150f  comment  (;;; <@143,#762> gap)
0x9c023ab1513  comment  (;;; <@144,#764> load-context-slot)
0x9c023ab1513  position  (12416)
0x9c023ab151a  comment  (;;; <@145,#764> gap)
0x9c023ab151e  comment  (;;; <@146,#765> check-value)
0x9c023ab1520  embedded object  (0x364e0635f5a1 <JS Function divide (SharedFunctionInfo 0xc1217b4d899)>)
0x9c023ab1531  comment  (;;; <@148,#766> load-context-slot)
0x9c023ab1531  position  (12423)
0x9c023ab1538  comment  (;;; <@149,#766> gap)
0x9c023ab153c  comment  (;;; <@150,#767> check-value)
0x9c023ab153e  embedded object  (0x364e0635f3c9 <JS Function add (SharedFunctionInfo 0xc1217b4d301)>)
0x9c023ab154f  comment  (;;; <@152,#768> load-context-slot)
0x9c023ab154f  position  (12427)
0x9c023ab1556  comment  (;;; <@154,#769> check-value)
0x9c023ab1558  embedded object  (0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>)
0x9c023ab1569  comment  (;;; <@156,#772> check-non-smi)
0x9c023ab1569  position  (12441)
0x9c023ab1571  comment  (;;; <@158,#773> check-maps)
0x9c023ab1573  embedded object  (0x2ccb5ec07e51 <Map(elements=0)>)
0x9c023ab1585  comment  (;;; <@160,#774> load-named-field)
0x9c023ab1589  comment  (;;; <@162,#775> load-named-field)
0x9c023ab158d  comment  (;;; <@164,#776> bounds-check)
0x9c023ab1597  comment  (;;; <@166,#777> load-keyed)
0x9c023ab159a  comment  (;;; <@168,#780> push-argument)
0x9c023ab159a  position  (12445)
0x9c023ab159c  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab15a6  comment  (;;; <@170,#892> smi-tag)
0x9c023ab15ad  comment  (;;; <@172,#781> push-argument)
0x9c023ab15af  comment  (;;; <@174,#782> push-argument)
0x9c023ab15b2  comment  (;;; <@175,#782> gap)
0x9c023ab15b5  comment  (;;; <@176,#783> invoke-function)
0x9c023ab15bc  comment  (;;; <@177,#783> gap)
0x9c023ab15c0  comment  (;;; <@178,#784> lazy-bailout)
0x9c023ab15c0  comment  (;;; <@179,#784> gap)
0x9c023ab15c4  comment  (;;; <@180,#785> load-context-slot)
0x9c023ab15c4  position  (12457)
0x9c023ab15cb  comment  (;;; <@181,#785> gap)
0x9c023ab15cf  comment  (;;; <@182,#786> check-value)
0x9c023ab15d1  embedded object  (0x364e0635f411 <JS Function subtract (SharedFunctionInfo 0xc1217b4d3b9)>)
0x9c023ab15e2  comment  (;;; <@184,#787> load-context-slot)
0x9c023ab15e2  position  (12469)
0x9c023ab15e9  comment  (;;; <@186,#788> check-value)
0x9c023ab15eb  embedded object  (0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>)
0x9c023ab15fc  comment  (;;; <@188,#792> push-argument)
0x9c023ab15fc  position  (12485)
0x9c023ab15fe  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1608  comment  (;;; <@190,#793> push-argument)
0x9c023ab160b  comment  (;;; <@192,#794> push-argument)
0x9c023ab160e  comment  (;;; <@193,#794> gap)
0x9c023ab1611  comment  (;;; <@194,#795> invoke-function)
0x9c023ab1618  comment  (;;; <@196,#796> lazy-bailout)
0x9c023ab1618  comment  (;;; <@198,#798> push-argument)
0x9c023ab161a  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1624  comment  (;;; <@200,#799> push-argument)
0x9c023ab1627  comment  (;;; <@202,#800> push-argument)
0x9c023ab1628  comment  (;;; <@203,#800> gap)
0x9c023ab1630  comment  (;;; <@204,#801> invoke-function)
0x9c023ab1637  comment  (;;; <@206,#802> lazy-bailout)
0x9c023ab1637  comment  (;;; <@208,#804> push-argument)
0x9c023ab1639  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1643  comment  (;;; <@210,#805> push-argument)
0x9c023ab1646  comment  (;;; <@212,#806> push-argument)
0x9c023ab1647  comment  (;;; <@213,#806> gap)
0x9c023ab164f  comment  (;;; <@214,#807> invoke-function)
0x9c023ab1656  comment  (;;; <@216,#808> lazy-bailout)
0x9c023ab1656  comment  (;;; <@218,#810> push-argument)
0x9c023ab1656  position  (12499)
0x9c023ab1658  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1662  comment  (;;; <@220,#811> push-argument)
0x9c023ab1663  comment  (;;; <@222,#812> push-argument)
0x9c023ab1666  comment  (;;; <@223,#812> gap)
0x9c023ab166e  comment  (;;; <@224,#813> invoke-function)
0x9c023ab1673  code target (OPTIMIZED_FUNCTION)  (0x9c023ab1300)
0x9c023ab1677  comment  (;;; <@225,#813> gap)
0x9c023ab167b  comment  (;;; <@226,#814> lazy-bailout)
0x9c023ab167b  comment  (;;; <@228,#817> push-argument)
0x9c023ab167b  position  (12516)
0x9c023ab167d  embedded object  (0x364e0635f5e9 <FixedArray[12]>)
0x9c023ab1687  comment  (;;; <@230,#819> push-argument)
0x9c023ab1693  comment  (;;; <@232,#821> push-argument)
0x9c023ab1695  embedded object  (0x26a635d04101 <FixedArray[0]>)
0x9c023ab169f  comment  (;;; <@234,#823> push-argument)
0x9c023ab16a5  comment  (;;; <@235,#823> gap)
0x9c023ab16a9  comment  (;;; <@236,#824> call-runtime)
0x9c023ab16b6  code target (STUB)  (0x9c023a06060)
0x9c023ab16ba  comment  (;;; <@237,#824> gap)
0x9c023ab16be  comment  (;;; <@238,#824> lazy-bailout)
0x9c023ab16be  comment  (;;; <@240,#825> check-maps)
0x9c023ab16c0  embedded object  (0x2ccb5ec07e51 <Map(elements=0)>)
0x9c023ab16d2  comment  (;;; <@241,#825> gap)
0x9c023ab16d6  comment  (;;; <@242,#827> load-context-slot)
0x9c023ab16d6  position  (12517)
0x9c023ab16dd  comment  (;;; <@243,#827> gap)
0x9c023ab16e1  comment  (;;; <@244,#828> check-value)
0x9c023ab16e3  embedded object  (0x364e0635f3c9 <JS Function add (SharedFunctionInfo 0xc1217b4d301)>)
0x9c023ab16f4  comment  (;;; <@246,#829> load-context-slot)
0x9c023ab16f4  position  (12521)
0x9c023ab16fb  comment  (;;; <@248,#830> check-value)
0x9c023ab16fd  embedded object  (0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>)
0x9c023ab170e  comment  (;;; <@249,#830> gap)
0x9c023ab1712  comment  (;;; <@250,#834> check-maps)
0x9c023ab1712  position  (12535)
0x9c023ab1714  embedded object  (0x2ccb5ec07e51 <Map(elements=0)>)
0x9c023ab1726  comment  (;;; <@252,#835> load-named-field)
0x9c023ab172a  comment  (;;; <@254,#836> load-named-field)
0x9c023ab172e  comment  (;;; <@256,#837> bounds-check)
0x9c023ab1738  comment  (;;; <@258,#838> load-keyed)
0x9c023ab173b  comment  (;;; <@260,#841> push-argument)
0x9c023ab173b  position  (12539)
0x9c023ab173d  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1747  comment  (;;; <@262,#895> smi-tag)
0x9c023ab174d  comment  (;;; <@264,#842> push-argument)
0x9c023ab174e  comment  (;;; <@266,#843> push-argument)
0x9c023ab1751  comment  (;;; <@267,#843> gap)
0x9c023ab1754  comment  (;;; <@268,#844> invoke-function)
0x9c023ab175b  comment  (;;; <@270,#845> lazy-bailout)
0x9c023ab175b  comment  (;;; <@271,#845> gap)
0x9c023ab175f  comment  (;;; <@272,#848> check-non-smi)
0x9c023ab175f  position  (12554)
0x9c023ab1768  comment  (;;; <@274,#849> check-maps)
0x9c023ab176a  embedded object  (0x2ccb5ec07e51 <Map(elements=0)>)
0x9c023ab177c  comment  (;;; <@276,#850> load-named-field)
0x9c023ab1780  comment  (;;; <@278,#851> load-named-field)
0x9c023ab1783  comment  (;;; <@280,#852> bounds-check)
0x9c023ab178c  comment  (;;; <@282,#853> load-keyed)
0x9c023ab178f  comment  (;;; <@284,#855> push-argument)
0x9c023ab1791  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab179b  comment  (;;; <@286,#856> push-argument)
0x9c023ab179c  comment  (;;; <@288,#896> smi-tag)
0x9c023ab17a2  comment  (;;; <@290,#857> push-argument)
0x9c023ab17a3  comment  (;;; <@291,#857> gap)
0x9c023ab17ab  comment  (;;; <@292,#858> invoke-function)
0x9c023ab17b2  comment  (;;; <@294,#859> lazy-bailout)
0x9c023ab17b2  comment  (;;; <@295,#859> gap)
0x9c023ab17b6  comment  (;;; <@296,#860> load-named-field)
0x9c023ab17ba  comment  (;;; <@297,#860> gap)
0x9c023ab17bd  comment  (;;; <@298,#897> check-smi)
0x9c023ab17c6  comment  (;;; <@300,#862> store-keyed)
0x9c023ab17ca  comment  (;;; <@301,#862> gap)
0x9c023ab17ce  comment  (;;; <@302,#867> check-maps)
0x9c023ab17ce  position  (12562)
0x9c023ab17d0  embedded object  (0x2ccb5ec07e51 <Map(elements=0)>)
0x9c023ab17e2  comment  (;;; <@304,#868> load-named-field)
0x9c023ab17e6  comment  (;;; <@306,#869> load-named-field)
0x9c023ab17e9  comment  (;;; <@308,#870> bounds-check)
0x9c023ab17f2  comment  (;;; <@310,#871> load-keyed)
0x9c023ab17f5  comment  (;;; <@312,#898> smi-tag)
0x9c023ab17fb  comment  (;;; <@314,#874> store-keyed)
0x9c023ab17ff  comment  (;;; <@315,#874> gap)
0x9c023ab1802  comment  (;;; <@316,#877> return)
0x9c023ab1809  comment  (;;; <@318,#715> -------------------- B10 (unreachable/replaced) --------------------)
0x9c023ab1809  position  (12273)
0x9c023ab1809  comment  (;;; <@322,#721> -------------------- B11 --------------------)
0x9c023ab1809  comment  (;;; <@323,#721> gap)
0x9c023ab180d  comment  (;;; <@324,#722> load-context-slot)
0x9c023ab1814  comment  (;;; <@326,#723> check-value)
0x9c023ab1816  embedded object  (0x364e0635f531 <JS Function sub (SharedFunctionInfo 0xc1217b4d701)>)
0x9c023ab1827  comment  (;;; <@328,#725> push-argument)
0x9c023ab1827  position  (12280)
0x9c023ab1829  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1833  comment  (;;; <@330,#726> push-argument)
0x9c023ab1836  comment  (;;; <@332,#727> push-argument)
0x9c023ab1839  comment  (;;; <@333,#727> gap)
0x9c023ab183c  comment  (;;; <@334,#728> invoke-function)
0x9c023ab1843  comment  (;;; <@336,#729> lazy-bailout)
0x9c023ab1843  comment  (;;; <@338,#731> return)
0x9c023ab184a  comment  (;;; <@340,#591> -------------------- B12 (unreachable/replaced) --------------------)
0x9c023ab184a  position  (12087)
0x9c023ab184a  comment  (;;; <@344,#597> -------------------- B13 --------------------)
0x9c023ab184a  comment  (;;; <@346,#598> load-context-slot)
0x9c023ab1851  comment  (;;; <@348,#599> push-argument)
0x9c023ab1851  position  (12102)
0x9c023ab1853  embedded object  (0x364e06304121 <undefined>)
0x9c023ab185d  comment  (;;; <@350,#600> push-argument)
0x9c023ab1860  comment  (;;; <@352,#601> push-argument)
0x9c023ab1863  comment  (;;; <@353,#601> gap)
0x9c023ab1866  comment  (;;; <@354,#602> call-function)
0x9c023ab1867  code target (STUB)  (0x9c023a28e20)
0x9c023ab186b  comment  (;;; <@356,#603> lazy-bailout)
0x9c023ab186b  comment  (;;; <@358,#607> deoptimize)
0x9c023ab186b  position  (12120)
0x9c023ab186b  comment  (;;; deoptimize: Insufficient type feedback for combined type of binary operation)
0x9c023ab186c  runtime entry
0x9c023ab1870  comment  (;;; <@360,#608> -------------------- B14 (unreachable/replaced) --------------------)
0x9c023ab1870  comment  (;;; <@370,#615> -------------------- B15 (unreachable/replaced) --------------------)
0x9c023ab1870  comment  (;;; <@374,#641> -------------------- B16 (unreachable/replaced) --------------------)
0x9c023ab1870  comment  (;;; <@378,#645> -------------------- B17 (unreachable/replaced) --------------------)
0x9c023ab1870  comment  (;;; <@388,#652> -------------------- B18 (unreachable/replaced) --------------------)
0x9c023ab1870  comment  (;;; <@392,#679> -------------------- B19 (unreachable/replaced) --------------------)
0x9c023ab1870  comment  (;;; <@448,#649> -------------------- B20 (unreachable/replaced) --------------------)
0x9c023ab1870  comment  (;;; <@452,#655> -------------------- B21 (unreachable/replaced) --------------------)
0x9c023ab1870  comment  (;;; <@494,#612> -------------------- B22 (unreachable/replaced) --------------------)
0x9c023ab1870  comment  (;;; <@498,#618> -------------------- B23 (unreachable/replaced) --------------------)
0x9c023ab1870  comment  (;;; <@538,#558> -------------------- B24 (unreachable/replaced) --------------------)
0x9c023ab1870  position  (12029)
0x9c023ab1870  comment  (;;; <@542,#564> -------------------- B25 --------------------)
0x9c023ab1870  comment  (;;; <@544,#566> push-argument)
0x9c023ab1872  embedded object  (0x364e0635f5e9 <FixedArray[12]>)
0x9c023ab187c  comment  (;;; <@546,#568> push-argument)
0x9c023ab1888  comment  (;;; <@548,#570> push-argument)
0x9c023ab188a  embedded object  (0x26a635d04101 <FixedArray[0]>)
0x9c023ab1894  comment  (;;; <@550,#572> push-argument)
0x9c023ab189a  comment  (;;; <@551,#572> gap)
0x9c023ab189e  comment  (;;; <@552,#573> call-runtime)
0x9c023ab18ab  code target (STUB)  (0x9c023a06060)
0x9c023ab18af  comment  (;;; <@554,#573> lazy-bailout)
0x9c023ab18af  comment  (;;; <@556,#574> check-maps)
0x9c023ab18b1  embedded object  (0x2ccb5ec07e51 <Map(elements=0)>)
0x9c023ab18c3  comment  (;;; <@557,#574> gap)
0x9c023ab18c7  comment  (;;; <@558,#576> load-context-slot)
0x9c023ab18c7  position  (12030)
0x9c023ab18ce  comment  (;;; <@560,#577> load-named-field)
0x9c023ab18d2  comment  (;;; <@562,#919> check-smi)
0x9c023ab18db  comment  (;;; <@564,#579> store-keyed)
0x9c023ab18df  comment  (;;; <@565,#579> gap)
0x9c023ab18e3  comment  (;;; <@566,#880> check-smi)
0x9c023ab18e3  position  (12036)
0x9c023ab18ec  comment  (;;; <@568,#583> store-keyed)
0x9c023ab18f0  comment  (;;; <@570,#586> return)
0x9c023ab18f7  position  (11034)
0x9c023ab18f7  comment  (;;; <@572,#51> -------------------- B26 --------------------)
0x9c023ab18fa  position  (11071)
0x9c023ab18fa  comment  (;;; <@576,#57> -------------------- B27 --------------------)
0x9c023ab18fa  comment  (;;; <@578,#58> load-context-slot)
0x9c023ab18fe  comment  (;;; <@579,#58> gap)
0x9c023ab1902  comment  (;;; <@580,#59> check-value)
0x9c023ab1904  embedded object  (0x364e0632ad89 <JS Function ceil (SharedFunctionInfo 0x364e06329bd9)>)
0x9c023ab1915  comment  (;;; <@582,#60> load-context-slot)
0x9c023ab1915  position  (11076)
0x9c023ab1919  comment  (;;; <@583,#60> gap)
0x9c023ab191d  comment  (;;; <@584,#61> check-value)
0x9c023ab191f  embedded object  (0x364e0632af29 <JS Function log (SharedFunctionInfo 0x364e06329ea1)>)
0x9c023ab1930  comment  (;;; <@586,#886> int32-to-double)
0x9c023ab1930  position  (11093)
0x9c023ab1938  comment  (;;; <@588,#921> double-untag)
0x9c023ab1938  position  (11081)
0x9c023ab1972  comment  (;;; <@590,#64> div-d)
0x9c023ab1972  position  (11091)
0x9c023ab1979  comment  (;;; <@591,#64> gap)
0x9c023ab1984  comment  (;;; <@592,#66> math-log)
0x9c023ab19c1  comment  (;;; <@593,#66> gap)
0x9c023ab19c9  comment  (;;; <@594,#66> lazy-bailout)
0x9c023ab19c9  comment  (;;; <@595,#66> gap)
0x9c023ab19cd  comment  (;;; <@596,#67> load-context-slot)
0x9c023ab19cd  position  (11121)
0x9c023ab19d1  comment  (;;; <@598,#922> double-untag)
0x9c023ab1a09  comment  (;;; <@599,#922> gap)
0x9c023ab1a11  comment  (;;; <@600,#68> div-d)
0x9c023ab1a11  position  (11119)
0x9c023ab1a18  comment  (;;; <@602,#923> constant-d)
0x9c023ab1a18  position  (754)
0x9c023ab1a27  comment  (;;; <@603,#923> gap)
0x9c023ab1a2a  comment  (;;; <@604,#76> mul-d)
0x9c023ab1a2e  comment  (;;; <@606,#78> math-floor)
0x9c023ab1a7c  comment  (;;; <@608,#80> mul-i)
0x9c023ab1a7c  position  (743)
0x9c023ab1a8c  runtime entry  (deoptimization bailout 66)
0x9c023ab1a90  comment  (;;; <@609,#80> gap)
0x9c023ab1a94  position  (11119)
0x9c023ab1a94  comment  (;;; <@612,#85> -------------------- B28 --------------------)
0x9c023ab1a94  comment  (;;; <@614,#87> load-context-slot)
0x9c023ab1a94  position  (11142)
0x9c023ab1a9b  comment  (;;; <@616,#88> check-value)
0x9c023ab1a9d  embedded object  (0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>)
0x9c023ab1aae  comment  (;;; <@618,#91> push-argument)
0x9c023ab1aae  position  (11156)
0x9c023ab1ab0  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1aba  comment  (;;; <@620,#92> push-argument)
0x9c023ab1abd  comment  (;;; <@622,#927> smi-tag)
0x9c023ab1ac3  comment  (;;; <@623,#927> gap)
0x9c023ab1ac7  comment  (;;; <@624,#93> push-argument)
0x9c023ab1ac8  comment  (;;; <@625,#93> gap)
0x9c023ab1acb  comment  (;;; <@626,#94> invoke-function)
0x9c023ab1ad2  comment  (;;; <@627,#94> gap)
0x9c023ab1ad6  comment  (;;; <@628,#95> lazy-bailout)
0x9c023ab1ad6  comment  (;;; <@629,#95> gap)
0x9c023ab1ada  comment  (;;; <@630,#97> load-context-slot)
0x9c023ab1ada  position  (11180)
0x9c023ab1ae1  comment  (;;; <@632,#98> check-value)
0x9c023ab1ae3  embedded object  (0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>)
0x9c023ab1af4  comment  (;;; <@634,#101> push-argument)
0x9c023ab1af4  position  (11194)
0x9c023ab1af6  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1b00  comment  (;;; <@636,#102> push-argument)
0x9c023ab1b03  comment  (;;; <@638,#103> push-argument)
0x9c023ab1b06  comment  (;;; <@639,#103> gap)
0x9c023ab1b09  comment  (;;; <@640,#104> invoke-function)
0x9c023ab1b10  comment  (;;; <@641,#104> gap)
0x9c023ab1b17  comment  (;;; <@642,#105> lazy-bailout)
0x9c023ab1b17  comment  (;;; <@643,#105> gap)
0x9c023ab1b1b  comment  (;;; <@644,#107> load-context-slot)
0x9c023ab1b1b  position  (11218)
0x9c023ab1b22  comment  (;;; <@646,#108> load-context-slot)
0x9c023ab1b22  position  (11223)
0x9c023ab1b29  comment  (;;; <@648,#110> check-non-smi)
0x9c023ab1b29  position  (11228)
0x9c023ab1b32  comment  (;;; <@650,#111> check-maps)
0x9c023ab1b34  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab1b46  comment  (;;; <@652,#112> load-named-field)
0x9c023ab1b4a  comment  (;;; <@654,#113> load-named-field)
0x9c023ab1b4d  comment  (;;; <@656,#114> load-named-field)
0x9c023ab1b51  comment  (;;; <@657,#114> gap)
0x9c023ab1b55  comment  (;;; <@658,#928> tagged-to-i)
0x9c023ab1b63  comment  (;;; <@660,#115> bounds-check)
0x9c023ab1b6b  comment  (;;; <@662,#116> load-keyed)
0x9c023ab1b76  comment  (;;; <@664,#117> check-non-smi)
0x9c023ab1b7f  comment  (;;; <@666,#118> check-maps)
0x9c023ab1b81  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab1b93  comment  (;;; <@668,#119> load-named-field)
0x9c023ab1b97  comment  (;;; <@670,#120> load-named-field)
0x9c023ab1b9b  comment  (;;; <@672,#121> load-named-field)
0x9c023ab1b9f  comment  (;;; <@674,#122> bounds-check)
0x9c023ab1ba8  comment  (;;; <@676,#123> load-keyed)
0x9c023ab1bb3  comment  (;;; <@677,#123> gap)
0x9c023ab1bb6  comment  (;;; <@678,#929> tagged-to-i)
0x9c023ab1bb6  position  (11258)
0x9c023ab1bc4  comment  (;;; <@680,#133> bounds-check)
0x9c023ab1bcd  comment  (;;; <@682,#134> load-keyed)
0x9c023ab1bd9  comment  (;;; <@684,#140> bounds-check)
0x9c023ab1be2  comment  (;;; <@686,#141> load-keyed)
0x9c023ab1bed  position  (11277)
0x9c023ab1bed  comment  (;;; <@689,#145> compare-numeric-and-branch)
0x9c023ab1bf5  comment  (;;; <@690,#149> -------------------- B29 (unreachable/replaced) --------------------)
0x9c023ab1bf5  position  (11330)
0x9c023ab1bf5  comment  (;;; <@694,#175> -------------------- B30 --------------------)
0x9c023ab1bf5  position  (11332)
0x9c023ab1bf5  comment  (;;; <@697,#178> compare-numeric-and-branch)
0x9c023ab1bfd  comment  (;;; <@698,#182> -------------------- B31 (unreachable/replaced) --------------------)
0x9c023ab1bfd  position  (11515)
0x9c023ab1bfd  comment  (;;; <@702,#298> -------------------- B32 --------------------)
0x9c023ab1bfd  comment  (;;; <@703,#298> gap)
0x9c023ab1c00  comment  (;;; <@704,#302> add-i)
0x9c023ab1c00  position  (11523)
0x9c023ab1c09  position  (11517)
0x9c023ab1c09  comment  (;;; <@707,#304> compare-numeric-and-branch)
0x9c023ab1c11  comment  (;;; <@708,#308> -------------------- B33 (unreachable/replaced) --------------------)
0x9c023ab1c11  position  (11644)
0x9c023ab1c11  comment  (;;; <@712,#361> -------------------- B34 --------------------)
0x9c023ab1c11  comment  (;;; <@713,#361> gap)
0x9c023ab1c14  comment  (;;; <@714,#364> sub-i)
0x9c023ab1c14  position  (11646)
0x9c023ab1c1c  comment  (;;; <@715,#364> gap)
0x9c023ab1c1f  comment  (;;; <@716,#367> sub-i)
0x9c023ab1c1f  position  (11650)
0x9c023ab1c28  comment  (;;; <@718,#370> mul-i)
0x9c023ab1c28  position  (11655)
0x9c023ab1c31  comment  (;;; <@719,#370> gap)
0x9c023ab1c38  comment  (;;; <@720,#373> load-context-slot)
0x9c023ab1c38  position  (11676)
0x9c023ab1c3f  comment  (;;; <@722,#374> check-value)
0x9c023ab1c41  embedded object  (0x364e0635f4e9 <JS Function right_shift (SharedFunctionInfo 0xc1217b4d5e1)>)
0x9c023ab1c52  comment  (;;; <@724,#378> push-argument)
0x9c023ab1c52  position  (11692)
0x9c023ab1c54  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1c5e  comment  (;;; <@726,#379> push-argument)
0x9c023ab1c61  comment  (;;; <@728,#933> smi-tag)
0x9c023ab1c67  comment  (;;; <@729,#933> gap)
0x9c023ab1c6e  comment  (;;; <@730,#380> push-argument)
0x9c023ab1c6f  comment  (;;; <@731,#380> gap)
0x9c023ab1c72  comment  (;;; <@732,#381> invoke-function)
0x9c023ab1c79  comment  (;;; <@733,#381> gap)
0x9c023ab1c80  comment  (;;; <@734,#382> lazy-bailout)
0x9c023ab1c80  comment  (;;; <@735,#382> gap)
0x9c023ab1c84  comment  (;;; <@736,#384> load-context-slot)
0x9c023ab1c84  position  (11718)
0x9c023ab1c8b  comment  (;;; <@738,#385> check-value)
0x9c023ab1c8d  embedded object  (0x364e0635f531 <JS Function sub (SharedFunctionInfo 0xc1217b4d701)>)
0x9c023ab1c9e  comment  (;;; <@740,#389> push-argument)
0x9c023ab1c9e  position  (11727)
0x9c023ab1ca0  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1caa  comment  (;;; <@742,#390> push-argument)
0x9c023ab1cab  comment  (;;; <@744,#391> push-argument)
0x9c023ab1cb1  comment  (;;; <@745,#391> gap)
0x9c023ab1cb4  comment  (;;; <@746,#392> invoke-function)
0x9c023ab1cbb  comment  (;;; <@747,#392> gap)
0x9c023ab1cc2  comment  (;;; <@748,#393> lazy-bailout)
0x9c023ab1cc2  comment  (;;; <@749,#393> gap)
0x9c023ab1cc6  comment  (;;; <@750,#395> load-context-slot)
0x9c023ab1cc6  position  (11746)
0x9c023ab1ccd  comment  (;;; <@751,#395> gap)
0x9c023ab1cd4  comment  (;;; <@752,#396> check-value)
0x9c023ab1cd6  embedded object  (0x364e0635f5a1 <JS Function divide (SharedFunctionInfo 0xc1217b4d899)>)
0x9c023ab1ce7  comment  (;;; <@754,#397> load-context-slot)
0x9c023ab1ce7  position  (11753)
0x9c023ab1cee  comment  (;;; <@755,#397> gap)
0x9c023ab1cf5  comment  (;;; <@756,#398> check-value)
0x9c023ab1cf7  embedded object  (0x364e0635f3c9 <JS Function add (SharedFunctionInfo 0xc1217b4d301)>)
0x9c023ab1d08  comment  (;;; <@758,#399> load-context-slot)
0x9c023ab1d08  position  (11757)
0x9c023ab1d0f  comment  (;;; <@760,#400> check-value)
0x9c023ab1d11  embedded object  (0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>)
0x9c023ab1d22  comment  (;;; <@762,#403> check-non-smi)
0x9c023ab1d22  position  (11771)
0x9c023ab1d2a  comment  (;;; <@764,#404> check-maps)
0x9c023ab1d2c  embedded object  (0x2ccb5ec07e51 <Map(elements=0)>)
0x9c023ab1d3e  comment  (;;; <@766,#405> load-named-field)
0x9c023ab1d42  comment  (;;; <@768,#406> load-named-field)
0x9c023ab1d46  comment  (;;; <@770,#407> bounds-check)
0x9c023ab1d50  comment  (;;; <@772,#408> load-keyed)
0x9c023ab1d53  comment  (;;; <@774,#411> push-argument)
0x9c023ab1d53  position  (11775)
0x9c023ab1d55  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1d5f  comment  (;;; <@776,#934> smi-tag)
0x9c023ab1d66  comment  (;;; <@778,#412> push-argument)
0x9c023ab1d68  comment  (;;; <@780,#413> push-argument)
0x9c023ab1d6e  comment  (;;; <@781,#413> gap)
0x9c023ab1d71  comment  (;;; <@782,#414> invoke-function)
0x9c023ab1d78  comment  (;;; <@783,#414> gap)
0x9c023ab1d7f  comment  (;;; <@784,#415> lazy-bailout)
0x9c023ab1d7f  comment  (;;; <@785,#415> gap)
0x9c023ab1d83  comment  (;;; <@786,#416> load-context-slot)
0x9c023ab1d83  position  (11787)
0x9c023ab1d8a  comment  (;;; <@787,#416> gap)
0x9c023ab1d91  comment  (;;; <@788,#417> check-value)
0x9c023ab1d93  embedded object  (0x364e0635f411 <JS Function subtract (SharedFunctionInfo 0xc1217b4d3b9)>)
0x9c023ab1da4  comment  (;;; <@790,#419> load-context-slot)
0x9c023ab1da4  position  (11800)
0x9c023ab1dab  comment  (;;; <@792,#420> check-value)
0x9c023ab1dad  embedded object  (0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>)
0x9c023ab1dbe  comment  (;;; <@794,#424> push-argument)
0x9c023ab1dbe  position  (11816)
0x9c023ab1dc0  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1dca  comment  (;;; <@796,#425> push-argument)
0x9c023ab1dd0  comment  (;;; <@798,#426> push-argument)
0x9c023ab1dd6  comment  (;;; <@799,#426> gap)
0x9c023ab1dd9  comment  (;;; <@800,#427> invoke-function)
0x9c023ab1de0  comment  (;;; <@802,#428> lazy-bailout)
0x9c023ab1de0  comment  (;;; <@804,#430> push-argument)
0x9c023ab1de2  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1dec  comment  (;;; <@806,#431> push-argument)
0x9c023ab1def  comment  (;;; <@808,#432> push-argument)
0x9c023ab1df0  comment  (;;; <@809,#432> gap)
0x9c023ab1dfb  comment  (;;; <@810,#433> invoke-function)
0x9c023ab1e02  comment  (;;; <@812,#434> lazy-bailout)
0x9c023ab1e02  comment  (;;; <@814,#436> push-argument)
0x9c023ab1e04  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1e0e  comment  (;;; <@816,#437> push-argument)
0x9c023ab1e14  comment  (;;; <@818,#438> push-argument)
0x9c023ab1e15  comment  (;;; <@819,#438> gap)
0x9c023ab1e20  comment  (;;; <@820,#439> invoke-function)
0x9c023ab1e27  comment  (;;; <@822,#440> lazy-bailout)
0x9c023ab1e27  comment  (;;; <@824,#443> push-argument)
0x9c023ab1e27  position  (11830)
0x9c023ab1e29  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1e33  comment  (;;; <@826,#444> push-argument)
0x9c023ab1e34  comment  (;;; <@828,#445> push-argument)
0x9c023ab1e3a  comment  (;;; <@829,#445> gap)
0x9c023ab1e45  comment  (;;; <@830,#446> invoke-function)
0x9c023ab1e4a  code target (OPTIMIZED_FUNCTION)  (0x9c023ab1300)
0x9c023ab1e4e  comment  (;;; <@831,#446> gap)
0x9c023ab1e55  comment  (;;; <@832,#447> lazy-bailout)
0x9c023ab1e55  comment  (;;; <@834,#450> push-argument)
0x9c023ab1e55  position  (11848)
0x9c023ab1e57  embedded object  (0x364e0635f5e9 <FixedArray[12]>)
0x9c023ab1e61  comment  (;;; <@836,#452> push-argument)
0x9c023ab1e6d  comment  (;;; <@838,#454> push-argument)
0x9c023ab1e6f  embedded object  (0x26a635d04101 <FixedArray[0]>)
0x9c023ab1e79  comment  (;;; <@840,#456> push-argument)
0x9c023ab1e7f  comment  (;;; <@841,#456> gap)
0x9c023ab1e83  comment  (;;; <@842,#457> call-runtime)
0x9c023ab1e90  code target (STUB)  (0x9c023a06060)
0x9c023ab1e94  comment  (;;; <@843,#457> gap)
0x9c023ab1e9b  comment  (;;; <@844,#457> lazy-bailout)
0x9c023ab1e9b  comment  (;;; <@846,#458> check-maps)
0x9c023ab1e9d  embedded object  (0x2ccb5ec07e51 <Map(elements=0)>)
0x9c023ab1eaf  comment  (;;; <@847,#458> gap)
0x9c023ab1eb3  comment  (;;; <@848,#460> load-context-slot)
0x9c023ab1eb3  position  (11849)
0x9c023ab1eba  comment  (;;; <@849,#460> gap)
0x9c023ab1ec1  comment  (;;; <@850,#461> check-value)
0x9c023ab1ec3  embedded object  (0x364e0635f3c9 <JS Function add (SharedFunctionInfo 0xc1217b4d301)>)
0x9c023ab1ed4  comment  (;;; <@852,#462> load-context-slot)
0x9c023ab1ed4  position  (11853)
0x9c023ab1edb  comment  (;;; <@854,#463> check-value)
0x9c023ab1edd  embedded object  (0x364e0635f4a1 <JS Function left_shift (SharedFunctionInfo 0xc1217b4d529)>)
0x9c023ab1eee  comment  (;;; <@855,#463> gap)
0x9c023ab1ef5  comment  (;;; <@856,#467> check-maps)
0x9c023ab1ef5  position  (11867)
0x9c023ab1ef7  embedded object  (0x2ccb5ec07e51 <Map(elements=0)>)
0x9c023ab1f09  comment  (;;; <@858,#468> load-named-field)
0x9c023ab1f0d  comment  (;;; <@860,#469> load-named-field)
0x9c023ab1f11  comment  (;;; <@862,#470> bounds-check)
0x9c023ab1f1b  comment  (;;; <@864,#471> load-keyed)
0x9c023ab1f1e  comment  (;;; <@866,#474> push-argument)
0x9c023ab1f1e  position  (11871)
0x9c023ab1f20  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1f2a  comment  (;;; <@868,#937> smi-tag)
0x9c023ab1f30  comment  (;;; <@870,#475> push-argument)
0x9c023ab1f31  comment  (;;; <@872,#476> push-argument)
0x9c023ab1f37  comment  (;;; <@873,#476> gap)
0x9c023ab1f3a  comment  (;;; <@874,#477> invoke-function)
0x9c023ab1f41  comment  (;;; <@876,#478> lazy-bailout)
0x9c023ab1f41  comment  (;;; <@877,#478> gap)
0x9c023ab1f48  comment  (;;; <@878,#481> check-non-smi)
0x9c023ab1f48  position  (11886)
0x9c023ab1f51  comment  (;;; <@880,#482> check-maps)
0x9c023ab1f53  embedded object  (0x2ccb5ec07e51 <Map(elements=0)>)
0x9c023ab1f65  comment  (;;; <@882,#483> load-named-field)
0x9c023ab1f69  comment  (;;; <@884,#484> load-named-field)
0x9c023ab1f6c  comment  (;;; <@886,#485> bounds-check)
0x9c023ab1f75  comment  (;;; <@888,#486> load-keyed)
0x9c023ab1f78  comment  (;;; <@890,#488> push-argument)
0x9c023ab1f7a  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab1f84  comment  (;;; <@892,#489> push-argument)
0x9c023ab1f85  comment  (;;; <@894,#938> smi-tag)
0x9c023ab1f8b  comment  (;;; <@896,#490> push-argument)
0x9c023ab1f8c  comment  (;;; <@897,#490> gap)
0x9c023ab1f97  comment  (;;; <@898,#491> invoke-function)
0x9c023ab1f9e  comment  (;;; <@900,#492> lazy-bailout)
0x9c023ab1f9e  comment  (;;; <@901,#492> gap)
0x9c023ab1fa5  comment  (;;; <@902,#493> load-named-field)
0x9c023ab1fa9  comment  (;;; <@903,#493> gap)
0x9c023ab1fac  comment  (;;; <@904,#939> check-smi)
0x9c023ab1fb5  comment  (;;; <@906,#495> store-keyed)
0x9c023ab1fb9  comment  (;;; <@907,#495> gap)
0x9c023ab1fbd  comment  (;;; <@908,#497> load-context-slot)
0x9c023ab1fbd  position  (11891)
0x9c023ab1fc4  comment  (;;; <@910,#498> check-value)
0x9c023ab1fc6  embedded object  (0x364e0635f4e9 <JS Function right_shift (SharedFunctionInfo 0xc1217b4d5e1)>)
0x9c023ab1fd7  comment  (;;; <@911,#498> gap)
0x9c023ab1fde  comment  (;;; <@912,#502> check-maps)
0x9c023ab1fde  position  (11906)
0x9c023ab1fe0  embedded object  (0x2ccb5ec07e51 <Map(elements=0)>)
0x9c023ab1ff2  comment  (;;; <@914,#503> load-named-field)
0x9c023ab1ff6  comment  (;;; <@916,#504> load-named-field)
0x9c023ab1ff9  comment  (;;; <@918,#505> bounds-check)
0x9c023ab2002  comment  (;;; <@920,#506> load-keyed)
0x9c023ab2005  comment  (;;; <@922,#509> push-argument)
0x9c023ab2005  position  (11910)
0x9c023ab2007  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab2011  comment  (;;; <@924,#940> smi-tag)
0x9c023ab2017  comment  (;;; <@926,#510> push-argument)
0x9c023ab2018  comment  (;;; <@928,#511> push-argument)
0x9c023ab201b  comment  (;;; <@929,#511> gap)
0x9c023ab201e  comment  (;;; <@930,#512> invoke-function)
0x9c023ab2025  comment  (;;; <@932,#513> lazy-bailout)
0x9c023ab2025  comment  (;;; <@933,#513> gap)
0x9c023ab202c  comment  (;;; <@934,#514> load-named-field)
0x9c023ab2030  comment  (;;; <@935,#514> gap)
0x9c023ab2033  comment  (;;; <@936,#941> check-smi)
0x9c023ab203c  comment  (;;; <@938,#516> store-keyed)
0x9c023ab2040  comment  (;;; <@939,#516> gap)
0x9c023ab2043  comment  (;;; <@940,#519> return)
0x9c023ab204a  position  (11517)
0x9c023ab204a  comment  (;;; <@942,#305> -------------------- B35 --------------------)
0x9c023ab204d  position  (11548)
0x9c023ab204d  comment  (;;; <@946,#311> -------------------- B36 --------------------)
0x9c023ab204d  comment  (;;; <@948,#312> load-context-slot)
0x9c023ab2054  comment  (;;; <@950,#315> push-argument)
0x9c023ab2054  position  (11556)
0x9c023ab2056  embedded object  (0x364e06304121 <undefined>)
0x9c023ab2060  comment  (;;; <@952,#316> push-argument)
0x9c023ab2063  comment  (;;; <@954,#317> push-argument)
0x9c023ab2069  comment  (;;; <@955,#317> gap)
0x9c023ab206c  comment  (;;; <@956,#318> call-function)
0x9c023ab206d  code target (STUB)  (0x9c023a28e20)
0x9c023ab2071  comment  (;;; <@957,#318> gap)
0x9c023ab2078  comment  (;;; <@958,#319> lazy-bailout)
0x9c023ab2078  comment  (;;; <@960,#322> push-argument)
0x9c023ab2078  position  (11575)
0x9c023ab207a  embedded object  (0x364e0635f5e9 <FixedArray[12]>)
0x9c023ab2084  comment  (;;; <@962,#324> push-argument)
0x9c023ab208a  comment  (;;; <@964,#326> push-argument)
0x9c023ab208c  embedded object  (0x26a635d04101 <FixedArray[0]>)
0x9c023ab2096  comment  (;;; <@966,#328> push-argument)
0x9c023ab209c  comment  (;;; <@967,#328> gap)
0x9c023ab20a0  comment  (;;; <@968,#329> call-runtime)
0x9c023ab20ad  code target (STUB)  (0x9c023a06060)
0x9c023ab20b1  comment  (;;; <@970,#329> lazy-bailout)
0x9c023ab20b1  comment  (;;; <@972,#330> check-maps)
0x9c023ab20b3  embedded object  (0x2ccb5ec07e51 <Map(elements=0)>)
0x9c023ab20c5  comment  (;;; <@974,#334> deoptimize)
0x9c023ab20c5  position  (11579)
0x9c023ab20c5  comment  (;;; deoptimize: Insufficient type feedback for keyed load)
0x9c023ab20c6  runtime entry
0x9c023ab20ca  comment  (;;; <@976,#335> -------------------- B37 (unreachable/replaced) --------------------)
0x9c023ab20ca  comment  (;;; <@1000,#346> -------------------- B38 (unreachable/replaced) --------------------)
0x9c023ab20ca  comment  (;;; <@1032,#179> -------------------- B39 (unreachable/replaced) --------------------)
0x9c023ab20ca  position  (11358)
0x9c023ab20ca  comment  (;;; <@1036,#185> -------------------- B40 --------------------)
0x9c023ab20ca  comment  (;;; <@1037,#185> gap)
0x9c023ab20ce  comment  (;;; <@1038,#186> load-context-slot)
0x9c023ab20d5  comment  (;;; <@1040,#189> push-argument)
0x9c023ab20d5  position  (11374)
0x9c023ab20d7  embedded object  (0x364e06304121 <undefined>)
0x9c023ab20e1  comment  (;;; <@1042,#190> push-argument)
0x9c023ab20e4  comment  (;;; <@1044,#191> push-argument)
0x9c023ab20ea  comment  (;;; <@1045,#191> gap)
0x9c023ab20ed  comment  (;;; <@1046,#192> call-function)
0x9c023ab20ee  code target (STUB)  (0x9c023a28e20)
0x9c023ab20f2  comment  (;;; <@1048,#193> lazy-bailout)
0x9c023ab20f2  comment  (;;; <@1050,#197> deoptimize)
0x9c023ab20f2  position  (11393)
0x9c023ab20f2  comment  (;;; deoptimize: Insufficient type feedback for combined type of binary operation)
0x9c023ab20f3  runtime entry
0x9c023ab20f7  comment  (;;; <@1052,#198> -------------------- B41 (unreachable/replaced) --------------------)
0x9c023ab20f7  comment  (;;; <@1062,#205> -------------------- B42 (unreachable/replaced) --------------------)
0x9c023ab20f7  comment  (;;; <@1066,#231> -------------------- B43 (unreachable/replaced) --------------------)
0x9c023ab20f7  comment  (;;; <@1070,#235> -------------------- B44 (unreachable/replaced) --------------------)
0x9c023ab20f7  comment  (;;; <@1080,#242> -------------------- B45 (unreachable/replaced) --------------------)
0x9c023ab20f7  comment  (;;; <@1084,#269> -------------------- B46 (unreachable/replaced) --------------------)
0x9c023ab20f7  comment  (;;; <@1140,#239> -------------------- B47 (unreachable/replaced) --------------------)
0x9c023ab20f7  comment  (;;; <@1144,#245> -------------------- B48 (unreachable/replaced) --------------------)
0x9c023ab20f7  comment  (;;; <@1186,#202> -------------------- B49 (unreachable/replaced) --------------------)
0x9c023ab20f7  comment  (;;; <@1190,#208> -------------------- B50 (unreachable/replaced) --------------------)
0x9c023ab20f7  comment  (;;; <@1230,#146> -------------------- B51 (unreachable/replaced) --------------------)
0x9c023ab20f7  position  (11300)
0x9c023ab20f7  comment  (;;; <@1234,#152> -------------------- B52 --------------------)
0x9c023ab20f7  comment  (;;; <@1236,#154> push-argument)
0x9c023ab20f9  embedded object  (0x364e0635f5e9 <FixedArray[12]>)
0x9c023ab2103  comment  (;;; <@1238,#156> push-argument)
0x9c023ab2105  comment  (;;; <@1240,#158> push-argument)
0x9c023ab2107  embedded object  (0x26a635d04101 <FixedArray[0]>)
0x9c023ab2111  comment  (;;; <@1242,#160> push-argument)
0x9c023ab2117  comment  (;;; <@1243,#160> gap)
0x9c023ab211b  comment  (;;; <@1244,#161> call-runtime)
0x9c023ab2128  code target (STUB)  (0x9c023a06060)
0x9c023ab212c  comment  (;;; <@1246,#161> lazy-bailout)
0x9c023ab212c  comment  (;;; <@1248,#162> check-maps)
0x9c023ab212e  embedded object  (0x2ccb5ec07e51 <Map(elements=0)>)
0x9c023ab2140  comment  (;;; <@1249,#162> gap)
0x9c023ab2144  comment  (;;; <@1250,#164> load-context-slot)
0x9c023ab2144  position  (11301)
0x9c023ab214b  comment  (;;; <@1252,#165> load-named-field)
0x9c023ab214f  comment  (;;; <@1254,#968> check-smi)
0x9c023ab2158  comment  (;;; <@1256,#167> store-keyed)
0x9c023ab215c  comment  (;;; <@1257,#167> gap)
0x9c023ab2160  comment  (;;; <@1258,#883> check-smi)
0x9c023ab2160  position  (11307)
0x9c023ab2169  comment  (;;; <@1260,#171> store-keyed)
0x9c023ab216d  comment  (;;; <@1262,#174> return)
0x9c023ab2174  position  (10914)
0x9c023ab2174  comment  (;;; <@30,#885> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab2192  comment  (Deferred TaggedToI: lost precision)
0x9c023ab2194  comment  (Deferred TaggedToI: NaN)
0x9c023ab219c  runtime entry  (deoptimization bailout 131)
0x9c023ab21a5  position  (11036)
0x9c023ab21a5  comment  (;;; <@62,#887> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab21c6  comment  (Deferred TaggedToI: lost precision)
0x9c023ab21c8  comment  (Deferred TaggedToI: NaN)
0x9c023ab21d0  runtime entry  (deoptimization bailout 132)
0x9c023ab21d9  position  (11959)
0x9c023ab21d9  comment  (;;; <@72,#881> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab21f7  comment  (Deferred TaggedToI: lost precision)
0x9c023ab21f9  comment  (Deferred TaggedToI: NaN)
0x9c023ab2201  runtime entry  (deoptimization bailout 133)
0x9c023ab220a  position  (11228)
0x9c023ab220a  comment  (;;; <@658,#928> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab2228  comment  (Deferred TaggedToI: lost precision)
0x9c023ab222a  comment  (Deferred TaggedToI: NaN)
0x9c023ab2232  runtime entry  (deoptimization bailout 134)
0x9c023ab223b  position  (11258)
0x9c023ab223b  comment  (;;; <@678,#929> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab225c  comment  (Deferred TaggedToI: lost precision)
0x9c023ab225e  comment  (Deferred TaggedToI: NaN)
0x9c023ab2266  runtime entry  (deoptimization bailout 135)
0x9c023ab226f  comment  (;;; -------------------- Jump table --------------------)
0x9c023ab226f  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x9c023ab2270  runtime entry  (deoptimization bailout 1)
0x9c023ab2274  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x9c023ab2275  runtime entry  (deoptimization bailout 2)
0x9c023ab2279  comment  (;;; jump table entry 2: deoptimization bailout 3.)
0x9c023ab227a  runtime entry  (deoptimization bailout 3)
0x9c023ab227e  comment  (;;; jump table entry 3: deoptimization bailout 4.)
0x9c023ab227f  runtime entry  (deoptimization bailout 4)
0x9c023ab2283  comment  (;;; jump table entry 4: deoptimization bailout 5.)
0x9c023ab2284  runtime entry  (deoptimization bailout 5)
0x9c023ab2288  comment  (;;; jump table entry 5: deoptimization bailout 6.)
0x9c023ab2289  runtime entry  (deoptimization bailout 6)
0x9c023ab228d  comment  (;;; jump table entry 6: deoptimization bailout 7.)
0x9c023ab228e  runtime entry  (deoptimization bailout 7)
0x9c023ab2292  comment  (;;; jump table entry 7: deoptimization bailout 8.)
0x9c023ab2293  runtime entry  (deoptimization bailout 8)
0x9c023ab2297  comment  (;;; jump table entry 8: deoptimization bailout 9.)
0x9c023ab2298  runtime entry  (deoptimization bailout 9)
0x9c023ab229c  comment  (;;; jump table entry 9: deoptimization bailout 10.)
0x9c023ab229d  runtime entry  (deoptimization bailout 10)
0x9c023ab22a1  comment  (;;; jump table entry 10: deoptimization bailout 11.)
0x9c023ab22a2  runtime entry  (deoptimization bailout 11)
0x9c023ab22a6  comment  (;;; jump table entry 11: deoptimization bailout 12.)
0x9c023ab22a7  runtime entry  (deoptimization bailout 12)
0x9c023ab22ab  comment  (;;; jump table entry 12: deoptimization bailout 13.)
0x9c023ab22ac  runtime entry  (deoptimization bailout 13)
0x9c023ab22b0  comment  (;;; jump table entry 13: deoptimization bailout 14.)
0x9c023ab22b1  runtime entry  (deoptimization bailout 14)
0x9c023ab22b5  comment  (;;; jump table entry 14: deoptimization bailout 15.)
0x9c023ab22b6  runtime entry  (deoptimization bailout 15)
0x9c023ab22ba  comment  (;;; jump table entry 15: deoptimization bailout 16.)
0x9c023ab22bb  runtime entry  (deoptimization bailout 16)
0x9c023ab22bf  comment  (;;; jump table entry 16: deoptimization bailout 17.)
0x9c023ab22c0  runtime entry  (deoptimization bailout 17)
0x9c023ab22c4  comment  (;;; jump table entry 17: deoptimization bailout 18.)
0x9c023ab22c5  runtime entry  (deoptimization bailout 18)
0x9c023ab22c9  comment  (;;; jump table entry 18: deoptimization bailout 19.)
0x9c023ab22ca  runtime entry  (deoptimization bailout 19)
0x9c023ab22ce  comment  (;;; jump table entry 19: deoptimization bailout 20.)
0x9c023ab22cf  runtime entry  (deoptimization bailout 20)
0x9c023ab22d3  comment  (;;; jump table entry 20: deoptimization bailout 21.)
0x9c023ab22d4  runtime entry  (deoptimization bailout 21)
0x9c023ab22d8  comment  (;;; jump table entry 21: deoptimization bailout 23.)
0x9c023ab22d9  runtime entry  (deoptimization bailout 23)
0x9c023ab22dd  comment  (;;; jump table entry 22: deoptimization bailout 25.)
0x9c023ab22de  runtime entry  (deoptimization bailout 25)
0x9c023ab22e2  comment  (;;; jump table entry 23: deoptimization bailout 26.)
0x9c023ab22e3  runtime entry  (deoptimization bailout 26)
0x9c023ab22e7  comment  (;;; jump table entry 24: deoptimization bailout 27.)
0x9c023ab22e8  runtime entry  (deoptimization bailout 27)
0x9c023ab22ec  comment  (;;; jump table entry 25: deoptimization bailout 28.)
0x9c023ab22ed  runtime entry  (deoptimization bailout 28)
0x9c023ab22f1  comment  (;;; jump table entry 26: deoptimization bailout 29.)
0x9c023ab22f2  runtime entry  (deoptimization bailout 29)
0x9c023ab22f6  comment  (;;; jump table entry 27: deoptimization bailout 30.)
0x9c023ab22f7  runtime entry  (deoptimization bailout 30)
0x9c023ab22fb  comment  (;;; jump table entry 28: deoptimization bailout 32.)
0x9c023ab22fc  runtime entry  (deoptimization bailout 32)
0x9c023ab2300  comment  (;;; jump table entry 29: deoptimization bailout 33.)
0x9c023ab2301  runtime entry  (deoptimization bailout 33)
0x9c023ab2305  comment  (;;; jump table entry 30: deoptimization bailout 39.)
0x9c023ab2306  runtime entry  (deoptimization bailout 39)
0x9c023ab230a  comment  (;;; jump table entry 31: deoptimization bailout 40.)
0x9c023ab230b  runtime entry  (deoptimization bailout 40)
0x9c023ab230f  comment  (;;; jump table entry 32: deoptimization bailout 41.)
0x9c023ab2310  runtime entry  (deoptimization bailout 41)
0x9c023ab2314  comment  (;;; jump table entry 33: deoptimization bailout 42.)
0x9c023ab2315  runtime entry  (deoptimization bailout 42)
0x9c023ab2319  comment  (;;; jump table entry 34: deoptimization bailout 43.)
0x9c023ab231a  runtime entry  (deoptimization bailout 43)
0x9c023ab231e  comment  (;;; jump table entry 35: deoptimization bailout 45.)
0x9c023ab231f  runtime entry  (deoptimization bailout 45)
0x9c023ab2323  comment  (;;; jump table entry 36: deoptimization bailout 46.)
0x9c023ab2324  runtime entry  (deoptimization bailout 46)
0x9c023ab2328  comment  (;;; jump table entry 37: deoptimization bailout 47.)
0x9c023ab2329  runtime entry  (deoptimization bailout 47)
0x9c023ab232d  comment  (;;; jump table entry 38: deoptimization bailout 49.)
0x9c023ab232e  runtime entry  (deoptimization bailout 49)
0x9c023ab2332  comment  (;;; jump table entry 39: deoptimization bailout 50.)
0x9c023ab2333  runtime entry  (deoptimization bailout 50)
0x9c023ab2337  comment  (;;; jump table entry 40: deoptimization bailout 51.)
0x9c023ab2338  runtime entry  (deoptimization bailout 51)
0x9c023ab233c  comment  (;;; jump table entry 41: deoptimization bailout 52.)
0x9c023ab233d  runtime entry  (deoptimization bailout 52)
0x9c023ab2341  comment  (;;; jump table entry 42: deoptimization bailout 57.)
0x9c023ab2342  runtime entry  (deoptimization bailout 57)
0x9c023ab2346  comment  (;;; jump table entry 43: deoptimization bailout 58.)
0x9c023ab2347  runtime entry  (deoptimization bailout 58)
0x9c023ab234b  comment  (;;; jump table entry 44: deoptimization bailout 59.)
0x9c023ab234c  runtime entry  (deoptimization bailout 59)
0x9c023ab2350  comment  (;;; jump table entry 45: deoptimization bailout 60.)
0x9c023ab2351  runtime entry  (deoptimization bailout 60)
0x9c023ab2355  comment  (;;; jump table entry 46: deoptimization bailout 61.)
0x9c023ab2356  runtime entry  (deoptimization bailout 61)
0x9c023ab235a  comment  (;;; jump table entry 47: deoptimization bailout 62.)
0x9c023ab235b  runtime entry  (deoptimization bailout 62)
0x9c023ab235f  comment  (;;; jump table entry 48: deoptimization bailout 64.)
0x9c023ab2360  runtime entry  (deoptimization bailout 64)
0x9c023ab2364  comment  (;;; jump table entry 49: deoptimization bailout 65.)
0x9c023ab2365  runtime entry  (deoptimization bailout 65)
0x9c023ab2369  comment  (;;; jump table entry 50: deoptimization bailout 66.)
0x9c023ab236a  runtime entry  (deoptimization bailout 66)
0x9c023ab236e  comment  (;;; jump table entry 51: deoptimization bailout 67.)
0x9c023ab236f  runtime entry  (deoptimization bailout 67)
0x9c023ab2373  comment  (;;; jump table entry 52: deoptimization bailout 69.)
0x9c023ab2374  runtime entry  (deoptimization bailout 69)
0x9c023ab2378  comment  (;;; jump table entry 53: deoptimization bailout 71.)
0x9c023ab2379  runtime entry  (deoptimization bailout 71)
0x9c023ab237d  comment  (;;; jump table entry 54: deoptimization bailout 72.)
0x9c023ab237e  runtime entry  (deoptimization bailout 72)
0x9c023ab2382  comment  (;;; jump table entry 55: deoptimization bailout 73.)
0x9c023ab2383  runtime entry  (deoptimization bailout 73)
0x9c023ab2387  comment  (;;; jump table entry 56: deoptimization bailout 74.)
0x9c023ab2388  runtime entry  (deoptimization bailout 74)
0x9c023ab238c  comment  (;;; jump table entry 57: deoptimization bailout 75.)
0x9c023ab238d  runtime entry  (deoptimization bailout 75)
0x9c023ab2391  comment  (;;; jump table entry 58: deoptimization bailout 76.)
0x9c023ab2392  runtime entry  (deoptimization bailout 76)
0x9c023ab2396  comment  (;;; jump table entry 59: deoptimization bailout 77.)
0x9c023ab2397  runtime entry  (deoptimization bailout 77)
0x9c023ab239b  comment  (;;; jump table entry 60: deoptimization bailout 78.)
0x9c023ab239c  runtime entry  (deoptimization bailout 78)
0x9c023ab23a0  comment  (;;; jump table entry 61: deoptimization bailout 79.)
0x9c023ab23a1  runtime entry  (deoptimization bailout 79)
0x9c023ab23a5  comment  (;;; jump table entry 62: deoptimization bailout 80.)
0x9c023ab23a6  runtime entry  (deoptimization bailout 80)
0x9c023ab23aa  comment  (;;; jump table entry 63: deoptimization bailout 81.)
0x9c023ab23ab  runtime entry  (deoptimization bailout 81)
0x9c023ab23af  comment  (;;; jump table entry 64: deoptimization bailout 82.)
0x9c023ab23b0  runtime entry  (deoptimization bailout 82)
0x9c023ab23b4  comment  (;;; jump table entry 65: deoptimization bailout 83.)
0x9c023ab23b5  runtime entry  (deoptimization bailout 83)
0x9c023ab23b9  comment  (;;; jump table entry 66: deoptimization bailout 84.)
0x9c023ab23ba  runtime entry  (deoptimization bailout 84)
0x9c023ab23be  comment  (;;; jump table entry 67: deoptimization bailout 85.)
0x9c023ab23bf  runtime entry  (deoptimization bailout 85)
0x9c023ab23c3  comment  (;;; jump table entry 68: deoptimization bailout 86.)
0x9c023ab23c4  runtime entry  (deoptimization bailout 86)
0x9c023ab23c8  comment  (;;; jump table entry 69: deoptimization bailout 87.)
0x9c023ab23c9  runtime entry  (deoptimization bailout 87)
0x9c023ab23cd  comment  (;;; jump table entry 70: deoptimization bailout 89.)
0x9c023ab23ce  runtime entry  (deoptimization bailout 89)
0x9c023ab23d2  comment  (;;; jump table entry 71: deoptimization bailout 91.)
0x9c023ab23d3  runtime entry  (deoptimization bailout 91)
0x9c023ab23d7  comment  (;;; jump table entry 72: deoptimization bailout 92.)
0x9c023ab23d8  runtime entry  (deoptimization bailout 92)
0x9c023ab23dc  comment  (;;; jump table entry 73: deoptimization bailout 93.)
0x9c023ab23dd  runtime entry  (deoptimization bailout 93)
0x9c023ab23e1  comment  (;;; jump table entry 74: deoptimization bailout 94.)
0x9c023ab23e2  runtime entry  (deoptimization bailout 94)
0x9c023ab23e6  comment  (;;; jump table entry 75: deoptimization bailout 95.)
0x9c023ab23e7  runtime entry  (deoptimization bailout 95)
0x9c023ab23eb  comment  (;;; jump table entry 76: deoptimization bailout 96.)
0x9c023ab23ec  runtime entry  (deoptimization bailout 96)
0x9c023ab23f0  comment  (;;; jump table entry 77: deoptimization bailout 98.)
0x9c023ab23f1  runtime entry  (deoptimization bailout 98)
0x9c023ab23f5  comment  (;;; jump table entry 78: deoptimization bailout 99.)
0x9c023ab23f6  runtime entry  (deoptimization bailout 99)
0x9c023ab23fa  comment  (;;; jump table entry 79: deoptimization bailout 105.)
0x9c023ab23fb  runtime entry  (deoptimization bailout 105)
0x9c023ab23ff  comment  (;;; jump table entry 80: deoptimization bailout 106.)
0x9c023ab2400  runtime entry  (deoptimization bailout 106)
0x9c023ab2404  comment  (;;; jump table entry 81: deoptimization bailout 107.)
0x9c023ab2405  runtime entry  (deoptimization bailout 107)
0x9c023ab2409  comment  (;;; jump table entry 82: deoptimization bailout 108.)
0x9c023ab240a  runtime entry  (deoptimization bailout 108)
0x9c023ab240e  comment  (;;; jump table entry 83: deoptimization bailout 109.)
0x9c023ab240f  runtime entry  (deoptimization bailout 109)
0x9c023ab2413  comment  (;;; jump table entry 84: deoptimization bailout 111.)
0x9c023ab2414  runtime entry  (deoptimization bailout 111)
0x9c023ab2418  comment  (;;; jump table entry 85: deoptimization bailout 112.)
0x9c023ab2419  runtime entry  (deoptimization bailout 112)
0x9c023ab241d  comment  (;;; jump table entry 86: deoptimization bailout 113.)
0x9c023ab241e  runtime entry  (deoptimization bailout 113)
0x9c023ab2422  comment  (;;; jump table entry 87: deoptimization bailout 115.)
0x9c023ab2423  runtime entry  (deoptimization bailout 115)
0x9c023ab2427  comment  (;;; jump table entry 88: deoptimization bailout 116.)
0x9c023ab2428  runtime entry  (deoptimization bailout 116)
0x9c023ab242c  comment  (;;; jump table entry 89: deoptimization bailout 117.)
0x9c023ab242d  runtime entry  (deoptimization bailout 117)
0x9c023ab2431  comment  (;;; jump table entry 90: deoptimization bailout 118.)
0x9c023ab2432  runtime entry  (deoptimization bailout 118)
0x9c023ab2436  comment  (;;; jump table entry 91: deoptimization bailout 120.)
0x9c023ab2437  runtime entry  (deoptimization bailout 120)
0x9c023ab243b  comment  (;;; jump table entry 92: deoptimization bailout 123.)
0x9c023ab243c  runtime entry  (deoptimization bailout 123)
0x9c023ab2440  comment  (;;; jump table entry 93: deoptimization bailout 128.)
0x9c023ab2441  runtime entry  (deoptimization bailout 128)
0x9c023ab2445  comment  (;;; jump table entry 94: deoptimization bailout 129.)
0x9c023ab2446  runtime entry  (deoptimization bailout 129)
0x9c023ab244a  comment  (;;; jump table entry 95: deoptimization bailout 130.)
0x9c023ab244b  runtime entry  (deoptimization bailout 130)
0x9c023ab2450  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (add) id{6,0} ---
(A, B){

    if ( heap[adrs[A]] > heap[adrs[B]] ) {
      var T = A
      A = B
      B = T
    }

    var size_a = heap[adrs[A]]
    var size_b = heap[adrs[B]]

    var size_r = size_b + 1
    var R = alloc(size_r)
    var Rp = adrs[R]
    heap[Rp + 1] = 0 // type integer
    heap[Rp + size_r - 1] = 0 // possible garbage cleanup

    var Ap = adrs[A]
    var Bp = adrs[B]

    var carry = 0
    var partial = 0

    for ( var i = 2; i < size_a; i ++ ) {
      partial = heap[Ap + i] + heap[Bp + i] + carry
      heap[Rp + i] = partial & 0x3ffffff
      carry = partial >>> 26
    }

    for ( ; i < size_b; i ++ ) {
      partial = heap[Bp + i] + carry
      heap[Rp + i] = partial & 0x3ffffff
      carry = partial >>> 26
    }

    if ( carry ) {
      heap[Rp + i] += carry
    } else {
      heap[Rp] = heap[Rp] - 1
    }

    return R
  }

--- END ---
--- FUNCTION SOURCE (alloc) id{6,1} ---
(length){
      // there is no check for it but length has to be larger than 0
      if ( length > unallocated ) {
        extend(length)
      }
      unallocated -= length
      // save data index to data_idx and advance the break point with length
      var data_idx = brk
      brk = brk + length
      // save data_idx in address space and advance next
      var pointer = next++
      adrs[pointer] = data_idx
      heap[data_idx] = length
      return pointer
    }

--- END ---
INLINE (alloc) id{6,1} AS 1 AT <0:202>
--- Raw source ---
(A, B){

    if ( heap[adrs[A]] > heap[adrs[B]] ) {
      var T = A
      A = B
      B = T
    }

    var size_a = heap[adrs[A]]
    var size_b = heap[adrs[B]]

    var size_r = size_b + 1
    var R = alloc(size_r)
    var Rp = adrs[R]
    heap[Rp + 1] = 0 // type integer
    heap[Rp + size_r - 1] = 0 // possible garbage cleanup

    var Ap = adrs[A]
    var Bp = adrs[B]

    var carry = 0
    var partial = 0

    for ( var i = 2; i < size_a; i ++ ) {
      partial = heap[Ap + i] + heap[Bp + i] + carry
      heap[Rp + i] = partial & 0x3ffffff
      carry = partial >>> 26
    }

    for ( ; i < size_b; i ++ ) {
      partial = heap[Bp + i] + carry
      heap[Rp + i] = partial & 0x3ffffff
      carry = partial >>> 26
    }

    if ( carry ) {
      heap[Rp + i] += carry
    } else {
      heap[Rp] = heap[Rp] - 1
    }

    return R
  }


--- Optimized code ---
optimization_id = 6
source_position = 4513
kind = OPTIMIZED_FUNCTION
name = add
stack_slots = 9
Instructions (size = 2356)
0x9c023ab2d80     0  55             push rbp
0x9c023ab2d81     1  4889e5         REX.W movq rbp,rsp
0x9c023ab2d84     4  56             push rsi
0x9c023ab2d85     5  57             push rdi
0x9c023ab2d86     6  4883ec48       REX.W subq rsp,0x48
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x9c023ab2d8a    10  488b45f8       REX.W movq rax,[rbp-0x8]    ;; debug: position 4513
                  ;;; <@3,#1> gap
0x9c023ab2d8e    14  488945e8       REX.W movq [rbp-0x18],rax
                  ;;; <@12,#9> -------------------- B1 --------------------
                  ;;; <@13,#9> gap
0x9c023ab2d92    18  488bf0         REX.W movq rsi,rax
                  ;;; <@14,#11> stack-check
0x9c023ab2d95    21  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023ab2d9c    28  7305           jnc 35  (0x9c023ab2da3)
0x9c023ab2d9e    30  e8bd30f7ff     call StackCheck  (0x9c023a25e60)    ;; code: BUILTIN
                  ;;; <@16,#11> lazy-bailout
                  ;;; <@17,#11> gap
0x9c023ab2da3    35  488b45e8       REX.W movq rax,[rbp-0x18]
                  ;;; <@18,#12> load-context-slot
0x9c023ab2da7    39  488b9897000000 REX.W movq rbx,[rax+0x97]    ;; debug: position 4531
                  ;;; <@20,#13> load-context-slot
0x9c023ab2dae    46  488b909f000000 REX.W movq rdx,[rax+0x9f]    ;; debug: position 4536
                  ;;; <@22,#15> check-non-smi
0x9c023ab2db5    53  f6c201         testb rdx,0x1            ;; debug: position 4541
0x9c023ab2db8    56  0f8480070000   jz 1982  (0x9c023ab353e)
                  ;;; <@24,#16> check-maps
0x9c023ab2dbe    62  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab2dc8    72  4c3952ff       REX.W cmpq [rdx-0x1],r10
0x9c023ab2dcc    76  0f8571070000   jnz 1987  (0x9c023ab3543)
                  ;;; <@26,#17> load-named-field
0x9c023ab2dd2    82  488b520f       REX.W movq rdx,[rdx+0xf]
                  ;;; <@28,#18> load-named-field
0x9c023ab2dd6    86  8b4a0b         movl rcx,[rdx+0xb]
                  ;;; <@30,#19> load-named-field
0x9c023ab2dd9    89  488b520f       REX.W movq rdx,[rdx+0xf]
                  ;;; <@31,#19> gap
0x9c023ab2ddd    93  488b7518       REX.W movq rsi,[rbp+0x18]
                  ;;; <@32,#500> tagged-to-i
0x9c023ab2de1    97  40f6c601       testb rsi,0x1
0x9c023ab2de5   101  0f8523050000   jnz 1422  (0x9c023ab330e)
0x9c023ab2deb   107  48c1ee20       REX.W shrq rsi,32
                  ;;; <@34,#20> bounds-check
0x9c023ab2def   111  3bce           cmpl rcx,rsi
0x9c023ab2df1   113  0f8651070000   jna 1992  (0x9c023ab3548)
                  ;;; <@36,#21> load-keyed
0x9c023ab2df7   119  8b3cb2         movl rdi,[rdx+rsi*4]
0x9c023ab2dfa   122  85ff           testl rdi,rdi
0x9c023ab2dfc   124  0f884b070000   js 1997  (0x9c023ab354d)
                  ;;; <@38,#22> check-non-smi
0x9c023ab2e02   130  f6c301         testb rbx,0x1
0x9c023ab2e05   133  0f8447070000   jz 2002  (0x9c023ab3552)
                  ;;; <@40,#23> check-maps
0x9c023ab2e0b   139  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab2e15   149  4c3953ff       REX.W cmpq [rbx-0x1],r10
0x9c023ab2e19   153  0f8538070000   jnz 2007  (0x9c023ab3557)
                  ;;; <@42,#24> load-named-field
0x9c023ab2e1f   159  488b5b0f       REX.W movq rbx,[rbx+0xf]
                  ;;; <@44,#25> load-named-field
0x9c023ab2e23   163  448b430b       movl r8,[rbx+0xb]
                  ;;; <@46,#26> load-named-field
0x9c023ab2e27   167  488b5b0f       REX.W movq rbx,[rbx+0xf]
                  ;;; <@48,#27> bounds-check
0x9c023ab2e2b   171  443bc7         cmpl r8,rdi
0x9c023ab2e2e   174  0f8628070000   jna 2012  (0x9c023ab355c)
                  ;;; <@50,#28> load-keyed
0x9c023ab2e34   180  8b3cbb         movl rdi,[rbx+rdi*4]
0x9c023ab2e37   183  85ff           testl rdi,rdi
0x9c023ab2e39   185  0f8822070000   js 2017  (0x9c023ab3561)
                  ;;; <@51,#28> gap
0x9c023ab2e3f   191  4c8b4d10       REX.W movq r9,[rbp+0x10]
                  ;;; <@52,#503> tagged-to-i
0x9c023ab2e43   195  41f6c101       testb r9,0x1             ;; debug: position 4557
0x9c023ab2e47   199  0f85f2040000   jnz 1471  (0x9c023ab333f)
0x9c023ab2e4d   205  49c1e920       REX.W shrq r9,32
                  ;;; <@54,#36> bounds-check
0x9c023ab2e51   209  413bc9         cmpl rcx,r9
0x9c023ab2e54   212  0f860c070000   jna 2022  (0x9c023ab3566)
                  ;;; <@56,#37> load-keyed
0x9c023ab2e5a   218  468b1c8a       movl r11,[rdx+r9*4]
0x9c023ab2e5e   222  4585db         testl r11,r11
0x9c023ab2e61   225  0f8804070000   js 2027  (0x9c023ab356b)
                  ;;; <@58,#43> bounds-check
0x9c023ab2e67   231  453bc3         cmpl r8,r11
0x9c023ab2e6a   234  0f8600070000   jna 2032  (0x9c023ab3570)
                  ;;; <@60,#44> load-keyed
0x9c023ab2e70   240  468b1c9b       movl r11,[rbx+r11*4]
0x9c023ab2e74   244  4585db         testl r11,r11
0x9c023ab2e77   247  0f88f8060000   js 2037  (0x9c023ab3575)
                  ;;; <@63,#45> compare-numeric-and-branch
0x9c023ab2e7d   253  413bfb         cmpl rdi,r11             ;; debug: position 4545
0x9c023ab2e80   256  0f8f08000000   jg 270  (0x9c023ab2e8e)
                  ;;; <@64,#49> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@68,#57> -------------------- B3 --------------------
                  ;;; <@70,#59> gap
0x9c023ab2e86   262  4c8bde         REX.W movq r11,rsi       ;; debug: position 4603
                  ;;; <@71,#59> goto
0x9c023ab2e89   265  e906000000     jmp 276  (0x9c023ab2e94)
                  ;;; <@72,#46> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@76,#52> -------------------- B5 --------------------
                  ;;; <@78,#56> gap
0x9c023ab2e8e   270  4d8bd9         REX.W movq r11,r9        ;; debug: position 4579
                                                             ;; debug: position 4603
0x9c023ab2e91   273  4c8bce         REX.W movq r9,rsi
                  ;;; <@80,#63> -------------------- B6 --------------------
0x9c023ab2e94   276  4c895dd8       REX.W movq [rbp-0x28],r11    ;; debug: position 4629
0x9c023ab2e98   280  4c894de0       REX.W movq [rbp-0x20],r9
                  ;;; <@82,#71> bounds-check
0x9c023ab2e9c   284  413bcb         cmpl rcx,r11             ;; debug: position 4639
0x9c023ab2e9f   287  0f86d5060000   jna 2042  (0x9c023ab357a)
                  ;;; <@84,#72> load-keyed
0x9c023ab2ea5   293  428b349a       movl rsi,[rdx+r11*4]
0x9c023ab2ea9   297  85f6           testl rsi,rsi
0x9c023ab2eab   299  0f88ce060000   js 2047  (0x9c023ab357f)
                  ;;; <@86,#78> bounds-check
0x9c023ab2eb1   305  443bc6         cmpl r8,rsi
0x9c023ab2eb4   308  0f86ca060000   jna 2052  (0x9c023ab3584)
                  ;;; <@88,#79> load-keyed
0x9c023ab2eba   314  448b34b3       movl r14,[rbx+rsi*4]
0x9c023ab2ebe   318  4585f6         testl r14,r14
0x9c023ab2ec1   321  0f88c2060000   js 2057  (0x9c023ab3589)
                  ;;; <@89,#79> gap
0x9c023ab2ec7   327  4c8975d0       REX.W movq [rbp-0x30],r14
                  ;;; <@90,#88> bounds-check
0x9c023ab2ecb   331  413bc9         cmpl rcx,r9              ;; debug: position 4670
0x9c023ab2ece   334  0f86ba060000   jna 2062  (0x9c023ab358e)
                  ;;; <@92,#89> load-keyed
0x9c023ab2ed4   340  428b0c8a       movl rcx,[rdx+r9*4]
0x9c023ab2ed8   344  85c9           testl rcx,rcx
0x9c023ab2eda   346  0f88b3060000   js 2067  (0x9c023ab3593)
                  ;;; <@94,#95> bounds-check
0x9c023ab2ee0   352  443bc1         cmpl r8,rcx
0x9c023ab2ee3   355  0f86af060000   jna 2072  (0x9c023ab3598)
                  ;;; <@96,#96> load-keyed
0x9c023ab2ee9   361  8b148b         movl rdx,[rbx+rcx*4]
0x9c023ab2eec   364  85d2           testl rdx,rdx
0x9c023ab2eee   366  0f88a9060000   js 2077  (0x9c023ab359d)
                  ;;; <@97,#96> gap
0x9c023ab2ef4   372  488955c8       REX.W movq [rbp-0x38],rdx
0x9c023ab2ef8   376  488bda         REX.W movq rbx,rdx
                  ;;; <@98,#100> add-i
0x9c023ab2efb   379  83c301         addl rbx,0x1             ;; debug: position 4699
0x9c023ab2efe   382  0f809e060000   jo 2082  (0x9c023ab35a2)
                  ;;; <@99,#100> gap
0x9c023ab2f04   388  48895dc0       REX.W movq [rbp-0x40],rbx
                  ;;; <@100,#103> load-context-slot
0x9c023ab2f08   392  488b88af000000 REX.W movq rcx,[rax+0xaf]    ;; debug: position 4715
                  ;;; <@101,#103> gap
0x9c023ab2f0f   399  48894db8       REX.W movq [rbp-0x48],rcx
                  ;;; <@102,#104> check-value
0x9c023ab2f13   403  49baa1fc35064e360000 REX.W movq r10,0x364e0635fca1    ;; object: 0x364e0635fca1 <JS Function alloc (SharedFunctionInfo 0xc1217b4f389)>
0x9c023ab2f1d   413  493bca         REX.W cmpq rcx,r10
0x9c023ab2f20   416  0f8581060000   jnz 2087  (0x9c023ab35a7)
                  ;;; <@104,#107> constant-t
0x9c023ab2f26   422  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@106,#110> load-context-slot
0x9c023ab2f30   432  488b7637       REX.W movq rsi,[rsi+0x37]    ;; debug: position 2205
                  ;;; <@108,#505> tagged-to-i
0x9c023ab2f34   436  40f6c601       testb rsi,0x1
0x9c023ab2f38   440  0f8535040000   jnz 1523  (0x9c023ab3373)
0x9c023ab2f3e   446  48c1ee20       REX.W shrq rsi,32
                  ;;; <@111,#111> compare-numeric-and-branch
0x9c023ab2f42   450  3bde           cmpl rbx,rsi             ;; debug: position 2203
0x9c023ab2f44   452  0f8e30000000   jle 506  (0x9c023ab2f7a)
                  ;;; <@112,#115> -------------------- B7 (unreachable/replaced) --------------------
                  ;;; <@116,#126> -------------------- B8 (unreachable/replaced) --------------------
                  ;;; <@120,#112> -------------------- B9 (unreachable/replaced) --------------------
                  ;;; <@124,#118> -------------------- B10 --------------------
                  ;;; <@126,#107> constant-t
0x9c023ab2f4a   458  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2229
                                                             ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@128,#119> load-context-slot
0x9c023ab2f54   468  488b7e4f       REX.W movq rdi,[rsi+0x4f]    ;; debug: position 2229
                  ;;; <@130,#120> push-argument
0x9c023ab2f58   472  49ba214130064e360000 REX.W movq r10,0x364e06304121    ;; debug: position 2236
                                                             ;; object: 0x364e06304121 <undefined>
0x9c023ab2f62   482  4152           push r10
                  ;;; <@132,#504> smi-tag
0x9c023ab2f64   484  8bf3           movl rsi,rbx
0x9c023ab2f66   486  48c1e620       REX.W shlq rsi,32
                  ;;; <@134,#121> push-argument
0x9c023ab2f6a   490  56             push rsi
                  ;;; <@136,#107> constant-t
0x9c023ab2f6b   491  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@138,#122> call-function
0x9c023ab2f75   501  e8a65df7ff     call 0x9c023a28d20       ;; debug: position 2236
                                                             ;; code: STUB, CallFunctionStub, argc = 1
                  ;;; <@140,#123> lazy-bailout
                  ;;; <@144,#129> -------------------- B11 --------------------
                  ;;; <@146,#107> constant-t
0x9c023ab2f7a   506  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2258
                                                             ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@148,#130> load-context-slot
0x9c023ab2f84   516  488b4637       REX.W movq rax,[rsi+0x37]    ;; debug: position 2258
                  ;;; <@150,#506> tagged-to-i
0x9c023ab2f88   520  a801           test al,0x1
0x9c023ab2f8a   522  0f8514040000   jnz 1572  (0x9c023ab33a4)
0x9c023ab2f90   528  48c1e820       REX.W shrq rax,32
                  ;;; <@152,#131> sub-i
0x9c023ab2f94   532  2b45c0         subl rax,[rbp-0x40]      ;; debug: position 2271
0x9c023ab2f97   535  0f800f060000   jo 2092  (0x9c023ab35ac)
                  ;;; <@154,#507> smi-tag
0x9c023ab2f9d   541  8bd8           movl rbx,rax
0x9c023ab2f9f   543  48c1e320       REX.W shlq rbx,32
                  ;;; <@156,#107> constant-t
0x9c023ab2fa3   547  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@158,#133> store-context-slot
0x9c023ab2fad   557  48895e37       REX.W movq [rsi+0x37],rbx    ;; debug: position 2271
                  ;;; <@160,#107> constant-t
0x9c023ab2fb1   561  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@162,#135> load-context-slot
0x9c023ab2fbb   571  488b5e3f       REX.W movq rbx,[rsi+0x3f]    ;; debug: position 2378
                  ;;; <@163,#135> gap
0x9c023ab2fbf   575  488bd3         REX.W movq rdx,rbx
                  ;;; <@164,#510> tagged-to-i
0x9c023ab2fc2   578  f6c201         testb rdx,0x1            ;; debug: position 2394
0x9c023ab2fc5   581  0f8517040000   jnz 1634  (0x9c023ab33e2)
0x9c023ab2fcb   587  48c1ea20       REX.W shrq rdx,32
                  ;;; <@165,#510> gap
0x9c023ab2fcf   591  488bca         REX.W movq rcx,rdx
                  ;;; <@166,#138> add-i
0x9c023ab2fd2   594  034dc0         addl rcx,[rbp-0x40]      ;; debug: position 2398
0x9c023ab2fd5   597  0f80d6050000   jo 2097  (0x9c023ab35b1)
                  ;;; <@168,#511> smi-tag
0x9c023ab2fdb   603  8bc1           movl rax,rcx
0x9c023ab2fdd   605  48c1e020       REX.W shlq rax,32
                  ;;; <@170,#107> constant-t
0x9c023ab2fe1   609  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@172,#140> store-context-slot
0x9c023ab2feb   619  4889463f       REX.W movq [rsi+0x3f],rax    ;; debug: position 2398
                  ;;; <@174,#107> constant-t
0x9c023ab2fef   623  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@176,#142> load-context-slot
0x9c023ab2ff9   633  488b4647       REX.W movq rax,[rsi+0x47]    ;; debug: position 2484
                  ;;; <@178,#512> tagged-to-i
0x9c023ab2ffd   637  a801           test al,0x1
0x9c023ab2fff   639  0f850e040000   jnz 1683  (0x9c023ab3413)
0x9c023ab3005   645  48c1e820       REX.W shrq rax,32
                  ;;; <@179,#512> gap
0x9c023ab3009   649  488945b0       REX.W movq [rbp-0x50],rax
0x9c023ab300d   653  488bf8         REX.W movq rdi,rax
                  ;;; <@180,#145> add-i
0x9c023ab3010   656  83c701         addl rdi,0x1
0x9c023ab3013   659  0f809d050000   jo 2102  (0x9c023ab35b6)
                  ;;; <@182,#514> smi-tag
0x9c023ab3019   665  8bcf           movl rcx,rdi
0x9c023ab301b   667  48c1e120       REX.W shlq rcx,32
                  ;;; <@184,#107> constant-t
0x9c023ab301f   671  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@186,#146> store-context-slot
0x9c023ab3029   681  48894e47       REX.W movq [rsi+0x47],rcx    ;; debug: position 2484
                  ;;; <@188,#107> constant-t
0x9c023ab302d   685  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@190,#149> load-named-field
0x9c023ab3037   695  488b4e17       REX.W movq rcx,[rsi+0x17]    ;; debug: position 2497
                  ;;; <@192,#150> load-context-slot
0x9c023ab303b   699  488bb19f000000 REX.W movq rsi,[rcx+0x9f]
                  ;;; <@194,#153> check-non-smi
0x9c023ab3042   706  40f6c601       testb rsi,0x1            ;; debug: position 2513
0x9c023ab3046   710  0f846f050000   jz 2107  (0x9c023ab35bb)
                  ;;; <@196,#154> check-maps
0x9c023ab304c   716  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab3056   726  4c3956ff       REX.W cmpq [rsi-0x1],r10
0x9c023ab305a   730  0f8560050000   jnz 2112  (0x9c023ab35c0)
                  ;;; <@198,#156> check-maps
                  ;;; <@200,#158> check-maps
                  ;;; <@202,#159> load-named-field
0x9c023ab3060   736  488b760f       REX.W movq rsi,[rsi+0xf]
                  ;;; <@204,#160> load-named-field
0x9c023ab3064   740  448b460b       movl r8,[rsi+0xb]
                  ;;; <@206,#161> load-named-field
0x9c023ab3068   744  488b760f       REX.W movq rsi,[rsi+0xf]
                  ;;; <@208,#162> bounds-check
0x9c023ab306c   748  443bc0         cmpl r8,rax
0x9c023ab306f   751  0f8650050000   jna 2117  (0x9c023ab35c5)
                  ;;; <@209,#162> gap
0x9c023ab3075   757  4c8bc3         REX.W movq r8,rbx
                  ;;; <@210,#509> tagged-to-i
0x9c023ab3078   760  41f6c001       testb r8,0x1
0x9c023ab307c   764  0f85cf030000   jnz 1745  (0x9c023ab3451)
0x9c023ab3082   770  49c1e820       REX.W shrq r8,32
                  ;;; <@212,#163> store-keyed
0x9c023ab3086   774  44890486       movl [rsi+rax*4],r8
                  ;;; <@214,#166> load-context-slot
0x9c023ab308a   778  488b8997000000 REX.W movq rcx,[rcx+0x97]    ;; debug: position 2528
                  ;;; <@216,#168> check-non-smi
0x9c023ab3091   785  f6c101         testb rcx,0x1            ;; debug: position 2545
0x9c023ab3094   788  0f8430050000   jz 2122  (0x9c023ab35ca)
                  ;;; <@218,#169> check-maps
0x9c023ab309a   794  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab30a4   804  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023ab30a8   808  0f8521050000   jnz 2127  (0x9c023ab35cf)
                  ;;; <@220,#174> load-named-field
0x9c023ab30ae   814  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@222,#175> load-named-field
0x9c023ab30b2   818  8b710b         movl rsi,[rcx+0xb]
                  ;;; <@224,#176> load-named-field
0x9c023ab30b5   821  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@226,#177> bounds-check
0x9c023ab30b9   825  3bf2           cmpl rsi,rdx
0x9c023ab30bb   827  0f8613050000   jna 2132  (0x9c023ab35d4)
                  ;;; <@227,#177> gap
0x9c023ab30c1   833  488b5dc0       REX.W movq rbx,[rbp-0x40]
                  ;;; <@228,#178> store-keyed
0x9c023ab30c5   837  891c91         movl [rcx+rdx*4],rbx
                  ;;; <@232,#184> -------------------- B12 --------------------
                  ;;; <@233,#184> gap
0x9c023ab30c8   840  488b55e8       REX.W movq rdx,[rbp-0x18]    ;; debug: position 2565
                                                             ;; debug: position 4721
                  ;;; <@234,#186> load-context-slot
0x9c023ab30cc   844  488b8a9f000000 REX.W movq rcx,[rdx+0x9f]    ;; debug: position 4742
                  ;;; <@236,#188> check-non-smi
0x9c023ab30d3   851  f6c101         testb rcx,0x1            ;; debug: position 4747
0x9c023ab30d6   854  0f84fd040000   jz 2137  (0x9c023ab35d9)
                  ;;; <@238,#189> check-maps
0x9c023ab30dc   860  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab30e6   870  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023ab30ea   874  0f85ee040000   jnz 2142  (0x9c023ab35de)
                  ;;; <@240,#190> load-named-field
0x9c023ab30f0   880  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@242,#191> load-named-field
0x9c023ab30f4   884  8b710b         movl rsi,[rcx+0xb]
                  ;;; <@244,#192> load-named-field
0x9c023ab30f7   887  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@246,#193> bounds-check
0x9c023ab30fb   891  3bf0           cmpl rsi,rax
0x9c023ab30fd   893  0f86e0040000   jna 2147  (0x9c023ab35e3)
                  ;;; <@248,#194> load-keyed
0x9c023ab3103   899  8b3c81         movl rdi,[rcx+rax*4]
0x9c023ab3106   902  85ff           testl rdi,rdi
0x9c023ab3108   904  0f88da040000   js 2152  (0x9c023ab35e8)
0x9c023ab310e   910  4863ff         REX.W movsxlq rdi,rdi
                  ;;; <@250,#196> load-context-slot
0x9c023ab3111   913  4c8b8297000000 REX.W movq r8,[rdx+0x97]    ;; debug: position 4754
                  ;;; <@251,#196> gap
0x9c023ab3118   920  4c8945a8       REX.W movq [rbp-0x58],r8
0x9c023ab311c   924  4c8bcf         REX.W movq r9,rdi
                  ;;; <@252,#199> add-i
0x9c023ab311f   927  4183c101       addl r9,0x1              ;; debug: position 4762
0x9c023ab3123   931  0f80c4040000   jo 2157  (0x9c023ab35ed)
                  ;;; <@254,#202> check-non-smi
0x9c023ab3129   937  41f6c001       testb r8,0x1             ;; debug: position 4769
0x9c023ab312d   941  0f84bf040000   jz 2162  (0x9c023ab35f2)
                  ;;; <@256,#203> check-maps
0x9c023ab3133   947  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab313d   957  4d3950ff       REX.W cmpq [r8-0x1],r10
0x9c023ab3141   961  0f85b0040000   jnz 2167  (0x9c023ab35f7)
                  ;;; <@258,#208> load-named-field
0x9c023ab3147   967  4d8b580f       REX.W movq r11,[r8+0xf]
                  ;;; <@260,#209> load-named-field
0x9c023ab314b   971  458b730b       movl r14,[r11+0xb]
                  ;;; <@262,#210> load-named-field
0x9c023ab314f   975  4d8b5b0f       REX.W movq r11,[r11+0xf]
                  ;;; <@264,#211> bounds-check
0x9c023ab3153   979  453bf1         cmpl r14,r9
0x9c023ab3156   982  0f86a0040000   jna 2172  (0x9c023ab35fc)
                  ;;; <@266,#201> constant-i
0x9c023ab315c   988  4533c9         xorl r9,r9
                  ;;; <@268,#212> store-keyed
0x9c023ab315f   991  45894cbb04     movl [r11+rdi*4+0x4],r9
                  ;;; <@269,#212> gap
0x9c023ab3164   996  4c8bcf         REX.W movq r9,rdi
                  ;;; <@270,#217> add-i
0x9c023ab3167   999  4403cb         addl r9,rbx              ;; debug: position 4799
0x9c023ab316a  1002  0f8091040000   jo 2177  (0x9c023ab3601)
                  ;;; <@271,#217> gap
0x9c023ab3170  1008  4d8bf9         REX.W movq r15,r9
                  ;;; <@272,#220> sub-i
0x9c023ab3173  1011  4183ef01       subl r15,0x1             ;; debug: position 4808
0x9c023ab3177  1015  0f8089040000   jo 2182  (0x9c023ab3606)
                  ;;; <@274,#232> bounds-check
0x9c023ab317d  1021  453bf7         cmpl r14,r15             ;; debug: position 4815
0x9c023ab3180  1024  0f8685040000   jna 2187  (0x9c023ab360b)
                  ;;; <@276,#201> constant-i
0x9c023ab3186  1030  4533c9         xorl r9,r9               ;; debug: position 4769
                  ;;; <@278,#233> store-keyed
0x9c023ab3189  1033  47890cbb       movl [r11+r15*4],r9      ;; debug: position 4815
                  ;;; <@279,#233> gap
0x9c023ab318d  1037  488b5dd8       REX.W movq rbx,[rbp-0x28]
                  ;;; <@280,#241> bounds-check
0x9c023ab3191  1041  3bf3           cmpl rsi,rbx             ;; debug: position 4864
0x9c023ab3193  1043  0f8677040000   jna 2192  (0x9c023ab3610)
                  ;;; <@282,#242> load-keyed
0x9c023ab3199  1049  448b0c99       movl r9,[rcx+rbx*4]
0x9c023ab319d  1053  4585c9         testl r9,r9
0x9c023ab31a0  1056  0f886f040000   js 2197  (0x9c023ab3615)
                  ;;; <@283,#242> gap
0x9c023ab31a6  1062  4c8b7de0       REX.W movq r15,[rbp-0x20]
                  ;;; <@284,#250> bounds-check
0x9c023ab31aa  1066  413bf7         cmpl rsi,r15             ;; debug: position 4885
0x9c023ab31ad  1069  0f8667040000   jna 2202  (0x9c023ab361a)
                  ;;; <@286,#251> load-keyed
0x9c023ab31b3  1075  428b34b9       movl rsi,[rcx+r15*4]
0x9c023ab31b7  1079  85f6           testl rsi,rsi
0x9c023ab31b9  1081  0f8860040000   js 2207  (0x9c023ab361f)
                  ;;; <@288,#275> gap
0x9c023ab31bf  1087  48c745c000000000 REX.W movq [rbp-0x40],0x0    ;; debug: position 4946
0x9c023ab31c7  1095  b902000000     movl rcx,0x2
                  ;;; <@290,#276> -------------------- B13 (loop header) --------------------
                  ;;; <@293,#279> compare-numeric-and-branch
0x9c023ab31cc  1100  3b4dd0         cmpl rcx,[rbp-0x30]      ;; debug: position 4949
                                                             ;; debug: position 4951
0x9c023ab31cf  1103  0f8d8d000000   jge 1250  (0x9c023ab3262)
                  ;;; <@294,#280> -------------------- B14 (unreachable/replaced) --------------------
                  ;;; <@298,#286> -------------------- B15 --------------------
                  ;;; <@300,#288> stack-check
0x9c023ab31d5  1109  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023ab31dc  1116  0f82da020000   jc 1852  (0x9c023ab34bc)
                  ;;; <@301,#288> gap
0x9c023ab31e2  1122  498bc1         REX.W movq rax,r9
                  ;;; <@302,#292> add-i
0x9c023ab31e5  1125  03c1           addl rax,rcx             ;; debug: position 4994
0x9c023ab31e7  1127  0f8037040000   jo 2212  (0x9c023ab3624)
                  ;;; <@304,#299> bounds-check
0x9c023ab31ed  1133  443bf0         cmpl r14,rax
0x9c023ab31f0  1136  0f8633040000   jna 2217  (0x9c023ab3629)
                  ;;; <@306,#300> load-keyed
0x9c023ab31f6  1142  418b0483       movl rax,[r11+rax*4]
0x9c023ab31fa  1146  85c0           testl rax,rax
0x9c023ab31fc  1148  0f882c040000   js 2222  (0x9c023ab362e)
                  ;;; <@307,#300> gap
0x9c023ab3202  1154  4c8bc6         REX.W movq r8,rsi
                  ;;; <@308,#304> add-i
0x9c023ab3205  1157  4403c1         addl r8,rcx              ;; debug: position 5009
0x9c023ab3208  1160  0f8025040000   jo 2227  (0x9c023ab3633)
                  ;;; <@310,#311> bounds-check
0x9c023ab320e  1166  453bf0         cmpl r14,r8
0x9c023ab3211  1169  0f8621040000   jna 2232  (0x9c023ab3638)
                  ;;; <@312,#312> load-keyed
0x9c023ab3217  1175  478b0483       movl r8,[r11+r8*4]
0x9c023ab321b  1179  4585c0         testl r8,r8
0x9c023ab321e  1182  0f8819040000   js 2237  (0x9c023ab363d)
                  ;;; <@314,#313> add-i
0x9c023ab3224  1188  4403c0         addl r8,rax              ;; debug: position 4999
0x9c023ab3227  1191  0f8015040000   jo 2242  (0x9c023ab3642)
                  ;;; <@316,#316> add-i
0x9c023ab322d  1197  440345c0       addl r8,[rbp-0x40]       ;; debug: position 5014
                  ;;; <@317,#316> gap
0x9c023ab3231  1201  488bc7         REX.W movq rax,rdi
                  ;;; <@318,#322> add-i
0x9c023ab3234  1204  03c1           addl rax,rcx             ;; debug: position 5036
0x9c023ab3236  1206  0f800b040000   jo 2247  (0x9c023ab3647)
                  ;;; <@319,#322> gap
0x9c023ab323c  1212  498bd0         REX.W movq rdx,r8
                  ;;; <@320,#326> bit-i
0x9c023ab323f  1215  81e2ffffff03   andl rdx,0x3ffffff       ;; debug: position 5051
                  ;;; <@322,#337> bounds-check
0x9c023ab3245  1221  443bf0         cmpl r14,rax
0x9c023ab3248  1224  0f86fe030000   jna 2252  (0x9c023ab364c)
                  ;;; <@324,#338> store-keyed
0x9c023ab324e  1230  41891483       movl [r11+rax*4],rdx
                  ;;; <@326,#342> shift-i
0x9c023ab3252  1234  41c1e81a       shrl r8,26               ;; debug: position 5085
                  ;;; <@328,#346> add-i
0x9c023ab3256  1238  83c101         addl rcx,0x1             ;; debug: position 4961
                  ;;; <@330,#349> gap
0x9c023ab3259  1241  4c8945c0       REX.W movq [rbp-0x40],r8
                  ;;; <@331,#349> goto
0x9c023ab325d  1245  e96affffff     jmp 1100  (0x9c023ab31cc)
                  ;;; <@332,#283> -------------------- B16 (unreachable/replaced) --------------------
                  ;;; <@336,#365> -------------------- B17 --------------------
                  ;;; <@338,#367> gap
0x9c023ab3262  1250  488b45c0       REX.W movq rax,[rbp-0x40]    ;; debug: position 5103
                  ;;; <@340,#368> -------------------- B18 (loop header) --------------------
                  ;;; <@343,#371> compare-numeric-and-branch
0x9c023ab3266  1254  3b4dc8         cmpl rcx,[rbp-0x38]      ;; debug: position 5111
                                                             ;; debug: position 5113
0x9c023ab3269  1257  0f8d5d000000   jge 1356  (0x9c023ab32cc)
                  ;;; <@344,#372> -------------------- B19 (unreachable/replaced) --------------------
                  ;;; <@348,#378> -------------------- B20 --------------------
                  ;;; <@350,#380> stack-check
0x9c023ab326f  1263  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023ab3276  1270  0f8281020000   jc 1917  (0x9c023ab34fd)
                  ;;; <@351,#380> gap
0x9c023ab327c  1276  488bd6         REX.W movq rdx,rsi
                  ;;; <@352,#384> add-i
0x9c023ab327f  1279  03d1           addl rdx,rcx             ;; debug: position 5156
0x9c023ab3281  1281  0f80ca030000   jo 2257  (0x9c023ab3651)
                  ;;; <@354,#391> bounds-check
0x9c023ab3287  1287  443bf2         cmpl r14,rdx
0x9c023ab328a  1290  0f86c6030000   jna 2262  (0x9c023ab3656)
                  ;;; <@356,#392> load-keyed
0x9c023ab3290  1296  418b1493       movl rdx,[r11+rdx*4]
0x9c023ab3294  1300  85d2           testl rdx,rdx
0x9c023ab3296  1302  0f88bf030000   js 2267  (0x9c023ab365b)
                  ;;; <@358,#394> add-i
0x9c023ab329c  1308  03d0           addl rdx,rax             ;; debug: position 5161
                  ;;; <@359,#394> gap
0x9c023ab329e  1310  4c8bc7         REX.W movq r8,rdi
                  ;;; <@360,#400> add-i
0x9c023ab32a1  1313  4403c1         addl r8,rcx              ;; debug: position 5183
0x9c023ab32a4  1316  0f80b6030000   jo 2272  (0x9c023ab3660)
                  ;;; <@361,#400> gap
0x9c023ab32aa  1322  4c8bca         REX.W movq r9,rdx
                  ;;; <@362,#404> bit-i
0x9c023ab32ad  1325  4181e1ffffff03 andl r9,0x3ffffff        ;; debug: position 5198
                  ;;; <@364,#415> bounds-check
0x9c023ab32b4  1332  453bf0         cmpl r14,r8
0x9c023ab32b7  1335  0f86a8030000   jna 2277  (0x9c023ab3665)
                  ;;; <@366,#416> store-keyed
0x9c023ab32bd  1341  47890c83       movl [r11+r8*4],r9
                  ;;; <@368,#420> shift-i
0x9c023ab32c1  1345  c1ea1a         shrl rdx,26              ;; debug: position 5232
                  ;;; <@370,#424> add-i
0x9c023ab32c4  1348  83c101         addl rcx,0x1             ;; debug: position 5123
                  ;;; <@372,#427> gap
0x9c023ab32c7  1351  488bc2         REX.W movq rax,rdx
                  ;;; <@373,#427> goto
0x9c023ab32ca  1354  eb9a           jmp 1254  (0x9c023ab3266)
                  ;;; <@374,#375> -------------------- B21 (unreachable/replaced) --------------------
                  ;;; <@378,#428> -------------------- B22 --------------------
                  ;;; <@381,#430> branch
0x9c023ab32cc  1356  85c0           testl rax,rax            ;; debug: position 5255
0x9c023ab32ce  1358  0f8521000000   jnz 1397  (0x9c023ab32f5)
                  ;;; <@382,#434> -------------------- B23 (unreachable/replaced) --------------------
                  ;;; <@386,#462> -------------------- B24 --------------------
                  ;;; <@388,#472> bounds-check
0x9c023ab32d4  1364  443bf7         cmpl r14,rdi             ;; debug: position 5312
                                                             ;; debug: position 5328
0x9c023ab32d7  1367  0f868d030000   jna 2282  (0x9c023ab366a)
                  ;;; <@390,#473> load-keyed
0x9c023ab32dd  1373  418b04bb       movl rax,[r11+rdi*4]
0x9c023ab32e1  1377  85c0           testl rax,rax
0x9c023ab32e3  1379  0f8886030000   js 2287  (0x9c023ab366f)
                  ;;; <@392,#475> sub-i
0x9c023ab32e9  1385  83e801         subl rax,0x1             ;; debug: position 5332
                  ;;; <@394,#487> store-keyed
0x9c023ab32ec  1388  418904bb       movl [r11+rdi*4],rax
                  ;;; <@397,#492> goto
0x9c023ab32f0  1392  e905000000     jmp 1402  (0x9c023ab32fa)
                  ;;; <@398,#431> -------------------- B25 (unreachable/replaced) --------------------
                  ;;; <@402,#437> -------------------- B26 --------------------
                  ;;; <@404,#441> deoptimize
                  ;;; deoptimize: Insufficient type feedback for LHS of binary operation
0x9c023ab32f5  1397  e89a2fe5ff     call 0x9c023906294       ;; debug: position 5271
                                                             ;; debug: position 5279
                                                             ;; soft deoptimization bailout 66
                  ;;; <@406,#442> -------------------- B27 (unreachable/replaced) --------------------
                  ;;; <@410,#444> -------------------- B28 (unreachable/replaced) --------------------
                  ;;; <@420,#448> -------------------- B29 (unreachable/replaced) --------------------
                  ;;; <@432,#453> -------------------- B30 (unreachable/replaced) --------------------
                  ;;; <@436,#455> -------------------- B31 (unreachable/replaced) --------------------
                  ;;; <@448,#459> -------------------- B32 (unreachable/replaced) --------------------
                  ;;; <@462,#493> -------------------- B33 --------------------
                  ;;; <@463,#493> gap
0x9c023ab32fa  1402  488b45b0       REX.W movq rax,[rbp-0x50]    ;; debug: position 5354
                  ;;; <@464,#513> smi-tag
0x9c023ab32fe  1406  8bd8           movl rbx,rax
0x9c023ab3300  1408  48c1e320       REX.W shlq rbx,32
                  ;;; <@465,#513> gap
0x9c023ab3304  1412  488bc3         REX.W movq rax,rbx
                  ;;; <@466,#496> return
0x9c023ab3307  1415  488be5         REX.W movq rsp,rbp
0x9c023ab330a  1418  5d             pop rbp
0x9c023ab330b  1419  c21800         ret 0x18
                  ;;; <@32,#500> -------------------- Deferred tagged-to-i --------------------
0x9c023ab330e  1422  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 4541
0x9c023ab3312  1426  4c3956ff       REX.W cmpq [rsi-0x1],r10
0x9c023ab3316  1430  751d           jnz 1461  (0x9c023ab3335)
0x9c023ab3318  1432  f20f104607     movsd xmm0,[rsi+0x7]
0x9c023ab331d  1437  f20f2cf0       cvttsd2sil rsi,xmm0
0x9c023ab3321  1441  0f57c9         xorps xmm1,xmm1
0x9c023ab3324  1444  f20f2ace       cvtsi2sd xmm1,rsi
0x9c023ab3328  1448  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab332c  1452  7507           jnz 1461  (0x9c023ab3335)
                  Deferred TaggedToI: NaN
0x9c023ab332e  1454  7a05           jpe 1461  (0x9c023ab3335)
0x9c023ab3330  1456  e9bafaffff     jmp 111  (0x9c023ab2def)
0x9c023ab3335  1461  e8642fc5ff     call 0x9c02370629e       ;; deoptimization bailout 67
0x9c023ab333a  1466  e9b0faffff     jmp 111  (0x9c023ab2def)
                  ;;; <@52,#503> -------------------- Deferred tagged-to-i --------------------
0x9c023ab333f  1471  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 4557
0x9c023ab3343  1475  4d3951ff       REX.W cmpq [r9-0x1],r10
0x9c023ab3347  1479  7520           jnz 1513  (0x9c023ab3369)
0x9c023ab3349  1481  f2410f104107   movsd xmm0,[r9+0x7]
0x9c023ab334f  1487  f2440f2cc8     cvttsd2sil r9,xmm0
0x9c023ab3354  1492  0f57c9         xorps xmm1,xmm1
0x9c023ab3357  1495  f2410f2ac9     cvtsi2sd xmm1,r9
0x9c023ab335c  1500  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab3360  1504  7507           jnz 1513  (0x9c023ab3369)
                  Deferred TaggedToI: NaN
0x9c023ab3362  1506  7a05           jpe 1513  (0x9c023ab3369)
0x9c023ab3364  1508  e9e8faffff     jmp 209  (0x9c023ab2e51)
0x9c023ab3369  1513  e83a2fc5ff     call 0x9c0237062a8       ;; deoptimization bailout 68
0x9c023ab336e  1518  e9defaffff     jmp 209  (0x9c023ab2e51)
                  ;;; <@108,#505> -------------------- Deferred tagged-to-i --------------------
0x9c023ab3373  1523  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2205
0x9c023ab3377  1527  4c3956ff       REX.W cmpq [rsi-0x1],r10
0x9c023ab337b  1531  751d           jnz 1562  (0x9c023ab339a)
0x9c023ab337d  1533  f20f104607     movsd xmm0,[rsi+0x7]
0x9c023ab3382  1538  f20f2cf0       cvttsd2sil rsi,xmm0
0x9c023ab3386  1542  0f57c9         xorps xmm1,xmm1
0x9c023ab3389  1545  f20f2ace       cvtsi2sd xmm1,rsi
0x9c023ab338d  1549  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab3391  1553  7507           jnz 1562  (0x9c023ab339a)
                  Deferred TaggedToI: NaN
0x9c023ab3393  1555  7a05           jpe 1562  (0x9c023ab339a)
0x9c023ab3395  1557  e9a8fbffff     jmp 450  (0x9c023ab2f42)
0x9c023ab339a  1562  e8132fc5ff     call 0x9c0237062b2       ;; deoptimization bailout 69
0x9c023ab339f  1567  e99efbffff     jmp 450  (0x9c023ab2f42)
                  ;;; <@150,#506> -------------------- Deferred tagged-to-i --------------------
0x9c023ab33a4  1572  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2258
0x9c023ab33a8  1576  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab33ac  1580  752a           jnz 1624  (0x9c023ab33d8)
0x9c023ab33ae  1582  f20f104007     movsd xmm0,[rax+0x7]
0x9c023ab33b3  1587  f20f2cc0       cvttsd2sil rax,xmm0
0x9c023ab33b7  1591  0f57c9         xorps xmm1,xmm1
0x9c023ab33ba  1594  f20f2ac8       cvtsi2sd xmm1,rax
0x9c023ab33be  1598  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab33c2  1602  7514           jnz 1624  (0x9c023ab33d8)
                  Deferred TaggedToI: NaN
0x9c023ab33c4  1604  7a12           jpe 1624  (0x9c023ab33d8)
0x9c023ab33c6  1606  85c0           testl rax,rax
0x9c023ab33c8  1608  7509           jnz 1619  (0x9c023ab33d3)
0x9c023ab33ca  1610  660f50c0       movmskpd rax,xmm0
0x9c023ab33ce  1614  83e001         andl rax,0x1
0x9c023ab33d1  1617  7505           jnz 1624  (0x9c023ab33d8)
0x9c023ab33d3  1619  e9bcfbffff     jmp 532  (0x9c023ab2f94)
0x9c023ab33d8  1624  e8df2ec5ff     call 0x9c0237062bc       ;; deoptimization bailout 70
0x9c023ab33dd  1629  e9b2fbffff     jmp 532  (0x9c023ab2f94)
                  ;;; <@164,#510> -------------------- Deferred tagged-to-i --------------------
0x9c023ab33e2  1634  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2394
0x9c023ab33e6  1638  4c3952ff       REX.W cmpq [rdx-0x1],r10
0x9c023ab33ea  1642  751d           jnz 1673  (0x9c023ab3409)
0x9c023ab33ec  1644  f20f104207     movsd xmm0,[rdx+0x7]
0x9c023ab33f1  1649  f20f2cd0       cvttsd2sil rdx,xmm0
0x9c023ab33f5  1653  0f57c9         xorps xmm1,xmm1
0x9c023ab33f8  1656  f20f2aca       cvtsi2sd xmm1,rdx
0x9c023ab33fc  1660  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab3400  1664  7507           jnz 1673  (0x9c023ab3409)
                  Deferred TaggedToI: NaN
0x9c023ab3402  1666  7a05           jpe 1673  (0x9c023ab3409)
0x9c023ab3404  1668  e9c6fbffff     jmp 591  (0x9c023ab2fcf)
0x9c023ab3409  1673  e8b82ec5ff     call 0x9c0237062c6       ;; deoptimization bailout 71
0x9c023ab340e  1678  e9bcfbffff     jmp 591  (0x9c023ab2fcf)
                  ;;; <@178,#512> -------------------- Deferred tagged-to-i --------------------
0x9c023ab3413  1683  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2484
0x9c023ab3417  1687  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab341b  1691  752a           jnz 1735  (0x9c023ab3447)
0x9c023ab341d  1693  f20f104007     movsd xmm0,[rax+0x7]
0x9c023ab3422  1698  f20f2cc0       cvttsd2sil rax,xmm0
0x9c023ab3426  1702  0f57c9         xorps xmm1,xmm1
0x9c023ab3429  1705  f20f2ac8       cvtsi2sd xmm1,rax
0x9c023ab342d  1709  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab3431  1713  7514           jnz 1735  (0x9c023ab3447)
                  Deferred TaggedToI: NaN
0x9c023ab3433  1715  7a12           jpe 1735  (0x9c023ab3447)
0x9c023ab3435  1717  85c0           testl rax,rax
0x9c023ab3437  1719  7509           jnz 1730  (0x9c023ab3442)
0x9c023ab3439  1721  660f50c0       movmskpd rax,xmm0
0x9c023ab343d  1725  83e001         andl rax,0x1
0x9c023ab3440  1728  7505           jnz 1735  (0x9c023ab3447)
0x9c023ab3442  1730  e9c2fbffff     jmp 649  (0x9c023ab3009)
0x9c023ab3447  1735  e8842ec5ff     call 0x9c0237062d0       ;; deoptimization bailout 72
0x9c023ab344c  1740  e9b8fbffff     jmp 649  (0x9c023ab3009)
                  ;;; <@210,#509> -------------------- Deferred tagged-to-i --------------------
0x9c023ab3451  1745  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2513
0x9c023ab3455  1749  4d3950ff       REX.W cmpq [r8-0x1],r10
0x9c023ab3459  1753  752b           jnz 1798  (0x9c023ab3486)
0x9c023ab345b  1755  f2410f104007   movsd xmm0,[r8+0x7]
0x9c023ab3461  1761  f24c0f2cc0     REX.W cvttsd2siq r8,xmm0
0x9c023ab3466  1766  4983f801       REX.W cmpq r8,0x1
0x9c023ab346a  1770  7112           jno 1790  (0x9c023ab347e)
0x9c023ab346c  1772  4883ec08       REX.W subq rsp,0x8
0x9c023ab3470  1776  f20f110424     movsd [rsp],xmm0
0x9c023ab3475  1781  e8c612f9ff     call 0x9c023a44740       ;; code: STUB, DoubleToIStub, minor: 266756
0x9c023ab347a  1786  4883c408       REX.W addq rsp,0x8
0x9c023ab347e  1790  458bc0         movl r8,r8
0x9c023ab3481  1793  e900fcffff     jmp 774  (0x9c023ab3086)
0x9c023ab3486  1798  4d3b45a8       REX.W cmpq r8,[r13-0x58]
0x9c023ab348a  1802  7508           jnz 1812  (0x9c023ab3494)
0x9c023ab348c  1804  4533c0         xorl r8,r8
0x9c023ab348f  1807  e9f2fbffff     jmp 774  (0x9c023ab3086)
0x9c023ab3494  1812  4d3b45c0       REX.W cmpq r8,[r13-0x40]
0x9c023ab3498  1816  750b           jnz 1829  (0x9c023ab34a5)
0x9c023ab349a  1818  41b801000000   movl r8,0x1
0x9c023ab34a0  1824  e9e1fbffff     jmp 774  (0x9c023ab3086)
0x9c023ab34a5  1829  4d3b45c8       REX.W cmpq r8,[r13-0x38]
                  Deferred TaggedToI: cannot truncate
0x9c023ab34a9  1833  0f85c5010000   jnz 2292  (0x9c023ab3674)
0x9c023ab34af  1839  4533c0         xorl r8,r8
0x9c023ab34b2  1842  e9cffbffff     jmp 774  (0x9c023ab3086)
0x9c023ab34b7  1847  e9cafbffff     jmp 774  (0x9c023ab3086)
                  ;;; <@300,#288> -------------------- Deferred stack-check --------------------
0x9c023ab34bc  1852  50             push rax                 ;; debug: position 4951
0x9c023ab34bd  1853  51             push rcx
0x9c023ab34be  1854  52             push rdx
0x9c023ab34bf  1855  53             push rbx
0x9c023ab34c0  1856  56             push rsi
0x9c023ab34c1  1857  57             push rdi
0x9c023ab34c2  1858  4150           push r8
0x9c023ab34c4  1860  4151           push r9
0x9c023ab34c6  1862  4153           push r11
0x9c023ab34c8  1864  4156           push r14
0x9c023ab34ca  1866  4157           push r15
0x9c023ab34cc  1868  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023ab34d1  1873  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023ab34d5  1877  33c0           xorl rax,rax
0x9c023ab34d7  1879  498d9d78f8e4fd REX.W leaq rbx,[r13-0x21b0788]
0x9c023ab34de  1886  e8dd2cf5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023ab34e3  1891  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023ab34e8  1896  415f           pop r15
0x9c023ab34ea  1898  415e           pop r14
0x9c023ab34ec  1900  415b           pop r11
0x9c023ab34ee  1902  4159           pop r9
0x9c023ab34f0  1904  4158           pop r8
0x9c023ab34f2  1906  5f             pop rdi
0x9c023ab34f3  1907  5e             pop rsi
0x9c023ab34f4  1908  5b             pop rbx
0x9c023ab34f5  1909  5a             pop rdx
0x9c023ab34f6  1910  59             pop rcx
0x9c023ab34f7  1911  58             pop rax
0x9c023ab34f8  1912  e9e5fcffff     jmp 1122  (0x9c023ab31e2)
                  ;;; <@350,#380> -------------------- Deferred stack-check --------------------
0x9c023ab34fd  1917  50             push rax                 ;; debug: position 5113
0x9c023ab34fe  1918  51             push rcx
0x9c023ab34ff  1919  52             push rdx
0x9c023ab3500  1920  53             push rbx
0x9c023ab3501  1921  56             push rsi
0x9c023ab3502  1922  57             push rdi
0x9c023ab3503  1923  4150           push r8
0x9c023ab3505  1925  4151           push r9
0x9c023ab3507  1927  4153           push r11
0x9c023ab3509  1929  4156           push r14
0x9c023ab350b  1931  4157           push r15
0x9c023ab350d  1933  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023ab3512  1938  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023ab3516  1942  33c0           xorl rax,rax
0x9c023ab3518  1944  498d9d78f8e4fd REX.W leaq rbx,[r13-0x21b0788]
0x9c023ab351f  1951  e89c2cf5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023ab3524  1956  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023ab3529  1961  415f           pop r15
0x9c023ab352b  1963  415e           pop r14
0x9c023ab352d  1965  415b           pop r11
0x9c023ab352f  1967  4159           pop r9
0x9c023ab3531  1969  4158           pop r8
0x9c023ab3533  1971  5f             pop rdi
0x9c023ab3534  1972  5e             pop rsi
0x9c023ab3535  1973  5b             pop rbx
0x9c023ab3536  1974  5a             pop rdx
0x9c023ab3537  1975  59             pop rcx
0x9c023ab3538  1976  58             pop rax
0x9c023ab3539  1977  e93efdffff     jmp 1276  (0x9c023ab327c)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x9c023ab353e  1982  e8c72ac5ff     call 0x9c02370600a       ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x9c023ab3543  1987  e8cc2ac5ff     call 0x9c023706014       ;; deoptimization bailout 2
                  ;;; jump table entry 2: deoptimization bailout 3.
0x9c023ab3548  1992  e8d12ac5ff     call 0x9c02370601e       ;; deoptimization bailout 3
                  ;;; jump table entry 3: deoptimization bailout 4.
0x9c023ab354d  1997  e8d62ac5ff     call 0x9c023706028       ;; deoptimization bailout 4
                  ;;; jump table entry 4: deoptimization bailout 5.
0x9c023ab3552  2002  e8db2ac5ff     call 0x9c023706032       ;; deoptimization bailout 5
                  ;;; jump table entry 5: deoptimization bailout 6.
0x9c023ab3557  2007  e8e02ac5ff     call 0x9c02370603c       ;; deoptimization bailout 6
                  ;;; jump table entry 6: deoptimization bailout 7.
0x9c023ab355c  2012  e8e52ac5ff     call 0x9c023706046       ;; deoptimization bailout 7
                  ;;; jump table entry 7: deoptimization bailout 8.
0x9c023ab3561  2017  e8ea2ac5ff     call 0x9c023706050       ;; deoptimization bailout 8
                  ;;; jump table entry 8: deoptimization bailout 9.
0x9c023ab3566  2022  e8ef2ac5ff     call 0x9c02370605a       ;; deoptimization bailout 9
                  ;;; jump table entry 9: deoptimization bailout 10.
0x9c023ab356b  2027  e8f42ac5ff     call 0x9c023706064       ;; deoptimization bailout 10
                  ;;; jump table entry 10: deoptimization bailout 11.
0x9c023ab3570  2032  e8f92ac5ff     call 0x9c02370606e       ;; deoptimization bailout 11
                  ;;; jump table entry 11: deoptimization bailout 12.
0x9c023ab3575  2037  e8fe2ac5ff     call 0x9c023706078       ;; deoptimization bailout 12
                  ;;; jump table entry 12: deoptimization bailout 13.
0x9c023ab357a  2042  e8032bc5ff     call 0x9c023706082       ;; deoptimization bailout 13
                  ;;; jump table entry 13: deoptimization bailout 14.
0x9c023ab357f  2047  e8082bc5ff     call 0x9c02370608c       ;; deoptimization bailout 14
                  ;;; jump table entry 14: deoptimization bailout 15.
0x9c023ab3584  2052  e80d2bc5ff     call 0x9c023706096       ;; deoptimization bailout 15
                  ;;; jump table entry 15: deoptimization bailout 16.
0x9c023ab3589  2057  e8122bc5ff     call 0x9c0237060a0       ;; deoptimization bailout 16
                  ;;; jump table entry 16: deoptimization bailout 17.
0x9c023ab358e  2062  e8172bc5ff     call 0x9c0237060aa       ;; deoptimization bailout 17
                  ;;; jump table entry 17: deoptimization bailout 18.
0x9c023ab3593  2067  e81c2bc5ff     call 0x9c0237060b4       ;; deoptimization bailout 18
                  ;;; jump table entry 18: deoptimization bailout 19.
0x9c023ab3598  2072  e8212bc5ff     call 0x9c0237060be       ;; deoptimization bailout 19
                  ;;; jump table entry 19: deoptimization bailout 20.
0x9c023ab359d  2077  e8262bc5ff     call 0x9c0237060c8       ;; deoptimization bailout 20
                  ;;; jump table entry 20: deoptimization bailout 21.
0x9c023ab35a2  2082  e82b2bc5ff     call 0x9c0237060d2       ;; deoptimization bailout 21
                  ;;; jump table entry 21: deoptimization bailout 22.
0x9c023ab35a7  2087  e8302bc5ff     call 0x9c0237060dc       ;; deoptimization bailout 22
                  ;;; jump table entry 22: deoptimization bailout 24.
0x9c023ab35ac  2092  e83f2bc5ff     call 0x9c0237060f0       ;; deoptimization bailout 24
                  ;;; jump table entry 23: deoptimization bailout 25.
0x9c023ab35b1  2097  e8442bc5ff     call 0x9c0237060fa       ;; deoptimization bailout 25
                  ;;; jump table entry 24: deoptimization bailout 26.
0x9c023ab35b6  2102  e8492bc5ff     call 0x9c023706104       ;; deoptimization bailout 26
                  ;;; jump table entry 25: deoptimization bailout 27.
0x9c023ab35bb  2107  e84e2bc5ff     call 0x9c02370610e       ;; deoptimization bailout 27
                  ;;; jump table entry 26: deoptimization bailout 28.
0x9c023ab35c0  2112  e8532bc5ff     call 0x9c023706118       ;; deoptimization bailout 28
                  ;;; jump table entry 27: deoptimization bailout 29.
0x9c023ab35c5  2117  e8582bc5ff     call 0x9c023706122       ;; deoptimization bailout 29
                  ;;; jump table entry 28: deoptimization bailout 30.
0x9c023ab35ca  2122  e85d2bc5ff     call 0x9c02370612c       ;; deoptimization bailout 30
                  ;;; jump table entry 29: deoptimization bailout 31.
0x9c023ab35cf  2127  e8622bc5ff     call 0x9c023706136       ;; deoptimization bailout 31
                  ;;; jump table entry 30: deoptimization bailout 32.
0x9c023ab35d4  2132  e8672bc5ff     call 0x9c023706140       ;; deoptimization bailout 32
                  ;;; jump table entry 31: deoptimization bailout 33.
0x9c023ab35d9  2137  e86c2bc5ff     call 0x9c02370614a       ;; deoptimization bailout 33
                  ;;; jump table entry 32: deoptimization bailout 34.
0x9c023ab35de  2142  e8712bc5ff     call 0x9c023706154       ;; deoptimization bailout 34
                  ;;; jump table entry 33: deoptimization bailout 35.
0x9c023ab35e3  2147  e8762bc5ff     call 0x9c02370615e       ;; deoptimization bailout 35
                  ;;; jump table entry 34: deoptimization bailout 36.
0x9c023ab35e8  2152  e87b2bc5ff     call 0x9c023706168       ;; deoptimization bailout 36
                  ;;; jump table entry 35: deoptimization bailout 37.
0x9c023ab35ed  2157  e8802bc5ff     call 0x9c023706172       ;; deoptimization bailout 37
                  ;;; jump table entry 36: deoptimization bailout 38.
0x9c023ab35f2  2162  e8852bc5ff     call 0x9c02370617c       ;; deoptimization bailout 38
                  ;;; jump table entry 37: deoptimization bailout 39.
0x9c023ab35f7  2167  e88a2bc5ff     call 0x9c023706186       ;; deoptimization bailout 39
                  ;;; jump table entry 38: deoptimization bailout 40.
0x9c023ab35fc  2172  e88f2bc5ff     call 0x9c023706190       ;; deoptimization bailout 40
                  ;;; jump table entry 39: deoptimization bailout 41.
0x9c023ab3601  2177  e8942bc5ff     call 0x9c02370619a       ;; deoptimization bailout 41
                  ;;; jump table entry 40: deoptimization bailout 42.
0x9c023ab3606  2182  e8992bc5ff     call 0x9c0237061a4       ;; deoptimization bailout 42
                  ;;; jump table entry 41: deoptimization bailout 43.
0x9c023ab360b  2187  e89e2bc5ff     call 0x9c0237061ae       ;; deoptimization bailout 43
                  ;;; jump table entry 42: deoptimization bailout 44.
0x9c023ab3610  2192  e8a32bc5ff     call 0x9c0237061b8       ;; deoptimization bailout 44
                  ;;; jump table entry 43: deoptimization bailout 45.
0x9c023ab3615  2197  e8a82bc5ff     call 0x9c0237061c2       ;; deoptimization bailout 45
                  ;;; jump table entry 44: deoptimization bailout 46.
0x9c023ab361a  2202  e8ad2bc5ff     call 0x9c0237061cc       ;; deoptimization bailout 46
                  ;;; jump table entry 45: deoptimization bailout 47.
0x9c023ab361f  2207  e8b22bc5ff     call 0x9c0237061d6       ;; deoptimization bailout 47
                  ;;; jump table entry 46: deoptimization bailout 49.
0x9c023ab3624  2212  e8c12bc5ff     call 0x9c0237061ea       ;; deoptimization bailout 49
                  ;;; jump table entry 47: deoptimization bailout 50.
0x9c023ab3629  2217  e8c62bc5ff     call 0x9c0237061f4       ;; deoptimization bailout 50
                  ;;; jump table entry 48: deoptimization bailout 51.
0x9c023ab362e  2222  e8cb2bc5ff     call 0x9c0237061fe       ;; deoptimization bailout 51
                  ;;; jump table entry 49: deoptimization bailout 52.
0x9c023ab3633  2227  e8d02bc5ff     call 0x9c023706208       ;; deoptimization bailout 52
                  ;;; jump table entry 50: deoptimization bailout 53.
0x9c023ab3638  2232  e8d52bc5ff     call 0x9c023706212       ;; deoptimization bailout 53
                  ;;; jump table entry 51: deoptimization bailout 54.
0x9c023ab363d  2237  e8da2bc5ff     call 0x9c02370621c       ;; deoptimization bailout 54
                  ;;; jump table entry 52: deoptimization bailout 55.
0x9c023ab3642  2242  e8df2bc5ff     call 0x9c023706226       ;; deoptimization bailout 55
                  ;;; jump table entry 53: deoptimization bailout 56.
0x9c023ab3647  2247  e8e42bc5ff     call 0x9c023706230       ;; deoptimization bailout 56
                  ;;; jump table entry 54: deoptimization bailout 57.
0x9c023ab364c  2252  e8e92bc5ff     call 0x9c02370623a       ;; deoptimization bailout 57
                  ;;; jump table entry 55: deoptimization bailout 59.
0x9c023ab3651  2257  e8f82bc5ff     call 0x9c02370624e       ;; deoptimization bailout 59
                  ;;; jump table entry 56: deoptimization bailout 60.
0x9c023ab3656  2262  e8fd2bc5ff     call 0x9c023706258       ;; deoptimization bailout 60
                  ;;; jump table entry 57: deoptimization bailout 61.
0x9c023ab365b  2267  e8022cc5ff     call 0x9c023706262       ;; deoptimization bailout 61
                  ;;; jump table entry 58: deoptimization bailout 62.
0x9c023ab3660  2272  e8072cc5ff     call 0x9c02370626c       ;; deoptimization bailout 62
                  ;;; jump table entry 59: deoptimization bailout 63.
0x9c023ab3665  2277  e80c2cc5ff     call 0x9c023706276       ;; deoptimization bailout 63
                  ;;; jump table entry 60: deoptimization bailout 64.
0x9c023ab366a  2282  e8112cc5ff     call 0x9c023706280       ;; deoptimization bailout 64
                  ;;; jump table entry 61: deoptimization bailout 65.
0x9c023ab366f  2287  e8162cc5ff     call 0x9c02370628a       ;; deoptimization bailout 65
                  ;;; jump table entry 62: deoptimization bailout 73.
0x9c023ab3674  2292  e8612cc5ff     call 0x9c0237062da       ;; deoptimization bailout 73
0x9c023ab3679  2297  0f1f00         nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 74)
 index  ast id    argc     pc             
     0       3       0     35
     1       3       0     -1
     2       3       0     -1
     3       3       0     -1
     4       3       0     -1
     5       3       0     -1
     6       3       0     -1
     7       3       0     -1
     8       3       0     -1
     9       3       0     -1
    10       3       0     -1
    11       3       0     -1
    12       3       0     -1
    13      57       0     -1
    14      57       0     -1
    15      57       0     -1
    16      57       0     -1
    17      57       0     -1
    18      57       0     -1
    19      57       0     -1
    20      57       0     -1
    21      57       0     -1
    22     110       0     -1
    23      16       0    506
    24      19       0     -1
    25      28       0     -1
    26      54       0     -1
    27      63       0     -1
    28      63       0     -1
    29      63       0     -1
    30      81       0     -1
    31      81       0     -1
    32      81       0     -1
    33     126       0     -1
    34     126       0     -1
    35     126       0     -1
    36     126       0     -1
    37     126       0     -1
    38     156       0     -1
    39     156       0     -1
    40     156       0     -1
    41     166       0     -1
    42     166       0     -1
    43     166       0     -1
    44     188       0     -1
    45     188       0     -1
    46     188       0     -1
    47     188       0     -1
    48     258       0   1122
    49     258       0     -1
    50     258       0     -1
    51     258       0     -1
    52     258       0     -1
    53     258       0     -1
    54     258       0     -1
    55     258       0     -1
    56     258       0     -1
    57     258       0     -1
    58     348       0   1276
    59     348       0     -1
    60     348       0     -1
    61     348       0     -1
    62     348       0     -1
    63     348       0     -1
    64     469       0     -1
    65     469       0     -1
    66     468       0     -1
    67       3       0     -1
    68       3       0     -1
    69       2       0     -1
    70      19       0     -1
    71      28       0     -1
    72      54       0     -1
    73      63       0     -1

Safepoints (size = 56)
0x9c023ab2da3    35  000000001 (sp -> fp)       0
0x9c023ab2f7a   506  001000001 (sp -> fp)      23
0x9c023ab34e3  1891  100000001 (sp -> fp)      48
0x9c023ab3524  1956  100000001 (sp -> fp)      58

RelocInfo (size = 4041)
0x9c023ab2d8a  position  (4513)
0x9c023ab2d8a  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x9c023ab2d8a  comment  (;;; <@2,#1> context)
0x9c023ab2d8e  comment  (;;; <@3,#1> gap)
0x9c023ab2d92  comment  (;;; <@12,#9> -------------------- B1 --------------------)
0x9c023ab2d92  comment  (;;; <@13,#9> gap)
0x9c023ab2d95  comment  (;;; <@14,#11> stack-check)
0x9c023ab2d9f  code target (BUILTIN)  (0x9c023a25e60)
0x9c023ab2da3  comment  (;;; <@16,#11> lazy-bailout)
0x9c023ab2da3  comment  (;;; <@17,#11> gap)
0x9c023ab2da7  comment  (;;; <@18,#12> load-context-slot)
0x9c023ab2da7  position  (4531)
0x9c023ab2dae  comment  (;;; <@20,#13> load-context-slot)
0x9c023ab2dae  position  (4536)
0x9c023ab2db5  comment  (;;; <@22,#15> check-non-smi)
0x9c023ab2db5  position  (4541)
0x9c023ab2dbe  comment  (;;; <@24,#16> check-maps)
0x9c023ab2dc0  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab2dd2  comment  (;;; <@26,#17> load-named-field)
0x9c023ab2dd6  comment  (;;; <@28,#18> load-named-field)
0x9c023ab2dd9  comment  (;;; <@30,#19> load-named-field)
0x9c023ab2ddd  comment  (;;; <@31,#19> gap)
0x9c023ab2de1  comment  (;;; <@32,#500> tagged-to-i)
0x9c023ab2def  comment  (;;; <@34,#20> bounds-check)
0x9c023ab2df7  comment  (;;; <@36,#21> load-keyed)
0x9c023ab2e02  comment  (;;; <@38,#22> check-non-smi)
0x9c023ab2e0b  comment  (;;; <@40,#23> check-maps)
0x9c023ab2e0d  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab2e1f  comment  (;;; <@42,#24> load-named-field)
0x9c023ab2e23  comment  (;;; <@44,#25> load-named-field)
0x9c023ab2e27  comment  (;;; <@46,#26> load-named-field)
0x9c023ab2e2b  comment  (;;; <@48,#27> bounds-check)
0x9c023ab2e34  comment  (;;; <@50,#28> load-keyed)
0x9c023ab2e3f  comment  (;;; <@51,#28> gap)
0x9c023ab2e43  comment  (;;; <@52,#503> tagged-to-i)
0x9c023ab2e43  position  (4557)
0x9c023ab2e51  comment  (;;; <@54,#36> bounds-check)
0x9c023ab2e5a  comment  (;;; <@56,#37> load-keyed)
0x9c023ab2e67  comment  (;;; <@58,#43> bounds-check)
0x9c023ab2e70  comment  (;;; <@60,#44> load-keyed)
0x9c023ab2e7d  position  (4545)
0x9c023ab2e7d  comment  (;;; <@63,#45> compare-numeric-and-branch)
0x9c023ab2e86  comment  (;;; <@64,#49> -------------------- B2 (unreachable/replaced) --------------------)
0x9c023ab2e86  position  (4603)
0x9c023ab2e86  comment  (;;; <@68,#57> -------------------- B3 --------------------)
0x9c023ab2e86  comment  (;;; <@70,#59> gap)
0x9c023ab2e89  comment  (;;; <@71,#59> goto)
0x9c023ab2e8e  comment  (;;; <@72,#46> -------------------- B4 (unreachable/replaced) --------------------)
0x9c023ab2e8e  position  (4579)
0x9c023ab2e8e  comment  (;;; <@76,#52> -------------------- B5 --------------------)
0x9c023ab2e8e  comment  (;;; <@78,#56> gap)
0x9c023ab2e8e  position  (4603)
0x9c023ab2e94  position  (4629)
0x9c023ab2e94  comment  (;;; <@80,#63> -------------------- B6 --------------------)
0x9c023ab2e9c  comment  (;;; <@82,#71> bounds-check)
0x9c023ab2e9c  position  (4639)
0x9c023ab2ea5  comment  (;;; <@84,#72> load-keyed)
0x9c023ab2eb1  comment  (;;; <@86,#78> bounds-check)
0x9c023ab2eba  comment  (;;; <@88,#79> load-keyed)
0x9c023ab2ec7  comment  (;;; <@89,#79> gap)
0x9c023ab2ecb  comment  (;;; <@90,#88> bounds-check)
0x9c023ab2ecb  position  (4670)
0x9c023ab2ed4  comment  (;;; <@92,#89> load-keyed)
0x9c023ab2ee0  comment  (;;; <@94,#95> bounds-check)
0x9c023ab2ee9  comment  (;;; <@96,#96> load-keyed)
0x9c023ab2ef4  comment  (;;; <@97,#96> gap)
0x9c023ab2efb  comment  (;;; <@98,#100> add-i)
0x9c023ab2efb  position  (4699)
0x9c023ab2f04  comment  (;;; <@99,#100> gap)
0x9c023ab2f08  comment  (;;; <@100,#103> load-context-slot)
0x9c023ab2f08  position  (4715)
0x9c023ab2f0f  comment  (;;; <@101,#103> gap)
0x9c023ab2f13  comment  (;;; <@102,#104> check-value)
0x9c023ab2f15  embedded object  (0x364e0635fca1 <JS Function alloc (SharedFunctionInfo 0xc1217b4f389)>)
0x9c023ab2f26  comment  (;;; <@104,#107> constant-t)
0x9c023ab2f26  position  (2106)
0x9c023ab2f28  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab2f30  comment  (;;; <@106,#110> load-context-slot)
0x9c023ab2f30  position  (2205)
0x9c023ab2f34  comment  (;;; <@108,#505> tagged-to-i)
0x9c023ab2f42  position  (2203)
0x9c023ab2f42  comment  (;;; <@111,#111> compare-numeric-and-branch)
0x9c023ab2f4a  comment  (;;; <@112,#115> -------------------- B7 (unreachable/replaced) --------------------)
0x9c023ab2f4a  comment  (;;; <@116,#126> -------------------- B8 (unreachable/replaced) --------------------)
0x9c023ab2f4a  comment  (;;; <@120,#112> -------------------- B9 (unreachable/replaced) --------------------)
0x9c023ab2f4a  position  (2229)
0x9c023ab2f4a  comment  (;;; <@124,#118> -------------------- B10 --------------------)
0x9c023ab2f4a  comment  (;;; <@126,#107> constant-t)
0x9c023ab2f4a  position  (2106)
0x9c023ab2f4c  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab2f54  comment  (;;; <@128,#119> load-context-slot)
0x9c023ab2f54  position  (2229)
0x9c023ab2f58  comment  (;;; <@130,#120> push-argument)
0x9c023ab2f58  position  (2236)
0x9c023ab2f5a  embedded object  (0x364e06304121 <undefined>)
0x9c023ab2f64  comment  (;;; <@132,#504> smi-tag)
0x9c023ab2f6a  comment  (;;; <@134,#121> push-argument)
0x9c023ab2f6b  comment  (;;; <@136,#107> constant-t)
0x9c023ab2f6b  position  (2106)
0x9c023ab2f6d  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab2f75  comment  (;;; <@138,#122> call-function)
0x9c023ab2f75  position  (2236)
0x9c023ab2f76  code target (STUB)  (0x9c023a28d20)
0x9c023ab2f7a  comment  (;;; <@140,#123> lazy-bailout)
0x9c023ab2f7a  position  (2258)
0x9c023ab2f7a  comment  (;;; <@144,#129> -------------------- B11 --------------------)
0x9c023ab2f7a  comment  (;;; <@146,#107> constant-t)
0x9c023ab2f7a  position  (2106)
0x9c023ab2f7c  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab2f84  comment  (;;; <@148,#130> load-context-slot)
0x9c023ab2f84  position  (2258)
0x9c023ab2f88  comment  (;;; <@150,#506> tagged-to-i)
0x9c023ab2f94  comment  (;;; <@152,#131> sub-i)
0x9c023ab2f94  position  (2271)
0x9c023ab2f9d  comment  (;;; <@154,#507> smi-tag)
0x9c023ab2fa3  comment  (;;; <@156,#107> constant-t)
0x9c023ab2fa3  position  (2106)
0x9c023ab2fa5  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab2fad  comment  (;;; <@158,#133> store-context-slot)
0x9c023ab2fad  position  (2271)
0x9c023ab2fb1  comment  (;;; <@160,#107> constant-t)
0x9c023ab2fb1  position  (2106)
0x9c023ab2fb3  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab2fbb  comment  (;;; <@162,#135> load-context-slot)
0x9c023ab2fbb  position  (2378)
0x9c023ab2fbf  comment  (;;; <@163,#135> gap)
0x9c023ab2fc2  comment  (;;; <@164,#510> tagged-to-i)
0x9c023ab2fc2  position  (2394)
0x9c023ab2fcf  comment  (;;; <@165,#510> gap)
0x9c023ab2fd2  comment  (;;; <@166,#138> add-i)
0x9c023ab2fd2  position  (2398)
0x9c023ab2fdb  comment  (;;; <@168,#511> smi-tag)
0x9c023ab2fe1  comment  (;;; <@170,#107> constant-t)
0x9c023ab2fe1  position  (2106)
0x9c023ab2fe3  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab2feb  comment  (;;; <@172,#140> store-context-slot)
0x9c023ab2feb  position  (2398)
0x9c023ab2fef  comment  (;;; <@174,#107> constant-t)
0x9c023ab2fef  position  (2106)
0x9c023ab2ff1  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab2ff9  comment  (;;; <@176,#142> load-context-slot)
0x9c023ab2ff9  position  (2484)
0x9c023ab2ffd  comment  (;;; <@178,#512> tagged-to-i)
0x9c023ab3009  comment  (;;; <@179,#512> gap)
0x9c023ab3010  comment  (;;; <@180,#145> add-i)
0x9c023ab3019  comment  (;;; <@182,#514> smi-tag)
0x9c023ab301f  comment  (;;; <@184,#107> constant-t)
0x9c023ab301f  position  (2106)
0x9c023ab3021  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab3029  comment  (;;; <@186,#146> store-context-slot)
0x9c023ab3029  position  (2484)
0x9c023ab302d  comment  (;;; <@188,#107> constant-t)
0x9c023ab302d  position  (2106)
0x9c023ab302f  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab3037  comment  (;;; <@190,#149> load-named-field)
0x9c023ab3037  position  (2497)
0x9c023ab303b  comment  (;;; <@192,#150> load-context-slot)
0x9c023ab3042  comment  (;;; <@194,#153> check-non-smi)
0x9c023ab3042  position  (2513)
0x9c023ab304c  comment  (;;; <@196,#154> check-maps)
0x9c023ab304e  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab3060  comment  (;;; <@198,#156> check-maps)
0x9c023ab3060  comment  (;;; <@200,#158> check-maps)
0x9c023ab3060  comment  (;;; <@202,#159> load-named-field)
0x9c023ab3064  comment  (;;; <@204,#160> load-named-field)
0x9c023ab3068  comment  (;;; <@206,#161> load-named-field)
0x9c023ab306c  comment  (;;; <@208,#162> bounds-check)
0x9c023ab3075  comment  (;;; <@209,#162> gap)
0x9c023ab3078  comment  (;;; <@210,#509> tagged-to-i)
0x9c023ab3086  comment  (;;; <@212,#163> store-keyed)
0x9c023ab308a  comment  (;;; <@214,#166> load-context-slot)
0x9c023ab308a  position  (2528)
0x9c023ab3091  comment  (;;; <@216,#168> check-non-smi)
0x9c023ab3091  position  (2545)
0x9c023ab309a  comment  (;;; <@218,#169> check-maps)
0x9c023ab309c  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab30ae  comment  (;;; <@220,#174> load-named-field)
0x9c023ab30b2  comment  (;;; <@222,#175> load-named-field)
0x9c023ab30b5  comment  (;;; <@224,#176> load-named-field)
0x9c023ab30b9  comment  (;;; <@226,#177> bounds-check)
0x9c023ab30c1  comment  (;;; <@227,#177> gap)
0x9c023ab30c5  comment  (;;; <@228,#178> store-keyed)
0x9c023ab30c8  position  (2565)
0x9c023ab30c8  position  (4721)
0x9c023ab30c8  comment  (;;; <@232,#184> -------------------- B12 --------------------)
0x9c023ab30c8  comment  (;;; <@233,#184> gap)
0x9c023ab30cc  comment  (;;; <@234,#186> load-context-slot)
0x9c023ab30cc  position  (4742)
0x9c023ab30d3  comment  (;;; <@236,#188> check-non-smi)
0x9c023ab30d3  position  (4747)
0x9c023ab30dc  comment  (;;; <@238,#189> check-maps)
0x9c023ab30de  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab30f0  comment  (;;; <@240,#190> load-named-field)
0x9c023ab30f4  comment  (;;; <@242,#191> load-named-field)
0x9c023ab30f7  comment  (;;; <@244,#192> load-named-field)
0x9c023ab30fb  comment  (;;; <@246,#193> bounds-check)
0x9c023ab3103  comment  (;;; <@248,#194> load-keyed)
0x9c023ab3111  comment  (;;; <@250,#196> load-context-slot)
0x9c023ab3111  position  (4754)
0x9c023ab3118  comment  (;;; <@251,#196> gap)
0x9c023ab311f  comment  (;;; <@252,#199> add-i)
0x9c023ab311f  position  (4762)
0x9c023ab3129  comment  (;;; <@254,#202> check-non-smi)
0x9c023ab3129  position  (4769)
0x9c023ab3133  comment  (;;; <@256,#203> check-maps)
0x9c023ab3135  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab3147  comment  (;;; <@258,#208> load-named-field)
0x9c023ab314b  comment  (;;; <@260,#209> load-named-field)
0x9c023ab314f  comment  (;;; <@262,#210> load-named-field)
0x9c023ab3153  comment  (;;; <@264,#211> bounds-check)
0x9c023ab315c  comment  (;;; <@266,#201> constant-i)
0x9c023ab315f  comment  (;;; <@268,#212> store-keyed)
0x9c023ab3164  comment  (;;; <@269,#212> gap)
0x9c023ab3167  comment  (;;; <@270,#217> add-i)
0x9c023ab3167  position  (4799)
0x9c023ab3170  comment  (;;; <@271,#217> gap)
0x9c023ab3173  comment  (;;; <@272,#220> sub-i)
0x9c023ab3173  position  (4808)
0x9c023ab317d  comment  (;;; <@274,#232> bounds-check)
0x9c023ab317d  position  (4815)
0x9c023ab3186  comment  (;;; <@276,#201> constant-i)
0x9c023ab3186  position  (4769)
0x9c023ab3189  comment  (;;; <@278,#233> store-keyed)
0x9c023ab3189  position  (4815)
0x9c023ab318d  comment  (;;; <@279,#233> gap)
0x9c023ab3191  comment  (;;; <@280,#241> bounds-check)
0x9c023ab3191  position  (4864)
0x9c023ab3199  comment  (;;; <@282,#242> load-keyed)
0x9c023ab31a6  comment  (;;; <@283,#242> gap)
0x9c023ab31aa  comment  (;;; <@284,#250> bounds-check)
0x9c023ab31aa  position  (4885)
0x9c023ab31b3  comment  (;;; <@286,#251> load-keyed)
0x9c023ab31bf  comment  (;;; <@288,#275> gap)
0x9c023ab31bf  position  (4946)
0x9c023ab31cc  position  (4949)
0x9c023ab31cc  comment  (;;; <@290,#276> -------------------- B13 (loop header) --------------------)
0x9c023ab31cc  position  (4951)
0x9c023ab31cc  comment  (;;; <@293,#279> compare-numeric-and-branch)
0x9c023ab31d5  comment  (;;; <@294,#280> -------------------- B14 (unreachable/replaced) --------------------)
0x9c023ab31d5  comment  (;;; <@298,#286> -------------------- B15 --------------------)
0x9c023ab31d5  comment  (;;; <@300,#288> stack-check)
0x9c023ab31e2  comment  (;;; <@301,#288> gap)
0x9c023ab31e5  comment  (;;; <@302,#292> add-i)
0x9c023ab31e5  position  (4994)
0x9c023ab31ed  comment  (;;; <@304,#299> bounds-check)
0x9c023ab31f6  comment  (;;; <@306,#300> load-keyed)
0x9c023ab3202  comment  (;;; <@307,#300> gap)
0x9c023ab3205  comment  (;;; <@308,#304> add-i)
0x9c023ab3205  position  (5009)
0x9c023ab320e  comment  (;;; <@310,#311> bounds-check)
0x9c023ab3217  comment  (;;; <@312,#312> load-keyed)
0x9c023ab3224  comment  (;;; <@314,#313> add-i)
0x9c023ab3224  position  (4999)
0x9c023ab322d  comment  (;;; <@316,#316> add-i)
0x9c023ab322d  position  (5014)
0x9c023ab3231  comment  (;;; <@317,#316> gap)
0x9c023ab3234  comment  (;;; <@318,#322> add-i)
0x9c023ab3234  position  (5036)
0x9c023ab323c  comment  (;;; <@319,#322> gap)
0x9c023ab323f  comment  (;;; <@320,#326> bit-i)
0x9c023ab323f  position  (5051)
0x9c023ab3245  comment  (;;; <@322,#337> bounds-check)
0x9c023ab324e  comment  (;;; <@324,#338> store-keyed)
0x9c023ab3252  comment  (;;; <@326,#342> shift-i)
0x9c023ab3252  position  (5085)
0x9c023ab3256  comment  (;;; <@328,#346> add-i)
0x9c023ab3256  position  (4961)
0x9c023ab3259  comment  (;;; <@330,#349> gap)
0x9c023ab325d  comment  (;;; <@331,#349> goto)
0x9c023ab3262  comment  (;;; <@332,#283> -------------------- B16 (unreachable/replaced) --------------------)
0x9c023ab3262  position  (5103)
0x9c023ab3262  comment  (;;; <@336,#365> -------------------- B17 --------------------)
0x9c023ab3262  comment  (;;; <@338,#367> gap)
0x9c023ab3266  position  (5111)
0x9c023ab3266  comment  (;;; <@340,#368> -------------------- B18 (loop header) --------------------)
0x9c023ab3266  position  (5113)
0x9c023ab3266  comment  (;;; <@343,#371> compare-numeric-and-branch)
0x9c023ab326f  comment  (;;; <@344,#372> -------------------- B19 (unreachable/replaced) --------------------)
0x9c023ab326f  comment  (;;; <@348,#378> -------------------- B20 --------------------)
0x9c023ab326f  comment  (;;; <@350,#380> stack-check)
0x9c023ab327c  comment  (;;; <@351,#380> gap)
0x9c023ab327f  comment  (;;; <@352,#384> add-i)
0x9c023ab327f  position  (5156)
0x9c023ab3287  comment  (;;; <@354,#391> bounds-check)
0x9c023ab3290  comment  (;;; <@356,#392> load-keyed)
0x9c023ab329c  comment  (;;; <@358,#394> add-i)
0x9c023ab329c  position  (5161)
0x9c023ab329e  comment  (;;; <@359,#394> gap)
0x9c023ab32a1  comment  (;;; <@360,#400> add-i)
0x9c023ab32a1  position  (5183)
0x9c023ab32aa  comment  (;;; <@361,#400> gap)
0x9c023ab32ad  comment  (;;; <@362,#404> bit-i)
0x9c023ab32ad  position  (5198)
0x9c023ab32b4  comment  (;;; <@364,#415> bounds-check)
0x9c023ab32bd  comment  (;;; <@366,#416> store-keyed)
0x9c023ab32c1  comment  (;;; <@368,#420> shift-i)
0x9c023ab32c1  position  (5232)
0x9c023ab32c4  comment  (;;; <@370,#424> add-i)
0x9c023ab32c4  position  (5123)
0x9c023ab32c7  comment  (;;; <@372,#427> gap)
0x9c023ab32ca  comment  (;;; <@373,#427> goto)
0x9c023ab32cc  comment  (;;; <@374,#375> -------------------- B21 (unreachable/replaced) --------------------)
0x9c023ab32cc  position  (5255)
0x9c023ab32cc  comment  (;;; <@378,#428> -------------------- B22 --------------------)
0x9c023ab32cc  comment  (;;; <@381,#430> branch)
0x9c023ab32d4  comment  (;;; <@382,#434> -------------------- B23 (unreachable/replaced) --------------------)
0x9c023ab32d4  position  (5312)
0x9c023ab32d4  comment  (;;; <@386,#462> -------------------- B24 --------------------)
0x9c023ab32d4  comment  (;;; <@388,#472> bounds-check)
0x9c023ab32d4  position  (5328)
0x9c023ab32dd  comment  (;;; <@390,#473> load-keyed)
0x9c023ab32e9  comment  (;;; <@392,#475> sub-i)
0x9c023ab32e9  position  (5332)
0x9c023ab32ec  comment  (;;; <@394,#487> store-keyed)
0x9c023ab32f0  comment  (;;; <@397,#492> goto)
0x9c023ab32f5  comment  (;;; <@398,#431> -------------------- B25 (unreachable/replaced) --------------------)
0x9c023ab32f5  position  (5271)
0x9c023ab32f5  comment  (;;; <@402,#437> -------------------- B26 --------------------)
0x9c023ab32f5  comment  (;;; <@404,#441> deoptimize)
0x9c023ab32f5  position  (5279)
0x9c023ab32f5  comment  (;;; deoptimize: Insufficient type feedback for LHS of binary operation)
0x9c023ab32f6  runtime entry
0x9c023ab32fa  comment  (;;; <@406,#442> -------------------- B27 (unreachable/replaced) --------------------)
0x9c023ab32fa  comment  (;;; <@410,#444> -------------------- B28 (unreachable/replaced) --------------------)
0x9c023ab32fa  comment  (;;; <@420,#448> -------------------- B29 (unreachable/replaced) --------------------)
0x9c023ab32fa  comment  (;;; <@432,#453> -------------------- B30 (unreachable/replaced) --------------------)
0x9c023ab32fa  comment  (;;; <@436,#455> -------------------- B31 (unreachable/replaced) --------------------)
0x9c023ab32fa  comment  (;;; <@448,#459> -------------------- B32 (unreachable/replaced) --------------------)
0x9c023ab32fa  position  (5354)
0x9c023ab32fa  comment  (;;; <@462,#493> -------------------- B33 --------------------)
0x9c023ab32fa  comment  (;;; <@463,#493> gap)
0x9c023ab32fe  comment  (;;; <@464,#513> smi-tag)
0x9c023ab3304  comment  (;;; <@465,#513> gap)
0x9c023ab3307  comment  (;;; <@466,#496> return)
0x9c023ab330e  position  (4541)
0x9c023ab330e  comment  (;;; <@32,#500> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab332c  comment  (Deferred TaggedToI: lost precision)
0x9c023ab332e  comment  (Deferred TaggedToI: NaN)
0x9c023ab3336  runtime entry  (deoptimization bailout 67)
0x9c023ab333f  position  (4557)
0x9c023ab333f  comment  (;;; <@52,#503> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab3360  comment  (Deferred TaggedToI: lost precision)
0x9c023ab3362  comment  (Deferred TaggedToI: NaN)
0x9c023ab336a  runtime entry  (deoptimization bailout 68)
0x9c023ab3373  position  (2205)
0x9c023ab3373  comment  (;;; <@108,#505> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab3391  comment  (Deferred TaggedToI: lost precision)
0x9c023ab3393  comment  (Deferred TaggedToI: NaN)
0x9c023ab339b  runtime entry  (deoptimization bailout 69)
0x9c023ab33a4  position  (2258)
0x9c023ab33a4  comment  (;;; <@150,#506> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab33c2  comment  (Deferred TaggedToI: lost precision)
0x9c023ab33c4  comment  (Deferred TaggedToI: NaN)
0x9c023ab33d9  runtime entry  (deoptimization bailout 70)
0x9c023ab33e2  position  (2394)
0x9c023ab33e2  comment  (;;; <@164,#510> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab3400  comment  (Deferred TaggedToI: lost precision)
0x9c023ab3402  comment  (Deferred TaggedToI: NaN)
0x9c023ab340a  runtime entry  (deoptimization bailout 71)
0x9c023ab3413  position  (2484)
0x9c023ab3413  comment  (;;; <@178,#512> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab3431  comment  (Deferred TaggedToI: lost precision)
0x9c023ab3433  comment  (Deferred TaggedToI: NaN)
0x9c023ab3448  runtime entry  (deoptimization bailout 72)
0x9c023ab3451  position  (2513)
0x9c023ab3451  comment  (;;; <@210,#509> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab3476  code target (STUB)  (0x9c023a44740)
0x9c023ab34a9  comment  (Deferred TaggedToI: cannot truncate)
0x9c023ab34bc  position  (4951)
0x9c023ab34bc  comment  (;;; <@300,#288> -------------------- Deferred stack-check --------------------)
0x9c023ab34df  code target (STUB)  (0x9c023a061c0)
0x9c023ab34fd  position  (5113)
0x9c023ab34fd  comment  (;;; <@350,#380> -------------------- Deferred stack-check --------------------)
0x9c023ab3520  code target (STUB)  (0x9c023a061c0)
0x9c023ab353e  comment  (;;; -------------------- Jump table --------------------)
0x9c023ab353e  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x9c023ab353f  runtime entry  (deoptimization bailout 1)
0x9c023ab3543  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x9c023ab3544  runtime entry  (deoptimization bailout 2)
0x9c023ab3548  comment  (;;; jump table entry 2: deoptimization bailout 3.)
0x9c023ab3549  runtime entry  (deoptimization bailout 3)
0x9c023ab354d  comment  (;;; jump table entry 3: deoptimization bailout 4.)
0x9c023ab354e  runtime entry  (deoptimization bailout 4)
0x9c023ab3552  comment  (;;; jump table entry 4: deoptimization bailout 5.)
0x9c023ab3553  runtime entry  (deoptimization bailout 5)
0x9c023ab3557  comment  (;;; jump table entry 5: deoptimization bailout 6.)
0x9c023ab3558  runtime entry  (deoptimization bailout 6)
0x9c023ab355c  comment  (;;; jump table entry 6: deoptimization bailout 7.)
0x9c023ab355d  runtime entry  (deoptimization bailout 7)
0x9c023ab3561  comment  (;;; jump table entry 7: deoptimization bailout 8.)
0x9c023ab3562  runtime entry  (deoptimization bailout 8)
0x9c023ab3566  comment  (;;; jump table entry 8: deoptimization bailout 9.)
0x9c023ab3567  runtime entry  (deoptimization bailout 9)
0x9c023ab356b  comment  (;;; jump table entry 9: deoptimization bailout 10.)
0x9c023ab356c  runtime entry  (deoptimization bailout 10)
0x9c023ab3570  comment  (;;; jump table entry 10: deoptimization bailout 11.)
0x9c023ab3571  runtime entry  (deoptimization bailout 11)
0x9c023ab3575  comment  (;;; jump table entry 11: deoptimization bailout 12.)
0x9c023ab3576  runtime entry  (deoptimization bailout 12)
0x9c023ab357a  comment  (;;; jump table entry 12: deoptimization bailout 13.)
0x9c023ab357b  runtime entry  (deoptimization bailout 13)
0x9c023ab357f  comment  (;;; jump table entry 13: deoptimization bailout 14.)
0x9c023ab3580  runtime entry  (deoptimization bailout 14)
0x9c023ab3584  comment  (;;; jump table entry 14: deoptimization bailout 15.)
0x9c023ab3585  runtime entry  (deoptimization bailout 15)
0x9c023ab3589  comment  (;;; jump table entry 15: deoptimization bailout 16.)
0x9c023ab358a  runtime entry  (deoptimization bailout 16)
0x9c023ab358e  comment  (;;; jump table entry 16: deoptimization bailout 17.)
0x9c023ab358f  runtime entry  (deoptimization bailout 17)
0x9c023ab3593  comment  (;;; jump table entry 17: deoptimization bailout 18.)
0x9c023ab3594  runtime entry  (deoptimization bailout 18)
0x9c023ab3598  comment  (;;; jump table entry 18: deoptimization bailout 19.)
0x9c023ab3599  runtime entry  (deoptimization bailout 19)
0x9c023ab359d  comment  (;;; jump table entry 19: deoptimization bailout 20.)
0x9c023ab359e  runtime entry  (deoptimization bailout 20)
0x9c023ab35a2  comment  (;;; jump table entry 20: deoptimization bailout 21.)
0x9c023ab35a3  runtime entry  (deoptimization bailout 21)
0x9c023ab35a7  comment  (;;; jump table entry 21: deoptimization bailout 22.)
0x9c023ab35a8  runtime entry  (deoptimization bailout 22)
0x9c023ab35ac  comment  (;;; jump table entry 22: deoptimization bailout 24.)
0x9c023ab35ad  runtime entry  (deoptimization bailout 24)
0x9c023ab35b1  comment  (;;; jump table entry 23: deoptimization bailout 25.)
0x9c023ab35b2  runtime entry  (deoptimization bailout 25)
0x9c023ab35b6  comment  (;;; jump table entry 24: deoptimization bailout 26.)
0x9c023ab35b7  runtime entry  (deoptimization bailout 26)
0x9c023ab35bb  comment  (;;; jump table entry 25: deoptimization bailout 27.)
0x9c023ab35bc  runtime entry  (deoptimization bailout 27)
0x9c023ab35c0  comment  (;;; jump table entry 26: deoptimization bailout 28.)
0x9c023ab35c1  runtime entry  (deoptimization bailout 28)
0x9c023ab35c5  comment  (;;; jump table entry 27: deoptimization bailout 29.)
0x9c023ab35c6  runtime entry  (deoptimization bailout 29)
0x9c023ab35ca  comment  (;;; jump table entry 28: deoptimization bailout 30.)
0x9c023ab35cb  runtime entry  (deoptimization bailout 30)
0x9c023ab35cf  comment  (;;; jump table entry 29: deoptimization bailout 31.)
0x9c023ab35d0  runtime entry  (deoptimization bailout 31)
0x9c023ab35d4  comment  (;;; jump table entry 30: deoptimization bailout 32.)
0x9c023ab35d5  runtime entry  (deoptimization bailout 32)
0x9c023ab35d9  comment  (;;; jump table entry 31: deoptimization bailout 33.)
0x9c023ab35da  runtime entry  (deoptimization bailout 33)
0x9c023ab35de  comment  (;;; jump table entry 32: deoptimization bailout 34.)
0x9c023ab35df  runtime entry  (deoptimization bailout 34)
0x9c023ab35e3  comment  (;;; jump table entry 33: deoptimization bailout 35.)
0x9c023ab35e4  runtime entry  (deoptimization bailout 35)
0x9c023ab35e8  comment  (;;; jump table entry 34: deoptimization bailout 36.)
0x9c023ab35e9  runtime entry  (deoptimization bailout 36)
0x9c023ab35ed  comment  (;;; jump table entry 35: deoptimization bailout 37.)
0x9c023ab35ee  runtime entry  (deoptimization bailout 37)
0x9c023ab35f2  comment  (;;; jump table entry 36: deoptimization bailout 38.)
0x9c023ab35f3  runtime entry  (deoptimization bailout 38)
0x9c023ab35f7  comment  (;;; jump table entry 37: deoptimization bailout 39.)
0x9c023ab35f8  runtime entry  (deoptimization bailout 39)
0x9c023ab35fc  comment  (;;; jump table entry 38: deoptimization bailout 40.)
0x9c023ab35fd  runtime entry  (deoptimization bailout 40)
0x9c023ab3601  comment  (;;; jump table entry 39: deoptimization bailout 41.)
0x9c023ab3602  runtime entry  (deoptimization bailout 41)
0x9c023ab3606  comment  (;;; jump table entry 40: deoptimization bailout 42.)
0x9c023ab3607  runtime entry  (deoptimization bailout 42)
0x9c023ab360b  comment  (;;; jump table entry 41: deoptimization bailout 43.)
0x9c023ab360c  runtime entry  (deoptimization bailout 43)
0x9c023ab3610  comment  (;;; jump table entry 42: deoptimization bailout 44.)
0x9c023ab3611  runtime entry  (deoptimization bailout 44)
0x9c023ab3615  comment  (;;; jump table entry 43: deoptimization bailout 45.)
0x9c023ab3616  runtime entry  (deoptimization bailout 45)
0x9c023ab361a  comment  (;;; jump table entry 44: deoptimization bailout 46.)
0x9c023ab361b  runtime entry  (deoptimization bailout 46)
0x9c023ab361f  comment  (;;; jump table entry 45: deoptimization bailout 47.)
0x9c023ab3620  runtime entry  (deoptimization bailout 47)
0x9c023ab3624  comment  (;;; jump table entry 46: deoptimization bailout 49.)
0x9c023ab3625  runtime entry  (deoptimization bailout 49)
0x9c023ab3629  comment  (;;; jump table entry 47: deoptimization bailout 50.)
0x9c023ab362a  runtime entry  (deoptimization bailout 50)
0x9c023ab362e  comment  (;;; jump table entry 48: deoptimization bailout 51.)
0x9c023ab362f  runtime entry  (deoptimization bailout 51)
0x9c023ab3633  comment  (;;; jump table entry 49: deoptimization bailout 52.)
0x9c023ab3634  runtime entry  (deoptimization bailout 52)
0x9c023ab3638  comment  (;;; jump table entry 50: deoptimization bailout 53.)
0x9c023ab3639  runtime entry  (deoptimization bailout 53)
0x9c023ab363d  comment  (;;; jump table entry 51: deoptimization bailout 54.)
0x9c023ab363e  runtime entry  (deoptimization bailout 54)
0x9c023ab3642  comment  (;;; jump table entry 52: deoptimization bailout 55.)
0x9c023ab3643  runtime entry  (deoptimization bailout 55)
0x9c023ab3647  comment  (;;; jump table entry 53: deoptimization bailout 56.)
0x9c023ab3648  runtime entry  (deoptimization bailout 56)
0x9c023ab364c  comment  (;;; jump table entry 54: deoptimization bailout 57.)
0x9c023ab364d  runtime entry  (deoptimization bailout 57)
0x9c023ab3651  comment  (;;; jump table entry 55: deoptimization bailout 59.)
0x9c023ab3652  runtime entry  (deoptimization bailout 59)
0x9c023ab3656  comment  (;;; jump table entry 56: deoptimization bailout 60.)
0x9c023ab3657  runtime entry  (deoptimization bailout 60)
0x9c023ab365b  comment  (;;; jump table entry 57: deoptimization bailout 61.)
0x9c023ab365c  runtime entry  (deoptimization bailout 61)
0x9c023ab3660  comment  (;;; jump table entry 58: deoptimization bailout 62.)
0x9c023ab3661  runtime entry  (deoptimization bailout 62)
0x9c023ab3665  comment  (;;; jump table entry 59: deoptimization bailout 63.)
0x9c023ab3666  runtime entry  (deoptimization bailout 63)
0x9c023ab366a  comment  (;;; jump table entry 60: deoptimization bailout 64.)
0x9c023ab366b  runtime entry  (deoptimization bailout 64)
0x9c023ab366f  comment  (;;; jump table entry 61: deoptimization bailout 65.)
0x9c023ab3670  runtime entry  (deoptimization bailout 65)
0x9c023ab3674  comment  (;;; jump table entry 62: deoptimization bailout 73.)
0x9c023ab3675  runtime entry  (deoptimization bailout 73)
0x9c023ab367c  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (left_shift) id{7,0} ---
(I, n){
    if ( equal(I, zero) ) return zero
    var words = (n / 26) | 0
    var bits = n % 26
    var offset_bits = 26 - bits

    var size_i = heap[adrs[I]]

    // size of the returned bigint will be the size of the input + the number of words it will be
    // extended with
    // and depending on the most significant bigit's size 1 or 0 more
    var msdi = heap[adrs[I] + size_i - 1]
    var bits_word = ((msdi * pow(2,bits)) > 0x3ffffff ? 1 : 0)
    var R = alloc(size_i + words + bits_word)
    var Rp = adrs[R]
    heap[Rp + 1] = 0 // type integer

    var Ip = adrs[I]

    // clean possible garbage
    for ( var i = 2; i < words + 2; i++ ) {
      heap[Rp + i] = 0
    }

    if ( bits > 0 ) {
      var carry = 0
      for ( var j = 2; j < size_i; j++ ) {
        heap[Rp + words + j] = (carry + (heap[Ip + j] << bits)) & 0x3ffffff
        carry = heap[Ip + j] >>> offset_bits
      }
      heap[Rp + words + j] = carry

    } else {
      for ( var i = 2; i < size_i; i++ ) {
        heap[Rp + words + i] = heap[Ip + i]
      }
    }
    return R
  }

--- END ---
--- FUNCTION SOURCE (equal) id{7,1} ---
(A, B){
    if ( A === B ) return true
    var Ap = adrs[A]
    var size_a = heap[Ap]

    var Bp = adrs[B]
    var size_b = heap[Bp]

    if ( size_a !== size_b ) return false
    for ( var i = 1; i < size_a; i++ ) {
      if ( heap[Ap + i] !== heap[Bp + i] ) return false
    }
    return true
  }

--- END ---
INLINE (equal) id{7,1} AS 1 AT <0:17>
--- FUNCTION SOURCE (alloc) id{7,2} ---
(length){
      // there is no check for it but length has to be larger than 0
      if ( length > unallocated ) {
        extend(length)
      }
      unallocated -= length
      // save data index to data_idx and advance the break point with length
      var data_idx = brk
      brk = brk + length
      // save data_idx in address space and advance next
      var pointer = next++
      adrs[pointer] = data_idx
      heap[data_idx] = length
      return pointer
    }

--- END ---
INLINE (alloc) id{7,2} AS 2 AT <0:468>
--- Raw source ---
(I, n){
    if ( equal(I, zero) ) return zero
    var words = (n / 26) | 0
    var bits = n % 26
    var offset_bits = 26 - bits

    var size_i = heap[adrs[I]]

    // size of the returned bigint will be the size of the input + the number of words it will be
    // extended with
    // and depending on the most significant bigit's size 1 or 0 more
    var msdi = heap[adrs[I] + size_i - 1]
    var bits_word = ((msdi * pow(2,bits)) > 0x3ffffff ? 1 : 0)
    var R = alloc(size_i + words + bits_word)
    var Rp = adrs[R]
    heap[Rp + 1] = 0 // type integer

    var Ip = adrs[I]

    // clean possible garbage
    for ( var i = 2; i < words + 2; i++ ) {
      heap[Rp + i] = 0
    }

    if ( bits > 0 ) {
      var carry = 0
      for ( var j = 2; j < size_i; j++ ) {
        heap[Rp + words + j] = (carry + (heap[Ip + j] << bits)) & 0x3ffffff
        carry = heap[Ip + j] >>> offset_bits
      }
      heap[Rp + words + j] = carry

    } else {
      for ( var i = 2; i < size_i; i++ ) {
        heap[Rp + words + i] = heap[Ip + i]
      }
    }
    return R
  }


--- Optimized code ---
optimization_id = 7
source_position = 7487
kind = OPTIMIZED_FUNCTION
name = left_shift
stack_slots = 11
Instructions (size = 3036)
0x9c023ab4280     0  55             push rbp
0x9c023ab4281     1  4889e5         REX.W movq rbp,rsp
0x9c023ab4284     4  56             push rsi
0x9c023ab4285     5  57             push rdi
0x9c023ab4286     6  4883ec58       REX.W subq rsp,0x58
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x9c023ab428a    10  488b45f8       REX.W movq rax,[rbp-0x8]    ;; debug: position 7487
                  ;;; <@3,#1> gap
0x9c023ab428e    14  488945e8       REX.W movq [rbp-0x18],rax
                  ;;; <@12,#9> -------------------- B1 --------------------
                  ;;; <@13,#9> gap
0x9c023ab4292    18  488bf0         REX.W movq rsi,rax
                  ;;; <@14,#11> stack-check
0x9c023ab4295    21  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023ab429c    28  7305           jnc 35  (0x9c023ab42a3)
0x9c023ab429e    30  e8bd1bf7ff     call StackCheck  (0x9c023a25e60)    ;; code: BUILTIN
                  ;;; <@16,#11> lazy-bailout
                  ;;; <@17,#11> gap
0x9c023ab42a3    35  488b5de8       REX.W movq rbx,[rbp-0x18]
                  ;;; <@18,#12> load-context-slot
0x9c023ab42a7    39  488b8327010000 REX.W movq rax,[rbx+0x127]    ;; debug: position 7504
                  ;;; <@20,#13> check-value
0x9c023ab42ae    46  49baa1f635064e360000 REX.W movq r10,0x364e0635f6a1    ;; object: 0x364e0635f6a1 <JS Function equal (SharedFunctionInfo 0xc1217b4d9c9)>
0x9c023ab42b8    56  493bc2         REX.W cmpq rax,r10
0x9c023ab42bb    59  0f85f7090000   jnz 2616  (0x9c023ab4cb8)
                  ;;; <@22,#15> load-context-slot
0x9c023ab42c1    65  488b93b7000000 REX.W movq rdx,[rbx+0xb7]    ;; debug: position 7513
                  ;;; <@23,#15> gap
0x9c023ab42c8    72  488955e0       REX.W movq [rbp-0x20],rdx
0x9c023ab42cc    76  488b4d18       REX.W movq rcx,[rbp+0x18]
                  ;;; <@24,#707> check-smi
0x9c023ab42d0    80  f6c101         testb rcx,0x1            ;; debug: position 13101
0x9c023ab42d3    83  0f85e4090000   jnz 2621  (0x9c023ab4cbd)
                  ;;; <@25,#707> gap
0x9c023ab42d9    89  488bf2         REX.W movq rsi,rdx
                  ;;; <@26,#711> check-smi
0x9c023ab42dc    92  40f6c601       testb rsi,0x1            ;; debug: position 13107
0x9c023ab42e0    96  0f85dc090000   jnz 2626  (0x9c023ab4cc2)
                  ;;; <@29,#20> compare-numeric-and-branch
0x9c023ab42e6   102  483bce         REX.W cmpq rcx,rsi       ;; debug: position 13103
0x9c023ab42e9   105  0f84db060000   jz 1866  (0x9c023ab49ca)
                  ;;; <@30,#24> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@34,#38> -------------------- B3 --------------------
                  ;;; <@36,#17> constant-t
0x9c023ab42ef   111  48b991ef35064e360000 REX.W movq rcx,0x364e0635ef91    ;; debug: position 13136
                                                             ;; debug: position 13084
                                                             ;; object: 0x364e0635ef91 <FixedArray[49]>
                  ;;; <@38,#39> load-context-slot
0x9c023ab42f9   121  488b899f000000 REX.W movq rcx,[rcx+0x9f]    ;; debug: position 13136
                  ;;; <@40,#40> check-non-smi
0x9c023ab4300   128  f6c101         testb rcx,0x1            ;; debug: position 13141
0x9c023ab4303   131  0f84be090000   jz 2631  (0x9c023ab4cc7)
                  ;;; <@42,#41> check-maps
0x9c023ab4309   137  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab4313   147  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023ab4317   151  0f85af090000   jnz 2636  (0x9c023ab4ccc)
                  ;;; <@44,#42> load-named-field
0x9c023ab431d   157  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@46,#43> load-named-field
0x9c023ab4321   161  8b710b         movl rsi,[rcx+0xb]
                  ;;; <@48,#44> load-named-field
0x9c023ab4324   164  488b790f       REX.W movq rdi,[rcx+0xf]
                  ;;; <@49,#44> gap
0x9c023ab4328   168  488b4d18       REX.W movq rcx,[rbp+0x18]
                  ;;; <@50,#706> tagged-to-i
0x9c023ab432c   172  f6c101         testb rcx,0x1
0x9c023ab432f   175  0f85a0060000   jnz 1877  (0x9c023ab49d5)
0x9c023ab4335   181  48c1e920       REX.W shrq rcx,32
                  ;;; <@52,#45> bounds-check
0x9c023ab4339   185  3bf1           cmpl rsi,rcx
0x9c023ab433b   187  0f8690090000   jna 2641  (0x9c023ab4cd1)
                  ;;; <@54,#46> load-keyed
0x9c023ab4341   193  448b048f       movl r8,[rdi+rcx*4]
0x9c023ab4345   197  4585c0         testl r8,r8
0x9c023ab4348   200  0f8888090000   js 2646  (0x9c023ab4cd6)
                  ;;; <@56,#17> constant-t
0x9c023ab434e   206  48b991ef35064e360000 REX.W movq rcx,0x364e0635ef91    ;; debug: position 13084
                                                             ;; object: 0x364e0635ef91 <FixedArray[49]>
                  ;;; <@58,#48> load-context-slot
0x9c023ab4358   216  488b8997000000 REX.W movq rcx,[rcx+0x97]    ;; debug: position 13161
                  ;;; <@60,#50> check-non-smi
0x9c023ab435f   223  f6c101         testb rcx,0x1            ;; debug: position 13166
0x9c023ab4362   226  0f8473090000   jz 2651  (0x9c023ab4cdb)
                  ;;; <@62,#51> check-maps
0x9c023ab4368   232  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab4372   242  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023ab4376   246  0f8564090000   jnz 2656  (0x9c023ab4ce0)
                  ;;; <@64,#52> load-named-field
0x9c023ab437c   252  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@66,#53> load-named-field
0x9c023ab4380   256  448b490b       movl r9,[rcx+0xb]
                  ;;; <@68,#54> load-named-field
0x9c023ab4384   260  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@70,#55> bounds-check
0x9c023ab4388   264  453bc8         cmpl r9,r8
0x9c023ab438b   267  0f8654090000   jna 2661  (0x9c023ab4ce5)
                  ;;; <@72,#56> load-keyed
0x9c023ab4391   273  468b1c81       movl r11,[rcx+r8*4]
0x9c023ab4395   277  4585db         testl r11,r11
0x9c023ab4398   280  0f884c090000   js 2666  (0x9c023ab4cea)
                  ;;; <@73,#56> gap
0x9c023ab439e   286  4c8bf2         REX.W movq r14,rdx
                  ;;; <@74,#710> tagged-to-i
0x9c023ab43a1   289  41f6c601       testb r14,0x1            ;; debug: position 13189
0x9c023ab43a5   293  0f855b060000   jnz 1926  (0x9c023ab4a06)
0x9c023ab43ab   299  49c1ee20       REX.W shrq r14,32
                  ;;; <@76,#64> bounds-check
0x9c023ab43af   303  413bf6         cmpl rsi,r14
0x9c023ab43b2   306  0f8637090000   jna 2671  (0x9c023ab4cef)
                  ;;; <@78,#65> load-keyed
0x9c023ab43b8   312  428b34b7       movl rsi,[rdi+r14*4]
0x9c023ab43bc   316  85f6           testl rsi,rsi
0x9c023ab43be   318  0f8830090000   js 2676  (0x9c023ab4cf4)
                  ;;; <@80,#74> bounds-check
0x9c023ab43c4   324  443bce         cmpl r9,rsi              ;; debug: position 13214
0x9c023ab43c7   327  0f862c090000   jna 2681  (0x9c023ab4cf9)
                  ;;; <@82,#75> load-keyed
0x9c023ab43cd   333  8b3cb1         movl rdi,[rcx+rsi*4]
0x9c023ab43d0   336  85ff           testl rdi,rdi
0x9c023ab43d2   338  0f8826090000   js 2686  (0x9c023ab4cfe)
                  ;;; <@85,#79> compare-numeric-and-branch
0x9c023ab43d8   344  443bdf         cmpl r11,rdi             ;; debug: position 13235
0x9c023ab43db   347  0f8508000000   jnz 361  (0x9c023ab43e9)
                  ;;; <@86,#83> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@90,#86> -------------------- B5 (unreachable/replaced) --------------------
                  ;;; <@94,#93> -------------------- B6 (unreachable/replaced) --------------------
                  ;;; <@98,#89> -------------------- B7 (unreachable/replaced) --------------------
                  ;;; <@102,#80> -------------------- B8 (unreachable/replaced) --------------------
                  ;;; <@106,#97> -------------------- B9 --------------------
                  ;;; <@108,#110> gap
0x9c023ab43e1   353  4c89e1         REX.W movq rcx,r12       ;; debug: position 13279
                  ;;; <@110,#111> -------------------- B10 (loop header) --------------------
                  ;;; <@112,#114> deoptimize
                  ;;; deoptimize: Insufficient type feedback for combined type of binary operation
0x9c023ab43e4   356  e8b71ce5ff     call 0x9c0239060a0       ;; debug: position 13282
                                                             ;; debug: position 13284
                                                             ;; soft deoptimization bailout 16
                  ;;; <@114,#115> -------------------- B11 (unreachable/replaced) --------------------
                  ;;; <@126,#119> -------------------- B12 (unreachable/replaced) --------------------
                  ;;; <@130,#125> -------------------- B13 (unreachable/replaced) --------------------
                  ;;; <@138,#132> -------------------- B14 (unreachable/replaced) --------------------
                  ;;; <@142,#134> -------------------- B15 (unreachable/replaced) --------------------
                  ;;; <@154,#138> -------------------- B16 (unreachable/replaced) --------------------
                  ;;; <@168,#145> -------------------- B17 (unreachable/replaced) --------------------
                  ;;; <@172,#147> -------------------- B18 (unreachable/replaced) --------------------
                  ;;; <@182,#151> -------------------- B19 (unreachable/replaced) --------------------
                  ;;; <@194,#155> -------------------- B20 (unreachable/replaced) --------------------
                  ;;; <@204,#159> -------------------- B21 (unreachable/replaced) --------------------
                  ;;; <@208,#176> -------------------- B22 (unreachable/replaced) --------------------
                  ;;; <@220,#122> -------------------- B23 (unreachable/replaced) --------------------
                  ;;; <@224,#183> -------------------- B24 (unreachable/replaced) --------------------
                  ;;; <@228,#190> -------------------- B25 (unreachable/replaced) --------------------
                  ;;; <@232,#186> -------------------- B26 (unreachable/replaced) --------------------
                  ;;; <@236,#162> -------------------- B27 (unreachable/replaced) --------------------
                  ;;; <@240,#165> -------------------- B28 (unreachable/replaced) --------------------
                  ;;; <@244,#172> -------------------- B29 (unreachable/replaced) --------------------
                  ;;; <@248,#168> -------------------- B30 (unreachable/replaced) --------------------
                  ;;; <@252,#21> -------------------- B31 (unreachable/replaced) --------------------
                  ;;; <@256,#27> -------------------- B32 (unreachable/replaced) --------------------
                  ;;; <@260,#34> -------------------- B33 (unreachable/replaced) --------------------
                  ;;; <@264,#197> -------------------- B34 (unreachable/replaced) --------------------
                  ;;; <@268,#204> -------------------- B35 --------------------
                  ;;; <@269,#204> gap
0x9c023ab43e9   361  488b5d10       REX.W movq rbx,[rbp+0x10]    ;; debug: position 7554
                  ;;; <@270,#709> tagged-to-i
0x9c023ab43ed   365  f6c301         testb rbx,0x1            ;; debug: position 7550
0x9c023ab43f0   368  0f8544060000   jnz 1978  (0x9c023ab4a3a)
0x9c023ab43f6   374  48c1eb20       REX.W shrq rbx,32
                  ;;; <@272,#206> div-by-const-i
0x9c023ab43fa   378  b84fecc44e     movl rax,0x4ec4ec4f      ;; debug: position 7552
0x9c023ab43ff   383  f7eb           imull rbx
0x9c023ab4401   385  c1fa03         sarl rdx,3
0x9c023ab4404   388  8bc3           movl rax,rbx
0x9c023ab4406   390  c1e81f         shrl rax,31
0x9c023ab4409   393  03d0           addl rdx,rax
                  ;;; <@273,#206> gap
0x9c023ab440b   395  488955d8       REX.W movq [rbp-0x28],rdx
0x9c023ab440f   399  488bca         REX.W movq rcx,rdx
                  ;;; <@274,#213> mod-by-const-i
0x9c023ab4412   402  b84fecc44e     movl rax,0x4ec4ec4f      ;; debug: position 7579
0x9c023ab4417   407  f7eb           imull rbx
0x9c023ab4419   409  c1fa03         sarl rdx,3
0x9c023ab441c   412  8bc3           movl rax,rbx
0x9c023ab441e   414  c1e81f         shrl rax,31
0x9c023ab4421   417  03d0           addl rdx,rax
0x9c023ab4423   419  6bd21a         imull rdx,rdx,0x1a
0x9c023ab4426   422  8bc3           movl rax,rbx
0x9c023ab4428   424  2bc2           subl rax,rdx
0x9c023ab442a   426  7509           jnz 437  (0x9c023ab4435)
0x9c023ab442c   428  83fb00         cmpl rbx,0x0
0x9c023ab442f   431  0f8cce080000   jl 2691  (0x9c023ab4d03)
                  ;;; <@275,#213> gap
0x9c023ab4435   437  488945d0       REX.W movq [rbp-0x30],rax
                  ;;; <@276,#205> constant-i
0x9c023ab4439   441  bb1a000000     movl rbx,0x1a            ;; debug: position 7554
                  ;;; <@278,#218> sub-i
0x9c023ab443e   446  2bd8           subl rbx,rax             ;; debug: position 7609
                  ;;; <@279,#218> gap
0x9c023ab4440   448  48895dc8       REX.W movq [rbp-0x38],rbx
0x9c023ab4444   452  488b55e8       REX.W movq rdx,[rbp-0x18]
                  ;;; <@280,#221> load-context-slot
0x9c023ab4448   456  488bb297000000 REX.W movq rsi,[rdx+0x97]    ;; debug: position 7634
                  ;;; <@282,#222> load-context-slot
0x9c023ab444f   463  488bba9f000000 REX.W movq rdi,[rdx+0x9f]    ;; debug: position 7639
                  ;;; <@284,#223> check-non-smi
0x9c023ab4456   470  40f6c701       testb rdi,0x1            ;; debug: position 7644
0x9c023ab445a   474  0f84a8080000   jz 2696  (0x9c023ab4d08)
                  ;;; <@286,#224> check-maps
0x9c023ab4460   480  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab446a   490  4c3957ff       REX.W cmpq [rdi-0x1],r10
0x9c023ab446e   494  0f8599080000   jnz 2701  (0x9c023ab4d0d)
                  ;;; <@288,#225> load-named-field
0x9c023ab4474   500  488b7f0f       REX.W movq rdi,[rdi+0xf]
                  ;;; <@290,#226> load-named-field
0x9c023ab4478   504  448b470b       movl r8,[rdi+0xb]
                  ;;; <@292,#227> load-named-field
0x9c023ab447c   508  488b7f0f       REX.W movq rdi,[rdi+0xf]
                  ;;; <@293,#227> gap
0x9c023ab4480   512  4c8b4d18       REX.W movq r9,[rbp+0x18]
                  ;;; <@294,#705> tagged-to-i
0x9c023ab4484   516  41f6c101       testb r9,0x1
0x9c023ab4488   520  0f85ea050000   jnz 2040  (0x9c023ab4a78)
0x9c023ab448e   526  49c1e920       REX.W shrq r9,32
                  ;;; <@295,#705> gap
0x9c023ab4492   530  4c894db0       REX.W movq [rbp-0x50],r9
                  ;;; <@296,#228> bounds-check
0x9c023ab4496   534  453bc1         cmpl r8,r9
0x9c023ab4499   537  0f8673080000   jna 2706  (0x9c023ab4d12)
                  ;;; <@298,#229> load-keyed
0x9c023ab449f   543  468b048f       movl r8,[rdi+r9*4]
0x9c023ab44a3   547  4585c0         testl r8,r8
0x9c023ab44a6   550  0f886b080000   js 2711  (0x9c023ab4d17)
                  ;;; <@300,#230> check-non-smi
0x9c023ab44ac   556  40f6c601       testb rsi,0x1
0x9c023ab44b0   560  0f8466080000   jz 2716  (0x9c023ab4d1c)
                  ;;; <@302,#231> check-maps
0x9c023ab44b6   566  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab44c0   576  4c3956ff       REX.W cmpq [rsi-0x1],r10
0x9c023ab44c4   580  0f8557080000   jnz 2721  (0x9c023ab4d21)
                  ;;; <@304,#232> load-named-field
0x9c023ab44ca   586  488b760f       REX.W movq rsi,[rsi+0xf]
                  ;;; <@306,#233> load-named-field
0x9c023ab44ce   590  8b7e0b         movl rdi,[rsi+0xb]
                  ;;; <@308,#234> load-named-field
0x9c023ab44d1   593  488b760f       REX.W movq rsi,[rsi+0xf]
                  ;;; <@310,#235> bounds-check
0x9c023ab44d5   597  413bf8         cmpl rdi,r8
0x9c023ab44d8   600  0f8648080000   jna 2726  (0x9c023ab4d26)
                  ;;; <@312,#236> load-keyed
0x9c023ab44de   606  468b1c86       movl r11,[rsi+r8*4]
0x9c023ab44e2   610  4585db         testl r11,r11
0x9c023ab44e5   613  0f8840080000   js 2731  (0x9c023ab4d2b)
                  ;;; <@313,#236> gap
0x9c023ab44eb   619  4c895dc0       REX.W movq [rbp-0x40],r11
                  ;;; <@314,#248> add-i
0x9c023ab44ef   623  4503c3         addl r8,r11              ;; debug: position 7866
0x9c023ab44f2   626  0f8038080000   jo 2736  (0x9c023ab4d30)
                  ;;; <@316,#251> sub-i
0x9c023ab44f8   632  4183e801       subl r8,0x1              ;; debug: position 7875
0x9c023ab44fc   636  0f8033080000   jo 2741  (0x9c023ab4d35)
                  ;;; <@318,#258> bounds-check
0x9c023ab4502   642  413bf8         cmpl rdi,r8
0x9c023ab4505   645  0f862f080000   jna 2746  (0x9c023ab4d3a)
                  ;;; <@320,#259> load-keyed
0x9c023ab450b   651  468b0486       movl r8,[rsi+r8*4]
                  ;;; <@321,#259> gap
0x9c023ab450f   655  4c8945b8       REX.W movq [rbp-0x48],r8
                  ;;; <@322,#262> load-context-slot
0x9c023ab4513   659  488b7a37       REX.W movq rdi,[rdx+0x37]    ;; debug: position 7909
                  ;;; <@324,#263> check-value
0x9c023ab4517   663  49ba61b032064e360000 REX.W movq r10,0x364e0632b061    ;; object: 0x364e0632b061 <JS Function pow (SharedFunctionInfo 0x364e0632a0d9)>
0x9c023ab4521   673  493bfa         REX.W cmpq rdi,r10
0x9c023ab4524   676  0f8515080000   jnz 2751  (0x9c023ab4d3f)
                  ;;; <@326,#266> push-argument
0x9c023ab452a   682  49ba214130064e360000 REX.W movq r10,0x364e06304121    ;; debug: position 7915
                                                             ;; object: 0x364e06304121 <undefined>
0x9c023ab4534   692  4152           push r10
                  ;;; <@328,#267> push-argument
0x9c023ab4536   694  4f8d1424       REX.W leaq r10,[r12+r12*1]
0x9c023ab453a   698  4152           push r10
                  ;;; <@330,#720> smi-tag
0x9c023ab453c   700  8bf0           movl rsi,rax
0x9c023ab453e   702  48c1e620       REX.W shlq rsi,32
                  ;;; <@332,#268> push-argument
0x9c023ab4542   706  56             push rsi
                  ;;; <@333,#268> gap
0x9c023ab4543   707  488bf2         REX.W movq rsi,rdx
                  ;;; <@334,#269> invoke-function
0x9c023ab4546   710  488b772f       REX.W movq rsi,[rdi+0x2f]
0x9c023ab454a   714  ff5717         call [rdi+0x17]
                  ;;; <@336,#270> lazy-bailout
                  ;;; <@337,#270> gap
0x9c023ab454d   717  488b5db8       REX.W movq rbx,[rbp-0x48]
                  ;;; <@338,#721> uint32-to-double
0x9c023ab4551   721  f2480f2ad3     REX.W cvtsi2sd xmm2,rbx    ;; debug: position 7902
                  ;;; <@340,#723> double-untag
0x9c023ab4556   726  a801           test al,0x1              ;; debug: position 7909
0x9c023ab4558   728  7424           jz 766  (0x9c023ab457e)
0x9c023ab455a   730  4d8b5500       REX.W movq r10,[r13+0x0]
0x9c023ab455e   734  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab4562   738  f20f104807     movsd xmm1,[rax+0x7]
0x9c023ab4567   743  7502           jnz 747  (0x9c023ab456b)
0x9c023ab4569   745  eb22           jmp 781  (0x9c023ab458d)
0x9c023ab456b   747  493b45a8       REX.W cmpq rax,[r13-0x58]
0x9c023ab456f   751  0f85cf070000   jnz 2756  (0x9c023ab4d44)
0x9c023ab4575   757  0f57c9         xorps xmm1,xmm1
0x9c023ab4578   760  f20f5ec9       divsd xmm1,xmm1
0x9c023ab457c   764  eb0f           jmp 781  (0x9c023ab458d)
0x9c023ab457e   766  4c8bd0         REX.W movq r10,rax
0x9c023ab4581   769  49c1ea20       REX.W shrq r10,32
0x9c023ab4585   773  0f57c9         xorps xmm1,xmm1
0x9c023ab4588   776  f2410f2aca     cvtsi2sd xmm1,r10
                  ;;; <@342,#271> mul-d
0x9c023ab458d   781  f20f59ca       mulsd xmm1,xmm2          ;; debug: position 7907
                  ;;; <@344,#724> constant-d
0x9c023ab4591   785  48b8000000f8ffff8f41 REX.W movq rax,0x418ffffff8000000    ;; debug: position 7922
0x9c023ab459b   795  66480f6ed0     REX.W movq xmm2,rax
                  ;;; <@347,#274> compare-numeric-and-branch
0x9c023ab45a0   800  660f2eca       ucomisd xmm1,xmm2
0x9c023ab45a4   804  0f8a06000000   jpe 816  (0x9c023ab45b0)
0x9c023ab45aa   810  0f8707000000   ja 823  (0x9c023ab45b7)
                  ;;; <@348,#278> -------------------- B36 (unreachable/replaced) --------------------
                  ;;; <@352,#283> -------------------- B37 --------------------
                  ;;; <@354,#288> gap
0x9c023ab45b0   816  33c0           xorl rax,rax             ;; debug: position 7940
                  ;;; <@355,#288> goto
0x9c023ab45b2   818  e905000000     jmp 828  (0x9c023ab45bc)
                  ;;; <@356,#275> -------------------- B38 (unreachable/replaced) --------------------
                  ;;; <@360,#281> -------------------- B39 --------------------
                  ;;; <@362,#286> gap
0x9c023ab45b7   823  b801000000     movl rax,0x1             ;; debug: position 7936
                                                             ;; debug: position 7940
                  ;;; <@364,#290> -------------------- B40 --------------------
                  ;;; <@365,#290> gap
0x9c023ab45bc   828  488b5de8       REX.W movq rbx,[rbp-0x18]
                  ;;; <@366,#292> load-context-slot
0x9c023ab45c0   832  488b93af000000 REX.W movq rdx,[rbx+0xaf]    ;; debug: position 7955
                  ;;; <@367,#292> gap
0x9c023ab45c7   839  488955b8       REX.W movq [rbp-0x48],rdx
                  ;;; <@368,#293> check-value
0x9c023ab45cb   843  49baa1fc35064e360000 REX.W movq r10,0x364e0635fca1    ;; object: 0x364e0635fca1 <JS Function alloc (SharedFunctionInfo 0xc1217b4f389)>
0x9c023ab45d5   853  493bd2         REX.W cmpq rdx,r10
0x9c023ab45d8   856  0f856b070000   jnz 2761  (0x9c023ab4d49)
                  ;;; <@369,#293> gap
0x9c023ab45de   862  488b4dc0       REX.W movq rcx,[rbp-0x40]
                  ;;; <@370,#296> add-i
0x9c023ab45e2   866  034dd8         addl rcx,[rbp-0x28]      ;; debug: position 7968
0x9c023ab45e5   869  0f8063070000   jo 2766  (0x9c023ab4d4e)
                  ;;; <@371,#296> gap
0x9c023ab45eb   875  4c8bc1         REX.W movq r8,rcx
                  ;;; <@372,#299> add-i
0x9c023ab45ee   878  4403c0         addl r8,rax              ;; debug: position 7976
0x9c023ab45f1   881  0f805c070000   jo 2771  (0x9c023ab4d53)
                  ;;; <@373,#299> gap
0x9c023ab45f7   887  4c8945a8       REX.W movq [rbp-0x58],r8
                  ;;; <@374,#302> constant-t
0x9c023ab45fb   891  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@376,#305> load-context-slot
0x9c023ab4605   901  488b4637       REX.W movq rax,[rsi+0x37]    ;; debug: position 2205
                  ;;; <@378,#726> tagged-to-i
0x9c023ab4609   905  a801           test al,0x1
0x9c023ab460b   907  0f859b040000   jnz 2092  (0x9c023ab4aac)
0x9c023ab4611   913  48c1e820       REX.W shrq rax,32
                  ;;; <@381,#306> compare-numeric-and-branch
0x9c023ab4615   917  443bc0         cmpl r8,rax              ;; debug: position 2203
0x9c023ab4618   920  0f8e31000000   jle 975  (0x9c023ab464f)
                  ;;; <@382,#310> -------------------- B41 (unreachable/replaced) --------------------
                  ;;; <@386,#321> -------------------- B42 (unreachable/replaced) --------------------
                  ;;; <@390,#307> -------------------- B43 (unreachable/replaced) --------------------
                  ;;; <@394,#313> -------------------- B44 --------------------
                  ;;; <@396,#302> constant-t
0x9c023ab461e   926  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2229
                                                             ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@398,#314> load-context-slot
0x9c023ab4628   936  488b7e4f       REX.W movq rdi,[rsi+0x4f]    ;; debug: position 2229
                  ;;; <@400,#315> push-argument
0x9c023ab462c   940  49ba214130064e360000 REX.W movq r10,0x364e06304121    ;; debug: position 2236
                                                             ;; object: 0x364e06304121 <undefined>
0x9c023ab4636   950  4152           push r10
                  ;;; <@402,#725> smi-tag
0x9c023ab4638   952  418bc0         movl rax,r8
0x9c023ab463b   955  48c1e020       REX.W shlq rax,32
                  ;;; <@404,#316> push-argument
0x9c023ab463f   959  50             push rax
                  ;;; <@406,#302> constant-t
0x9c023ab4640   960  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@408,#317> call-function
0x9c023ab464a   970  e8d146f7ff     call 0x9c023a28d20       ;; debug: position 2236
                                                             ;; code: STUB, CallFunctionStub, argc = 1
                  ;;; <@410,#318> lazy-bailout
                  ;;; <@414,#324> -------------------- B45 --------------------
                  ;;; <@416,#302> constant-t
0x9c023ab464f   975  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2258
                                                             ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@418,#325> load-context-slot
0x9c023ab4659   985  488b4637       REX.W movq rax,[rsi+0x37]    ;; debug: position 2258
                  ;;; <@420,#727> tagged-to-i
0x9c023ab465d   989  a801           test al,0x1
0x9c023ab465f   991  0f8578040000   jnz 2141  (0x9c023ab4add)
0x9c023ab4665   997  48c1e820       REX.W shrq rax,32
                  ;;; <@422,#326> sub-i
0x9c023ab4669  1001  2b45a8         subl rax,[rbp-0x58]      ;; debug: position 2271
0x9c023ab466c  1004  0f80e6060000   jo 2776  (0x9c023ab4d58)
                  ;;; <@424,#728> smi-tag
0x9c023ab4672  1010  8bd8           movl rbx,rax
0x9c023ab4674  1012  48c1e320       REX.W shlq rbx,32
                  ;;; <@426,#302> constant-t
0x9c023ab4678  1016  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@428,#328> store-context-slot
0x9c023ab4682  1026  48895e37       REX.W movq [rsi+0x37],rbx    ;; debug: position 2271
                  ;;; <@430,#302> constant-t
0x9c023ab4686  1030  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@432,#330> load-context-slot
0x9c023ab4690  1040  488b5e3f       REX.W movq rbx,[rsi+0x3f]    ;; debug: position 2378
                  ;;; <@433,#330> gap
0x9c023ab4694  1044  488bd3         REX.W movq rdx,rbx
                  ;;; <@434,#731> tagged-to-i
0x9c023ab4697  1047  f6c201         testb rdx,0x1            ;; debug: position 2394
0x9c023ab469a  1050  0f857b040000   jnz 2203  (0x9c023ab4b1b)
0x9c023ab46a0  1056  48c1ea20       REX.W shrq rdx,32
                  ;;; <@435,#731> gap
0x9c023ab46a4  1060  488bca         REX.W movq rcx,rdx
                  ;;; <@436,#333> add-i
0x9c023ab46a7  1063  034da8         addl rcx,[rbp-0x58]      ;; debug: position 2398
0x9c023ab46aa  1066  0f80ad060000   jo 2781  (0x9c023ab4d5d)
                  ;;; <@438,#732> smi-tag
0x9c023ab46b0  1072  8bc1           movl rax,rcx
0x9c023ab46b2  1074  48c1e020       REX.W shlq rax,32
                  ;;; <@440,#302> constant-t
0x9c023ab46b6  1078  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@442,#335> store-context-slot
0x9c023ab46c0  1088  4889463f       REX.W movq [rsi+0x3f],rax    ;; debug: position 2398
                  ;;; <@444,#302> constant-t
0x9c023ab46c4  1092  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@446,#337> load-context-slot
0x9c023ab46ce  1102  488b4647       REX.W movq rax,[rsi+0x47]    ;; debug: position 2484
                  ;;; <@448,#733> tagged-to-i
0x9c023ab46d2  1106  a801           test al,0x1
0x9c023ab46d4  1108  0f8572040000   jnz 2252  (0x9c023ab4b4c)
0x9c023ab46da  1114  48c1e820       REX.W shrq rax,32
                  ;;; <@449,#733> gap
0x9c023ab46de  1118  488945a0       REX.W movq [rbp-0x60],rax
0x9c023ab46e2  1122  488bf8         REX.W movq rdi,rax
                  ;;; <@450,#339> add-i
0x9c023ab46e5  1125  83c701         addl rdi,0x1
0x9c023ab46e8  1128  0f8074060000   jo 2786  (0x9c023ab4d62)
                  ;;; <@452,#735> smi-tag
0x9c023ab46ee  1134  8bcf           movl rcx,rdi
0x9c023ab46f0  1136  48c1e120       REX.W shlq rcx,32
                  ;;; <@454,#302> constant-t
0x9c023ab46f4  1140  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@456,#340> store-context-slot
0x9c023ab46fe  1150  48894e47       REX.W movq [rsi+0x47],rcx    ;; debug: position 2484
                  ;;; <@458,#302> constant-t
0x9c023ab4702  1154  48be49fc35064e360000 REX.W movq rsi,0x364e0635fc49    ;; debug: position 2106
                                                             ;; object: 0x364e0635fc49 <FixedArray[9]>
                  ;;; <@460,#343> load-named-field
0x9c023ab470c  1164  488b4e17       REX.W movq rcx,[rsi+0x17]    ;; debug: position 2497
                  ;;; <@462,#344> load-context-slot
0x9c023ab4710  1168  488bb19f000000 REX.W movq rsi,[rcx+0x9f]
                  ;;; <@464,#347> check-non-smi
0x9c023ab4717  1175  40f6c601       testb rsi,0x1            ;; debug: position 2513
0x9c023ab471b  1179  0f8446060000   jz 2791  (0x9c023ab4d67)
                  ;;; <@466,#348> check-maps
0x9c023ab4721  1185  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab472b  1195  4c3956ff       REX.W cmpq [rsi-0x1],r10
0x9c023ab472f  1199  0f8537060000   jnz 2796  (0x9c023ab4d6c)
                  ;;; <@468,#350> check-maps
                  ;;; <@470,#352> check-maps
                  ;;; <@472,#353> load-named-field
0x9c023ab4735  1205  488b760f       REX.W movq rsi,[rsi+0xf]
                  ;;; <@474,#354> load-named-field
0x9c023ab4739  1209  448b460b       movl r8,[rsi+0xb]
                  ;;; <@476,#355> load-named-field
0x9c023ab473d  1213  488b760f       REX.W movq rsi,[rsi+0xf]
                  ;;; <@478,#356> bounds-check
0x9c023ab4741  1217  443bc0         cmpl r8,rax
0x9c023ab4744  1220  0f8627060000   jna 2801  (0x9c023ab4d71)
                  ;;; <@479,#356> gap
0x9c023ab474a  1226  4c8bc3         REX.W movq r8,rbx
                  ;;; <@480,#730> tagged-to-i
0x9c023ab474d  1229  41f6c001       testb r8,0x1
0x9c023ab4751  1233  0f8533040000   jnz 2314  (0x9c023ab4b8a)
0x9c023ab4757  1239  49c1e820       REX.W shrq r8,32
                  ;;; <@482,#357> store-keyed
0x9c023ab475b  1243  44890486       movl [rsi+rax*4],r8
                  ;;; <@484,#360> load-context-slot
0x9c023ab475f  1247  488b8997000000 REX.W movq rcx,[rcx+0x97]    ;; debug: position 2528
                  ;;; <@486,#362> check-non-smi
0x9c023ab4766  1254  f6c101         testb rcx,0x1            ;; debug: position 2545
0x9c023ab4769  1257  0f8407060000   jz 2806  (0x9c023ab4d76)
                  ;;; <@488,#363> check-maps
0x9c023ab476f  1263  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab4779  1273  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023ab477d  1277  0f85f8050000   jnz 2811  (0x9c023ab4d7b)
                  ;;; <@490,#368> load-named-field
0x9c023ab4783  1283  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@492,#369> load-named-field
0x9c023ab4787  1287  8b710b         movl rsi,[rcx+0xb]
                  ;;; <@494,#370> load-named-field
0x9c023ab478a  1290  488b490f       REX.W movq rcx,[rcx+0xf]
                  ;;; <@496,#371> bounds-check
0x9c023ab478e  1294  3bf2           cmpl rsi,rdx
0x9c023ab4790  1296  0f86ea050000   jna 2816  (0x9c023ab4d80)
                  ;;; <@497,#371> gap
0x9c023ab4796  1302  488b5da8       REX.W movq rbx,[rbp-0x58]
                  ;;; <@498,#372> store-keyed
0x9c023ab479a  1306  891c91         movl [rcx+rdx*4],rbx
                  ;;; <@502,#378> -------------------- B46 --------------------
                  ;;; <@503,#378> gap
0x9c023ab479d  1309  488b5de8       REX.W movq rbx,[rbp-0x18]    ;; debug: position 2565
                                                             ;; debug: position 7976
                  ;;; <@504,#380> load-context-slot
0x9c023ab47a1  1313  488b939f000000 REX.W movq rdx,[rbx+0x9f]    ;; debug: position 8002
                  ;;; <@506,#382> check-non-smi
0x9c023ab47a8  1320  f6c201         testb rdx,0x1            ;; debug: position 8007
0x9c023ab47ab  1323  0f84d4050000   jz 2821  (0x9c023ab4d85)
                  ;;; <@508,#383> check-maps
0x9c023ab47b1  1329  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab47bb  1339  4c3952ff       REX.W cmpq [rdx-0x1],r10
0x9c023ab47bf  1343  0f85c5050000   jnz 2826  (0x9c023ab4d8a)
                  ;;; <@510,#384> load-named-field
0x9c023ab47c5  1349  488b520f       REX.W movq rdx,[rdx+0xf]
                  ;;; <@512,#385> load-named-field
0x9c023ab47c9  1353  8b4a0b         movl rcx,[rdx+0xb]
                  ;;; <@514,#386> load-named-field
0x9c023ab47cc  1356  488b520f       REX.W movq rdx,[rdx+0xf]
                  ;;; <@516,#387> bounds-check
0x9c023ab47d0  1360  3bc8           cmpl rcx,rax
0x9c023ab47d2  1362  0f86b7050000   jna 2831  (0x9c023ab4d8f)
                  ;;; <@518,#388> load-keyed
0x9c023ab47d8  1368  8b3482         movl rsi,[rdx+rax*4]
0x9c023ab47db  1371  85f6           testl rsi,rsi
0x9c023ab47dd  1373  0f88b1050000   js 2836  (0x9c023ab4d94)
0x9c023ab47e3  1379  4863f6         REX.W movsxlq rsi,rsi
                  ;;; <@520,#390> load-context-slot
0x9c023ab47e6  1382  488bbb97000000 REX.W movq rdi,[rbx+0x97]    ;; debug: position 8014
                  ;;; <@521,#390> gap
0x9c023ab47ed  1389  48897da8       REX.W movq [rbp-0x58],rdi
0x9c023ab47f1  1393  4c8bc6         REX.W movq r8,rsi
                  ;;; <@522,#393> add-i
0x9c023ab47f4  1396  4183c001       addl r8,0x1              ;; debug: position 8022
0x9c023ab47f8  1400  0f809b050000   jo 2841  (0x9c023ab4d99)
                  ;;; <@524,#396> check-non-smi
0x9c023ab47fe  1406  40f6c701       testb rdi,0x1            ;; debug: position 8029
0x9c023ab4802  1410  0f8496050000   jz 2846  (0x9c023ab4d9e)
                  ;;; <@526,#397> check-maps
0x9c023ab4808  1416  49ba51bdc05ecb2c0000 REX.W movq r10,0x2ccb5ec0bd51    ;; object: 0x2ccb5ec0bd51 <Map(elements=13)>
0x9c023ab4812  1426  4c3957ff       REX.W cmpq [rdi-0x1],r10
0x9c023ab4816  1430  0f8587050000   jnz 2851  (0x9c023ab4da3)
                  ;;; <@528,#402> load-named-field
0x9c023ab481c  1436  4c8b4f0f       REX.W movq r9,[rdi+0xf]
                  ;;; <@530,#403> load-named-field
0x9c023ab4820  1440  458b590b       movl r11,[r9+0xb]
                  ;;; <@532,#404> load-named-field
0x9c023ab4824  1444  4d8b490f       REX.W movq r9,[r9+0xf]
                  ;;; <@534,#405> bounds-check
0x9c023ab4828  1448  453bd8         cmpl r11,r8
0x9c023ab482b  1451  0f8677050000   jna 2856  (0x9c023ab4da8)
                  ;;; <@536,#208> constant-i
0x9c023ab4831  1457  4533c0         xorl r8,r8               ;; debug: position 7560
                  ;;; <@538,#406> store-keyed
0x9c023ab4834  1460  458944b104     movl [r9+rsi*4+0x4],r8    ;; debug: position 8029
                  ;;; <@539,#406> gap
0x9c023ab4839  1465  4c8b45b0       REX.W movq r8,[rbp-0x50]
                  ;;; <@540,#414> bounds-check
0x9c023ab483d  1469  413bc8         cmpl rcx,r8              ;; debug: position 8066
0x9c023ab4840  1472  0f8667050000   jna 2861  (0x9c023ab4dad)
                  ;;; <@542,#415> load-keyed
0x9c023ab4846  1478  468b3482       movl r14,[rdx+r8*4]
0x9c023ab484a  1482  4585f6         testl r14,r14
0x9c023ab484d  1485  0f885f050000   js 2866  (0x9c023ab4db2)
                  ;;; <@543,#415> gap
0x9c023ab4853  1491  488b55d8       REX.W movq rdx,[rbp-0x28]
                  ;;; <@544,#441> add-i
0x9c023ab4857  1495  83c202         addl rdx,0x2             ;; debug: position 8131
0x9c023ab485a  1498  0f8057050000   jo 2871  (0x9c023ab4db7)
                  ;;; <@546,#436> gap
0x9c023ab4860  1504  b902000000     movl rcx,0x2             ;; debug: position 8118
                  ;;; <@548,#437> -------------------- B47 (loop header) --------------------
                  ;;; <@551,#443> compare-numeric-and-branch
0x9c023ab4865  1509  3bca           cmpl rcx,rdx             ;; debug: position 8121
                                                             ;; debug: position 8123
0x9c023ab4867  1511  0f8d2e000000   jge 1563  (0x9c023ab489b)
                  ;;; <@552,#444> -------------------- B48 (unreachable/replaced) --------------------
                  ;;; <@556,#450> -------------------- B49 --------------------
                  ;;; <@558,#452> stack-check
0x9c023ab486d  1517  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023ab4874  1524  0f827b030000   jc 2421  (0x9c023ab4bf5)
                  ;;; <@559,#452> gap
0x9c023ab487a  1530  4c8bfe         REX.W movq r15,rsi
                  ;;; <@560,#456> add-i
0x9c023ab487d  1533  4403f9         addl r15,rcx             ;; debug: position 8158
0x9c023ab4880  1536  0f8036050000   jo 2876  (0x9c023ab4dbc)
                  ;;; <@562,#468> bounds-check
0x9c023ab4886  1542  453bdf         cmpl r11,r15             ;; debug: position 8165
0x9c023ab4889  1545  0f8632050000   jna 2881  (0x9c023ab4dc1)
                  ;;; <@564,#208> constant-i
0x9c023ab488f  1551  4533c0         xorl r8,r8               ;; debug: position 7560
                  ;;; <@566,#469> store-keyed
0x9c023ab4892  1554  478904b9       movl [r9+r15*4],r8       ;; debug: position 8165
                  ;;; <@568,#472> add-i
0x9c023ab4896  1558  83c101         addl rcx,0x1             ;; debug: position 8136
                  ;;; <@571,#475> goto
0x9c023ab4899  1561  ebca           jmp 1509  (0x9c023ab4865)
                  ;;; <@572,#447> -------------------- B50 (unreachable/replaced) --------------------
                  ;;; <@576,#476> -------------------- B51 --------------------
                  ;;; <@578,#479> gap
0x9c023ab489b  1563  488b55d0       REX.W movq rdx,[rbp-0x30]    ;; debug: position 8183
                                                             ;; debug: position 8188
                  ;;; <@579,#479> compare-numeric-and-branch
0x9c023ab489f  1567  83fa00         cmpl rdx,0x0
0x9c023ab48a2  1570  0f8f5d000000   jg 1669  (0x9c023ab4905)
                  ;;; <@580,#483> -------------------- B52 (unreachable/replaced) --------------------
                  ;;; <@584,#606> -------------------- B53 --------------------
                  ;;; <@585,#606> gap
0x9c023ab48a8  1576  488bd6         REX.W movq rdx,rsi       ;; debug: position 8457
                  ;;; <@586,#643> add-i
0x9c023ab48ab  1579  0355d8         addl rdx,[rbp-0x28]      ;; debug: position 8496
0x9c023ab48ae  1582  0f8012050000   jo 2886  (0x9c023ab4dc6)
                  ;;; <@588,#626> gap
0x9c023ab48b4  1588  b902000000     movl rcx,0x2             ;; debug: position 8457
                  ;;; <@590,#627> -------------------- B54 (loop header) --------------------
                  ;;; <@593,#630> compare-numeric-and-branch
0x9c023ab48b9  1593  3b4dc0         cmpl rcx,[rbp-0x40]      ;; debug: position 8460
                                                             ;; debug: position 8462
0x9c023ab48bc  1596  0f8df4000000   jge 1846  (0x9c023ab49b6)
                  ;;; <@594,#631> -------------------- B55 (unreachable/replaced) --------------------
                  ;;; <@598,#637> -------------------- B56 --------------------
                  ;;; <@600,#639> stack-check
0x9c023ab48c2  1602  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023ab48c9  1609  0f8267030000   jc 2486  (0x9c023ab4c36)
                  ;;; <@601,#639> gap
0x9c023ab48cf  1615  488bfa         REX.W movq rdi,rdx
                  ;;; <@602,#646> add-i
0x9c023ab48d2  1618  03f9           addl rdi,rcx             ;; debug: position 8504
0x9c023ab48d4  1620  0f80f1040000   jo 2891  (0x9c023ab4dcb)
                  ;;; <@603,#646> gap
0x9c023ab48da  1626  4d8bc6         REX.W movq r8,r14
                  ;;; <@604,#651> add-i
0x9c023ab48dd  1629  4403c1         addl r8,rcx              ;; debug: position 8519
0x9c023ab48e0  1632  0f80ea040000   jo 2896  (0x9c023ab4dd0)
                  ;;; <@606,#658> bounds-check
0x9c023ab48e6  1638  453bd8         cmpl r11,r8
0x9c023ab48e9  1641  0f86e6040000   jna 2901  (0x9c023ab4dd5)
                  ;;; <@608,#659> load-keyed
0x9c023ab48ef  1647  478b0481       movl r8,[r9+r8*4]
                  ;;; <@610,#669> bounds-check
0x9c023ab48f3  1651  443bdf         cmpl r11,rdi
0x9c023ab48f6  1654  0f86de040000   jna 2906  (0x9c023ab4dda)
                  ;;; <@612,#670> store-keyed
0x9c023ab48fc  1660  458904b9       movl [r9+rdi*4],r8
                  ;;; <@614,#673> add-i
0x9c023ab4900  1664  83c101         addl rcx,0x1             ;; debug: position 8472
                  ;;; <@617,#676> goto
0x9c023ab4903  1667  ebb4           jmp 1593  (0x9c023ab48b9)
                  ;;; <@618,#634> -------------------- B57 (unreachable/replaced) --------------------
                  ;;; <@622,#679> -------------------- B58 (unreachable/replaced) --------------------
                  ;;; <@626,#480> -------------------- B59 (unreachable/replaced) --------------------
                  ;;; <@630,#486> -------------------- B60 --------------------
                  ;;; <@631,#486> gap
0x9c023ab4905  1669  4c8bc6         REX.W movq r8,rsi        ;; debug: position 8214
                  ;;; <@632,#525> add-i
0x9c023ab4908  1672  440345d8       addl r8,[rbp-0x28]       ;; debug: position 8275
0x9c023ab490c  1676  0f80cd040000   jo 2911  (0x9c023ab4ddf)
                  ;;; <@633,#525> gap
0x9c023ab4912  1682  4c8945b0       REX.W movq [rbp-0x50],r8
                  ;;; <@634,#508> gap
0x9c023ab4916  1686  33c9           xorl rcx,rcx             ;; debug: position 8236
0x9c023ab4918  1688  41bf02000000   movl r15,0x2
                  ;;; <@636,#509> -------------------- B61 (loop header) --------------------
0x9c023ab491e  1694  48894d98       REX.W movq [rbp-0x68],rcx    ;; debug: position 8239
                  ;;; <@639,#512> compare-numeric-and-branch
0x9c023ab4922  1698  443b7dc0       cmpl r15,[rbp-0x40]      ;; debug: position 8241
0x9c023ab4926  1702  0f8d6c000000   jge 1816  (0x9c023ab4998)
                  ;;; <@640,#513> -------------------- B62 (unreachable/replaced) --------------------
                  ;;; <@644,#519> -------------------- B63 --------------------
                  ;;; <@646,#521> stack-check
0x9c023ab492c  1708  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023ab4933  1715  0f823e030000   jc 2551  (0x9c023ab4c77)
                  ;;; <@647,#521> gap
0x9c023ab4939  1721  488b45b0       REX.W movq rax,[rbp-0x50]
                  ;;; <@648,#528> add-i
0x9c023ab493d  1725  4103c7         addl rax,r15             ;; debug: position 8283
0x9c023ab4940  1728  0f809e040000   jo 2916  (0x9c023ab4de4)
                  ;;; <@649,#528> gap
0x9c023ab4946  1734  498bfe         REX.W movq rdi,r14
                  ;;; <@650,#534> add-i
0x9c023ab4949  1737  4103ff         addl rdi,r15             ;; debug: position 8308
0x9c023ab494c  1740  0f8097040000   jo 2921  (0x9c023ab4de9)
                  ;;; <@652,#541> bounds-check
0x9c023ab4952  1746  443bdf         cmpl r11,rdi
0x9c023ab4955  1749  0f8693040000   jna 2926  (0x9c023ab4dee)
                  ;;; <@654,#542> load-keyed
0x9c023ab495b  1755  458b04b9       movl r8,[r9+rdi*4]
                  ;;; <@655,#542> gap
0x9c023ab495f  1759  488bca         REX.W movq rcx,rdx
                  ;;; <@656,#544> shift-i
0x9c023ab4962  1762  41d3e0         shll r8,cl               ;; debug: position 8313
                  ;;; <@658,#546> add-i
0x9c023ab4965  1765  44034598       addl r8,[rbp-0x68]       ;; debug: position 8297
                  ;;; <@660,#549> bit-i
0x9c023ab4969  1769  4181e0ffffff03 andl r8,0x3ffffff        ;; debug: position 8323
                  ;;; <@662,#560> bounds-check
0x9c023ab4970  1776  443bd8         cmpl r11,rax
0x9c023ab4973  1779  0f867a040000   jna 2931  (0x9c023ab4df3)
                  ;;; <@664,#561> store-keyed
0x9c023ab4979  1785  45890481       movl [r9+rax*4],r8
                  ;;; <@666,#574> load-keyed
0x9c023ab497d  1789  418b04b9       movl rax,[r9+rdi*4]      ;; debug: position 8359
                  ;;; <@667,#574> gap
0x9c023ab4981  1793  488b4dc8       REX.W movq rcx,[rbp-0x38]
                  ;;; <@668,#576> shift-i
0x9c023ab4985  1797  d3e8           shrl rax,cl              ;; debug: position 8364
0x9c023ab4987  1799  85c0           testl rax,rax
0x9c023ab4989  1801  0f8869040000   js 2936  (0x9c023ab4df8)
                  ;;; <@670,#580> add-i
0x9c023ab498f  1807  4183c701       addl r15,0x1             ;; debug: position 8251
                  ;;; <@672,#583> gap
0x9c023ab4993  1811  488bc8         REX.W movq rcx,rax
                  ;;; <@673,#583> goto
0x9c023ab4996  1814  eb86           jmp 1694  (0x9c023ab491e)
                  ;;; <@674,#516> -------------------- B64 (unreachable/replaced) --------------------
                  ;;; <@678,#584> -------------------- B65 --------------------
                  ;;; <@679,#584> gap
0x9c023ab4998  1816  488b45b0       REX.W movq rax,[rbp-0x50]    ;; debug: position 8394
                  ;;; <@680,#591> add-i
0x9c023ab499c  1820  4103c7         addl rax,r15             ;; debug: position 8410
0x9c023ab499f  1823  0f8058040000   jo 2941  (0x9c023ab4dfd)
                  ;;; <@682,#603> bounds-check
0x9c023ab49a5  1829  443bd8         cmpl r11,rax             ;; debug: position 8417
0x9c023ab49a8  1832  0f8654040000   jna 2946  (0x9c023ab4e02)
                  ;;; <@683,#603> gap
0x9c023ab49ae  1838  488b5d98       REX.W movq rbx,[rbp-0x68]
                  ;;; <@684,#604> store-keyed
0x9c023ab49b2  1842  41891c81       movl [r9+rax*4],rbx
                  ;;; <@688,#698> -------------------- B66 --------------------
                  ;;; <@689,#698> gap
0x9c023ab49b6  1846  488b45a0       REX.W movq rax,[rbp-0x60]    ;; debug: position 8472
                                                             ;; debug: position 8549
                  ;;; <@690,#734> smi-tag
0x9c023ab49ba  1850  8bd8           movl rbx,rax
0x9c023ab49bc  1852  48c1e320       REX.W shlq rbx,32
                  ;;; <@691,#734> gap
0x9c023ab49c0  1856  488bc3         REX.W movq rax,rbx
                  ;;; <@692,#701> return
0x9c023ab49c3  1859  488be5         REX.W movq rsp,rbp
0x9c023ab49c6  1862  5d             pop rbp
0x9c023ab49c7  1863  c21800         ret 0x18
                  ;;; <@694,#30> -------------------- B67 (unreachable/replaced) --------------------
                  ;;; <@698,#194> -------------------- B68 (unreachable/replaced) --------------------
                  ;;; <@702,#200> -------------------- B69 --------------------
                  ;;; <@703,#200> gap
0x9c023ab49ca  1866  488b45e0       REX.W movq rax,[rbp-0x20]    ;; debug: position 7528
                  ;;; <@704,#203> return
0x9c023ab49ce  1870  488be5         REX.W movq rsp,rbp
0x9c023ab49d1  1873  5d             pop rbp
0x9c023ab49d2  1874  c21800         ret 0x18
                  ;;; <@50,#706> -------------------- Deferred tagged-to-i --------------------
0x9c023ab49d5  1877  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 13141
0x9c023ab49d9  1881  4c3951ff       REX.W cmpq [rcx-0x1],r10
0x9c023ab49dd  1885  751d           jnz 1916  (0x9c023ab49fc)
0x9c023ab49df  1887  f20f104107     movsd xmm0,[rcx+0x7]
0x9c023ab49e4  1892  f20f2cc8       cvttsd2sil rcx,xmm0
0x9c023ab49e8  1896  0f57c9         xorps xmm1,xmm1
0x9c023ab49eb  1899  f20f2ac9       cvtsi2sd xmm1,rcx
0x9c023ab49ef  1903  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab49f3  1907  7507           jnz 1916  (0x9c023ab49fc)
                  Deferred TaggedToI: NaN
0x9c023ab49f5  1909  7a05           jpe 1916  (0x9c023ab49fc)
0x9c023ab49f7  1911  e93df9ffff     jmp 185  (0x9c023ab4339)
0x9c023ab49fc  1916  e8e318c5ff     call 0x9c0237062e4       ;; deoptimization bailout 74
0x9c023ab4a01  1921  e933f9ffff     jmp 185  (0x9c023ab4339)
                  ;;; <@74,#710> -------------------- Deferred tagged-to-i --------------------
0x9c023ab4a06  1926  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 13189
0x9c023ab4a0a  1930  4d3956ff       REX.W cmpq [r14-0x1],r10
0x9c023ab4a0e  1934  7520           jnz 1968  (0x9c023ab4a30)
0x9c023ab4a10  1936  f2410f104607   movsd xmm0,[r14+0x7]
0x9c023ab4a16  1942  f2440f2cf0     cvttsd2sil r14,xmm0
0x9c023ab4a1b  1947  0f57c9         xorps xmm1,xmm1
0x9c023ab4a1e  1950  f2410f2ace     cvtsi2sd xmm1,r14
0x9c023ab4a23  1955  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab4a27  1959  7507           jnz 1968  (0x9c023ab4a30)
                  Deferred TaggedToI: NaN
0x9c023ab4a29  1961  7a05           jpe 1968  (0x9c023ab4a30)
0x9c023ab4a2b  1963  e97ff9ffff     jmp 303  (0x9c023ab43af)
0x9c023ab4a30  1968  e8b918c5ff     call 0x9c0237062ee       ;; deoptimization bailout 75
0x9c023ab4a35  1973  e975f9ffff     jmp 303  (0x9c023ab43af)
                  ;;; <@270,#709> -------------------- Deferred tagged-to-i --------------------
0x9c023ab4a3a  1978  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 7550
0x9c023ab4a3e  1982  4c3953ff       REX.W cmpq [rbx-0x1],r10
0x9c023ab4a42  1986  752a           jnz 2030  (0x9c023ab4a6e)
0x9c023ab4a44  1988  f20f104307     movsd xmm0,[rbx+0x7]
0x9c023ab4a49  1993  f20f2cd8       cvttsd2sil rbx,xmm0
0x9c023ab4a4d  1997  0f57c9         xorps xmm1,xmm1
0x9c023ab4a50  2000  f20f2acb       cvtsi2sd xmm1,rbx
0x9c023ab4a54  2004  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab4a58  2008  7514           jnz 2030  (0x9c023ab4a6e)
                  Deferred TaggedToI: NaN
0x9c023ab4a5a  2010  7a12           jpe 2030  (0x9c023ab4a6e)
0x9c023ab4a5c  2012  85db           testl rbx,rbx
0x9c023ab4a5e  2014  7509           jnz 2025  (0x9c023ab4a69)
0x9c023ab4a60  2016  660f50d8       movmskpd rbx,xmm0
0x9c023ab4a64  2020  83e301         andl rbx,0x1
0x9c023ab4a67  2023  7505           jnz 2030  (0x9c023ab4a6e)
0x9c023ab4a69  2025  e98cf9ffff     jmp 378  (0x9c023ab43fa)
0x9c023ab4a6e  2030  e88518c5ff     call 0x9c0237062f8       ;; deoptimization bailout 76
0x9c023ab4a73  2035  e982f9ffff     jmp 378  (0x9c023ab43fa)
                  ;;; <@294,#705> -------------------- Deferred tagged-to-i --------------------
0x9c023ab4a78  2040  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 7644
0x9c023ab4a7c  2044  4d3951ff       REX.W cmpq [r9-0x1],r10
0x9c023ab4a80  2048  7520           jnz 2082  (0x9c023ab4aa2)
0x9c023ab4a82  2050  f2410f104107   movsd xmm0,[r9+0x7]
0x9c023ab4a88  2056  f2440f2cc8     cvttsd2sil r9,xmm0
0x9c023ab4a8d  2061  0f57c9         xorps xmm1,xmm1
0x9c023ab4a90  2064  f2410f2ac9     cvtsi2sd xmm1,r9
0x9c023ab4a95  2069  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab4a99  2073  7507           jnz 2082  (0x9c023ab4aa2)
                  Deferred TaggedToI: NaN
0x9c023ab4a9b  2075  7a05           jpe 2082  (0x9c023ab4aa2)
0x9c023ab4a9d  2077  e9f0f9ffff     jmp 530  (0x9c023ab4492)
0x9c023ab4aa2  2082  e85b18c5ff     call 0x9c023706302       ;; deoptimization bailout 77
0x9c023ab4aa7  2087  e9e6f9ffff     jmp 530  (0x9c023ab4492)
                  ;;; <@378,#726> -------------------- Deferred tagged-to-i --------------------
0x9c023ab4aac  2092  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2205
0x9c023ab4ab0  2096  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab4ab4  2100  751d           jnz 2131  (0x9c023ab4ad3)
0x9c023ab4ab6  2102  f20f104007     movsd xmm0,[rax+0x7]
0x9c023ab4abb  2107  f20f2cc0       cvttsd2sil rax,xmm0
0x9c023ab4abf  2111  0f57c9         xorps xmm1,xmm1
0x9c023ab4ac2  2114  f20f2ac8       cvtsi2sd xmm1,rax
0x9c023ab4ac6  2118  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab4aca  2122  7507           jnz 2131  (0x9c023ab4ad3)
                  Deferred TaggedToI: NaN
0x9c023ab4acc  2124  7a05           jpe 2131  (0x9c023ab4ad3)
0x9c023ab4ace  2126  e942fbffff     jmp 917  (0x9c023ab4615)
0x9c023ab4ad3  2131  e83418c5ff     call 0x9c02370630c       ;; deoptimization bailout 78
0x9c023ab4ad8  2136  e938fbffff     jmp 917  (0x9c023ab4615)
                  ;;; <@420,#727> -------------------- Deferred tagged-to-i --------------------
0x9c023ab4add  2141  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2258
0x9c023ab4ae1  2145  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab4ae5  2149  752a           jnz 2193  (0x9c023ab4b11)
0x9c023ab4ae7  2151  f20f104007     movsd xmm0,[rax+0x7]
0x9c023ab4aec  2156  f20f2cc0       cvttsd2sil rax,xmm0
0x9c023ab4af0  2160  0f57c9         xorps xmm1,xmm1
0x9c023ab4af3  2163  f20f2ac8       cvtsi2sd xmm1,rax
0x9c023ab4af7  2167  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab4afb  2171  7514           jnz 2193  (0x9c023ab4b11)
                  Deferred TaggedToI: NaN
0x9c023ab4afd  2173  7a12           jpe 2193  (0x9c023ab4b11)
0x9c023ab4aff  2175  85c0           testl rax,rax
0x9c023ab4b01  2177  7509           jnz 2188  (0x9c023ab4b0c)
0x9c023ab4b03  2179  660f50c0       movmskpd rax,xmm0
0x9c023ab4b07  2183  83e001         andl rax,0x1
0x9c023ab4b0a  2186  7505           jnz 2193  (0x9c023ab4b11)
0x9c023ab4b0c  2188  e958fbffff     jmp 1001  (0x9c023ab4669)
0x9c023ab4b11  2193  e80018c5ff     call 0x9c023706316       ;; deoptimization bailout 79
0x9c023ab4b16  2198  e94efbffff     jmp 1001  (0x9c023ab4669)
                  ;;; <@434,#731> -------------------- Deferred tagged-to-i --------------------
0x9c023ab4b1b  2203  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2394
0x9c023ab4b1f  2207  4c3952ff       REX.W cmpq [rdx-0x1],r10
0x9c023ab4b23  2211  751d           jnz 2242  (0x9c023ab4b42)
0x9c023ab4b25  2213  f20f104207     movsd xmm0,[rdx+0x7]
0x9c023ab4b2a  2218  f20f2cd0       cvttsd2sil rdx,xmm0
0x9c023ab4b2e  2222  0f57c9         xorps xmm1,xmm1
0x9c023ab4b31  2225  f20f2aca       cvtsi2sd xmm1,rdx
0x9c023ab4b35  2229  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab4b39  2233  7507           jnz 2242  (0x9c023ab4b42)
                  Deferred TaggedToI: NaN
0x9c023ab4b3b  2235  7a05           jpe 2242  (0x9c023ab4b42)
0x9c023ab4b3d  2237  e962fbffff     jmp 1060  (0x9c023ab46a4)
0x9c023ab4b42  2242  e8d917c5ff     call 0x9c023706320       ;; deoptimization bailout 80
0x9c023ab4b47  2247  e958fbffff     jmp 1060  (0x9c023ab46a4)
                  ;;; <@448,#733> -------------------- Deferred tagged-to-i --------------------
0x9c023ab4b4c  2252  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2484
0x9c023ab4b50  2256  4c3950ff       REX.W cmpq [rax-0x1],r10
0x9c023ab4b54  2260  752a           jnz 2304  (0x9c023ab4b80)
0x9c023ab4b56  2262  f20f104007     movsd xmm0,[rax+0x7]
0x9c023ab4b5b  2267  f20f2cc0       cvttsd2sil rax,xmm0
0x9c023ab4b5f  2271  0f57c9         xorps xmm1,xmm1
0x9c023ab4b62  2274  f20f2ac8       cvtsi2sd xmm1,rax
0x9c023ab4b66  2278  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab4b6a  2282  7514           jnz 2304  (0x9c023ab4b80)
                  Deferred TaggedToI: NaN
0x9c023ab4b6c  2284  7a12           jpe 2304  (0x9c023ab4b80)
0x9c023ab4b6e  2286  85c0           testl rax,rax
0x9c023ab4b70  2288  7509           jnz 2299  (0x9c023ab4b7b)
0x9c023ab4b72  2290  660f50c0       movmskpd rax,xmm0
0x9c023ab4b76  2294  83e001         andl rax,0x1
0x9c023ab4b79  2297  7505           jnz 2304  (0x9c023ab4b80)
0x9c023ab4b7b  2299  e95efbffff     jmp 1118  (0x9c023ab46de)
0x9c023ab4b80  2304  e8a517c5ff     call 0x9c02370632a       ;; deoptimization bailout 81
0x9c023ab4b85  2309  e954fbffff     jmp 1118  (0x9c023ab46de)
                  ;;; <@480,#730> -------------------- Deferred tagged-to-i --------------------
0x9c023ab4b8a  2314  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 2513
0x9c023ab4b8e  2318  4d3950ff       REX.W cmpq [r8-0x1],r10
0x9c023ab4b92  2322  752b           jnz 2367  (0x9c023ab4bbf)
0x9c023ab4b94  2324  f2410f104007   movsd xmm0,[r8+0x7]
0x9c023ab4b9a  2330  f24c0f2cc0     REX.W cvttsd2siq r8,xmm0
0x9c023ab4b9f  2335  4983f801       REX.W cmpq r8,0x1
0x9c023ab4ba3  2339  7112           jno 2359  (0x9c023ab4bb7)
0x9c023ab4ba5  2341  4883ec08       REX.W subq rsp,0x8
0x9c023ab4ba9  2345  f20f110424     movsd [rsp],xmm0
0x9c023ab4bae  2350  e88dfbf8ff     call 0x9c023a44740       ;; code: STUB, DoubleToIStub, minor: 266756
0x9c023ab4bb3  2355  4883c408       REX.W addq rsp,0x8
0x9c023ab4bb7  2359  458bc0         movl r8,r8
0x9c023ab4bba  2362  e99cfbffff     jmp 1243  (0x9c023ab475b)
0x9c023ab4bbf  2367  4d3b45a8       REX.W cmpq r8,[r13-0x58]
0x9c023ab4bc3  2371  7508           jnz 2381  (0x9c023ab4bcd)
0x9c023ab4bc5  2373  4533c0         xorl r8,r8
0x9c023ab4bc8  2376  e98efbffff     jmp 1243  (0x9c023ab475b)
0x9c023ab4bcd  2381  4d3b45c0       REX.W cmpq r8,[r13-0x40]
0x9c023ab4bd1  2385  750b           jnz 2398  (0x9c023ab4bde)
0x9c023ab4bd3  2387  41b801000000   movl r8,0x1
0x9c023ab4bd9  2393  e97dfbffff     jmp 1243  (0x9c023ab475b)
0x9c023ab4bde  2398  4d3b45c8       REX.W cmpq r8,[r13-0x38]
                  Deferred TaggedToI: cannot truncate
0x9c023ab4be2  2402  0f851f020000   jnz 2951  (0x9c023ab4e07)
0x9c023ab4be8  2408  4533c0         xorl r8,r8
0x9c023ab4beb  2411  e96bfbffff     jmp 1243  (0x9c023ab475b)
0x9c023ab4bf0  2416  e966fbffff     jmp 1243  (0x9c023ab475b)
                  ;;; <@558,#452> -------------------- Deferred stack-check --------------------
0x9c023ab4bf5  2421  50             push rax                 ;; debug: position 8123
0x9c023ab4bf6  2422  51             push rcx
0x9c023ab4bf7  2423  52             push rdx
0x9c023ab4bf8  2424  53             push rbx
0x9c023ab4bf9  2425  56             push rsi
0x9c023ab4bfa  2426  57             push rdi
0x9c023ab4bfb  2427  4150           push r8
0x9c023ab4bfd  2429  4151           push r9
0x9c023ab4bff  2431  4153           push r11
0x9c023ab4c01  2433  4156           push r14
0x9c023ab4c03  2435  4157           push r15
0x9c023ab4c05  2437  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023ab4c0a  2442  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023ab4c0e  2446  33c0           xorl rax,rax
0x9c023ab4c10  2448  498d9d78f8e4fd REX.W leaq rbx,[r13-0x21b0788]
0x9c023ab4c17  2455  e8a415f5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023ab4c1c  2460  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023ab4c21  2465  415f           pop r15
0x9c023ab4c23  2467  415e           pop r14
0x9c023ab4c25  2469  415b           pop r11
0x9c023ab4c27  2471  4159           pop r9
0x9c023ab4c29  2473  4158           pop r8
0x9c023ab4c2b  2475  5f             pop rdi
0x9c023ab4c2c  2476  5e             pop rsi
0x9c023ab4c2d  2477  5b             pop rbx
0x9c023ab4c2e  2478  5a             pop rdx
0x9c023ab4c2f  2479  59             pop rcx
0x9c023ab4c30  2480  58             pop rax
0x9c023ab4c31  2481  e944fcffff     jmp 1530  (0x9c023ab487a)
                  ;;; <@600,#639> -------------------- Deferred stack-check --------------------
0x9c023ab4c36  2486  50             push rax                 ;; debug: position 8462
0x9c023ab4c37  2487  51             push rcx
0x9c023ab4c38  2488  52             push rdx
0x9c023ab4c39  2489  53             push rbx
0x9c023ab4c3a  2490  56             push rsi
0x9c023ab4c3b  2491  57             push rdi
0x9c023ab4c3c  2492  4150           push r8
0x9c023ab4c3e  2494  4151           push r9
0x9c023ab4c40  2496  4153           push r11
0x9c023ab4c42  2498  4156           push r14
0x9c023ab4c44  2500  4157           push r15
0x9c023ab4c46  2502  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023ab4c4b  2507  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023ab4c4f  2511  33c0           xorl rax,rax
0x9c023ab4c51  2513  498d9d78f8e4fd REX.W leaq rbx,[r13-0x21b0788]
0x9c023ab4c58  2520  e86315f5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023ab4c5d  2525  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023ab4c62  2530  415f           pop r15
0x9c023ab4c64  2532  415e           pop r14
0x9c023ab4c66  2534  415b           pop r11
0x9c023ab4c68  2536  4159           pop r9
0x9c023ab4c6a  2538  4158           pop r8
0x9c023ab4c6c  2540  5f             pop rdi
0x9c023ab4c6d  2541  5e             pop rsi
0x9c023ab4c6e  2542  5b             pop rbx
0x9c023ab4c6f  2543  5a             pop rdx
0x9c023ab4c70  2544  59             pop rcx
0x9c023ab4c71  2545  58             pop rax
0x9c023ab4c72  2546  e958fcffff     jmp 1615  (0x9c023ab48cf)
                  ;;; <@646,#521> -------------------- Deferred stack-check --------------------
0x9c023ab4c77  2551  50             push rax                 ;; debug: position 8241
0x9c023ab4c78  2552  51             push rcx
0x9c023ab4c79  2553  52             push rdx
0x9c023ab4c7a  2554  53             push rbx
0x9c023ab4c7b  2555  56             push rsi
0x9c023ab4c7c  2556  57             push rdi
0x9c023ab4c7d  2557  4150           push r8
0x9c023ab4c7f  2559  4151           push r9
0x9c023ab4c81  2561  4153           push r11
0x9c023ab4c83  2563  4156           push r14
0x9c023ab4c85  2565  4157           push r15
0x9c023ab4c87  2567  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023ab4c8c  2572  488b75f8       REX.W movq rsi,[rbp-0x8]
0x9c023ab4c90  2576  33c0           xorl rax,rax
0x9c023ab4c92  2578  498d9d78f8e4fd REX.W leaq rbx,[r13-0x21b0788]
0x9c023ab4c99  2585  e82215f5ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023ab4c9e  2590  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023ab4ca3  2595  415f           pop r15
0x9c023ab4ca5  2597  415e           pop r14
0x9c023ab4ca7  2599  415b           pop r11
0x9c023ab4ca9  2601  4159           pop r9
0x9c023ab4cab  2603  4158           pop r8
0x9c023ab4cad  2605  5f             pop rdi
0x9c023ab4cae  2606  5e             pop rsi
0x9c023ab4caf  2607  5b             pop rbx
0x9c023ab4cb0  2608  5a             pop rdx
0x9c023ab4cb1  2609  59             pop rcx
0x9c023ab4cb2  2610  58             pop rax
0x9c023ab4cb3  2611  e981fcffff     jmp 1721  (0x9c023ab4939)
                  ;;; -------------------- Jump table --------------------
                  ;;; jump table entry 0: deoptimization bailout 1.
0x9c023ab4cb8  2616  e84d13c5ff     call 0x9c02370600a       ;; deoptimization bailout 1
                  ;;; jump table entry 1: deoptimization bailout 2.
0x9c023ab4cbd  2621  e85213c5ff     call 0x9c023706014       ;; deoptimization bailout 2
                  ;;; jump table entry 2: deoptimization bailout 3.
0x9c023ab4cc2  2626  e85713c5ff     call 0x9c02370601e       ;; deoptimization bailout 3
                  ;;; jump table entry 3: deoptimization bailout 4.
0x9c023ab4cc7  2631  e85c13c5ff     call 0x9c023706028       ;; deoptimization bailout 4
                  ;;; jump table entry 4: deoptimization bailout 5.
0x9c023ab4ccc  2636  e86113c5ff     call 0x9c023706032       ;; deoptimization bailout 5
                  ;;; jump table entry 5: deoptimization bailout 6.
0x9c023ab4cd1  2641  e86613c5ff     call 0x9c02370603c       ;; deoptimization bailout 6
                  ;;; jump table entry 6: deoptimization bailout 7.
0x9c023ab4cd6  2646  e86b13c5ff     call 0x9c023706046       ;; deoptimization bailout 7
                  ;;; jump table entry 7: deoptimization bailout 8.
0x9c023ab4cdb  2651  e87013c5ff     call 0x9c023706050       ;; deoptimization bailout 8
                  ;;; jump table entry 8: deoptimization bailout 9.
0x9c023ab4ce0  2656  e87513c5ff     call 0x9c02370605a       ;; deoptimization bailout 9
                  ;;; jump table entry 9: deoptimization bailout 10.
0x9c023ab4ce5  2661  e87a13c5ff     call 0x9c023706064       ;; deoptimization bailout 10
                  ;;; jump table entry 10: deoptimization bailout 11.
0x9c023ab4cea  2666  e87f13c5ff     call 0x9c02370606e       ;; deoptimization bailout 11
                  ;;; jump table entry 11: deoptimization bailout 12.
0x9c023ab4cef  2671  e88413c5ff     call 0x9c023706078       ;; deoptimization bailout 12
                  ;;; jump table entry 12: deoptimization bailout 13.
0x9c023ab4cf4  2676  e88913c5ff     call 0x9c023706082       ;; deoptimization bailout 13
                  ;;; jump table entry 13: deoptimization bailout 14.
0x9c023ab4cf9  2681  e88e13c5ff     call 0x9c02370608c       ;; deoptimization bailout 14
                  ;;; jump table entry 14: deoptimization bailout 15.
0x9c023ab4cfe  2686  e89313c5ff     call 0x9c023706096       ;; deoptimization bailout 15
                  ;;; jump table entry 15: deoptimization bailout 17.
0x9c023ab4d03  2691  e8a213c5ff     call 0x9c0237060aa       ;; deoptimization bailout 17
                  ;;; jump table entry 16: deoptimization bailout 18.
0x9c023ab4d08  2696  e8a713c5ff     call 0x9c0237060b4       ;; deoptimization bailout 18
                  ;;; jump table entry 17: deoptimization bailout 19.
0x9c023ab4d0d  2701  e8ac13c5ff     call 0x9c0237060be       ;; deoptimization bailout 19
                  ;;; jump table entry 18: deoptimization bailout 20.
0x9c023ab4d12  2706  e8b113c5ff     call 0x9c0237060c8       ;; deoptimization bailout 20
                  ;;; jump table entry 19: deoptimization bailout 21.
0x9c023ab4d17  2711  e8b613c5ff     call 0x9c0237060d2       ;; deoptimization bailout 21
                  ;;; jump table entry 20: deoptimization bailout 22.
0x9c023ab4d1c  2716  e8bb13c5ff     call 0x9c0237060dc       ;; deoptimization bailout 22
                  ;;; jump table entry 21: deoptimization bailout 23.
0x9c023ab4d21  2721  e8c013c5ff     call 0x9c0237060e6       ;; deoptimization bailout 23
                  ;;; jump table entry 22: deoptimization bailout 24.
0x9c023ab4d26  2726  e8c513c5ff     call 0x9c0237060f0       ;; deoptimization bailout 24
                  ;;; jump table entry 23: deoptimization bailout 25.
0x9c023ab4d2b  2731  e8ca13c5ff     call 0x9c0237060fa       ;; deoptimization bailout 25
                  ;;; jump table entry 24: deoptimization bailout 26.
0x9c023ab4d30  2736  e8cf13c5ff     call 0x9c023706104       ;; deoptimization bailout 26
                  ;;; jump table entry 25: deoptimization bailout 27.
0x9c023ab4d35  2741  e8d413c5ff     call 0x9c02370610e       ;; deoptimization bailout 27
                  ;;; jump table entry 26: deoptimization bailout 28.
0x9c023ab4d3a  2746  e8d913c5ff     call 0x9c023706118       ;; deoptimization bailout 28
                  ;;; jump table entry 27: deoptimization bailout 29.
0x9c023ab4d3f  2751  e8de13c5ff     call 0x9c023706122       ;; deoptimization bailout 29
                  ;;; jump table entry 28: deoptimization bailout 31.
0x9c023ab4d44  2756  e8ed13c5ff     call 0x9c023706136       ;; deoptimization bailout 31
                  ;;; jump table entry 29: deoptimization bailout 32.
0x9c023ab4d49  2761  e8f213c5ff     call 0x9c023706140       ;; deoptimization bailout 32
                  ;;; jump table entry 30: deoptimization bailout 33.
0x9c023ab4d4e  2766  e8f713c5ff     call 0x9c02370614a       ;; deoptimization bailout 33
                  ;;; jump table entry 31: deoptimization bailout 34.
0x9c023ab4d53  2771  e8fc13c5ff     call 0x9c023706154       ;; deoptimization bailout 34
                  ;;; jump table entry 32: deoptimization bailout 36.
0x9c023ab4d58  2776  e80b14c5ff     call 0x9c023706168       ;; deoptimization bailout 36
                  ;;; jump table entry 33: deoptimization bailout 37.
0x9c023ab4d5d  2781  e81014c5ff     call 0x9c023706172       ;; deoptimization bailout 37
                  ;;; jump table entry 34: deoptimization bailout 38.
0x9c023ab4d62  2786  e81514c5ff     call 0x9c02370617c       ;; deoptimization bailout 38
                  ;;; jump table entry 35: deoptimization bailout 39.
0x9c023ab4d67  2791  e81a14c5ff     call 0x9c023706186       ;; deoptimization bailout 39
                  ;;; jump table entry 36: deoptimization bailout 40.
0x9c023ab4d6c  2796  e81f14c5ff     call 0x9c023706190       ;; deoptimization bailout 40
                  ;;; jump table entry 37: deoptimization bailout 41.
0x9c023ab4d71  2801  e82414c5ff     call 0x9c02370619a       ;; deoptimization bailout 41
                  ;;; jump table entry 38: deoptimization bailout 42.
0x9c023ab4d76  2806  e82914c5ff     call 0x9c0237061a4       ;; deoptimization bailout 42
                  ;;; jump table entry 39: deoptimization bailout 43.
0x9c023ab4d7b  2811  e82e14c5ff     call 0x9c0237061ae       ;; deoptimization bailout 43
                  ;;; jump table entry 40: deoptimization bailout 44.
0x9c023ab4d80  2816  e83314c5ff     call 0x9c0237061b8       ;; deoptimization bailout 44
                  ;;; jump table entry 41: deoptimization bailout 45.
0x9c023ab4d85  2821  e83814c5ff     call 0x9c0237061c2       ;; deoptimization bailout 45
                  ;;; jump table entry 42: deoptimization bailout 46.
0x9c023ab4d8a  2826  e83d14c5ff     call 0x9c0237061cc       ;; deoptimization bailout 46
                  ;;; jump table entry 43: deoptimization bailout 47.
0x9c023ab4d8f  2831  e84214c5ff     call 0x9c0237061d6       ;; deoptimization bailout 47
                  ;;; jump table entry 44: deoptimization bailout 48.
0x9c023ab4d94  2836  e84714c5ff     call 0x9c0237061e0       ;; deoptimization bailout 48
                  ;;; jump table entry 45: deoptimization bailout 49.
0x9c023ab4d99  2841  e84c14c5ff     call 0x9c0237061ea       ;; deoptimization bailout 49
                  ;;; jump table entry 46: deoptimization bailout 50.
0x9c023ab4d9e  2846  e85114c5ff     call 0x9c0237061f4       ;; deoptimization bailout 50
                  ;;; jump table entry 47: deoptimization bailout 51.
0x9c023ab4da3  2851  e85614c5ff     call 0x9c0237061fe       ;; deoptimization bailout 51
                  ;;; jump table entry 48: deoptimization bailout 52.
0x9c023ab4da8  2856  e85b14c5ff     call 0x9c023706208       ;; deoptimization bailout 52
                  ;;; jump table entry 49: deoptimization bailout 53.
0x9c023ab4dad  2861  e86014c5ff     call 0x9c023706212       ;; deoptimization bailout 53
                  ;;; jump table entry 50: deoptimization bailout 54.
0x9c023ab4db2  2866  e86514c5ff     call 0x9c02370621c       ;; deoptimization bailout 54
                  ;;; jump table entry 51: deoptimization bailout 55.
0x9c023ab4db7  2871  e86a14c5ff     call 0x9c023706226       ;; deoptimization bailout 55
                  ;;; jump table entry 52: deoptimization bailout 57.
0x9c023ab4dbc  2876  e87914c5ff     call 0x9c02370623a       ;; deoptimization bailout 57
                  ;;; jump table entry 53: deoptimization bailout 58.
0x9c023ab4dc1  2881  e87e14c5ff     call 0x9c023706244       ;; deoptimization bailout 58
                  ;;; jump table entry 54: deoptimization bailout 59.
0x9c023ab4dc6  2886  e88314c5ff     call 0x9c02370624e       ;; deoptimization bailout 59
                  ;;; jump table entry 55: deoptimization bailout 61.
0x9c023ab4dcb  2891  e89214c5ff     call 0x9c023706262       ;; deoptimization bailout 61
                  ;;; jump table entry 56: deoptimization bailout 62.
0x9c023ab4dd0  2896  e89714c5ff     call 0x9c02370626c       ;; deoptimization bailout 62
                  ;;; jump table entry 57: deoptimization bailout 63.
0x9c023ab4dd5  2901  e89c14c5ff     call 0x9c023706276       ;; deoptimization bailout 63
                  ;;; jump table entry 58: deoptimization bailout 64.
0x9c023ab4dda  2906  e8a114c5ff     call 0x9c023706280       ;; deoptimization bailout 64
                  ;;; jump table entry 59: deoptimization bailout 65.
0x9c023ab4ddf  2911  e8a614c5ff     call 0x9c02370628a       ;; deoptimization bailout 65
                  ;;; jump table entry 60: deoptimization bailout 67.
0x9c023ab4de4  2916  e8b514c5ff     call 0x9c02370629e       ;; deoptimization bailout 67
                  ;;; jump table entry 61: deoptimization bailout 68.
0x9c023ab4de9  2921  e8ba14c5ff     call 0x9c0237062a8       ;; deoptimization bailout 68
                  ;;; jump table entry 62: deoptimization bailout 69.
0x9c023ab4dee  2926  e8bf14c5ff     call 0x9c0237062b2       ;; deoptimization bailout 69
                  ;;; jump table entry 63: deoptimization bailout 70.
0x9c023ab4df3  2931  e8c414c5ff     call 0x9c0237062bc       ;; deoptimization bailout 70
                  ;;; jump table entry 64: deoptimization bailout 71.
0x9c023ab4df8  2936  e8c914c5ff     call 0x9c0237062c6       ;; deoptimization bailout 71
                  ;;; jump table entry 65: deoptimization bailout 72.
0x9c023ab4dfd  2941  e8ce14c5ff     call 0x9c0237062d0       ;; deoptimization bailout 72
                  ;;; jump table entry 66: deoptimization bailout 73.
0x9c023ab4e02  2946  e8d314c5ff     call 0x9c0237062da       ;; deoptimization bailout 73
                  ;;; jump table entry 67: deoptimization bailout 82.
0x9c023ab4e07  2951  e82815c5ff     call 0x9c023706334       ;; deoptimization bailout 82
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 83)
 index  ast id    argc     pc             
     0       3       0     35
     1       3       0     -1
     2       2       0     -1
     3       2       0     -1
     4      14       0     -1
     5      14       0     -1
     6      14       0     -1
     7      14       0     -1
     8      14       0     -1
     9      14       0     -1
    10      14       0     -1
    11      14       0     -1
    12      14       0     -1
    13      14       0     -1
    14      14       0     -1
    15      14       0     -1
    16     105       0     -1
    17      26       0     -1
    18      26       0     -1
    19      26       0     -1
    20      26       0     -1
    21      26       0     -1
    22      26       0     -1
    23      26       0     -1
    24      26       0     -1
    25      26       0     -1
    26      26       0     -1
    27      26       0     -1
    28      26       0     -1
    29      26       0     -1
    30     135       0    717
    31     135       0     -1
    32     149       0     -1
    33     149       0     -1
    34     168       0     -1
    35      16       0    975
    36      19       0     -1
    37      28       0     -1
    38      54       0     -1
    39      63       0     -1
    40      63       0     -1
    41      63       0     -1
    42      81       0     -1
    43      81       0     -1
    44      81       0     -1
    45     176       0     -1
    46     176       0     -1
    47     176       0     -1
    48     176       0     -1
    49     176       0     -1
    50     206       0     -1
    51     206       0     -1
    52     206       0     -1
    53     216       0     -1
    54     216       0     -1
    55     244       0     -1
    56     248       0   1530
    57     248       0     -1
    58     248       0     -1
    59     438       0     -1
    60     442       0   1615
    61     442       0     -1
    62     442       0     -1
    63     442       0     -1
    64     442       0     -1
    65     315       0     -1
    66     319       0   1721
    67     319       0     -1
    68     319       0     -1
    69     319       0     -1
    70     319       0     -1
    71     380       0     -1
    72     409       0     -1
    73     409       0     -1
    74      14       0     -1
    75      14       0     -1
    76      17       0     -1
    77      26       0     -1
    78       2       0     -1
    79      19       0     -1
    80      28       0     -1
    81      54       0     -1
    82      63       0     -1

Safepoints (size = 80)
0x9c023ab42a3    35  00000000001 (sp -> fp)       0
0x9c023ab454d   717  00000000001 (sp -> fp)      30
0x9c023ab464f   975  00001000001 (sp -> fp)      35
0x9c023ab4c1c  2460  00100000001 | rbx | rdi (sp -> fp)      56
0x9c023ab4c5d  2525  00000000001 | rbx (sp -> fp)      60
0x9c023ab4c9e  2590  00100000001 | rbx (sp -> fp)      66

RelocInfo (size = 5404)
0x9c023ab428a  position  (7487)
0x9c023ab428a  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x9c023ab428a  comment  (;;; <@2,#1> context)
0x9c023ab428e  comment  (;;; <@3,#1> gap)
0x9c023ab4292  comment  (;;; <@12,#9> -------------------- B1 --------------------)
0x9c023ab4292  comment  (;;; <@13,#9> gap)
0x9c023ab4295  comment  (;;; <@14,#11> stack-check)
0x9c023ab429f  code target (BUILTIN)  (0x9c023a25e60)
0x9c023ab42a3  comment  (;;; <@16,#11> lazy-bailout)
0x9c023ab42a3  comment  (;;; <@17,#11> gap)
0x9c023ab42a7  comment  (;;; <@18,#12> load-context-slot)
0x9c023ab42a7  position  (7504)
0x9c023ab42ae  comment  (;;; <@20,#13> check-value)
0x9c023ab42b0  embedded object  (0x364e0635f6a1 <JS Function equal (SharedFunctionInfo 0xc1217b4d9c9)>)
0x9c023ab42c1  comment  (;;; <@22,#15> load-context-slot)
0x9c023ab42c1  position  (7513)
0x9c023ab42c8  comment  (;;; <@23,#15> gap)
0x9c023ab42d0  comment  (;;; <@24,#707> check-smi)
0x9c023ab42d0  position  (13101)
0x9c023ab42d9  comment  (;;; <@25,#707> gap)
0x9c023ab42dc  comment  (;;; <@26,#711> check-smi)
0x9c023ab42dc  position  (13107)
0x9c023ab42e6  position  (13103)
0x9c023ab42e6  comment  (;;; <@29,#20> compare-numeric-and-branch)
0x9c023ab42ef  comment  (;;; <@30,#24> -------------------- B2 (unreachable/replaced) --------------------)
0x9c023ab42ef  position  (13136)
0x9c023ab42ef  comment  (;;; <@34,#38> -------------------- B3 --------------------)
0x9c023ab42ef  comment  (;;; <@36,#17> constant-t)
0x9c023ab42ef  position  (13084)
0x9c023ab42f1  embedded object  (0x364e0635ef91 <FixedArray[49]>)
0x9c023ab42f9  comment  (;;; <@38,#39> load-context-slot)
0x9c023ab42f9  position  (13136)
0x9c023ab4300  comment  (;;; <@40,#40> check-non-smi)
0x9c023ab4300  position  (13141)
0x9c023ab4309  comment  (;;; <@42,#41> check-maps)
0x9c023ab430b  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab431d  comment  (;;; <@44,#42> load-named-field)
0x9c023ab4321  comment  (;;; <@46,#43> load-named-field)
0x9c023ab4324  comment  (;;; <@48,#44> load-named-field)
0x9c023ab4328  comment  (;;; <@49,#44> gap)
0x9c023ab432c  comment  (;;; <@50,#706> tagged-to-i)
0x9c023ab4339  comment  (;;; <@52,#45> bounds-check)
0x9c023ab4341  comment  (;;; <@54,#46> load-keyed)
0x9c023ab434e  comment  (;;; <@56,#17> constant-t)
0x9c023ab434e  position  (13084)
0x9c023ab4350  embedded object  (0x364e0635ef91 <FixedArray[49]>)
0x9c023ab4358  comment  (;;; <@58,#48> load-context-slot)
0x9c023ab4358  position  (13161)
0x9c023ab435f  comment  (;;; <@60,#50> check-non-smi)
0x9c023ab435f  position  (13166)
0x9c023ab4368  comment  (;;; <@62,#51> check-maps)
0x9c023ab436a  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab437c  comment  (;;; <@64,#52> load-named-field)
0x9c023ab4380  comment  (;;; <@66,#53> load-named-field)
0x9c023ab4384  comment  (;;; <@68,#54> load-named-field)
0x9c023ab4388  comment  (;;; <@70,#55> bounds-check)
0x9c023ab4391  comment  (;;; <@72,#56> load-keyed)
0x9c023ab439e  comment  (;;; <@73,#56> gap)
0x9c023ab43a1  comment  (;;; <@74,#710> tagged-to-i)
0x9c023ab43a1  position  (13189)
0x9c023ab43af  comment  (;;; <@76,#64> bounds-check)
0x9c023ab43b8  comment  (;;; <@78,#65> load-keyed)
0x9c023ab43c4  comment  (;;; <@80,#74> bounds-check)
0x9c023ab43c4  position  (13214)
0x9c023ab43cd  comment  (;;; <@82,#75> load-keyed)
0x9c023ab43d8  position  (13235)
0x9c023ab43d8  comment  (;;; <@85,#79> compare-numeric-and-branch)
0x9c023ab43e1  comment  (;;; <@86,#83> -------------------- B4 (unreachable/replaced) --------------------)
0x9c023ab43e1  comment  (;;; <@90,#86> -------------------- B5 (unreachable/replaced) --------------------)
0x9c023ab43e1  comment  (;;; <@94,#93> -------------------- B6 (unreachable/replaced) --------------------)
0x9c023ab43e1  comment  (;;; <@98,#89> -------------------- B7 (unreachable/replaced) --------------------)
0x9c023ab43e1  comment  (;;; <@102,#80> -------------------- B8 (unreachable/replaced) --------------------)
0x9c023ab43e1  position  (13279)
0x9c023ab43e1  comment  (;;; <@106,#97> -------------------- B9 --------------------)
0x9c023ab43e1  comment  (;;; <@108,#110> gap)
0x9c023ab43e4  position  (13282)
0x9c023ab43e4  comment  (;;; <@110,#111> -------------------- B10 (loop header) --------------------)
0x9c023ab43e4  comment  (;;; <@112,#114> deoptimize)
0x9c023ab43e4  position  (13284)
0x9c023ab43e4  comment  (;;; deoptimize: Insufficient type feedback for combined type of binary operation)
0x9c023ab43e5  runtime entry
0x9c023ab43e9  comment  (;;; <@114,#115> -------------------- B11 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@126,#119> -------------------- B12 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@130,#125> -------------------- B13 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@138,#132> -------------------- B14 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@142,#134> -------------------- B15 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@154,#138> -------------------- B16 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@168,#145> -------------------- B17 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@172,#147> -------------------- B18 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@182,#151> -------------------- B19 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@194,#155> -------------------- B20 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@204,#159> -------------------- B21 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@208,#176> -------------------- B22 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@220,#122> -------------------- B23 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@224,#183> -------------------- B24 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@228,#190> -------------------- B25 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@232,#186> -------------------- B26 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@236,#162> -------------------- B27 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@240,#165> -------------------- B28 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@244,#172> -------------------- B29 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@248,#168> -------------------- B30 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@252,#21> -------------------- B31 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@256,#27> -------------------- B32 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@260,#34> -------------------- B33 (unreachable/replaced) --------------------)
0x9c023ab43e9  comment  (;;; <@264,#197> -------------------- B34 (unreachable/replaced) --------------------)
0x9c023ab43e9  position  (7554)
0x9c023ab43e9  comment  (;;; <@268,#204> -------------------- B35 --------------------)
0x9c023ab43e9  comment  (;;; <@269,#204> gap)
0x9c023ab43ed  comment  (;;; <@270,#709> tagged-to-i)
0x9c023ab43ed  position  (7550)
0x9c023ab43fa  comment  (;;; <@272,#206> div-by-const-i)
0x9c023ab43fa  position  (7552)
0x9c023ab440b  comment  (;;; <@273,#206> gap)
0x9c023ab4412  comment  (;;; <@274,#213> mod-by-const-i)
0x9c023ab4412  position  (7579)
0x9c023ab4435  comment  (;;; <@275,#213> gap)
0x9c023ab4439  comment  (;;; <@276,#205> constant-i)
0x9c023ab4439  position  (7554)
0x9c023ab443e  comment  (;;; <@278,#218> sub-i)
0x9c023ab443e  position  (7609)
0x9c023ab4440  comment  (;;; <@279,#218> gap)
0x9c023ab4448  comment  (;;; <@280,#221> load-context-slot)
0x9c023ab4448  position  (7634)
0x9c023ab444f  comment  (;;; <@282,#222> load-context-slot)
0x9c023ab444f  position  (7639)
0x9c023ab4456  comment  (;;; <@284,#223> check-non-smi)
0x9c023ab4456  position  (7644)
0x9c023ab4460  comment  (;;; <@286,#224> check-maps)
0x9c023ab4462  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab4474  comment  (;;; <@288,#225> load-named-field)
0x9c023ab4478  comment  (;;; <@290,#226> load-named-field)
0x9c023ab447c  comment  (;;; <@292,#227> load-named-field)
0x9c023ab4480  comment  (;;; <@293,#227> gap)
0x9c023ab4484  comment  (;;; <@294,#705> tagged-to-i)
0x9c023ab4492  comment  (;;; <@295,#705> gap)
0x9c023ab4496  comment  (;;; <@296,#228> bounds-check)
0x9c023ab449f  comment  (;;; <@298,#229> load-keyed)
0x9c023ab44ac  comment  (;;; <@300,#230> check-non-smi)
0x9c023ab44b6  comment  (;;; <@302,#231> check-maps)
0x9c023ab44b8  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab44ca  comment  (;;; <@304,#232> load-named-field)
0x9c023ab44ce  comment  (;;; <@306,#233> load-named-field)
0x9c023ab44d1  comment  (;;; <@308,#234> load-named-field)
0x9c023ab44d5  comment  (;;; <@310,#235> bounds-check)
0x9c023ab44de  comment  (;;; <@312,#236> load-keyed)
0x9c023ab44eb  comment  (;;; <@313,#236> gap)
0x9c023ab44ef  comment  (;;; <@314,#248> add-i)
0x9c023ab44ef  position  (7866)
0x9c023ab44f8  comment  (;;; <@316,#251> sub-i)
0x9c023ab44f8  position  (7875)
0x9c023ab4502  comment  (;;; <@318,#258> bounds-check)
0x9c023ab450b  comment  (;;; <@320,#259> load-keyed)
0x9c023ab450f  comment  (;;; <@321,#259> gap)
0x9c023ab4513  comment  (;;; <@322,#262> load-context-slot)
0x9c023ab4513  position  (7909)
0x9c023ab4517  comment  (;;; <@324,#263> check-value)
0x9c023ab4519  embedded object  (0x364e0632b061 <JS Function pow (SharedFunctionInfo 0x364e0632a0d9)>)
0x9c023ab452a  comment  (;;; <@326,#266> push-argument)
0x9c023ab452a  position  (7915)
0x9c023ab452c  embedded object  (0x364e06304121 <undefined>)
0x9c023ab4536  comment  (;;; <@328,#267> push-argument)
0x9c023ab453c  comment  (;;; <@330,#720> smi-tag)
0x9c023ab4542  comment  (;;; <@332,#268> push-argument)
0x9c023ab4543  comment  (;;; <@333,#268> gap)
0x9c023ab4546  comment  (;;; <@334,#269> invoke-function)
0x9c023ab454d  comment  (;;; <@336,#270> lazy-bailout)
0x9c023ab454d  comment  (;;; <@337,#270> gap)
0x9c023ab4551  comment  (;;; <@338,#721> uint32-to-double)
0x9c023ab4551  position  (7902)
0x9c023ab4556  comment  (;;; <@340,#723> double-untag)
0x9c023ab4556  position  (7909)
0x9c023ab458d  comment  (;;; <@342,#271> mul-d)
0x9c023ab458d  position  (7907)
0x9c023ab4591  comment  (;;; <@344,#724> constant-d)
0x9c023ab4591  position  (7922)
0x9c023ab45a0  comment  (;;; <@347,#274> compare-numeric-and-branch)
0x9c023ab45b0  comment  (;;; <@348,#278> -------------------- B36 (unreachable/replaced) --------------------)
0x9c023ab45b0  position  (7940)
0x9c023ab45b0  comment  (;;; <@352,#283> -------------------- B37 --------------------)
0x9c023ab45b0  comment  (;;; <@354,#288> gap)
0x9c023ab45b2  comment  (;;; <@355,#288> goto)
0x9c023ab45b7  comment  (;;; <@356,#275> -------------------- B38 (unreachable/replaced) --------------------)
0x9c023ab45b7  position  (7936)
0x9c023ab45b7  comment  (;;; <@360,#281> -------------------- B39 --------------------)
0x9c023ab45b7  comment  (;;; <@362,#286> gap)
0x9c023ab45b7  position  (7940)
0x9c023ab45bc  comment  (;;; <@364,#290> -------------------- B40 --------------------)
0x9c023ab45bc  comment  (;;; <@365,#290> gap)
0x9c023ab45c0  comment  (;;; <@366,#292> load-context-slot)
0x9c023ab45c0  position  (7955)
0x9c023ab45c7  comment  (;;; <@367,#292> gap)
0x9c023ab45cb  comment  (;;; <@368,#293> check-value)
0x9c023ab45cd  embedded object  (0x364e0635fca1 <JS Function alloc (SharedFunctionInfo 0xc1217b4f389)>)
0x9c023ab45de  comment  (;;; <@369,#293> gap)
0x9c023ab45e2  comment  (;;; <@370,#296> add-i)
0x9c023ab45e2  position  (7968)
0x9c023ab45eb  comment  (;;; <@371,#296> gap)
0x9c023ab45ee  comment  (;;; <@372,#299> add-i)
0x9c023ab45ee  position  (7976)
0x9c023ab45f7  comment  (;;; <@373,#299> gap)
0x9c023ab45fb  comment  (;;; <@374,#302> constant-t)
0x9c023ab45fb  position  (2106)
0x9c023ab45fd  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab4605  comment  (;;; <@376,#305> load-context-slot)
0x9c023ab4605  position  (2205)
0x9c023ab4609  comment  (;;; <@378,#726> tagged-to-i)
0x9c023ab4615  position  (2203)
0x9c023ab4615  comment  (;;; <@381,#306> compare-numeric-and-branch)
0x9c023ab461e  comment  (;;; <@382,#310> -------------------- B41 (unreachable/replaced) --------------------)
0x9c023ab461e  comment  (;;; <@386,#321> -------------------- B42 (unreachable/replaced) --------------------)
0x9c023ab461e  comment  (;;; <@390,#307> -------------------- B43 (unreachable/replaced) --------------------)
0x9c023ab461e  position  (2229)
0x9c023ab461e  comment  (;;; <@394,#313> -------------------- B44 --------------------)
0x9c023ab461e  comment  (;;; <@396,#302> constant-t)
0x9c023ab461e  position  (2106)
0x9c023ab4620  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab4628  comment  (;;; <@398,#314> load-context-slot)
0x9c023ab4628  position  (2229)
0x9c023ab462c  comment  (;;; <@400,#315> push-argument)
0x9c023ab462c  position  (2236)
0x9c023ab462e  embedded object  (0x364e06304121 <undefined>)
0x9c023ab4638  comment  (;;; <@402,#725> smi-tag)
0x9c023ab463f  comment  (;;; <@404,#316> push-argument)
0x9c023ab4640  comment  (;;; <@406,#302> constant-t)
0x9c023ab4640  position  (2106)
0x9c023ab4642  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab464a  comment  (;;; <@408,#317> call-function)
0x9c023ab464a  position  (2236)
0x9c023ab464b  code target (STUB)  (0x9c023a28d20)
0x9c023ab464f  comment  (;;; <@410,#318> lazy-bailout)
0x9c023ab464f  position  (2258)
0x9c023ab464f  comment  (;;; <@414,#324> -------------------- B45 --------------------)
0x9c023ab464f  comment  (;;; <@416,#302> constant-t)
0x9c023ab464f  position  (2106)
0x9c023ab4651  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab4659  comment  (;;; <@418,#325> load-context-slot)
0x9c023ab4659  position  (2258)
0x9c023ab465d  comment  (;;; <@420,#727> tagged-to-i)
0x9c023ab4669  comment  (;;; <@422,#326> sub-i)
0x9c023ab4669  position  (2271)
0x9c023ab4672  comment  (;;; <@424,#728> smi-tag)
0x9c023ab4678  comment  (;;; <@426,#302> constant-t)
0x9c023ab4678  position  (2106)
0x9c023ab467a  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab4682  comment  (;;; <@428,#328> store-context-slot)
0x9c023ab4682  position  (2271)
0x9c023ab4686  comment  (;;; <@430,#302> constant-t)
0x9c023ab4686  position  (2106)
0x9c023ab4688  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab4690  comment  (;;; <@432,#330> load-context-slot)
0x9c023ab4690  position  (2378)
0x9c023ab4694  comment  (;;; <@433,#330> gap)
0x9c023ab4697  comment  (;;; <@434,#731> tagged-to-i)
0x9c023ab4697  position  (2394)
0x9c023ab46a4  comment  (;;; <@435,#731> gap)
0x9c023ab46a7  comment  (;;; <@436,#333> add-i)
0x9c023ab46a7  position  (2398)
0x9c023ab46b0  comment  (;;; <@438,#732> smi-tag)
0x9c023ab46b6  comment  (;;; <@440,#302> constant-t)
0x9c023ab46b6  position  (2106)
0x9c023ab46b8  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab46c0  comment  (;;; <@442,#335> store-context-slot)
0x9c023ab46c0  position  (2398)
0x9c023ab46c4  comment  (;;; <@444,#302> constant-t)
0x9c023ab46c4  position  (2106)
0x9c023ab46c6  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab46ce  comment  (;;; <@446,#337> load-context-slot)
0x9c023ab46ce  position  (2484)
0x9c023ab46d2  comment  (;;; <@448,#733> tagged-to-i)
0x9c023ab46de  comment  (;;; <@449,#733> gap)
0x9c023ab46e5  comment  (;;; <@450,#339> add-i)
0x9c023ab46ee  comment  (;;; <@452,#735> smi-tag)
0x9c023ab46f4  comment  (;;; <@454,#302> constant-t)
0x9c023ab46f4  position  (2106)
0x9c023ab46f6  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab46fe  comment  (;;; <@456,#340> store-context-slot)
0x9c023ab46fe  position  (2484)
0x9c023ab4702  comment  (;;; <@458,#302> constant-t)
0x9c023ab4702  position  (2106)
0x9c023ab4704  embedded object  (0x364e0635fc49 <FixedArray[9]>)
0x9c023ab470c  comment  (;;; <@460,#343> load-named-field)
0x9c023ab470c  position  (2497)
0x9c023ab4710  comment  (;;; <@462,#344> load-context-slot)
0x9c023ab4717  comment  (;;; <@464,#347> check-non-smi)
0x9c023ab4717  position  (2513)
0x9c023ab4721  comment  (;;; <@466,#348> check-maps)
0x9c023ab4723  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab4735  comment  (;;; <@468,#350> check-maps)
0x9c023ab4735  comment  (;;; <@470,#352> check-maps)
0x9c023ab4735  comment  (;;; <@472,#353> load-named-field)
0x9c023ab4739  comment  (;;; <@474,#354> load-named-field)
0x9c023ab473d  comment  (;;; <@476,#355> load-named-field)
0x9c023ab4741  comment  (;;; <@478,#356> bounds-check)
0x9c023ab474a  comment  (;;; <@479,#356> gap)
0x9c023ab474d  comment  (;;; <@480,#730> tagged-to-i)
0x9c023ab475b  comment  (;;; <@482,#357> store-keyed)
0x9c023ab475f  comment  (;;; <@484,#360> load-context-slot)
0x9c023ab475f  position  (2528)
0x9c023ab4766  comment  (;;; <@486,#362> check-non-smi)
0x9c023ab4766  position  (2545)
0x9c023ab476f  comment  (;;; <@488,#363> check-maps)
0x9c023ab4771  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab4783  comment  (;;; <@490,#368> load-named-field)
0x9c023ab4787  comment  (;;; <@492,#369> load-named-field)
0x9c023ab478a  comment  (;;; <@494,#370> load-named-field)
0x9c023ab478e  comment  (;;; <@496,#371> bounds-check)
0x9c023ab4796  comment  (;;; <@497,#371> gap)
0x9c023ab479a  comment  (;;; <@498,#372> store-keyed)
0x9c023ab479d  position  (2565)
0x9c023ab479d  position  (7976)
0x9c023ab479d  comment  (;;; <@502,#378> -------------------- B46 --------------------)
0x9c023ab479d  comment  (;;; <@503,#378> gap)
0x9c023ab47a1  comment  (;;; <@504,#380> load-context-slot)
0x9c023ab47a1  position  (8002)
0x9c023ab47a8  comment  (;;; <@506,#382> check-non-smi)
0x9c023ab47a8  position  (8007)
0x9c023ab47b1  comment  (;;; <@508,#383> check-maps)
0x9c023ab47b3  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab47c5  comment  (;;; <@510,#384> load-named-field)
0x9c023ab47c9  comment  (;;; <@512,#385> load-named-field)
0x9c023ab47cc  comment  (;;; <@514,#386> load-named-field)
0x9c023ab47d0  comment  (;;; <@516,#387> bounds-check)
0x9c023ab47d8  comment  (;;; <@518,#388> load-keyed)
0x9c023ab47e6  comment  (;;; <@520,#390> load-context-slot)
0x9c023ab47e6  position  (8014)
0x9c023ab47ed  comment  (;;; <@521,#390> gap)
0x9c023ab47f4  comment  (;;; <@522,#393> add-i)
0x9c023ab47f4  position  (8022)
0x9c023ab47fe  comment  (;;; <@524,#396> check-non-smi)
0x9c023ab47fe  position  (8029)
0x9c023ab4808  comment  (;;; <@526,#397> check-maps)
0x9c023ab480a  embedded object  (0x2ccb5ec0bd51 <Map(elements=13)>)
0x9c023ab481c  comment  (;;; <@528,#402> load-named-field)
0x9c023ab4820  comment  (;;; <@530,#403> load-named-field)
0x9c023ab4824  comment  (;;; <@532,#404> load-named-field)
0x9c023ab4828  comment  (;;; <@534,#405> bounds-check)
0x9c023ab4831  comment  (;;; <@536,#208> constant-i)
0x9c023ab4831  position  (7560)
0x9c023ab4834  comment  (;;; <@538,#406> store-keyed)
0x9c023ab4834  position  (8029)
0x9c023ab4839  comment  (;;; <@539,#406> gap)
0x9c023ab483d  comment  (;;; <@540,#414> bounds-check)
0x9c023ab483d  position  (8066)
0x9c023ab4846  comment  (;;; <@542,#415> load-keyed)
0x9c023ab4853  comment  (;;; <@543,#415> gap)
0x9c023ab4857  comment  (;;; <@544,#441> add-i)
0x9c023ab4857  position  (8131)
0x9c023ab4860  comment  (;;; <@546,#436> gap)
0x9c023ab4860  position  (8118)
0x9c023ab4865  position  (8121)
0x9c023ab4865  comment  (;;; <@548,#437> -------------------- B47 (loop header) --------------------)
0x9c023ab4865  position  (8123)
0x9c023ab4865  comment  (;;; <@551,#443> compare-numeric-and-branch)
0x9c023ab486d  comment  (;;; <@552,#444> -------------------- B48 (unreachable/replaced) --------------------)
0x9c023ab486d  comment  (;;; <@556,#450> -------------------- B49 --------------------)
0x9c023ab486d  comment  (;;; <@558,#452> stack-check)
0x9c023ab487a  comment  (;;; <@559,#452> gap)
0x9c023ab487d  comment  (;;; <@560,#456> add-i)
0x9c023ab487d  position  (8158)
0x9c023ab4886  comment  (;;; <@562,#468> bounds-check)
0x9c023ab4886  position  (8165)
0x9c023ab488f  comment  (;;; <@564,#208> constant-i)
0x9c023ab488f  position  (7560)
0x9c023ab4892  comment  (;;; <@566,#469> store-keyed)
0x9c023ab4892  position  (8165)
0x9c023ab4896  comment  (;;; <@568,#472> add-i)
0x9c023ab4896  position  (8136)
0x9c023ab4899  comment  (;;; <@571,#475> goto)
0x9c023ab489b  comment  (;;; <@572,#447> -------------------- B50 (unreachable/replaced) --------------------)
0x9c023ab489b  position  (8183)
0x9c023ab489b  comment  (;;; <@576,#476> -------------------- B51 --------------------)
0x9c023ab489b  comment  (;;; <@578,#479> gap)
0x9c023ab489b  position  (8188)
0x9c023ab489f  comment  (;;; <@579,#479> compare-numeric-and-branch)
0x9c023ab48a8  comment  (;;; <@580,#483> -------------------- B52 (unreachable/replaced) --------------------)
0x9c023ab48a8  position  (8457)
0x9c023ab48a8  comment  (;;; <@584,#606> -------------------- B53 --------------------)
0x9c023ab48a8  comment  (;;; <@585,#606> gap)
0x9c023ab48ab  comment  (;;; <@586,#643> add-i)
0x9c023ab48ab  position  (8496)
0x9c023ab48b4  comment  (;;; <@588,#626> gap)
0x9c023ab48b4  position  (8457)
0x9c023ab48b9  position  (8460)
0x9c023ab48b9  comment  (;;; <@590,#627> -------------------- B54 (loop header) --------------------)
0x9c023ab48b9  position  (8462)
0x9c023ab48b9  comment  (;;; <@593,#630> compare-numeric-and-branch)
0x9c023ab48c2  comment  (;;; <@594,#631> -------------------- B55 (unreachable/replaced) --------------------)
0x9c023ab48c2  comment  (;;; <@598,#637> -------------------- B56 --------------------)
0x9c023ab48c2  comment  (;;; <@600,#639> stack-check)
0x9c023ab48cf  comment  (;;; <@601,#639> gap)
0x9c023ab48d2  comment  (;;; <@602,#646> add-i)
0x9c023ab48d2  position  (8504)
0x9c023ab48da  comment  (;;; <@603,#646> gap)
0x9c023ab48dd  comment  (;;; <@604,#651> add-i)
0x9c023ab48dd  position  (8519)
0x9c023ab48e6  comment  (;;; <@606,#658> bounds-check)
0x9c023ab48ef  comment  (;;; <@608,#659> load-keyed)
0x9c023ab48f3  comment  (;;; <@610,#669> bounds-check)
0x9c023ab48fc  comment  (;;; <@612,#670> store-keyed)
0x9c023ab4900  comment  (;;; <@614,#673> add-i)
0x9c023ab4900  position  (8472)
0x9c023ab4903  comment  (;;; <@617,#676> goto)
0x9c023ab4905  comment  (;;; <@618,#634> -------------------- B57 (unreachable/replaced) --------------------)
0x9c023ab4905  comment  (;;; <@622,#679> -------------------- B58 (unreachable/replaced) --------------------)
0x9c023ab4905  comment  (;;; <@626,#480> -------------------- B59 (unreachable/replaced) --------------------)
0x9c023ab4905  position  (8214)
0x9c023ab4905  comment  (;;; <@630,#486> -------------------- B60 --------------------)
0x9c023ab4905  comment  (;;; <@631,#486> gap)
0x9c023ab4908  comment  (;;; <@632,#525> add-i)
0x9c023ab4908  position  (8275)
0x9c023ab4912  comment  (;;; <@633,#525> gap)
0x9c023ab4916  comment  (;;; <@634,#508> gap)
0x9c023ab4916  position  (8236)
0x9c023ab491e  position  (8239)
0x9c023ab491e  comment  (;;; <@636,#509> -------------------- B61 (loop header) --------------------)
0x9c023ab4922  position  (8241)
0x9c023ab4922  comment  (;;; <@639,#512> compare-numeric-and-branch)
0x9c023ab492c  comment  (;;; <@640,#513> -------------------- B62 (unreachable/replaced) --------------------)
0x9c023ab492c  comment  (;;; <@644,#519> -------------------- B63 --------------------)
0x9c023ab492c  comment  (;;; <@646,#521> stack-check)
0x9c023ab4939  comment  (;;; <@647,#521> gap)
0x9c023ab493d  comment  (;;; <@648,#528> add-i)
0x9c023ab493d  position  (8283)
0x9c023ab4946  comment  (;;; <@649,#528> gap)
0x9c023ab4949  comment  (;;; <@650,#534> add-i)
0x9c023ab4949  position  (8308)
0x9c023ab4952  comment  (;;; <@652,#541> bounds-check)
0x9c023ab495b  comment  (;;; <@654,#542> load-keyed)
0x9c023ab495f  comment  (;;; <@655,#542> gap)
0x9c023ab4962  comment  (;;; <@656,#544> shift-i)
0x9c023ab4962  position  (8313)
0x9c023ab4965  comment  (;;; <@658,#546> add-i)
0x9c023ab4965  position  (8297)
0x9c023ab4969  comment  (;;; <@660,#549> bit-i)
0x9c023ab4969  position  (8323)
0x9c023ab4970  comment  (;;; <@662,#560> bounds-check)
0x9c023ab4979  comment  (;;; <@664,#561> store-keyed)
0x9c023ab497d  comment  (;;; <@666,#574> load-keyed)
0x9c023ab497d  position  (8359)
0x9c023ab4981  comment  (;;; <@667,#574> gap)
0x9c023ab4985  comment  (;;; <@668,#576> shift-i)
0x9c023ab4985  position  (8364)
0x9c023ab498f  comment  (;;; <@670,#580> add-i)
0x9c023ab498f  position  (8251)
0x9c023ab4993  comment  (;;; <@672,#583> gap)
0x9c023ab4996  comment  (;;; <@673,#583> goto)
0x9c023ab4998  comment  (;;; <@674,#516> -------------------- B64 (unreachable/replaced) --------------------)
0x9c023ab4998  position  (8394)
0x9c023ab4998  comment  (;;; <@678,#584> -------------------- B65 --------------------)
0x9c023ab4998  comment  (;;; <@679,#584> gap)
0x9c023ab499c  comment  (;;; <@680,#591> add-i)
0x9c023ab499c  position  (8410)
0x9c023ab49a5  comment  (;;; <@682,#603> bounds-check)
0x9c023ab49a5  position  (8417)
0x9c023ab49ae  comment  (;;; <@683,#603> gap)
0x9c023ab49b2  comment  (;;; <@684,#604> store-keyed)
0x9c023ab49b6  position  (8472)
0x9c023ab49b6  position  (8549)
0x9c023ab49b6  comment  (;;; <@688,#698> -------------------- B66 --------------------)
0x9c023ab49b6  comment  (;;; <@689,#698> gap)
0x9c023ab49ba  comment  (;;; <@690,#734> smi-tag)
0x9c023ab49c0  comment  (;;; <@691,#734> gap)
0x9c023ab49c3  comment  (;;; <@692,#701> return)
0x9c023ab49ca  comment  (;;; <@694,#30> -------------------- B67 (unreachable/replaced) --------------------)
0x9c023ab49ca  comment  (;;; <@698,#194> -------------------- B68 (unreachable/replaced) --------------------)
0x9c023ab49ca  position  (7528)
0x9c023ab49ca  comment  (;;; <@702,#200> -------------------- B69 --------------------)
0x9c023ab49ca  comment  (;;; <@703,#200> gap)
0x9c023ab49ce  comment  (;;; <@704,#203> return)
0x9c023ab49d5  position  (13141)
0x9c023ab49d5  comment  (;;; <@50,#706> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab49f3  comment  (Deferred TaggedToI: lost precision)
0x9c023ab49f5  comment  (Deferred TaggedToI: NaN)
0x9c023ab49fd  runtime entry  (deoptimization bailout 74)
0x9c023ab4a06  position  (13189)
0x9c023ab4a06  comment  (;;; <@74,#710> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab4a27  comment  (Deferred TaggedToI: lost precision)
0x9c023ab4a29  comment  (Deferred TaggedToI: NaN)
0x9c023ab4a31  runtime entry  (deoptimization bailout 75)
0x9c023ab4a3a  position  (7550)
0x9c023ab4a3a  comment  (;;; <@270,#709> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab4a58  comment  (Deferred TaggedToI: lost precision)
0x9c023ab4a5a  comment  (Deferred TaggedToI: NaN)
0x9c023ab4a6f  runtime entry  (deoptimization bailout 76)
0x9c023ab4a78  position  (7644)
0x9c023ab4a78  comment  (;;; <@294,#705> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab4a99  comment  (Deferred TaggedToI: lost precision)
0x9c023ab4a9b  comment  (Deferred TaggedToI: NaN)
0x9c023ab4aa3  runtime entry  (deoptimization bailout 77)
0x9c023ab4aac  position  (2205)
0x9c023ab4aac  comment  (;;; <@378,#726> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab4aca  comment  (Deferred TaggedToI: lost precision)
0x9c023ab4acc  comment  (Deferred TaggedToI: NaN)
0x9c023ab4ad4  runtime entry  (deoptimization bailout 78)
0x9c023ab4add  position  (2258)
0x9c023ab4add  comment  (;;; <@420,#727> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab4afb  comment  (Deferred TaggedToI: lost precision)
0x9c023ab4afd  comment  (Deferred TaggedToI: NaN)
0x9c023ab4b12  runtime entry  (deoptimization bailout 79)
0x9c023ab4b1b  position  (2394)
0x9c023ab4b1b  comment  (;;; <@434,#731> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab4b39  comment  (Deferred TaggedToI: lost precision)
0x9c023ab4b3b  comment  (Deferred TaggedToI: NaN)
0x9c023ab4b43  runtime entry  (deoptimization bailout 80)
0x9c023ab4b4c  position  (2484)
0x9c023ab4b4c  comment  (;;; <@448,#733> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab4b6a  comment  (Deferred TaggedToI: lost precision)
0x9c023ab4b6c  comment  (Deferred TaggedToI: NaN)
0x9c023ab4b81  runtime entry  (deoptimization bailout 81)
0x9c023ab4b8a  position  (2513)
0x9c023ab4b8a  comment  (;;; <@480,#730> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab4baf  code target (STUB)  (0x9c023a44740)
0x9c023ab4be2  comment  (Deferred TaggedToI: cannot truncate)
0x9c023ab4bf5  position  (8123)
0x9c023ab4bf5  comment  (;;; <@558,#452> -------------------- Deferred stack-check --------------------)
0x9c023ab4c18  code target (STUB)  (0x9c023a061c0)
0x9c023ab4c36  position  (8462)
0x9c023ab4c36  comment  (;;; <@600,#639> -------------------- Deferred stack-check --------------------)
0x9c023ab4c59  code target (STUB)  (0x9c023a061c0)
0x9c023ab4c77  position  (8241)
0x9c023ab4c77  comment  (;;; <@646,#521> -------------------- Deferred stack-check --------------------)
0x9c023ab4c9a  code target (STUB)  (0x9c023a061c0)
0x9c023ab4cb8  comment  (;;; -------------------- Jump table --------------------)
0x9c023ab4cb8  comment  (;;; jump table entry 0: deoptimization bailout 1.)
0x9c023ab4cb9  runtime entry  (deoptimization bailout 1)
0x9c023ab4cbd  comment  (;;; jump table entry 1: deoptimization bailout 2.)
0x9c023ab4cbe  runtime entry  (deoptimization bailout 2)
0x9c023ab4cc2  comment  (;;; jump table entry 2: deoptimization bailout 3.)
0x9c023ab4cc3  runtime entry  (deoptimization bailout 3)
0x9c023ab4cc7  comment  (;;; jump table entry 3: deoptimization bailout 4.)
0x9c023ab4cc8  runtime entry  (deoptimization bailout 4)
0x9c023ab4ccc  comment  (;;; jump table entry 4: deoptimization bailout 5.)
0x9c023ab4ccd  runtime entry  (deoptimization bailout 5)
0x9c023ab4cd1  comment  (;;; jump table entry 5: deoptimization bailout 6.)
0x9c023ab4cd2  runtime entry  (deoptimization bailout 6)
0x9c023ab4cd6  comment  (;;; jump table entry 6: deoptimization bailout 7.)
0x9c023ab4cd7  runtime entry  (deoptimization bailout 7)
0x9c023ab4cdb  comment  (;;; jump table entry 7: deoptimization bailout 8.)
0x9c023ab4cdc  runtime entry  (deoptimization bailout 8)
0x9c023ab4ce0  comment  (;;; jump table entry 8: deoptimization bailout 9.)
0x9c023ab4ce1  runtime entry  (deoptimization bailout 9)
0x9c023ab4ce5  comment  (;;; jump table entry 9: deoptimization bailout 10.)
0x9c023ab4ce6  runtime entry  (deoptimization bailout 10)
0x9c023ab4cea  comment  (;;; jump table entry 10: deoptimization bailout 11.)
0x9c023ab4ceb  runtime entry  (deoptimization bailout 11)
0x9c023ab4cef  comment  (;;; jump table entry 11: deoptimization bailout 12.)
0x9c023ab4cf0  runtime entry  (deoptimization bailout 12)
0x9c023ab4cf4  comment  (;;; jump table entry 12: deoptimization bailout 13.)
0x9c023ab4cf5  runtime entry  (deoptimization bailout 13)
0x9c023ab4cf9  comment  (;;; jump table entry 13: deoptimization bailout 14.)
0x9c023ab4cfa  runtime entry  (deoptimization bailout 14)
0x9c023ab4cfe  comment  (;;; jump table entry 14: deoptimization bailout 15.)
0x9c023ab4cff  runtime entry  (deoptimization bailout 15)
0x9c023ab4d03  comment  (;;; jump table entry 15: deoptimization bailout 17.)
0x9c023ab4d04  runtime entry  (deoptimization bailout 17)
0x9c023ab4d08  comment  (;;; jump table entry 16: deoptimization bailout 18.)
0x9c023ab4d09  runtime entry  (deoptimization bailout 18)
0x9c023ab4d0d  comment  (;;; jump table entry 17: deoptimization bailout 19.)
0x9c023ab4d0e  runtime entry  (deoptimization bailout 19)
0x9c023ab4d12  comment  (;;; jump table entry 18: deoptimization bailout 20.)
0x9c023ab4d13  runtime entry  (deoptimization bailout 20)
0x9c023ab4d17  comment  (;;; jump table entry 19: deoptimization bailout 21.)
0x9c023ab4d18  runtime entry  (deoptimization bailout 21)
0x9c023ab4d1c  comment  (;;; jump table entry 20: deoptimization bailout 22.)
0x9c023ab4d1d  runtime entry  (deoptimization bailout 22)
0x9c023ab4d21  comment  (;;; jump table entry 21: deoptimization bailout 23.)
0x9c023ab4d22  runtime entry  (deoptimization bailout 23)
0x9c023ab4d26  comment  (;;; jump table entry 22: deoptimization bailout 24.)
0x9c023ab4d27  runtime entry  (deoptimization bailout 24)
0x9c023ab4d2b  comment  (;;; jump table entry 23: deoptimization bailout 25.)
0x9c023ab4d2c  runtime entry  (deoptimization bailout 25)
0x9c023ab4d30  comment  (;;; jump table entry 24: deoptimization bailout 26.)
0x9c023ab4d31  runtime entry  (deoptimization bailout 26)
0x9c023ab4d35  comment  (;;; jump table entry 25: deoptimization bailout 27.)
0x9c023ab4d36  runtime entry  (deoptimization bailout 27)
0x9c023ab4d3a  comment  (;;; jump table entry 26: deoptimization bailout 28.)
0x9c023ab4d3b  runtime entry  (deoptimization bailout 28)
0x9c023ab4d3f  comment  (;;; jump table entry 27: deoptimization bailout 29.)
0x9c023ab4d40  runtime entry  (deoptimization bailout 29)
0x9c023ab4d44  comment  (;;; jump table entry 28: deoptimization bailout 31.)
0x9c023ab4d45  runtime entry  (deoptimization bailout 31)
0x9c023ab4d49  comment  (;;; jump table entry 29: deoptimization bailout 32.)
0x9c023ab4d4a  runtime entry  (deoptimization bailout 32)
0x9c023ab4d4e  comment  (;;; jump table entry 30: deoptimization bailout 33.)
0x9c023ab4d4f  runtime entry  (deoptimization bailout 33)
0x9c023ab4d53  comment  (;;; jump table entry 31: deoptimization bailout 34.)
0x9c023ab4d54  runtime entry  (deoptimization bailout 34)
0x9c023ab4d58  comment  (;;; jump table entry 32: deoptimization bailout 36.)
0x9c023ab4d59  runtime entry  (deoptimization bailout 36)
0x9c023ab4d5d  comment  (;;; jump table entry 33: deoptimization bailout 37.)
0x9c023ab4d5e  runtime entry  (deoptimization bailout 37)
0x9c023ab4d62  comment  (;;; jump table entry 34: deoptimization bailout 38.)
0x9c023ab4d63  runtime entry  (deoptimization bailout 38)
0x9c023ab4d67  comment  (;;; jump table entry 35: deoptimization bailout 39.)
0x9c023ab4d68  runtime entry  (deoptimization bailout 39)
0x9c023ab4d6c  comment  (;;; jump table entry 36: deoptimization bailout 40.)
0x9c023ab4d6d  runtime entry  (deoptimization bailout 40)
0x9c023ab4d71  comment  (;;; jump table entry 37: deoptimization bailout 41.)
0x9c023ab4d72  runtime entry  (deoptimization bailout 41)
0x9c023ab4d76  comment  (;;; jump table entry 38: deoptimization bailout 42.)
0x9c023ab4d77  runtime entry  (deoptimization bailout 42)
0x9c023ab4d7b  comment  (;;; jump table entry 39: deoptimization bailout 43.)
0x9c023ab4d7c  runtime entry  (deoptimization bailout 43)
0x9c023ab4d80  comment  (;;; jump table entry 40: deoptimization bailout 44.)
0x9c023ab4d81  runtime entry  (deoptimization bailout 44)
0x9c023ab4d85  comment  (;;; jump table entry 41: deoptimization bailout 45.)
0x9c023ab4d86  runtime entry  (deoptimization bailout 45)
0x9c023ab4d8a  comment  (;;; jump table entry 42: deoptimization bailout 46.)
0x9c023ab4d8b  runtime entry  (deoptimization bailout 46)
0x9c023ab4d8f  comment  (;;; jump table entry 43: deoptimization bailout 47.)
0x9c023ab4d90  runtime entry  (deoptimization bailout 47)
0x9c023ab4d94  comment  (;;; jump table entry 44: deoptimization bailout 48.)
0x9c023ab4d95  runtime entry  (deoptimization bailout 48)
0x9c023ab4d99  comment  (;;; jump table entry 45: deoptimization bailout 49.)
0x9c023ab4d9a  runtime entry  (deoptimization bailout 49)
0x9c023ab4d9e  comment  (;;; jump table entry 46: deoptimization bailout 50.)
0x9c023ab4d9f  runtime entry  (deoptimization bailout 50)
0x9c023ab4da3  comment  (;;; jump table entry 47: deoptimization bailout 51.)
0x9c023ab4da4  runtime entry  (deoptimization bailout 51)
0x9c023ab4da8  comment  (;;; jump table entry 48: deoptimization bailout 52.)
0x9c023ab4da9  runtime entry  (deoptimization bailout 52)
0x9c023ab4dad  comment  (;;; jump table entry 49: deoptimization bailout 53.)
0x9c023ab4dae  runtime entry  (deoptimization bailout 53)
0x9c023ab4db2  comment  (;;; jump table entry 50: deoptimization bailout 54.)
0x9c023ab4db3  runtime entry  (deoptimization bailout 54)
0x9c023ab4db7  comment  (;;; jump table entry 51: deoptimization bailout 55.)
0x9c023ab4db8  runtime entry  (deoptimization bailout 55)
0x9c023ab4dbc  comment  (;;; jump table entry 52: deoptimization bailout 57.)
0x9c023ab4dbd  runtime entry  (deoptimization bailout 57)
0x9c023ab4dc1  comment  (;;; jump table entry 53: deoptimization bailout 58.)
0x9c023ab4dc2  runtime entry  (deoptimization bailout 58)
0x9c023ab4dc6  comment  (;;; jump table entry 54: deoptimization bailout 59.)
0x9c023ab4dc7  runtime entry  (deoptimization bailout 59)
0x9c023ab4dcb  comment  (;;; jump table entry 55: deoptimization bailout 61.)
0x9c023ab4dcc  runtime entry  (deoptimization bailout 61)
0x9c023ab4dd0  comment  (;;; jump table entry 56: deoptimization bailout 62.)
0x9c023ab4dd1  runtime entry  (deoptimization bailout 62)
0x9c023ab4dd5  comment  (;;; jump table entry 57: deoptimization bailout 63.)
0x9c023ab4dd6  runtime entry  (deoptimization bailout 63)
0x9c023ab4dda  comment  (;;; jump table entry 58: deoptimization bailout 64.)
0x9c023ab4ddb  runtime entry  (deoptimization bailout 64)
0x9c023ab4ddf  comment  (;;; jump table entry 59: deoptimization bailout 65.)
0x9c023ab4de0  runtime entry  (deoptimization bailout 65)
0x9c023ab4de4  comment  (;;; jump table entry 60: deoptimization bailout 67.)
0x9c023ab4de5  runtime entry  (deoptimization bailout 67)
0x9c023ab4de9  comment  (;;; jump table entry 61: deoptimization bailout 68.)
0x9c023ab4dea  runtime entry  (deoptimization bailout 68)
0x9c023ab4dee  comment  (;;; jump table entry 62: deoptimization bailout 69.)
0x9c023ab4def  runtime entry  (deoptimization bailout 69)
0x9c023ab4df3  comment  (;;; jump table entry 63: deoptimization bailout 70.)
0x9c023ab4df4  runtime entry  (deoptimization bailout 70)
0x9c023ab4df8  comment  (;;; jump table entry 64: deoptimization bailout 71.)
0x9c023ab4df9  runtime entry  (deoptimization bailout 71)
0x9c023ab4dfd  comment  (;;; jump table entry 65: deoptimization bailout 72.)
0x9c023ab4dfe  runtime entry  (deoptimization bailout 72)
0x9c023ab4e02  comment  (;;; jump table entry 66: deoptimization bailout 73.)
0x9c023ab4e03  runtime entry  (deoptimization bailout 73)
0x9c023ab4e07  comment  (;;; jump table entry 67: deoptimization bailout 82.)
0x9c023ab4e08  runtime entry  (deoptimization bailout 82)
0x9c023ab4e0c  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (IN) id{8,0} ---
(a){
if(!(%_IsSpecObject(a))){
throw %MakeTypeError('invalid_in_operator_use',[this,a]);
}
return %_IsNonNegativeSmi(this)?
%HasElement(a,this):%HasProperty(a,%ToName(this));
}

--- END ---
--- FUNCTION SOURCE (Instantiate) id{9,0} ---
(a,b){
if(!%IsTemplate(a))return a;
var c=%GetTemplateField(a,0);
switch(c){
case 0:
return InstantiateFunction(a,b);
case 1:
var d=%GetTemplateField(a,3);
var g=typeof d==='undefined'?
{}:new(Instantiate(d))();
ConfigureTemplateInstance(g,a);
g=%ToFastProperties(g);
return g;
default:
throw'Unknown API tag <'+c+'>';
}
}

--- END ---
--- Raw source ---
(a,b){
if(!%IsTemplate(a))return a;
var c=%GetTemplateField(a,0);
switch(c){
case 0:
return InstantiateFunction(a,b);
case 1:
var d=%GetTemplateField(a,3);
var g=typeof d==='undefined'?
{}:new(Instantiate(d))();
ConfigureTemplateInstance(g,a);
g=%ToFastProperties(g);
return g;
default:
throw'Unknown API tag <'+c+'>';
}
}


--- Optimized code ---
optimization_id = 9
source_position = 170
kind = OPTIMIZED_FUNCTION
name = Instantiate
stack_slots = 2
Instructions (size = 778)
0x9c023ab68a0     0  55             push rbp
0x9c023ab68a1     1  4889e5         REX.W movq rbp,rsp
0x9c023ab68a4     4  56             push rsi
0x9c023ab68a5     5  57             push rdi
0x9c023ab68a6     6  4883ec10       REX.W subq rsp,0x10
                  ;;; <@0,#0> -------------------- B0 --------------------
                  ;;; <@2,#1> context
0x9c023ab68aa    10  488b45f8       REX.W movq rax,[rbp-0x8]    ;; debug: position 170
                  ;;; <@3,#1> gap
0x9c023ab68ae    14  488945e8       REX.W movq [rbp-0x18],rax
                  ;;; <@12,#9> -------------------- B1 --------------------
                  ;;; <@13,#9> gap
0x9c023ab68b2    18  488bf0         REX.W movq rsi,rax
                  ;;; <@14,#11> stack-check
0x9c023ab68b5    21  493ba5c8070000 REX.W cmpq rsp,[r13+0x7c8]
0x9c023ab68bc    28  7305           jnc 35  (0x9c023ab68c3)
0x9c023ab68be    30  e89df5f6ff     call StackCheck  (0x9c023a25e60)    ;; code: BUILTIN
                  ;;; <@16,#11> lazy-bailout
                  ;;; <@17,#11> gap
0x9c023ab68c3    35  488b4518       REX.W movq rax,[rbp+0x18]
                  ;;; <@18,#13> push-argument
0x9c023ab68c7    39  50             push rax                 ;; debug: position 193
                  ;;; <@19,#13> gap
0x9c023ab68c8    40  488b75e8       REX.W movq rsi,[rbp-0x18]
                  ;;; <@20,#14> call-runtime
0x9c023ab68cc    44  0f1f4000       nop
0x9c023ab68d0    48  b801000000     movl rax,0x1
0x9c023ab68d5    53  498d9dd89ce5fd REX.W leaq rbx,[r13-0x21a6328]
0x9c023ab68dc    60  e87ff7f4ff     call 0x9c023a06060       ;; code: STUB, CEntryStub, minor: 0
                  ;;; <@22,#15> lazy-bailout
                  ;;; <@25,#16> branch
0x9c023ab68e1    65  493b45c0       REX.W cmpq rax,[r13-0x40]
0x9c023ab68e5    69  0f841a000000   jz 101  (0x9c023ab6905)
0x9c023ab68eb    75  493b45c8       REX.W cmpq rax,[r13-0x38]
0x9c023ab68ef    79  0f8405000000   jz 90  (0x9c023ab68fa)
0x9c023ab68f5    85  e81af7c4ff     call 0x9c023706014       ;; deoptimization bailout 2
                  ;;; <@26,#20> -------------------- B2 (unreachable/replaced) --------------------
                  ;;; <@30,#23> -------------------- B3 --------------------
                  ;;; <@31,#23> gap
0x9c023ab68fa    90  488b4518       REX.W movq rax,[rbp+0x18]    ;; debug: position 203
                  ;;; <@32,#25> return
0x9c023ab68fe    94  488be5         REX.W movq rsp,rbp
0x9c023ab6901    97  5d             pop rbp
0x9c023ab6902    98  c21800         ret 0x18
                  ;;; <@34,#17> -------------------- B4 (unreachable/replaced) --------------------
                  ;;; <@38,#26> -------------------- B5 --------------------
                  ;;; <@40,#28> push-argument
0x9c023ab6905   101  ff7518         push [rbp+0x18]          ;; debug: position 232
                  ;;; <@42,#29> push-argument
0x9c023ab6908   104  6a00           push 0x0
                  ;;; <@43,#29> gap
0x9c023ab690a   106  488b75e8       REX.W movq rsi,[rbp-0x18]
                  ;;; <@44,#30> call-runtime
0x9c023ab690e   110  b802000000     movl rax,0x2
0x9c023ab6913   115  498d9da8fae4fd REX.W leaq rbx,[r13-0x21b0558]
0x9c023ab691a   122  e841f7f4ff     call 0x9c023a06060       ;; code: STUB, CEntryStub, minor: 0
                  ;;; <@46,#31> lazy-bailout
                  ;;; <@47,#31> gap
0x9c023ab691f   127  488bd8         REX.W movq rbx,rax
                  ;;; <@48,#150> tagged-to-i
0x9c023ab6922   130  f6c301         testb rbx,0x1            ;; debug: position 243
0x9c023ab6925   133  0f857e010000   jnz 521  (0x9c023ab6aa9)
0x9c023ab692b   139  48c1eb20       REX.W shrq rbx,32
                  ;;; <@51,#36> compare-numeric-and-branch
0x9c023ab692f   143  83fb00         cmpl rbx,0x0             ;; debug: position 252
0x9c023ab6932   146  0f843f010000   jz 471  (0x9c023ab6a77)
                  ;;; <@52,#37> -------------------- B6 --------------------
                  ;;; <@55,#39> compare-numeric-and-branch
0x9c023ab6938   152  83fb01         cmpl rbx,0x1             ;; debug: position 293
0x9c023ab693b   155  0f8405000000   jz 166  (0x9c023ab6946)
                  ;;; <@56,#120> -------------------- B7 --------------------
                  ;;; <@58,#123> deoptimize
                  ;;; deoptimize: Insufficient type feedback for RHS of binary operation
0x9c023ab6941   161  e8e2f6e4ff     call 0x9c023906028       ;; debug: position 462
                                                             ;; debug: position 481
                                                             ;; soft deoptimization bailout 4
                  ;;; <@60,#124> -------------------- B8 (unreachable/replaced) --------------------
                  ;;; <@84,#134> -------------------- B9 (unreachable/replaced) --------------------
                  ;;; <@110,#52> -------------------- B10 --------------------
                  ;;; <@112,#54> push-argument
0x9c023ab6946   166  ff7518         push [rbp+0x18]          ;; debug: position 322
                  ;;; <@114,#55> push-argument
0x9c023ab6949   169  4f8d1464       REX.W leaq r10,[r12+r12*2]
0x9c023ab694d   173  4152           push r10
                  ;;; <@115,#55> gap
0x9c023ab694f   175  488b75e8       REX.W movq rsi,[rbp-0x18]
                  ;;; <@116,#56> call-runtime
0x9c023ab6953   179  b802000000     movl rax,0x2
0x9c023ab6958   184  498d9da8fae4fd REX.W leaq rbx,[r13-0x21b0558]
0x9c023ab695f   191  e8fcf6f4ff     call 0x9c023a06060       ;; code: STUB, CEntryStub, minor: 0
                  ;;; <@118,#57> lazy-bailout
                  ;;; <@120,#60> gap
0x9c023ab6964   196  488bd8         REX.W movq rbx,rax       ;; debug: position 340
                  ;;; <@121,#60> typeof-is-and-branch
0x9c023ab6967   199  493b5da8       REX.W cmpq rbx,[r13-0x58]
0x9c023ab696b   203  0f8464000000   jz 309  (0x9c023ab69d5)
0x9c023ab6971   209  f6c301         testb rbx,0x1
0x9c023ab6974   212  740e           jz 228  (0x9c023ab6984)
0x9c023ab6976   214  488b5bff       REX.W movq rbx,[rbx-0x1]
0x9c023ab697a   218  f6430d20       testb [rbx+0xd],0x20
0x9c023ab697e   222  0f8551000000   jnz 309  (0x9c023ab69d5)
                  ;;; <@122,#64> -------------------- B11 (unreachable/replaced) --------------------
                  ;;; <@126,#78> -------------------- B12 --------------------
                  ;;; <@128,#83> push-argument
0x9c023ab6984   228  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 363
                                                             ;; debug: position 375
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab698e   238  4152           push r10
                  ;;; <@130,#84> push-argument
0x9c023ab6990   240  50             push rax
                  ;;; <@132,#79> constant-t
0x9c023ab6991   241  48bf798533064e360000 REX.W movq rdi,0x364e06338579    ;; debug: position 363
                                                             ;; object: 0x364e06338579 <JS Function Instantiate (SharedFunctionInfo 0x364e06338129)>
                  ;;; <@134,#87> load-named-field
0x9c023ab699b   251  488b772f       REX.W movq rsi,[rdi+0x2f]    ;; debug: position 375
                  ;;; <@136,#79> constant-t
0x9c023ab699f   255  48bf798533064e360000 REX.W movq rdi,0x364e06338579    ;; debug: position 363
                                                             ;; object: 0x364e06338579 <JS Function Instantiate (SharedFunctionInfo 0x364e06338129)>
                  ;;; <@138,#38> constant-i
0x9c023ab69a9   265  b801000000     movl rax,0x1             ;; debug: position 293
                  ;;; <@140,#86> constant-i
0x9c023ab69ae   270  bb02000000     movl rbx,0x2             ;; debug: position 375
                  ;;; <@142,#90> call-with-descriptor
0x9c023ab69b3   275  e8a87cf6ff     call ArgumentsAdaptorTrampoline  (0x9c023a1e660)    ;; code: BUILTIN
                  ;;; <@144,#91> lazy-bailout
                  ;;; <@146,#92> push-argument
0x9c023ab69b8   280  50             push rax
                  ;;; <@147,#92> gap
0x9c023ab69b9   281  488b75e8       REX.W movq rsi,[rbp-0x18]
0x9c023ab69bd   285  488bf8         REX.W movq rdi,rax
                  ;;; <@148,#93> call-new
0x9c023ab69c0   288  0f1f440000     nop
0x9c023ab69c5   293  33c0           xorl rax,rax
0x9c023ab69c7   295  498b5da8       REX.W movq rbx,[r13-0x58]
0x9c023ab69cb   299  e81086f6ff     call 0x9c023a1efe0       ;; code: constructor, STUB, CallConstructStub, minor: 0
                  ;;; <@150,#97> lazy-bailout
                  ;;; <@153,#98> goto
0x9c023ab69d0   304  e958000000     jmp 397  (0x9c023ab6a2d)
                  ;;; <@154,#61> -------------------- B13 (unreachable/replaced) --------------------
                  ;;; <@158,#67> -------------------- B14 --------------------
                  ;;; <@160,#69> allocate
0x9c023ab69d5   309  498b9dd00a0000 REX.W movq rbx,[r13+0xad0]    ;; debug: position 356
0x9c023ab69dc   316  488bc3         REX.W movq rax,rbx
0x9c023ab69df   319  4883c018       REX.W addq rax,0x18
0x9c023ab69e3   323  0f82f1000000   jc 570  (0x9c023ab6ada)
0x9c023ab69e9   329  493b85d80a0000 REX.W cmpq rax,[r13+0xad8]
0x9c023ab69f0   336  0f87e4000000   ja 570  (0x9c023ab6ada)
0x9c023ab69f6   342  498985d00a0000 REX.W movq [r13+0xad0],rax
0x9c023ab69fd   349  48ffc3         REX.W incq rbx
                  ;;; <@162,#71> store-named-field
0x9c023ab6a00   352  49ba0141d035a6260000 REX.W movq r10,0x26a635d04101    ;; object: 0x26a635d04101 <FixedArray[0]>
0x9c023ab6a0a   362  4c89530f       REX.W movq [rbx+0xf],r10
                  ;;; <@164,#73> store-named-field
0x9c023ab6a0e   366  49ba9987c05ecb2c0000 REX.W movq r10,0x2ccb5ec08799    ;; object: 0x2ccb5ec08799 <Map(elements=3)>
0x9c023ab6a18   376  4c8953ff       REX.W movq [rbx-0x1],r10
                  ;;; <@166,#75> store-named-field
0x9c023ab6a1c   380  49ba0141d035a6260000 REX.W movq r10,0x26a635d04101    ;; object: 0x26a635d04101 <FixedArray[0]>
0x9c023ab6a26   390  4c895307       REX.W movq [rbx+0x7],r10
                  ;;; <@168,#96> gap
0x9c023ab6a2a   394  488bc3         REX.W movq rax,rbx       ;; debug: position 375
                  ;;; <@170,#100> -------------------- B15 --------------------
0x9c023ab6a2d   397  488945e0       REX.W movq [rbp-0x20],rax
                  ;;; <@172,#106> push-argument
0x9c023ab6a31   401  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 410
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab6a3b   411  4152           push r10
                  ;;; <@174,#107> push-argument
0x9c023ab6a3d   413  50             push rax
                  ;;; <@176,#108> push-argument
0x9c023ab6a3e   414  ff7518         push [rbp+0x18]
                  ;;; <@178,#102> constant-t
0x9c023ab6a41   417  48bf898633064e360000 REX.W movq rdi,0x364e06338689    ;; debug: position 382
                                                             ;; object: 0x364e06338689 <JS Function ConfigureTemplateInstance (SharedFunctionInfo 0x364e06338299)>
                  ;;; <@180,#110> call-js-function
0x9c023ab6a4b   427  488b772f       REX.W movq rsi,[rdi+0x2f]    ;; debug: position 410
0x9c023ab6a4f   431  ff5717         call [rdi+0x17]
                  ;;; <@182,#111> lazy-bailout
                  ;;; <@184,#113> push-argument
0x9c023ab6a52   434  ff75e0         push [rbp-0x20]          ;; debug: position 434
                  ;;; <@185,#113> gap
0x9c023ab6a55   437  488b75e8       REX.W movq rsi,[rbp-0x18]
                  ;;; <@186,#114> call-runtime
0x9c023ab6a59   441  660f1f440000   nop
0x9c023ab6a5f   447  b801000000     movl rax,0x1
0x9c023ab6a64   452  498d9dd89be5fd REX.W leaq rbx,[r13-0x21a6428]
0x9c023ab6a6b   459  e8f0f5f4ff     call 0x9c023a06060       ;; code: STUB, CEntryStub, minor: 0
                  ;;; <@188,#115> lazy-bailout
                  ;;; <@190,#119> return
0x9c023ab6a70   464  488be5         REX.W movq rsp,rbp       ;; debug: position 445
0x9c023ab6a73   467  5d             pop rbp
0x9c023ab6a74   468  c21800         ret 0x18
                  ;;; <@192,#40> -------------------- B16 --------------------
                  ;;; <@194,#44> push-argument
0x9c023ab6a77   471  49baf9fa30064e360000 REX.W movq r10,0x364e0630faf9    ;; debug: position 262
                                                             ;; debug: position 284
                                                             ;; object: 0x364e0630faf9 <JS Global Object>
0x9c023ab6a81   481  4152           push r10
                  ;;; <@196,#45> push-argument
0x9c023ab6a83   483  ff7518         push [rbp+0x18]
                  ;;; <@197,#45> gap
0x9c023ab6a86   486  488b4510       REX.W movq rax,[rbp+0x10]
                  ;;; <@198,#46> push-argument
0x9c023ab6a8a   490  50             push rax
                  ;;; <@200,#41> constant-t
0x9c023ab6a8b   491  48bf018633064e360000 REX.W movq rdi,0x364e06338601    ;; debug: position 262
                                                             ;; object: 0x364e06338601 <JS Function InstantiateFunction (SharedFunctionInfo 0x364e063381e9)>
                  ;;; <@202,#48> call-js-function
0x9c023ab6a95   501  488b772f       REX.W movq rsi,[rdi+0x2f]    ;; debug: position 284
0x9c023ab6a99   505  ff5717         call [rdi+0x17]
                  ;;; <@204,#49> lazy-bailout
                  ;;; <@206,#51> return
0x9c023ab6a9c   508  488be5         REX.W movq rsp,rbp
0x9c023ab6a9f   511  5d             pop rbp
0x9c023ab6aa0   512  c21800         ret 0x18
0x9c023ab6aa3   515  660f1f440000   nop
                  ;;; <@48,#150> -------------------- Deferred tagged-to-i --------------------
0x9c023ab6aa9   521  4d8b5500       REX.W movq r10,[r13+0x0]    ;; debug: position 243
0x9c023ab6aad   525  4c3953ff       REX.W cmpq [rbx-0x1],r10
0x9c023ab6ab1   529  751d           jnz 560  (0x9c023ab6ad0)
0x9c023ab6ab3   531  f20f104307     movsd xmm0,[rbx+0x7]
0x9c023ab6ab8   536  f20f2cd8       cvttsd2sil rbx,xmm0
0x9c023ab6abc   540  0f57c9         xorps xmm1,xmm1
0x9c023ab6abf   543  f20f2acb       cvtsi2sd xmm1,rbx
0x9c023ab6ac3   547  660f2ec1       ucomisd xmm0,xmm1
                  Deferred TaggedToI: lost precision
0x9c023ab6ac7   551  7507           jnz 560  (0x9c023ab6ad0)
                  Deferred TaggedToI: NaN
0x9c023ab6ac9   553  7a05           jpe 560  (0x9c023ab6ad0)
0x9c023ab6acb   555  e95ffeffff     jmp 143  (0x9c023ab692f)
0x9c023ab6ad0   560  e899f5c4ff     call 0x9c02370606e       ;; deoptimization bailout 11
0x9c023ab6ad5   565  e955feffff     jmp 143  (0x9c023ab692f)
                  ;;; <@160,#69> -------------------- Deferred allocate --------------------
0x9c023ab6ada   570  33db           xorl rbx,rbx             ;; debug: position 356
0x9c023ab6adc   572  50             push rax
0x9c023ab6add   573  51             push rcx
0x9c023ab6ade   574  52             push rdx
0x9c023ab6adf   575  53             push rbx
0x9c023ab6ae0   576  56             push rsi
0x9c023ab6ae1   577  57             push rdi
0x9c023ab6ae2   578  4150           push r8
0x9c023ab6ae4   580  4151           push r9
0x9c023ab6ae6   582  4153           push r11
0x9c023ab6ae8   584  4156           push r14
0x9c023ab6aea   586  4157           push r15
0x9c023ab6aec   588  488d6424d8     REX.W leaq rsp,[rsp-0x28]
0x9c023ab6af1   593  49ba0000000018000000 REX.W movq r10,0x1800000000
0x9c023ab6afb   603  4152           push r10
0x9c023ab6afd   605  6a00           push 0x0
0x9c023ab6aff   607  488b75e8       REX.W movq rsi,[rbp-0x18]
0x9c023ab6b03   611  b802000000     movl rax,0x2
0x9c023ab6b08   616  498d9d2892e5fd REX.W leaq rbx,[r13-0x21a6dd8]
0x9c023ab6b0f   623  e8acf6f4ff     call 0x9c023a061c0       ;; code: STUB, CEntryStub, minor: 1
0x9c023ab6b14   628  4889442460     REX.W movq [rsp+0x60],rax
0x9c023ab6b19   633  488d642428     REX.W leaq rsp,[rsp+0x28]
0x9c023ab6b1e   638  415f           pop r15
0x9c023ab6b20   640  415e           pop r14
0x9c023ab6b22   642  415b           pop r11
0x9c023ab6b24   644  4159           pop r9
0x9c023ab6b26   646  4158           pop r8
0x9c023ab6b28   648  5f             pop rdi
0x9c023ab6b29   649  5e             pop rsi
0x9c023ab6b2a   650  5b             pop rbx
0x9c023ab6b2b   651  5a             pop rdx
0x9c023ab6b2c   652  59             pop rcx
0x9c023ab6b2d   653  58             pop rax
0x9c023ab6b2e   654  e9cdfeffff     jmp 352  (0x9c023ab6a00)
0x9c023ab6b33   659  90             nop
                  ;;; Safepoint table.

Deoptimization Input Data (deopt points = 12)
 index  ast id    argc     pc             
     0       3       0     35
     1       6       0     65
     2       6       0     -1
     3      25       0    127
     4      32       0     -1
     5      61       0    196
     6      88       0    280
     7      94       0    304
     8     109       0    434
     9     116       0    464
    10      44       0    508
    11      32       0     -1

Safepoints (size = 118)
0x9c023ab68c3    35  01 (sp -> fp)       0
0x9c023ab68e1    65  01 (sp -> fp)       1
0x9c023ab691f   127  01 (sp -> fp)       3
0x9c023ab6964   196  01 (sp -> fp)       5
0x9c023ab69b8   280  01 (sp -> fp)       6
0x9c023ab69d0   304  01 (sp -> fp)       7
0x9c023ab6a52   434  11 (sp -> fp)       8
0x9c023ab6a70   464  00 (sp -> fp)       9
0x9c023ab6a9c   508  00 (sp -> fp)      10
0x9c023ab6b14   628  01 | rbx (sp -> fp)  <none> argc: 2

RelocInfo (size = 1138)
0x9c023ab68aa  position  (170)
0x9c023ab68aa  comment  (;;; <@0,#0> -------------------- B0 --------------------)
0x9c023ab68aa  comment  (;;; <@2,#1> context)
0x9c023ab68ae  comment  (;;; <@3,#1> gap)
0x9c023ab68b2  comment  (;;; <@12,#9> -------------------- B1 --------------------)
0x9c023ab68b2  comment  (;;; <@13,#9> gap)
0x9c023ab68b5  comment  (;;; <@14,#11> stack-check)
0x9c023ab68bf  code target (BUILTIN)  (0x9c023a25e60)
0x9c023ab68c3  comment  (;;; <@16,#11> lazy-bailout)
0x9c023ab68c3  comment  (;;; <@17,#11> gap)
0x9c023ab68c7  comment  (;;; <@18,#13> push-argument)
0x9c023ab68c7  position  (193)
0x9c023ab68c8  comment  (;;; <@19,#13> gap)
0x9c023ab68cc  comment  (;;; <@20,#14> call-runtime)
0x9c023ab68dd  code target (STUB)  (0x9c023a06060)
0x9c023ab68e1  comment  (;;; <@22,#15> lazy-bailout)
0x9c023ab68e1  comment  (;;; <@25,#16> branch)
0x9c023ab68f6  runtime entry  (deoptimization bailout 2)
0x9c023ab68fa  comment  (;;; <@26,#20> -------------------- B2 (unreachable/replaced) --------------------)
0x9c023ab68fa  position  (203)
0x9c023ab68fa  comment  (;;; <@30,#23> -------------------- B3 --------------------)
0x9c023ab68fa  comment  (;;; <@31,#23> gap)
0x9c023ab68fe  comment  (;;; <@32,#25> return)
0x9c023ab6905  comment  (;;; <@34,#17> -------------------- B4 (unreachable/replaced) --------------------)
0x9c023ab6905  position  (232)
0x9c023ab6905  comment  (;;; <@38,#26> -------------------- B5 --------------------)
0x9c023ab6905  comment  (;;; <@40,#28> push-argument)
0x9c023ab6908  comment  (;;; <@42,#29> push-argument)
0x9c023ab690a  comment  (;;; <@43,#29> gap)
0x9c023ab690e  comment  (;;; <@44,#30> call-runtime)
0x9c023ab691b  code target (STUB)  (0x9c023a06060)
0x9c023ab691f  comment  (;;; <@46,#31> lazy-bailout)
0x9c023ab691f  comment  (;;; <@47,#31> gap)
0x9c023ab6922  comment  (;;; <@48,#150> tagged-to-i)
0x9c023ab6922  position  (243)
0x9c023ab692f  position  (252)
0x9c023ab692f  comment  (;;; <@51,#36> compare-numeric-and-branch)
0x9c023ab6938  position  (293)
0x9c023ab6938  comment  (;;; <@52,#37> -------------------- B6 --------------------)
0x9c023ab6938  comment  (;;; <@55,#39> compare-numeric-and-branch)
0x9c023ab6941  position  (462)
0x9c023ab6941  comment  (;;; <@56,#120> -------------------- B7 --------------------)
0x9c023ab6941  comment  (;;; <@58,#123> deoptimize)
0x9c023ab6941  position  (481)
0x9c023ab6941  comment  (;;; deoptimize: Insufficient type feedback for RHS of binary operation)
0x9c023ab6942  runtime entry
0x9c023ab6946  comment  (;;; <@60,#124> -------------------- B8 (unreachable/replaced) --------------------)
0x9c023ab6946  comment  (;;; <@84,#134> -------------------- B9 (unreachable/replaced) --------------------)
0x9c023ab6946  position  (322)
0x9c023ab6946  comment  (;;; <@110,#52> -------------------- B10 --------------------)
0x9c023ab6946  comment  (;;; <@112,#54> push-argument)
0x9c023ab6949  comment  (;;; <@114,#55> push-argument)
0x9c023ab694f  comment  (;;; <@115,#55> gap)
0x9c023ab6953  comment  (;;; <@116,#56> call-runtime)
0x9c023ab6960  code target (STUB)  (0x9c023a06060)
0x9c023ab6964  comment  (;;; <@118,#57> lazy-bailout)
0x9c023ab6964  comment  (;;; <@120,#60> gap)
0x9c023ab6964  position  (340)
0x9c023ab6967  comment  (;;; <@121,#60> typeof-is-and-branch)
0x9c023ab6984  comment  (;;; <@122,#64> -------------------- B11 (unreachable/replaced) --------------------)
0x9c023ab6984  position  (363)
0x9c023ab6984  comment  (;;; <@126,#78> -------------------- B12 --------------------)
0x9c023ab6984  comment  (;;; <@128,#83> push-argument)
0x9c023ab6984  position  (375)
0x9c023ab6986  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab6990  comment  (;;; <@130,#84> push-argument)
0x9c023ab6991  comment  (;;; <@132,#79> constant-t)
0x9c023ab6991  position  (363)
0x9c023ab6993  embedded object  (0x364e06338579 <JS Function Instantiate (SharedFunctionInfo 0x364e06338129)>)
0x9c023ab699b  comment  (;;; <@134,#87> load-named-field)
0x9c023ab699b  position  (375)
0x9c023ab699f  comment  (;;; <@136,#79> constant-t)
0x9c023ab699f  position  (363)
0x9c023ab69a1  embedded object  (0x364e06338579 <JS Function Instantiate (SharedFunctionInfo 0x364e06338129)>)
0x9c023ab69a9  comment  (;;; <@138,#38> constant-i)
0x9c023ab69a9  position  (293)
0x9c023ab69ae  comment  (;;; <@140,#86> constant-i)
0x9c023ab69ae  position  (375)
0x9c023ab69b3  comment  (;;; <@142,#90> call-with-descriptor)
0x9c023ab69b4  code target (BUILTIN)  (0x9c023a1e660)
0x9c023ab69b8  comment  (;;; <@144,#91> lazy-bailout)
0x9c023ab69b8  comment  (;;; <@146,#92> push-argument)
0x9c023ab69b9  comment  (;;; <@147,#92> gap)
0x9c023ab69c0  comment  (;;; <@148,#93> call-new)
0x9c023ab69cc  code target (js construct call) (STUB)  (0x9c023a1efe0)
0x9c023ab69d0  comment  (;;; <@150,#97> lazy-bailout)
0x9c023ab69d0  comment  (;;; <@153,#98> goto)
0x9c023ab69d5  comment  (;;; <@154,#61> -------------------- B13 (unreachable/replaced) --------------------)
0x9c023ab69d5  position  (356)
0x9c023ab69d5  comment  (;;; <@158,#67> -------------------- B14 --------------------)
0x9c023ab69d5  comment  (;;; <@160,#69> allocate)
0x9c023ab6a00  comment  (;;; <@162,#71> store-named-field)
0x9c023ab6a02  embedded object  (0x26a635d04101 <FixedArray[0]>)
0x9c023ab6a0e  comment  (;;; <@164,#73> store-named-field)
0x9c023ab6a10  embedded object  (0x2ccb5ec08799 <Map(elements=3)>)
0x9c023ab6a1c  comment  (;;; <@166,#75> store-named-field)
0x9c023ab6a1e  embedded object  (0x26a635d04101 <FixedArray[0]>)
0x9c023ab6a2a  comment  (;;; <@168,#96> gap)
0x9c023ab6a2a  position  (375)
0x9c023ab6a2d  comment  (;;; <@170,#100> -------------------- B15 --------------------)
0x9c023ab6a31  comment  (;;; <@172,#106> push-argument)
0x9c023ab6a31  position  (410)
0x9c023ab6a33  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab6a3d  comment  (;;; <@174,#107> push-argument)
0x9c023ab6a3e  comment  (;;; <@176,#108> push-argument)
0x9c023ab6a41  comment  (;;; <@178,#102> constant-t)
0x9c023ab6a41  position  (382)
0x9c023ab6a43  embedded object  (0x364e06338689 <JS Function ConfigureTemplateInstance (SharedFunctionInfo 0x364e06338299)>)
0x9c023ab6a4b  comment  (;;; <@180,#110> call-js-function)
0x9c023ab6a4b  position  (410)
0x9c023ab6a52  comment  (;;; <@182,#111> lazy-bailout)
0x9c023ab6a52  comment  (;;; <@184,#113> push-argument)
0x9c023ab6a52  position  (434)
0x9c023ab6a55  comment  (;;; <@185,#113> gap)
0x9c023ab6a59  comment  (;;; <@186,#114> call-runtime)
0x9c023ab6a6c  code target (STUB)  (0x9c023a06060)
0x9c023ab6a70  comment  (;;; <@188,#115> lazy-bailout)
0x9c023ab6a70  comment  (;;; <@190,#119> return)
0x9c023ab6a70  position  (445)
0x9c023ab6a77  position  (262)
0x9c023ab6a77  comment  (;;; <@192,#40> -------------------- B16 --------------------)
0x9c023ab6a77  comment  (;;; <@194,#44> push-argument)
0x9c023ab6a77  position  (284)
0x9c023ab6a79  embedded object  (0x364e0630faf9 <JS Global Object>)
0x9c023ab6a83  comment  (;;; <@196,#45> push-argument)
0x9c023ab6a86  comment  (;;; <@197,#45> gap)
0x9c023ab6a8a  comment  (;;; <@198,#46> push-argument)
0x9c023ab6a8b  comment  (;;; <@200,#41> constant-t)
0x9c023ab6a8b  position  (262)
0x9c023ab6a8d  embedded object  (0x364e06338601 <JS Function InstantiateFunction (SharedFunctionInfo 0x364e063381e9)>)
0x9c023ab6a95  comment  (;;; <@202,#48> call-js-function)
0x9c023ab6a95  position  (284)
0x9c023ab6a9c  comment  (;;; <@204,#49> lazy-bailout)
0x9c023ab6a9c  comment  (;;; <@206,#51> return)
0x9c023ab6aa9  position  (243)
0x9c023ab6aa9  comment  (;;; <@48,#150> -------------------- Deferred tagged-to-i --------------------)
0x9c023ab6ac7  comment  (Deferred TaggedToI: lost precision)
0x9c023ab6ac9  comment  (Deferred TaggedToI: NaN)
0x9c023ab6ad1  runtime entry  (deoptimization bailout 11)
0x9c023ab6ada  position  (356)
0x9c023ab6ada  comment  (;;; <@160,#69> -------------------- Deferred allocate --------------------)
0x9c023ab6b10  code target (STUB)  (0x9c023a061c0)
0x9c023ab6b34  comment  (;;; Safepoint table.)

--- End code ---
--- FUNCTION SOURCE (ToName) id{10,0} ---
(a){
return(typeof(a)==='symbol')?a:%ToString(a);
}

--- END ---
