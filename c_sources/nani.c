#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv)
{
    int value;
    if (scanf("%d", &value) == EOF)
    {
        perror("scanf");
        exit(1);
    }
    printf(
        "\t.text\n\t"
        ".global nani_main\n"
        "nani_main:\n\t"
        "mov $%d, %%eax\n\t"
        "ret\n",
        value);
    return 0;
}
