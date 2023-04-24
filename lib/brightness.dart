import 'package:flutter/services.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

import 'services.dart';

class BrightnessNode {
  final Ref<Brightness> ref;
  final Trigger<Brightness> setBrightness;

  BrightnessNode({
    required this.ref,
    required this.setBrightness,
  });
}

const _kBrightnessKey = 'brightness';
const _kLight = 'light';
const _kDark = 'dark';

BrightnessNode withBrightness(CTNode n) {
  final brightness = n.ref(() {
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

  final setBrightness = brightness.action((value, Brightness arg) => arg);

  n.invoke(() {
    prefs.setString(
      _kBrightnessKey,
      brightness.value == Brightness.light ? _kLight : _kDark,
    );
  }, brightness.value);

  return BrightnessNode(
    ref: brightness,
    setBrightness: setBrightness,
  );
}
