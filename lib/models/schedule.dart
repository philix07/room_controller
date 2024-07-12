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
      ScheduleDetail(
        dayOfWeek: Days.monday,
        startTime: date1,
        endTime: date2,
        description: 'Inf 4Q - Arsitektur dan Organisasi Komputer',
      ),
      ScheduleDetail(
        dayOfWeek: Days.monday,
        startTime: date3,
        endTime: date4,
        description: 'Inf 4Q - Sistem Operasi',
      ),
    ];

    List<ScheduleDetail> tuesdaySchedule = [
      ScheduleDetail(
        dayOfWeek: Days.tuesday,
        startTime: date1,
        endTime: date2,
        description: 'Inf 2P - Algoritma',
      ),
      ScheduleDetail(
        dayOfWeek: Days.tuesday,
        startTime: date3,
        endTime: date4,
        description: 'Inf 2P - Kalkulus 2',
      ),
    ];

    List<ScheduleDetail> wednesdaySchedule = [
      ScheduleDetail(
        dayOfWeek: Days.wednesday,
        startTime: date1,
        endTime: date2,
        description: 'Inf 6A - Statistika',
      ),
      ScheduleDetail(
        dayOfWeek: Days.wednesday,
        startTime: date3,
        endTime: date4,
        description: 'Inf 6A - Interaksi Manusia dan Komputer',
      ),
    ];

    List<ScheduleDetail> thursdaySchedule = [
      ScheduleDetail(
        dayOfWeek: Days.thursday,
        startTime: date1,
        endTime: date2,
        description: 'SI 4Q - Kompetensi Interpersonil',
      ),
      ScheduleDetail(
        dayOfWeek: Days.thursday,
        startTime: date3,
        endTime: date4,
        description: 'SI 4Q - Kerja Praktek',
      ),
    ];

    List<ScheduleDetail> fridaySchedule = [
      ScheduleDetail(
        dayOfWeek: Days.friday,
        startTime: date1,
        endTime: date2,
        description: 'Inf 8Q - Skripsi',
      ),
      ScheduleDetail(
        dayOfWeek: Days.friday,
        startTime: date3,
        endTime: date4,
        description: 'Inf 8Q - Pend. Pancasila',
      ),
    ];

    List<ScheduleDetail> saturdaySchedule = [
      ScheduleDetail(
        dayOfWeek: Days.saturday,
        startTime: date1,
        endTime: date2,
        description: 'SI 2A - Kalkulus',
      ),
      ScheduleDetail(
        dayOfWeek: Days.saturday,
        startTime: date3,
        endTime: date4,
        description: 'SI 2A - Pemrograman Web',
      ),
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
    //! Index 0 is Monday - Index 6 is Sunday
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

  //! Map Contains Specific Schedule For A Single Day
  factory Schedule.fromMap(Map<String, dynamic> map) {
    List<dynamic> singleDaySchedule = map as List;
    List<ScheduleDetail> schedules = singleDaySchedule
        .where((element) => element != null)
        .map((e) => ScheduleDetail.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();

    return Schedule(schedules: schedules);
  }

  //! Map Contains Specific Schedule For A Single Day
  factory Schedule.fromList(List? scheduleList) {
    if (scheduleList == null) {
      return Schedule(schedules: []);
    }

    List<ScheduleDetail> schedules = scheduleList
        .where((element) => element != null)
        .map((e) => ScheduleDetail.fromMap(Map<String, dynamic>.from(e as Map)))
        .toList();

    return Schedule(schedules: schedules);
  }

  String toJson() => json.encode(toMap());

  factory Schedule.fromJson(String source) =>
      Schedule.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ScheduleDetail {
  final Days dayOfWeek;
  final DateTime startTime;
  final DateTime endTime;
  final String description;

  ScheduleDetail({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dayOfWeek': dayOfWeek.value,
      'startTime': startTime.toString(),
      'endTime': endTime.toString(),
      'description': description,
    };
  }

  factory ScheduleDetail.fromMap(Map<String, dynamic> map) {
    return ScheduleDetail(
      dayOfWeek: Days.fromString(map['dayOfWeek'] as String),
      startTime: DateTime.parse(map['startTime'] as String),
      endTime: DateTime.parse(map['endTime'] as String),
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ScheduleDetail.fromJson(String source) =>
      ScheduleDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ScheduleDetail(dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime, description: $description)';
  }
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
