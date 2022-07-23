#include <gmock/gmock.h>
#include <gtest/gtest.h>
#include <memory>
#include <optional>
#include <stdexcept>

#include <libhello/hello.h>

using namespace std::string_literals;

TEST(Greeter, Default)
{
    hello::Greeter g("Test");
    EXPECT_EQ(g.Greet(), "Hello Test"s);
}
