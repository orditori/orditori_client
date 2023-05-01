import 'package:flutter/services.dart';
import 'package:flutter_compute_tree/flutter_compute_tree.dart';

import 'services.dart';

const _key = 'brightness';

final _brightnessMap = {
  Brightness.light.name: Brightness.light,
  Brightness.dark.name: Brightness.dark,
};

extension BrightnessCodec on Brightness {
  String encode() {
    return name;
  }

  static Brightness decode(String value) {
    final b = _brightnessMap[value];

    if (b == null) {
      throw Exception('Unknown brightness value: $value');
    }

    return b;
  }
}

void withBrightness(CTNode n) {
  final brightness = n.ref(() {
    Brightness brightness;

    final encodedBrightness = prefs.getString(_key);

    if (encodedBrightness == null) {
      brightness = Brightness.light;
    } else {
      try {
        brightness = BrightnessCodec.decode(encodedBrightness);
      } on Exception {
        brightness = Brightness.light;
      }
    }

    return brightness;
  });

  final setBrightness = brightness.action.setValue();
  final toggleBrightness = brightness.action((value) {
    if (value == Brightness.light) {
      return Brightness.dark;
    } else {
      return Brightness.light;
    }
  });

  final setBrightnessFromBool = brightness.reducer((value, bool isDarkMode) {
    if (isDarkMode) {
      return Brightness.dark;
    } else {
      return Brightness.light;
    }
  });

  n.invoke(
    () => prefs.setString(_key, brightness.value.encode()),
    brightness.value,
  );

  brightness.provide();
  setBrightness.provide();
  toggleBrightness.provide();
  setBrightnessFromBool.provide();
}
