#include "../interface/libhello/hello.h"

#include <iostream>

#include <fmt/core.h>

namespace hello {
Greeter::Greeter(std::string name)
    : mName(std::move(name))
{
}

void Greeter::Greet() const { std::cout << fmt::format("Hello {}", mName) << std::endl; }
} // namespace hello