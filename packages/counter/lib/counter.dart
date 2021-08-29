
import 'dart:async';

import 'package:flutter/services.dart';

import 'dart:ffi';

import 'dart:io' show Platform;

// For C/Rust
typedef increment_func = Int64 Function(Int64 val);
// For Dart
typedef Increment = int Function(int val);

DynamicLibrary load({String basePath = ''}) {
  if (Platform.isAndroid || Platform.isLinux) {
    return DynamicLibrary.open('${basePath}libcounter_ffi.so');
  } else {
    throw NotSupportedPlatform('${Platform.operatingSystem} is not supported!');
  }
}

class NotSupportedPlatform implements Exception {
  NotSupportedPlatform(String s);
}

class LibraryInitializationFailed implements Exception {
  LibraryInitializationFailed();
}

class Counter {
  static DynamicLibrary? _lib;

  static const MethodChannel _channel =
      const MethodChannel('counter');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Counter() {
    if (_lib != null) return;
    _lib = load();
  }

  int increment(int val) {
    if (_lib == null) {
      throw LibraryInitializationFailed();
    }
    final addPointer = _lib!.lookup<NativeFunction<increment_func>>(
        'increment');
    final incrementer = addPointer.asFunction<Increment>();
    return incrementer(val);
  }
}
