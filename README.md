# flutter_rust_counter_demo

A Demo Flutter app using rust on Android and Web.

## Structure

- [Rust Counter Library](native/counter): Pure Rust project. Could also be an external library.
- [Rust FFI Library](native/counter-ffi): Rust Project setup to be called from other languages.
- [Flutter project](lib): Pure Dart/Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Notes

- The Latest NDK (v23) is currently not supported by stabe rust (v1.54.0)