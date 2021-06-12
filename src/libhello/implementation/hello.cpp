#include "../interface/libhello/hello.h"

#include <iostream>

#include <fmt/core.h>

namespace hello {
Greeter::Greeter(const std::string& name)
    : mName(name)
{
}

void Greeter::Greet() const
{
    std::cout << fmt::format("Hello {}", mName) << std::endl;
}
}