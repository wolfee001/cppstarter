#pragma once

#include <string>

namespace hello {
class Greeter {
public:
    explicit Greeter(std::string name);

    void Greet() const;

private:
    std::string mName;
};
} // namespace hello