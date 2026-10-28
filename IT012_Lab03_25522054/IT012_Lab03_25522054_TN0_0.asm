# Ho va ten: Nguyen Vu Van; MSSV: 25522054
# Muc dich: Lam quen voi phan mem MARS.
# Ma nguon 0 - kiem tra nhanh
.data
msg:   .asciiz "Xin chao, MARS!\n"
 
.text
.globl main
main:
    li   $v0, 4
    la   $a0, msg
    syscall
    li   $v0, 10
    syscall
