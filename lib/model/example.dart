
import 'package:freezed_annotation/freezed_annotation.dart';

part 'example.freezed.dart';
part 'example.g.dart';

@freezed
abstract class Example with _$Example {
  factory Example({
    int? definition,
    int? id,
    required String string,
    String? translation,
  }) = _Example;
	
  factory Example.fromJson(Map<String, dynamic> json) =>
			_$ExampleFromJson(json);
}
