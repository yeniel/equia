// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chore_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChoreResponse _$ChoreResponseFromJson(Map<String, dynamic> json) =>
    ChoreResponse(
      id: json['id'] as String,
      type: $enumDecode(_$ChoreTypeResponseEnumMap, json['type']),
      name: json['name'] as String,
      comments: json['comments'] as String,
      duration: Duration(microseconds: json['duration'] as int),
      assignedTo: json['assignedTo'] as String,
      createdBy: json['createdBy'] as String,
      weekdays:
          (json['weekdays'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$ChoreResponseToJson(ChoreResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ChoreTypeResponseEnumMap[instance.type]!,
      'name': instance.name,
      'comments': instance.comments,
      'duration': instance.duration.inMicroseconds,
      'assignedTo': instance.assignedTo,
      'createdBy': instance.createdBy,
      'weekdays': instance.weekdays,
    };

const _$ChoreTypeResponseEnumMap = {
  ChoreTypeResponse.weekly: 'weekly',
  ChoreTypeResponse.repeatable: 'repeatable',
  ChoreTypeResponse.oneTime: 'one_time',
  ChoreTypeResponse.countable: 'Countable',
};
