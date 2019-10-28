#include <iostream>
#include <lib/component1.hh>
#include "colors.h"

int main(int argc, char* argv[])
{
    std::cout << "Greetings from the main function." << std::endl;
    std::cout << FYEL("I'm the yellow text.") << std::endl;
    std::cout << BOLD(FBLU("I'm the blue-bold text.")) << std::endl;
    return Bar().foo();
}
