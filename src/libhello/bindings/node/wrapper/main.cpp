#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wsign-conversion"
#pragma GCC diagnostic ignored "-Wconversion"
#pragma GCC diagnostic ignored "-Wshadow"
#include <napi.h>
#pragma GCC diagnostic pop

#include "greater_wrapper.h"

Napi::Object InitAll(Napi::Env env, Napi::Object exports)
{
    hello::wrapper::GreeterWrapper::Init(env, exports);
    return exports;
}

NODE_API_MODULE(NODE_GYP_MODULE_NAME, InitAll)
