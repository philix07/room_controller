import 'package:aplikasi_kontrol_kelas/blocs/schedule/schedule_bloc.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_dialog.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_scaffold.dart';
import 'package:aplikasi_kontrol_kelas/common/components/app_text_field.dart';
import 'package:aplikasi_kontrol_kelas/common/components/spaces.dart';
import 'package:aplikasi_kontrol_kelas/common/style/app_style.dart';
import 'package:aplikasi_kontrol_kelas/common/utils/app_form_validator.dart';
import 'package:aplikasi_kontrol_kelas/common/utils/app_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../../common/components/app_button.dart';
import '../../../common/style/app_colors.dart';
import '../../../models/schedule.dart';

class EditSchedulePage extends StatefulWidget {
  const EditSchedulePage({
    super.key,
    required this.schedule,
    required this.daysOfWeek,
  });

  final Schedule schedule;
  final Days daysOfWeek;

  @override
  State<EditSchedulePage> createState() => _EditSchedulePageState();
}

class _EditSchedulePageState extends State<EditSchedulePage> {
  var formState = AppFormValidator().formState;

  final descriptionController1 = TextEditingController();
  final descriptionController2 = TextEditingController();
  final formatter = AppFormatter();

  late DateTime startTime1;
  late DateTime endTime1;

  late DateTime startTime2;
  late DateTime endTime2;

  @override
  void initState() {
    super.initState();

    startTime1 = widget.schedule.schedules[0].startTime;
    endTime1 = widget.schedule.schedules[0].endTime;

    startTime2 = widget.schedule.schedules[1].startTime;
    endTime2 = widget.schedule.schedules[1].endTime;
  }

  @override
  Widget build(BuildContext context) {
    Future<DateTime?> showDatePicker(DateTime initialTime) async {
      DateTime? selectedDate;

      await showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.white.withOpacity(0.1),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                      dateOrder: DatePickerDateOrder.dmy,
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      initialDateTime: initialTime,
                      onDateTimeChanged: (DateTime newDate) {
                        selectedDate = newDate;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    child: AppButton(
                      title: 'Done',
                      color: AppColor.gray,
                      textStyle: AppTextStyle.black(),
                      onTap: () => Navigator.pop(context),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );

      return selectedDate;
    }

    return AppScaffold(
      child: Form(
        key: formState,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "${widget.daysOfWeek.value.toUpperCase()}'s Schedule Edit",
                style: AppTextStyle.black(fontSize: 18.0),
              ),
            ),
            const SpaceHeight(20.0),

            //? First Schedule Section
            Text(
              "First Schedule (Morning Class)",
              style: AppTextStyle.black(fontSize: 16.0),
            ),
            const Divider(
              color: AppColor.black,
              thickness: 1,
            ),
            Text(
              "Description",
              style: AppTextStyle.black(fontSize: 14.0),
            ),
            const SpaceHeight(5.0),
            AppTextField(
              controller: descriptionController1,
              labelText: widget.schedule.schedules[0].description,
              inputFormatter: AppFormValidator().acceptAll(),
              validator: (val) => AppFormValidator().validateNotNull(val),
            ),
            Text(
              "Schedule",
              style: AppTextStyle.black(fontSize: 14.0),
            ),
            const SpaceHeight(5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    var dateTime = await showDatePicker(startTime1);
                    if (dateTime != null) {
                      setState(() {
                        startTime1 = dateTime;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            formatter.time(startTime1),
                            style: AppTextStyle.black(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SpaceWidth(3.0),
                        const Flexible(
                          child: Icon(
                            IconlyLight.calendar,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  '-----',
                  style: AppTextStyle.black(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var dateTime = await showDatePicker(endTime1);
                    if (dateTime != null) {
                      setState(() {
                        endTime1 = dateTime;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            formatter.time(endTime1),
                            style: AppTextStyle.black(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SpaceWidth(3.0),
                        const Flexible(
                          child: Icon(
                            IconlyLight.calendar,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SpaceHeight(80.0),

            //? Second Schedule Section
            Text(
              "Second Schedule (Afternoon Class)",
              style: AppTextStyle.black(fontSize: 16.0),
            ),
            const Divider(
              color: AppColor.black,
              thickness: 1,
            ),
            Text(
              "Description",
              style: AppTextStyle.black(fontSize: 14.0),
            ),
            const SpaceHeight(5.0),
            AppTextField(
              controller: descriptionController2,
              labelText: widget.schedule.schedules[1].description,
              inputFormatter: AppFormValidator().acceptAll(),
              validator: (val) => AppFormValidator().validateNotNull(val),
            ),
            Text(
              "Schedule",
              style: AppTextStyle.black(fontSize: 14.0),
            ),
            const SpaceHeight(5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () async {
                    var dateTime = await showDatePicker(startTime2);
                    if (dateTime != null) {
                      setState(() {
                        startTime2 = dateTime;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            formatter.time(startTime2),
                            style: AppTextStyle.black(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SpaceWidth(3.0),
                        const Flexible(
                          child: Icon(
                            IconlyLight.calendar,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  '-----',
                  style: AppTextStyle.black(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    var dateTime = await showDatePicker(endTime2);
                    if (dateTime != null) {
                      setState(() {
                        endTime2 = dateTime;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            formatter.time(endTime2),
                            style: AppTextStyle.black(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SpaceWidth(3.0),
                        const Flexible(
                          child: Icon(
                            IconlyLight.calendar,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SpaceHeight(80.0),

            //? Buttons Section
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        title: "Update",
                        height: 60.0,
                        color: AppColor.lightGreen,
                        textStyle: AppTextStyle.black(fontSize: 16.0),
                        onTap: () {
                          if (formState.currentState!.validate()) {
                            Schedule schedule = Schedule(
                              schedules: <ScheduleDetail>[
                                ScheduleDetail(
                                  dayOfWeek: widget.daysOfWeek,
                                  startTime: startTime1,
                                  endTime: endTime1,
                                  description: descriptionController1.text,
                                ),
                                ScheduleDetail(
                                  dayOfWeek: widget.daysOfWeek,
                                  startTime: startTime2,
                                  endTime: endTime2,
                                  description: descriptionController2.text,
                                ),
                              ],
                            );

                            context.read<ScheduleBloc>().add(
                                  UpdateSchedule(
                                    schedule: schedule,
                                    daysOfWeek: widget.daysOfWeek,
                                  ),
                                );

                            AppDialog.show(
                              context,
                              contentColor: AppColor.blue,
                              iconPath: 'assets/icons/information.svg',
                              message: 'Schedule Updated',
                              customOnBack: true,
                              onBack: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            );
                          }
                        },
                      ),
                    ),
                    const SpaceWidth(10.0),
                    Expanded(
                      child: AppButton(
                        title: "Revert",
                        height: 60.0,
                        color: AppColor.red,
                        textStyle: AppTextStyle.black(fontSize: 16.0),
                        onTap: () {
                          //! Revert All The Information Into The Initial Value (Before Changes)
                          setState(() {
                            startTime1 = widget.schedule.schedules[0].startTime;
                            endTime1 = widget.schedule.schedules[0].endTime;
                            descriptionController1.text =
                                widget.schedule.schedules[0].description;

                            startTime2 = widget.schedule.schedules[1].startTime;
                            endTime2 = widget.schedule.schedules[1].endTime;
                            descriptionController2.text =
                                widget.schedule.schedules[1].description;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SpaceHeight(10.0),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        title: "Go Back",
                        height: 60.0,
                        color: AppColor.blue,
                        textStyle: AppTextStyle.black(fontSize: 16.0),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
