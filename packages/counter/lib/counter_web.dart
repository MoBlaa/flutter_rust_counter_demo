import 'dart:async';
// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show document, ScriptElement;
import 'dart:js' as js;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';


/// A web implementation of the Counter plugin.
class CounterWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'counter',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = CounterWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  CounterWeb() {
    html.document.body!.append(html.ScriptElement()
      ..src = "assets/packages/counter/pkg/counter_wasm.js"
      ..type = "module"
      ..defer = true);
    html.document.body!.append(html.ScriptElement()
      ..src = "assets/packages/counter/pkg/init_module.js"
      ..type = "module"
      ..defer = true);
  }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'increment':
        Object? args = call.arguments ?? "0";
        int val = int.parse(args.toString());
        return increment(val);
      case 'count':
        return count();
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: 'counter for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  Future<int> increment(int val) {
    final jsValue = js.context.callMethod('increment', [val]);
    final value = int.parse(jsValue.toString());
    return Future.value(value);
  }

  Future<int> count() {
    final jsValue = js.context.callMethod('count');
    final value = int.parse(jsValue.toString());
    return Future.value(value);
  }
}
