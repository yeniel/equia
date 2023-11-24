import 'package:json_annotation/json_annotation.dart';

enum ChoreTypeResponse {
  @JsonValue('weekly')
  weekly,
  @JsonValue('repeatable')
  repeatable,
  @JsonValue('one_time')
  oneTime,
  @JsonValue('Countable')
  countable,
}
