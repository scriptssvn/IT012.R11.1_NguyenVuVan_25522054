# Ho Ten: Nguyen Vu Van MSSV: 25522054
# Muc dich: tinh dien nang tung thang, tong ca nam va thang tieu thu cao nhat
# Ma nguon 7 va 8
# Thanh ghi: $s0 reading, $s1 usage, $s2 i, $s3 n, $s4 tong, $s5 max, $s6 thang max
#            $t1 = 4i, $t2 = &reading[i], $t3/$t4 = reading[i]/[i+1], $t5 = dien nang, $t6 = &usage[i], $t7 = so sanh
.data
m1:      .asciiz "Thang "
m2:      .asciiz ": "
mt:      .asciiz "Tong: "
mm:      .asciiz "Thang cao nhat: "
lp:      .asciiz " ("
rp:      .asciiz ")"
nl:      .asciiz "\n"
reading: .word 1000, 1095, 1205, 1345, 1510, 1715, 1955
         .word 2210, 2440, 2625, 2775, 2895, 2995
usage:   .space 48

.text
.globl main
main:
  la   $s0, reading     # $s0 = dia chi nen reading
  la   $s1, usage       # $s1 = dia chi nen usage
  addi $s2, $zero, 0    # i = 0
  addi $s3, $zero, 12   # n = 12 thang
  addi $s4, $zero, 0    # tong = 0
  addi $s5, $zero, 0    # max = 0
  addi $s6, $zero, 0    # thang cao nhat = 0
Loop:
  beq  $s2, $s3, Done   # thoat neu i == n
  sll  $t1, $s2, 2      # $t1 = 4 * i
  add  $t2, $t1, $s0    # $t2 = dia chi reading[i]
  lw   $t3, 0($t2)      # $t3 = reading[i]
  lw   $t4, 4($t2)      # $t4 = reading[i+1]
  sub  $t5, $t4, $t3    # $t5 = dien nang thang i+1
  add  $t6, $t1, $s1    # $t6 = dia chi usage[i]
  sw   $t5, 0($t6)      # usage[i] = $t5
  add  $s4, $s4, $t5    # tong += dien nang
  slt  $t7, $s5, $t5    # max < dien nang ?
  beq  $t7, $zero, Next # neu khong thi bo qua
  add  $s5, $t5, $zero  # max = dien nang
  addi $s6, $s2, 1      # thang cao nhat = i + 1
Next:
  li   $v0, 4
  la   $a0, m1
  syscall
  li   $v0, 1
  addi $a0, $s2, 1
  syscall
  li   $v0, 4
  la   $a0, m2
  syscall
  li   $v0, 1
  add  $a0, $t5, $zero
  syscall
  li   $v0, 4
  la   $a0, nl
  syscall
  addi $s2, $s2, 1      # i = i + 1
  j    Loop
Done:
  li   $v0, 4
  la   $a0, mt
  syscall
  li   $v0, 1
  add  $a0, $s4, $zero
  syscall
  li   $v0, 4
  la   $a0, nl
  syscall
  li   $v0, 4
  la   $a0, mm
  syscall
  li   $v0, 1
  add  $a0, $s6, $zero
  syscall
  li   $v0, 4
  la   $a0, lp
  syscall
  li   $v0, 1
  add  $a0, $s5, $zero
  syscall
  li   $v0, 4
  la   $a0, rp
  syscall
  li   $v0, 4
  la   $a0, nl
  syscall
  li   $v0, 10
  syscall