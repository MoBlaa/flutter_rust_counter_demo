# flutter_rust_counter_demo

A Demo Flutter app using rust on Android and Web.

## How it works

The Rust Counter library (`native/counter`) is either wrapped by:

- the FFI Library (`native/counter-ffi`) exposing a API similiar to C for other languages to call or
- the WASM Library (`native/counter-wasm`) creating a .wasm file (and a .js file to load it).

These libraries are copied to their appropriate locations:

- Android: [packages/counter/android/src/main/jniLibs](packages/counter/android/src/main/jniLibs)
- Web: [packages/counter/pkg](packages/counter/pkg)

and later called by the plugin code ([packages/counter/lib](packages/counter/lib)) which is organized to expose an implementation of the CounterBase class fitting the platform the application is currently running. 
This means: Either a delegate to a method channel ([counter_method_channel.dart](packages/counter/lib/counter_method_channel.dart)) or a native implementation ([counter_native.dart](packages/counter/lib/counter_native.dart)) which calls the rust code.

For the Web part this requires some additional files. The Plugin code in [counter_web.dart](packages/counter/lib/counter_web.dart) is only delegating to the [init_module.js](packages/counter/pkg/init_module.js) which loads the wasm code and registers methods on the window.

## Structure

- [Rust Counter Library](native/counter): Pure Rust project. Could also be an external library.
- [Rust FFI Library](native/counter-ffi): Rust Project setup to be called from other languages.
- [Rust WASM Library](native/counter-wasm): Rust Project setup to be called from web.
- [Flutter Plugin](packages/counter): Bridge to the platform specific code. Calls the rust code either through wasm (web) or ffi (android).
- [Flutter project](lib): Pure Dart/Flutter project.

## Notes

- The Latest NDK (v23) is currently not supported by stable rust (v1.54.0) so an older NDK has to be installed (v22) and the environment variable ANDROID_NDK_HOME has to be set appropriately.