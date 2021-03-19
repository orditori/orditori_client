// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Response _$_$_ResponseFromJson(Map<String, dynamic> json) {
  return _$_Response(
    apiKey: json['apiKey'] as String,
    entries: (json['entries'] as List<dynamic>)
        .map((e) => NotebookEntry.fromJson(e as Map<String, dynamic>))
        .toList(),
    formatVersion: json['formatVersion'] as int,
    id: json['id'] as int,
    revision: json['revision'] as int,
  );
}

Map<String, dynamic> _$_$_ResponseToJson(_$_Response instance) =>
    <String, dynamic>{
      'apiKey': instance.apiKey,
      'entries': instance.entries,
      'formatVersion': instance.formatVersion,
      'id': instance.id,
      'revision': instance.revision,
    };
