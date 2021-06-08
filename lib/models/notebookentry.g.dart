// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notebookentry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotebookEntry _$_$_NotebookEntryFromJson(Map<String, dynamic> json) {
  return _$_NotebookEntry(
    addedDate: json['addedDate'] as String,
    definitions: (json['definitions'] as List<dynamic>)
        .map((e) => Definition.fromJson(e as Map<String, dynamic>))
        .toList(),
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$_$_NotebookEntryToJson(_$_NotebookEntry instance) =>
    <String, dynamic>{
      'addedDate': instance.addedDate,
      'definitions': instance.definitions,
      'id': instance.id,
    };
