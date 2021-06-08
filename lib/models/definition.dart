import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orditori/models/language.dart';

import 'example.dart';

part 'definition.freezed.dart';
part 'definition.g.dart';

@freezed
class Definition with _$Definition {
  factory Definition({
    int? id,
    required String definition,
    required List<Example> examples,
    required Language language,
    required String word,
  }) = _Definition;

  factory Definition.fromJson(Map<String, dynamic> json) =>
      _$DefinitionFromJson(json);
}
