# Ho va ten: Nguyen Vu Van; MSSV: 25522054
# Muc dich: Minh hoa cac phep toan so hoc duoc chuyen thanh cac lenh hop ngu, su dung thanh ghi trung gian, lam quen voi su thay doii gia tri cua thanh ghi qua tung buoc chay chuong trinh.
# Ma nguon 2 - a = b + c
.text
.globl main
main:
    addi $t1, $zero, 7       # b = 7
    addi $t2, $zero, 5       # c = 5
    add  $t0, $t1, $t2       # a = b + c
    li   $v0, 10
    syscall
