
import 'package:freezed_annotation/freezed_annotation.dart';

part 'language.freezed.dart';
part 'language.g.dart';

@freezed
abstract class Language with _$Language {
  factory Language({
    required String name,
    required String code,
  }) = _Language;
	
  factory Language.fromJson(Map<String, dynamic> json) =>
			_$LanguageFromJson(json);
}
