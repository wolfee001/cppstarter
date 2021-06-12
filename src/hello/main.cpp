#include <libhello/hello.h>

#include <iostream>

#include <fmt/core.h>

int main()
{
    std::cout << fmt::format("Hello, {}!", "World") << std::endl;

    hello::Greeter greeter("wolfee");
    greeter.Greet();

    return 0;
}