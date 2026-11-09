# Ho Ten: Nguyen Vu Van MSSV: 25522054
# Muc dich: doc dien nang (kWh), xac dinh bac gia dien 1..4 va in ra man hinh
# Ma nguon 5 – phan bac dien nang
.data
prompt: .asciiz "Nhap dien nang (kWh): "
msg:    .asciiz "Bac: "
nl:     .asciiz "\n"
 
.text
.globl main
main:
  li  $v0, 4
  la  $a0, prompt
  syscall
  li  $v0, 5            # doc kWh, ket qua o $v0
  syscall
  add $s0, $v0, $zero   # $s0 = dien nang (kWh)
  slti $t0, $s0, 101    # kWh < 101 (tuc <= 100) ?
  bne  $t0, $zero, Bac1
  slti $t0, $s0, 151    # kWh < 151 ?
  bne  $t0, $zero, Bac2
  slti $t0, $s0, 201    # kWh < 201 ?
  bne  $t0, $zero, Bac3
  addi $s1, $zero, 4    # con lai: bac 4
  j    InKQ
Bac1:
  addi $s1, $zero, 1
  j    InKQ
Bac2:
  addi $s1, $zero, 2
  j    InKQ
Bac3:
  addi $s1, $zero, 3
InKQ:
  li  $v0, 4
  la  $a0, msg
  syscall
  li  $v0, 1
  add $a0, $s1, $zero
  syscall
  li  $v0, 4
  la  $a0, nl
  syscall
  li  $v0, 10
  syscall
