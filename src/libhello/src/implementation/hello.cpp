#include "../interface/libhello/hello.h"

#include <iostream>

#include <fmt/core.h>

namespace hello {
Greeter::Greeter(std::string name)
    : mName(std::move(name))
{
}

std::string Greeter::Greet() const { return fmt::format("Hello {}", mName); }
} // namespace hello