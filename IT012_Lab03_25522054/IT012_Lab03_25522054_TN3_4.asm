# Ho va ten: Nguyen Vu Van; MSSV: 25522054
# Muc dich: Chuyen doii cac bieu thuc toan hoc phuc tap thanh cac cau lenh hop ngu MIPS, nam vung cach su dung thanh ghi tam thoi vi du nhu $t5 de luu ket qua trung gian, khao sat cach bo xu ly MIPS bieu dien so am trong thanh ghi qua phuong phap bu 2.
# Ma nguon 4 - chuyen cau lenh thanh lenh hop ngu
.text
.globl main
main:
    addi $s0, $zero, 8       # y = 8
    addi $s1, $zero, 5       # z = 5
    addi $s2, $zero, 3       # w = 3
 
    # x1 = y + z + w 
    add $t0, $s0, $s1
    addi $t0, $t0, $s2 
    # x2 = (y + z) - (w +5)
    add $t1, $s0, $s1
    addi $t5, $s2, 5
    sub $t1, $t1, $t5
    # x3 = y
    add $t2, $s0, $zero
    #x4 = z - y 
    sub $t3, $s1, $s0
 
    li   $v0, 10
    syscall
