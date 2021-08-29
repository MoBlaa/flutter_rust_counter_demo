import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:ffi';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

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

  static const MethodChannel _channel = const MethodChannel('counter');

  Counter() {
    if (_lib != null) return;
    _lib = load();
  }

  Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  Future<int> increment(int val) async {
    if (kIsWeb) {
      final int result = await _channel.invokeMethod('increment');
      return result;
    } else {
      return await _incrementNative(val);
    }
  }

  Future<int> _incrementNative(int val) {
    if (_lib == null) {
      throw LibraryInitializationFailed();
    }
    final addPointer =
        _lib!.lookup<NativeFunction<increment_func>>('increment');
    final incrementer = addPointer.asFunction<Increment>();
    return Future.value(incrementer(val));
  }
}
