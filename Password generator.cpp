
#include <iostream>
#include<ctime>
#include<stdio.h>

extern "C" unsigned __int64 Generate(unsigned __int8 length);
int main()
{
    unsigned __int64 length = 5;
    std::cout << "Write password length:" << std::endl;
    std::cin >> length;
    if (length == 1)
    {
        srand(time(NULL));
        std::cout << rand() % 10;
        return 0;
    }

    unsigned __int64 generatedPassword = Generate(length);
    std::cout << generatedPassword;

    return 0;
}
