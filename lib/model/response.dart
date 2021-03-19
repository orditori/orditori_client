
import 'package:freezed_annotation/freezed_annotation.dart';

import 'notebookentry.dart';

part 'response.freezed.dart';
part 'response.g.dart';

@freezed
abstract class Response with _$Response {
  factory Response({
    required String apiKey,
    required List<NotebookEntry> entries,
    required int formatVersion,
    required int id,
    required int revision,
  }) = _Response;
	
  factory Response.fromJson(Map<String, dynamic> json) =>
			_$ResponseFromJson(json);
}
