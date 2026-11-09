# Ho Ten: Nguyen Vu Van MSSV: 25522054
# Muc dich: khai bao mang reading (13 chi so) va usage trong bo 
# Ma nguon 1 – mang trong bo nho
.data
reading: .word 1000, 1095, 1205, 1345, 1510, 1715, 1955
         .word 2210, 2440, 2625, 2775, 2895, 2995
usage:   .space 48
 
.text
.globl main
main:
  li  $v0, 10
  syscall
