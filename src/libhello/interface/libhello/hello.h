#pragma once

#include <string>

namespace hello {
class Greeter {
public:
    Greeter(const std::string& name);

    void Greet() const;

private:
    std::string mName;
};
}