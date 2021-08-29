
import 'dart:io' show Platform;
import 'dart:ffi';

import 'package:counter/shared.dart';

// For C/Rust
typedef increment_func = Int32 Function(Int32 val);
// For Dart
typedef Increment = int Function(int val);

// For C/Rust
typedef count_func = Int32 Function();
// For Dart
typedef Count = int Function();

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

class Counter implements CounterBase {
  static DynamicLibrary? _lib;

  Counter() {
    if (_lib != null) return;
    _lib = load();
  }

  @override
  Future<int> increment(int val) {
    if (_lib == null) {
      throw LibraryInitializationFailed();
    }
    final addPointer =
    _lib!.lookup<NativeFunction<increment_func>>('increment');
    final incrementer = addPointer.asFunction<Increment>();
    return Future.value(incrementer(val));
  }

  @override
  Future<int> count() {
    if (_lib == null) {
      throw LibraryInitializationFailed();
    }
    final addPointer =
    _lib!.lookup<NativeFunction<count_func>>('count');
    final counter = addPointer.asFunction<Count>();
    return Future.value(counter());
  }
}