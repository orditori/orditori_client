import 'package:flutter/services.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

import 'services.dart';

const _kBrightnessKey = 'brightness';
const _kLight = 'light';
const _kDark = 'dark';

void withBrightness(CTNode n) {
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

  brightness.provide();
  setBrightness.provide();
}
