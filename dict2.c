/**
0;136;0c * dict1.c -- программа чтения словаря и печати словарной статьи по номеру
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAXLINE 1023
#define MAXFILESIZE 10485760

/* Функция загрузки словаря в память */
char* load_dictionary(char *dictionary, FILE *stream);
/* Функция вывода статей, соответствующих заданному шаблону */
char *filter_dictionary(char *pattern, const char *dictionary,
			char *entries);
/*Функция поиска соответсвий шаблону в файле*/
int valid(const char *line, const char *pattern);

int main(int argc, char *argv[])
{
    if (argc < 2) {
	fprintf(stderr, "Not enough arguments\n");
	exit(EXIT_FAILURE);
    }

    /* Файл словаря */
    FILE *dict = NULL;
    char *dictionary = 0;

    /* Открываем файл словаря */
    dict = fopen(argv[1], "r");
    if (dict == NULL){
	perror(argv[0]);
    exit(EXIT_FAILURE);
    }
    /*"Выделяем динамическую память для словоря" */
    dictionary = (char*)malloc(MAXFILESIZE);
    dictionary = load_dictionary(dictionary,dict);
        
    /*Проверяем файл*/
    if (dict == NULL) {
	fprintf(stderr, "Error while opening file\n");
	exit(EXIT_FAILURE);
    }
    
    /* Выделяем память под вывод отобранных статей */
    char *entries;
    entries = (char*)malloc(MAXFILESIZE);

    /* Шаблон искомой статьи */
    char linein[MAXLINE +1] = "";

    char *enter;
    
    printf("Чтобы закончить работу с программой введите -1\n");
    
    /* Получаем шаблон словарной статьи для поиска */
    while((scanf("%s", linein) != -1)){
	if (strcmp(linein,"-1")==0)
	    return 0;
        /* Выводим статьи, соответствующие заданному шаблону */
	enter = (char*)malloc(MAXFILESIZE);
	enter = filter_dictionary(linein, dictionary, entries);

	/* Если статей не было найдено, выводим соответствующее сообщение */
	if (enter == NULL)
	    printf("Статей не найдено\n");

	/* Иначе выводим найденные статьи */
	else
	    puts(enter);

	memset(linein, 0, MAXLINE);
    }

    /* Освобождаем память */
    free(entries);
    free(dictionary);
    free(enter);

    /* Завершаем работу с файлом словаря */
    fclose(dict);

    return 0;
}

/* Функция вывода статей, соответствующих шаблону */
char *filter_dictionary(char *pattern, const char *dictionary,
			char *entries)
{
    /* Текущая строка */
    char current_line[MAXLINE + 1];

    /* Обнуляем переменные и освобождаем буфер найденных статей */
    memset(entries, 0, MAXFILESIZE);

    /* Флаг соответствия текущей статьи условию отбора */
    int matched_entry = 0;

    /* Текущий символ словаря */
    int s = 0;
    /* Символ, на котором остановились при просмотре */
    int end_dict = 0;
    int end_buffer = 0;

    /* Просматриваем словарь, печатая строки запрошенной статьи */
    while (dictionary[end_dict] != '\0') {
	int i = 0;
	for (s = end_dict; dictionary[s] != '\n' && dictionary[s] != '\0'; s++) {
	    current_line[i] = dictionary[s];
	    i++;
	    if (i == MAXLINE - 1) {
		break;
	    }
	}
	current_line[i] = '\n';
	current_line[i + 1] = '\0';

	/* Символ, на котором мы остановились при просмотре словаря */
	end_dict = s + 1;

	/* Если первый символ строки не является пробелом, найдено начало новой \
	   словарной статьи */
	if (!isspace(current_line[0])) {
	    /* Флаг соответствия текущей статьи условию отбора */
	    matched_entry = 0;

	    /* Определяем, выполнено ли условие отбора для данной статьи */
	    if (valid(current_line, pattern) == 1) {
		matched_entry = 1;
	    }
	}

	/* Записываем строку в буфер, если найдено совпадение */
	if (matched_entry) {
	    sprintf(entries + end_buffer, "%s\n", current_line);
	    end_buffer += strlen(current_line);
	}

	/* Обнуляем текущую строку */
	memset(current_line, 0, MAXLINE);
    }

    /* Возвращаем адрес буфера выбранных статей */
    if (*entries == 0)
	return NULL;
    else
	return entries;

}


int valid(const char *line, const char *pattern)
{
    int result = 0;

    /*Флаг расположения шаблона в начале строки*/
    int left = 0;
    /*Флаг расположения шаблона в конце строки*/
    int right = 0;

    int length = strlen(pattern);

    if (pattern[0] == '^') {
	left = 1;
    }
    if (pattern[length - 1] == '$') {
	right = 1;
    }

    if (left == 0 && right == 0) {
	if (strstr(line, pattern) != NULL) {
	    result = 1;
	}
    } else if (left == 1 && right == 0) {
	int matches = 0;

	/*Проверяем совпадения строки и шаблона*/
	for (int i = 0; i < length - 1; i++) {
	    if (line[i] == pattern[i + 1]) {
		matches++;
	    }
	}

	if (matches == length - 1)
	    result = 1;
    } else if (left == 0 && right == 1) {
	int matches = 0;
	int line_length = strlen(line);

	/*Проверяем совпадения строки и шаблона*/
	for (int i = 0; i < length; i++) {
	    if (line[line_length - 1 - i] == pattern[length - 1 - i]) {
		matches++;
	    }
	}

	if (matches == length - 1)
	    result = 1;
    } else if (left == 1 && right == 1) {
	int matches = 0;
	/*Получаем длину заголовка статьи */
	int line_length = strlen(line);

	/*Проверяем совпадения строки и шаблона*/
	for (int i = 1; i < length - 1; i++) {
	    if (line[i - 1] == pattern[i])
		matches++;
	}

	if (matches == length - 2 && line_length == length - 1)
	    result = 1;
    }

    return result;
}
char* load_dictionary(char *dictionary, FILE *dict){

    /*Ставим указатель на конец открытого файла */
    if (fseek(dict, 0L, SEEK_END) != 0 )
	return NULL;
    /*size =  размер открытого файла */
    long size = ftell(dict);
    /*Ставим указатель на начало */
    if (fseek(dict,0L, SEEK_SET) != 0)
	return NULL;
    /*Проверяем Превышение размера файла */
    if (size > MAXFILESIZE || size < 0){ 
	return NULL;
    }
    /*Записываем все символы файла в символьный массив */
    if (fread(dictionary, 1,size, dict) != (size_t) size){
	return NULL;
    }
    return dictionary;
}

