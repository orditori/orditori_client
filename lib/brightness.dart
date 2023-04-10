import 'package:flutter/services.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';
import 'package:flutter_context/flutter_context.dart';
import 'package:orditori/context_node.dart';

import 'package:shared_preferences/shared_preferences.dart';

typedef BrightnessSetter = void Function(Brightness brightness);
final brightnessContext = createContext<Brightness>();

class BrightnessNode extends ContextNode<Brightness> {
  @override
  final Brightness value;
  @override
  Context<Brightness> get context => brightnessContext;
  final BrightnessSetter setBrightness;

  BrightnessNode({
    required this.value,
    required this.setBrightness,
  });
}

const _kBrightnessKey = 'brightness';
const _kLight = 'light';
const _kDark = 'dark';

BrightnessNode withBrightness(SharedPreferences prefs) {
  final brightness = ref(() {
    final currentBrightness = prefs.getString(_kBrightnessKey) ?? _kLight;

    Brightness brightness;

    switch (currentBrightness) {
      case _kLight:
        brightness = Brightness.light;
        break;
      case _kDark:
        brightness = Brightness.dark;
        break;
      default:
        throw Exception('Unknown brightness: $currentBrightness');
    }

    return brightness;
  });

  final setBrightness = brightness.write;

  invoke.immediate(() {
    prefs.setString(
      _kBrightnessKey,
      brightness.value == Brightness.light ? _kLight : _kDark,
    );
  }, brightness.value);

  return BrightnessNode(
    value: brightness.value,
    setBrightness: setBrightness,
  );
}
