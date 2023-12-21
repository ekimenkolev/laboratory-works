/*
 * Программа вычисления и вывода (в стандартный вывод) суммы одноцифровых чисел. 
 */

.include "my-macro"

.bss
    .lcomm c, 1     # буфер для чтения текущего символа. Размер - 1 байт
    .lcomm a, 1     # Буфер под хранение символа обработки.
    .lcomm str_sum, 10  # Строка под десятичное значение числа.
    .lcomm str_sum_oct, 10  # Строка под 8 ое значение числа.
    .lcomm str_sum_bin, 17  # Строка для бинарного значения числа.
.data
sum:    .short +65530 
ten:    .long 10
oct:    .long 8
bin:    .long 2
.text
.global _start

_start:
    
show_prompt:
    Puts "Вводите цифру, друг мой!"     # макровызов вывода строки на стандартный

kbd_input:
    Getchar $c           # макровызов ввода символа со стандартного ввода

    cmpl $0, %eax       # Конец файл - EOF (введено 0 символов) ? 
    je output       # Да - на завершение программы

    cmpb $'\n',c    # Получен Enter.
    je if_enter         # Выполнение инструкции при minus.

    cmpb $'9', c    # код больше кода символа '9' ?
    ja show_prompt
    cmpb $'0', c    # код меньше кода символа '0' ?
    jb show_prompt

    movb c, %al         # код из с пишем в al
    mov %eax, a        

    jmp kbd_input   # на ввод следующего символа

if_enter:

    cmpb $'9', a    # код больше кода символа '9' ?
        ja show_prompt
    cmpb $'0', a    # код меньше кода символа '0' ?
        jb show_prompt
    
    movw a, %ax
    subw $48, %ax
    addw %ax, sum   
    jo buf_err          # Проверка на переполнение.
    jc buf_err  
    movw $0, a
    
    Puts "Число получено" # Вывод сообщения об успешном вводе.
    jmp show_prompt

buf_err:
    Puts "Буфер переполнен" # Сообщение об ошибке 
    jmp  stop

output: 
    
    movl $6, %esi
    movb $'\n', str_sum(%esi) 
    decl %esi
    
    movw sum, %ax    # готовим деление  
nextdigit:
    movl  $0, %edx          # еще готовим
    idivl ten      # делим объединенные регистры edx:eax на 10
    addl $48, %edx
    movb %dl, str_sum(%esi) # Загрузить содержимое dl (введенный символ) в байт по
    decl %esi
    cmpl $0, %eax    # частное < 0 ?
    jg   nextdigit   # НЕТ, продолжаем
    
## Выводим строки в консоль.
    movl $4, %eax        # Указываем системный вызов на write.
    movl $1, %ebx           # Указываем поток (stdout).
    movl $str_sum, %ecx     # указатель на строку.
    movl $7, %edx       # Длина строки(7 максимум чисел при 2 байтах).
    int $0x80       # Вызов ядра.


## Перевод в восьмеричную систему счисления

    movl $7, %esi
    movb $'\n', str_sum_oct(%esi) 
    decl %esi
    
    movw sum, %ax    # готовим деление  
nextdigit_oct:
    movl  $0, %edx          # еще готовим
    idivl oct      # делим объединенные регистры edx:eax на 8
    addl $48, %edx
    movb %dl, str_sum_oct(%esi) # Загрузить содержимое dl (введенный символ) в байт по
    decl %esi
    cmpl $0, %eax    # частное < 0 ?
    jg   nextdigit_oct   # НЕТ, продолжаем
    
    ## Выводим строки в консоль.
    movl $4, %eax       
    movl $1, %ebx       
    movl $str_sum_oct, %ecx     
    movl $8, %edx   
    int $0x80

    ## Перевод в двоичную систему счисления

    movl $16, %esi
    movb $'\n', str_sum_bin(%esi)
    decl %esi
    
    movw sum, %ax    # готовим деление  
nextdigit_bin:
    movl  $0, %edx          # еще готовим
    idivl bin      # делим объединенные регистры edx:eax на 2
    addl $48, %edx
    movb %dl, str_sum_bin(%esi) # Загрузить содержимое dl (введенный символ) в байт по
    decl %esi
    cmpl $0, %eax    # частное < 0 ?
    jg   nextdigit_bin   # НЕТ, продолжаем
    
    ## Выводим строки в консоль.
    movl $4, %eax       
    movl $1, %ebx       
    movl $str_sum_bin, %ecx     
    movl $17, %edx  
    int $0x80

    

    jmp stop
    
stop:
    Exit $0
    
.end
