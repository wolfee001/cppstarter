#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wsign-conversion"
#pragma GCC diagnostic ignored "-Wconversion"
#pragma GCC diagnostic ignored "-Wshadow"
#include <napi.h>
#pragma GCC diagnostic pop

#include <memory>

namespace hello {

class Greeter;

namespace wrapper {

    class GreeterWrapper : public Napi::ObjectWrap<GreeterWrapper> {
    public:
        static Napi::Object Init(Napi::Env env, Napi::Object exports);
        GreeterWrapper(const Napi::CallbackInfo& info);

    private:
        Napi::Value greet(const Napi::CallbackInfo& info);

    private:
        static Napi::FunctionReference constructor;
        std::unique_ptr<Greeter> mUnderlyingObject;
    };

}
}
