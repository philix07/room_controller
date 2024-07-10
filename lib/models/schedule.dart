// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

//! One Schedule For One Day
//! One Day Can Have Several Schedules
class Schedule {
  final List<ScheduleDetail> schedules;

  Schedule({required this.schedules});

  static List<Schedule> getDummyListOfSchedule() {
    var date1 = DateTime(2024, 10, 3, 7, 0, 0);
    var date2 = DateTime(2024, 10, 3, 12, 0, 0);

    var date3 = DateTime(2024, 10, 3, 16, 30, 0);
    var date4 = DateTime(2024, 10, 3, 20, 45, 0);

    List<ScheduleDetail> mondaySchedule = [
      ScheduleDetail(dayOfWeek: Days.monday, startTime: date1, endTime: date2),
      ScheduleDetail(dayOfWeek: Days.monday, startTime: date3, endTime: date4),
    ];

    List<ScheduleDetail> tuesdaySchedule = [
      ScheduleDetail(dayOfWeek: Days.tuesday, startTime: date1, endTime: date2),
      ScheduleDetail(dayOfWeek: Days.tuesday, startTime: date3, endTime: date4),
    ];

    List<ScheduleDetail> wednesdaySchedule = [
      ScheduleDetail(dayOfWeek: Days.wednesday, startTime: date1, endTime: date2),
      ScheduleDetail(dayOfWeek: Days.wednesday, startTime: date3, endTime: date4),
    ];

    List<ScheduleDetail> thursdaySchedule = [
      ScheduleDetail(dayOfWeek: Days.thursday, startTime: date1, endTime: date2),
      ScheduleDetail(dayOfWeek: Days.thursday, startTime: date3, endTime: date4),
    ];

    List<ScheduleDetail> fridaySchedule = [
      ScheduleDetail(dayOfWeek: Days.friday, startTime: date1, endTime: date2),
      ScheduleDetail(dayOfWeek: Days.friday, startTime: date3, endTime: date4),
    ];

    List<ScheduleDetail> saturdaySchedule = [
      ScheduleDetail(dayOfWeek: Days.saturday, startTime: date1, endTime: date2),
      ScheduleDetail(dayOfWeek: Days.saturday, startTime: date3, endTime: date4),
    ];

    List<Schedule> dummySchedule = [
      Schedule(schedules: mondaySchedule),
      Schedule(schedules: tuesdaySchedule),
      Schedule(schedules: wednesdaySchedule),
      Schedule(schedules: thursdaySchedule),
      Schedule(schedules: fridaySchedule),
      Schedule(schedules: saturdaySchedule),
    ];

    return dummySchedule;
  }

  Map<String, dynamic> toMap() {
    //! Groups Schedule By Days Of Week
    Map<String, dynamic> daysOfWeekMap = {
      'monday': [],
      'tuesday': [],
      'wednesday': [],
      'thursday': [],
      'friday': [],
      'saturday': [],
      'sunday': [],
    };

    for (var schedule in schedules) {
      if (daysOfWeekMap.containsKey(schedule.dayOfWeek.value)) {
        daysOfWeekMap[schedule.dayOfWeek.value]?.add(schedule.toMap());
      }
    }

    return daysOfWeekMap;
  }

  factory Schedule.fromMap(Map<String, dynamic> map) {
    return Schedule(
      schedules: List<ScheduleDetail>.from(
        (map['schedules'] as List<int>).map<ScheduleDetail>(
          (x) => ScheduleDetail.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Schedule.fromJson(String source) =>
      Schedule.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ScheduleDetail {
  final Days dayOfWeek;
  final DateTime startTime;
  final DateTime endTime;

  ScheduleDetail({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dayOfWeek': dayOfWeek.value,
      'startTime': startTime.toString(),
      'endTime': endTime.toString(),
    };
  }

  factory ScheduleDetail.fromMap(Map<String, dynamic> map) {
    return ScheduleDetail(
      dayOfWeek: Days.fromString(map['dayOfWeek'] as String),
      startTime: map['startTime'] as DateTime,
      endTime: map['endTime'] as DateTime,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleDetail.fromJson(String source) =>
      ScheduleDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum Days {
  monday('monday'),
  tuesday('tuesday'),
  wednesday('wednesday'),
  thursday('thursday'),
  friday('friday'),
  saturday('saturday'),
  sunday('sunday');

  final String value;
  const Days(this.value);

  static Days fromString(String day) {
    switch (day) {
      case 'monday':
        return Days.monday;
      case 'tuesday':
        return Days.tuesday;
      case 'wednesday':
        return Days.wednesday;
      case 'thursday':
        return Days.thursday;
      case 'friday':
        return Days.friday;
      case 'saturday':
        return Days.saturday;
      default:
        return Days.sunday;
    }
  }
}
