
import 'package:freezed_annotation/freezed_annotation.dart';

import 'definition.dart';

part 'notebookentry.freezed.dart';
part 'notebookentry.g.dart';

@freezed
abstract class NotebookEntry with _$NotebookEntry {
  factory NotebookEntry({
    required String addedDate,
    required List<Definition> definitions,
    required int id,
  }) = _NotebookEntry;
	
  factory NotebookEntry.fromJson(Map<String, dynamic> json) =>
			_$NotebookEntryFromJson(json);
}
