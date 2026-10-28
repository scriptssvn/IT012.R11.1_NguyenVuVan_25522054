# Ho va ten: Nguyen Vu Van; MSSV: 25522054
# Muc dich: Huong dan nguoi dung cach doc du lieu dau vao thong qua loi goi he thong ket hop cac phep toan so hoc
# Ma nguon 6 - dien nang tieu thu giua hai chi so
.data
prompt1: .asciiz "Nhap chi so cu (kWh): "
prompt2: .asciiz "Nhap chi so moi (kWh): "
label:   .asciiz "Dien nang (kWh): "
newline: .asciiz "\n"

.text
.globl main
main:
    # --- doc chi so cu vao $s0 ---
    li   $v0, 4
    la   $a0, prompt1
    syscall
    li   $v0, 5              # dich vu 5: doc so nguyen, ket qua o $v0
    syscall
    add  $s0, $v0, $zero     # giu gia tri trong $s0

    # --- doc chi so moi vao $s1 ---
    li   $v0, 4
    la   $a0, prompt2
    syscall
    li   $v0, 5
    syscall
    add  $s1, $v0, $zero

    sub  $t0, $s1, $s0       # usage = current - previous

    li   $v0, 4              # in label
    la   $a0, label
    syscall
    li   $v0, 1              # in usage
    add  $a0, $t0, $zero
    syscall
    li   $v0, 4              # in newline
    la   $a0, newline
    syscall

    li   $v0, 10
    syscall
