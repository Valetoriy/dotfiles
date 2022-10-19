#include <dirent.h>
#include <linux/limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

static char *argv0;

static int match;
static int flag[26];
#define FLAG(x) (flag[(x) - 'a'])
static struct stat old, new;

static void test(const char *path, const char *name) {
    struct stat stt, link;

    if ((!stat(path, &stt) &&
         (FLAG('a') || name[0] != '.') /* Не игнорировать скрытый */
         && (!FLAG('b') || S_ISBLK(stt.st_mode)) /* Блочный (особ.) */
         && (!FLAG('c') || S_ISCHR(stt.st_mode)) /* Символьный (особ.) */
         && (!FLAG('d') || S_ISDIR(stt.st_mode))    /* Папка */
         && (!FLAG('e') || access(path, F_OK) == 0) /* Существует */
         && (!FLAG('f') || S_ISREG(stt.st_mode))    /* Обычный */
         &&
         (!FLAG('g') || stt.st_mode & S_ISGID) /* Установлен флаг-ID группы */
         && (!FLAG('h') ||
             (!lstat(path, &link) && S_ISLNK(link.st_mode))) /* Ссылка */
         && (!FLAG('n') || stt.st_mtime > new.st_mtime) /* Новее, чем файл */
         && (!FLAG('o') || stt.st_mtime < old.st_mtime) /* Старее, чем файл */
         && (!FLAG('p') || S_ISFIFO(stt.st_mode)) /* Именованный канал (|) */
         && (!FLAG('r') || access(path, R_OK) == 0) /* Читаемый */
         && (!FLAG('s') || stt.st_size > 0)         /* Не пустой */
         && (!FLAG('u') ||
             stt.st_mode & S_ISUID) /* Установлен флаг-ID пользователя */
         && (!FLAG('w') || access(path, W_OK) == 0) /* Записываемый */
         && (!FLAG('x') || access(path, X_OK) == 0)) != /* Исполняемый */
        FLAG('v')) {
        if (FLAG('q')) exit(0);
        match = 1;
        puts(name);
    }
}

static void usage(void) {
    fprintf(stderr,
            "usage: %s [-abcdefghlpqrsuvwx] "
            "[-n file] [-o file] [file...]\n",
            argv0);
    exit(2); /* Аналогично test(1) возвращаем > 1 при ошибке */
}

int main(int argc, char **argv) {
    struct dirent *dir_entry;
    char path[PATH_MAX], *line = NULL, *file;
    size_t linesiz = 0;
    ssize_t num_read;
    DIR *dir;
    int res;

    /* Парсинг аргументов, начинающихся с '-' */
    for (argv0 = *argv, ++argv, --argc;
         argv[0] && argv[0][0] == '-' && argv[0][1]; ++argv, --argc) {
        char arg_char;
        int brk_flag;
        /* При "--" выходим из цикла */
        if (argv[0][1] == '-' && argv[0][2] == '\0') {
            ++argv;
            --argc;
            break;
        }
        /* В каждом аргументе после '-' */
        for (brk_flag = 0, ++argv[0]; argv[0][0] && !brk_flag; ++argv[0]) {
            /* Сопоставляем символ агрумента */
            arg_char = argv[0][0];
            switch (arg_char) {
                case 'n': /* Новее, чем файл */
                case 'o': /* Старее, чем файл */
                    file =
                        /* Предоставлен ли файл для -n/o? */
                        ((argv[0][1] != '\0' || argv[1] == NULL)
                             ? (usage(), (char *)0) /* Нет - ошибка */
                             : (brk_flag =
                                    1, /* Да - ставим флаг и возвращаем адрес */
                                (++argv, --argc, argv[0])));

                    if (!(FLAG(arg_char) =
                              !stat(file, (arg_char == 'n' ? &new : &old))))
                        perror(file);
                    break;
                default:
                    /* Остальные флаги */
                    if (strchr("abcdefghlpqrsuvwx", arg_char))
                        FLAG(arg_char) = 1;
                    else
                        usage(); /* Неизвестный флаг */
            }
        }
    }

    /* Если в агрументы не были переданы имена файлов, считываем их из stdin */
    if (!argc) {
        while ((num_read = getline(&line, &linesiz, stdin)) > 1) {
            if (line[num_read - 1] == '\n') line[num_read - 1] = '\0';
            test(line, line);
        }
        free(line);
    } else {
        for (; argc; argc--, argv++) {
            if (FLAG('l') && (dir = opendir(*argv))) {
                /* Проверка сожержимого папки */
                while ((dir_entry = readdir(dir))) {
                    res = snprintf(path, sizeof path, "%s/%s", *argv,
                                   dir_entry->d_name);
                    if (res >= 0 && (size_t)res < sizeof path)
                        test(path, dir_entry->d_name);
                }
                closedir(dir);
            } else {
                test(*argv, *argv);
            }
        }
    }
    return match ? 0 : 1;
}
