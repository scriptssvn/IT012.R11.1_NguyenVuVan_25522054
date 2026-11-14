# Ho Ten: Nguyen Vu Van MSSV: 25522054
# Muc dich: tinh dien nang tung thang, tong, thang cao nhat va dem so thang theo bac gia dien
# Ma nguon 7 (Phan du lieu)
.data
m1:      .asciiz "Thang "
m2:      .asciiz ": "
mt:      .asciiz "Tong: "
mm:      .asciiz "Thang cao nhat: "
lp:      .asciiz " ("
rp:      .asciiz ")"
nl:      .asciiz "\n"
mb:      .asciiz "Bac "
reading: .word 1000, 1095, 1205, 1345, 1510, 1715, 1955
         .word 2210, 2440, 2625, 2775, 2895, 2995
usage:   .space 48

cnt:     .word 0, 0, 0, 0

# Ma nguon 8 – dien nang tung thang
.text
.globl main
main:
  la   $s0, reading     # $s0 = dia chi nen reading
  la   $s1, usage       # $s1 = dia chi nen usage
  addi $s2, $zero, 0    # i = 0
  addi $s3, $zero, 12   # n = 12 thang
  addi $s4, $0, 0       # $s4: tong dien nang = 0
  addi $s5, $0, -1      # $s5: dien nang lon nhat = -1
  addi $s6, $0, 0       # $s6: thang cao nhat = 0
Loop:
  # >>> thoat neu i == n
  beq $s2, $s3, Done

  # >>> tinh dia chi reading[i]
  sll $t1, $s2, 2       # $t1 = 4*i
  add $t2, $t1, $s0     # $t2 = dia chi reading[i]

  # >>> $t3 = reading[i], $t4 = reading[i+1]
  lw $t3, 0($t2)        # $t3 = reading[i]
  lw $t4, 4($t2)        # $t4 = reading[i+1]

  # >>> $t5 = $t4 - $t3 (dien nang thang i+1)
  sub $t5, $t4, $t3

  # >>> tinh dia chi usage[i], luu $t5 vao usage[i]
  add $t6, $t1, $s1     # $t6 = 4*i + dia chi nen usage
  sw $t5, 0($t6)        # usage[i] = $t5

  # >>> cong don dien nang cac thang vao $s4, dien nang lon nhat $s5, thang tuong ung $s6
  add $s4, $s4, $t5
  # >>> so sanh dien nang thang hien tai voi $s5 bang slt
  slt $t7, $s5, $t5
  beq $t7, $0, month
  add $s5, $t5, $0
  addi $s6, $s2, 1

  month:
  # >>> in "Thang ", i+1, ": ", $t5, xuong dong
  li $v0, 4
  la $a0, m1
  syscall

  li $v0, 1
  addi $a0, $s2, 1
  syscall

  li $v0, 4
  la $a0, m2
  syscall

  li $v0, 1
  add $a0, $t5, $zero
  syscall

  li $v0, 4
  la $a0, nl
  syscall
  # >>> i = i + 1, quay lai Loop
  addi $s2, $s2, 1
  j Loop

Done:
  # >>> in tong
  li $v0, 4
  la $a0, mt            # in "Tong: "
  syscall

  li $v0, 1
  add $a0, $s4, $0      # in tong dien nang cac thang
  syscall

  li $v0, 4
  la $a0, nl            # xuong dong
  syscall
  # >>> in thang cao nhat
  li $v0, 4
  la $a0, mm            # in "Thang cao nhat: "
  syscall

  li $v0, 1
  add $a0, $s6, $0      # in thang tuong ung $s6
  syscall

  li $v0, 4
  la $a0, lp            # in " ("
  syscall

  li $v0, 1
  add $a0, $s5, $0      # in dien nang lon nhat $s5
  syscall

  li $v0, 4
  la $a0, rp            # in ")"
  syscall

  li $v0, 4
  la $a0, nl
  syscall

  la   $s7, cnt         # $s7 = dia chi nen cua cnt
  addi $s2, $0, 0       # i = 0; n van la 12 ($s3 = 12)
  LoopBac:
        beq $s2, $s3, InBac     # i = n thi nhay toi InBac
        # lay gia tri cua usage[i] vao $t3
        sll $t1, $s2, 2         # $t1 = 4*i
        add $t2, $t1, $s1       # $t2 = dia chi nen cua usage[i]
        lw $t3, 0($t2)          # $t3 = usage[i]

        addi $t5, $0, 101       # Bac1 <= 100 kWh
        slt $t6, $t3, $t5
        bne $t6, $0, Bac1

        addi $t5, $0, 151       # Bac2 <= 150 kWh
        slt $t6, $t3, $t5
        bne $t6, $0, Bac2

        addi $t5, $0, 201       # Bac3 <= 200 kWh
        slt $t6, $t3, $t5
        bne $t6, $0, Bac3

        j       Bac4            # Bac4 > 201 kWh

 Bac1:
        addi $t4, $0, 0         # chi so mang cnt la 0
        j       Updatecnt
 Bac2:
        addi $t4, $0, 1         # chi so mang cnt la 1
        j       Updatecnt
 Bac3:
        addi $t4, $0, 2         # chi so mang cnt la 2
        j       Updatecnt
 Bac4:
        addi $t4, $0, 3         # chi so mang cnt la 3
        j       Updatecnt

 Updatecnt:
        # tinh dia chi cua cnt[k] va tang len 1
        sll $t5, $t4, 2         # $t5 = 4*k
        add $t5, $t5, $s7       # $t5 = dia chi cua cnt[k]
        lw $t6, 0($t5)          # doc gia tri cua cnt[k]
        addi $t6, $t6, 1        # tang them 1
        sw $t6, 0($t5)          # luu lai vao cnt[k]

        addi $s2, $s2, 1        # i++
        j       LoopBac

 InBac:
        addi $s2, $0, 0         # j = 0
        addi $s3, $0, 4         # so luong bac = 4
 LoopInBac:
        beq $s2, $s3, Exit

        li $v0, 4
        la $a0, mb              # in "Bac "
        syscall

        li $v0, 1
        addi $a0, $s2, 1        # in so thu tu bac k (j + 1)
        syscall

        li $v0, 4
        la $a0, m2              # in ": "
        syscall

        # in cnt[j]
        sll $t1, $s2, 2         # $t1 = 4*j
        add $t2, $t1, $s7       # $t2 = dia chi cua cnt[j]
        lw $a0, 0($t2)          # $a0 = cnt[j]
        li $v0, 1
        syscall

        li $v0, 4
        la $a0, nl
        syscall

        addi $s2, $s2, 1
        j       LoopInBac
 Exit:
        li   $v0, 10
        syscall