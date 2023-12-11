; bootloader.asm

section .text
    global _start

_start:
    ; Set up segments and stack
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00  ; Set stack pointer to 0x7C00

    ; Load kernel into memory
    mov bx, 0x0000  ; Segment where the kernel will be loaded
    mov ah, 0x02    ; BIOS read sector function
    mov al, 1       ; Number of sectors to read
    mov ch, 0       ; Cylinder number
    mov dh, 0       ; Head number
    mov dl, 0x00    ; Drive number (assume the kernel is on the first floppy disk)
    mov es, bx      ; Set ES to the segment where the kernel will be loaded
    mov bx, 0x0100  ; Offset where the kernel will be loaded
    int 0x13        ; BIOS interrupt to read disk sectors

    ; Check for errors in the read operation
    jc disk_error

    ; Jump to the kernel
    jmp 0x0000:0x0100

disk_error:
    ; Handle disk read error (add your error handling code here)

    ; Infinite loop
    cli
    hlt

section .bss
    ; BSS section (if needed)
