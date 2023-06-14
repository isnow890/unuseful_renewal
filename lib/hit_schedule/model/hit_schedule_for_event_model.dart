import 'package:json_annotation/json_annotation.dart';

part 'hit_schedule_for_event_model.g.dart';

abstract class HitScheduleForEventModelBase {}

class HitScheduleForEventModelLoading extends HitScheduleForEventModelBase {}

class HitScheduleForEventModelError extends HitScheduleForEventModelBase {
  final String message;

  HitScheduleForEventModelError({required this.message});
}

@JsonSerializable()
class HitScheduleForEventModel extends HitScheduleForEventModelBase {
  final List<HitScheduleForEventListModel>? data;

  HitScheduleForEventModel({
    required this.data,
  });

  factory HitScheduleForEventModel.fromJson(Map<String, dynamic> json) =>
      _$HitScheduleForEventModelFromJson(json);
}


@JsonSerializable()
class HitScheduleForEventListModel extends HitScheduleForEventModelBase {
  final DateTime? scheduleDate;
  final int count;

  HitScheduleForEventListModel( {
    required this.scheduleDate,
    required this.count,
  });

  factory HitScheduleForEventListModel.fromJson(Map<String, dynamic> json) =>
      _$HitScheduleForEventListModelFromJson(json);
}
