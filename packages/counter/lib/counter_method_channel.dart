import 'package:counter/shared.dart';
import 'package:flutter/services.dart';

class Counter implements CounterBase {
  static const MethodChannel _channel = const MethodChannel('counter');

  Future<int> increment(int val) async {
    final int result = await _channel.invokeMethod('increment', val);
    return result;
  }

  Future<int> count() async {
    final int result = await _channel.invokeMethod('count');
    return result;
  }
}