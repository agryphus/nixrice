syntax case ignore

" Match regexes.
syntax match lc3Label     /[A-Za-z_][A-Za-z0-9_]*/
syntax match lc3Register  /[rR][0-7]/
syntax match lc3Decimal   /#\=-\=\<[0-9]\+\>/
syntax match lc3Hex       /x-\=[A-Fa-f0-9]\+/
syntax match lc3Binary    /b-\=[01]\+/
syntax region lc3String   start=+"+ skip=+\\"+ end=+"+
syntax region lc3Comment  start=+;+ end=+$+

" Assembler directives/pseudo-ops
syntax match lc3Directive /\.orig/
syntax match lc3Directive /\.end/
syntax match lc3Directive /\.fill/
syntax match lc3Directive /\.blkw/
syntax match lc3Directive /\.stringz/

" LC-3 opcodes/aliases, minus branches
syntax keyword lc3Opcode add ld st jsrr jsr and ldr str rti not ldi sti jmp ret lea trap nop
" Branches
syntax keyword lc3Opcode br brn brz brp brnz brnp brzp brnzp
" Trap subroutines
syntax keyword lc3Opcode getc out puts in putsp halt
" LC-3b opcodes
syntax keyword lc3Opcode ldb ldw lshf rshfl rshfa stb stw xor

" Link colors.
hi def link lc3Opcode    Statement
hi def link lc3Label     Identifier
hi def link lc3Register  Type
hi def link lc3Directive Define
hi def link lc3Decimal   Number
hi def link lc3Hex       Number
hi def link lc3Binary    Number
hi def link lc3String    String
hi def link lc3Comment   Comment

let b:current_syntax = "asm"

