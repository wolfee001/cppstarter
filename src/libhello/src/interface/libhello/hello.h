#pragma once

#include <string>

namespace hello {
class Greeter {
public:
    explicit Greeter(std::string name);

    std::string Greet() const;

private:
    std::string mName;
};
} // namespace hello