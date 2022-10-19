/* dmenu появится в верхней части экрана (-o) */
static int toppbar = 1;

/* Шрифт */
static const char *fonts[] = {"Cascadia Code PL:size=11"};

/* Текст слева от поля ввода (-p) */
static const char *prompt = NULL;

/* Цветовая схема */
static const char *colors[SchemeLast][2] = {
    /* Передний фон / задний фон */
    [SchemeNorm] = {"#11A8CD", "#222222"},
    [SchemeSel] = {"#eeeeee", "#11A8CD"},
    [SchemeOut] = {"#000000", "#00ffff"},
};

/* Элементы списка идут горизонтально (-l) */
static unsigned lines = 0;

/* Разделители слов */
static const char worddelimiters[] = " ";
