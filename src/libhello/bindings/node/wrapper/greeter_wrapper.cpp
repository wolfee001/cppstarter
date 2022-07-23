#include "greeter_wrapper.h"
#include "napi.h"

#include <libhello/hello.h>
#include <memory>

namespace hello::wrapper {

Napi::FunctionReference GreeterWrapper::constructor;

Napi::Object GreeterWrapper::Init(Napi::Env env, Napi::Object exports)
{
    Napi::Function func = DefineClass(env, "Greeter", { InstanceMethod("greet", &GreeterWrapper::greet) });

    constructor = Napi::Persistent(func);
    constructor.SuppressDestruct();

    exports.Set("Greeter", func);
    return exports;
}

GreeterWrapper::GreeterWrapper(const Napi::CallbackInfo& info)
    : Napi::ObjectWrap<GreeterWrapper>(info)
{
    if (info.Length() != 1 || !info[0].IsString()) {
        Napi::TypeError::New(info.Env(), "One string parameter expected").ThrowAsJavaScriptException();
    }

    mUnderlyingObject = std::make_unique<hello::Greeter>(info[0].As<Napi::String>());
}

Napi::Value GreeterWrapper::greet(const Napi::CallbackInfo& info)
{
    if (info.Length() != 0) {
        Napi::TypeError::New(info.Env(), "No argument expected").ThrowAsJavaScriptException();
    }

    return Napi::String::New(info.Env(), mUnderlyingObject->Greet());
}

}