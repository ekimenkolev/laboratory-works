/*
 * Программа вычисления и вывода (в стандартный вывод) суммы одноцифровых чисел. 
 */

.include "my-macro"

.bss
    .lcomm c, 1     # буфер для чтения текущего символа. Размер - 1 байт
    .lcomm a, 1     # Буфер под хранение символа обработки.
    .lcomm str_sum, 10  # Строка под десятичное значение числа.
    .lcomm minus, 1 # Флаг минуса.
.data
sum:    .short -32760
ten:    .long 10
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

    cmpl $'-', c
    je if_minus

    cmpb $'9', c    # код больше кода символа '9' ?
    ja show_prompt
    cmpb $'0', c    # код меньше кода символа '0' ?
    jb show_prompt

    movb c, %al         # код из с пишем в al
    mov %eax, a        
    movl $0, minus


    jmp kbd_input   # на ввод следующего символа

if_enter:

    cmpb $'9', a    # код больше кода символа '9' ?
        ja show_prompt
    cmpb $'0', a    # код меньше кода символа '0' ?
        jb show_prompt
    
    movw a, %ax
    subw $48, %ax
    cmp $1, minus
    je sub_sum
    addw %ax, sum   
    jo buf_err          # Проверка на переполнение.

    movw $0, a
    
    Puts "Число получено" # Вывод сообщения об успешном вводе.
    jmp show_prompt
sub_sum:
    subw %ax, sum   
    jo buf_err       # Проверка на переполнение.

    movw $0, a
    
    Puts "Следующий символ" # вывод сообщения об успешном вводе
    jmp show_prompt

if_minus: 
    Getchar $a

    cmpb $'9', a    # код больше кода символа '9' ?
    ja show_prompt
    cmpb $'0', a    # код меньше кода символа '0' ?
    jb show_prompt
    
    movl $1, minus
    jmp show_prompt
buf_err:
    Puts "Буфер переполнен" # Сообщение об ошибке 
    jmp  stop
    
inversia:
    negw sum        #Инверсия
    
    movl $0, %esi
    movb $'-', str_sum(%esi)    # Знак - в начало строки

output:
    cmpw $0, sum    # частное положительное?  
    jl   inversia   # нет, на обработку отр. числа   
    
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

    jmp stop
    
stop:
    Exit $0
    
.end
