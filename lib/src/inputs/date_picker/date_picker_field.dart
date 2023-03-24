// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_input_library/src/inputs/date_picker/date_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DateTimeInputField extends ConsumerStatefulWidget {
  const DateTimeInputField({
    this.decoration,
    Key? key,
    required this.inputType,
    required this.autovalidateMode,
    this.label,
    this.showIcon = true,
    this.icon,
    required this.dateFormat,
    required this.firstDate,
    required this.lastDate,
    this.initialDate,
    this.initialDateTimeRange,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.validator,
    required this.timePickerEntryMode,
    required this.style,
  }) : super(
          key: key,
        );
  final TextStyle? style;
  final InputDecoration? decoration;
  final AutovalidateMode autovalidateMode;
  final FlutterFormDateTimeType inputType;
  final DateFormat dateFormat;
  final bool showIcon;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final DateTimeRange? initialDateTimeRange;
  final IconData? icon;
  final Widget? label;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final TimePickerEntryMode timePickerEntryMode;

  @override
  ConsumerState<DateTimeInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends ConsumerState<DateTimeInputField> {
  late final DateTime firstDate;
  late final DateTime lastDate;
  late final DateTime initialDate;
  late final DateTimeRange initialDateRange;
  String currentValue = '';

  @override
  void initState() {
    firstDate = widget.firstDate ??
        DateTime.now().subtract(
          const Duration(days: 1000),
        );
    lastDate = widget.lastDate ??
        DateTime.now().add(
          const Duration(days: 1000),
        );
    initialDate = widget.initialDate ?? DateTime.now();
    initialDateRange = widget.initialDateTimeRange ??
        DateTimeRange(
          start: DateTime.now(),
          end: DateTime.now().add(
            const Duration(days: 7),
          ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<String> getInputFromUser(FlutterFormDateTimeType inputType) async {
      String userInput = '';
      switch (inputType) {
        case FlutterFormDateTimeType.date:
          DateTime? unformatted = await showDatePicker(
            initialDate: initialDate,
            context: context,
            firstDate: firstDate,
            lastDate: lastDate,
          );
          userInput = unformatted != null
              ? widget.dateFormat.format(unformatted)
              : userInput;
          break;
        case FlutterFormDateTimeType.dateTime:
          await getInputFromUser(FlutterFormDateTimeType.date)
              .then((value) async {
            if (value != '') {
              String secondInput =
                  await getInputFromUser(FlutterFormDateTimeType.time);
              if (secondInput != '') {
                var date = widget.dateFormat.parse(value);
                var time = DateFormat('dd MM yyyy hh:mm')
                    .parse('01 01 1970 $secondInput');
                userInput = widget.dateFormat.format(DateTime(
                  date.year,
                  date.month,
                  date.day,
                  time.hour,
                  time.minute,
                ));
              }
            }
          });
          break;
        case FlutterFormDateTimeType.range:
          userInput = (await showDateRangePicker(
                      context: context,
                      firstDate: firstDate,
                      lastDate: lastDate,
                      initialDateRange: initialDateRange)
                  .then((value) {
            return value != null
                ? '${widget.dateFormat.format(value.start)} - ${widget.dateFormat.format(value.end)}'
                : '';
          }))
              .toString();
          break;
        case FlutterFormDateTimeType.time:
          userInput = await showTimePicker(
                  initialEntryMode: widget.timePickerEntryMode,
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: child!,
                    );
                  },
                  context: context,
                  initialTime: TimeOfDay.now())
              .then((value) => value == null
                  ? ''
                  : MaterialLocalizations.of(context)
                      .formatTimeOfDay(value, alwaysUse24HourFormat: true));
      }
      return userInput;
    }

    return TextFormField(
      style: widget.style,
      autovalidateMode: widget.autovalidateMode,
      keyboardType: TextInputType.none,
      readOnly: true,
      key: Key(currentValue.toString()),
      initialValue: currentValue.isEmpty ? widget.initialValue : currentValue,
      onSaved: (value) => widget.onSaved?.call(value),
      onTap: () async {
        String userInput = await getInputFromUser(widget.inputType);
        setState(() {
          currentValue = userInput != '' ? userInput : currentValue;
          widget.onChanged?.call(userInput != '' ? userInput : currentValue);
        });
      },
      validator: (value) => widget.validator?.call(value),
      decoration: widget.decoration ??
          InputDecoration(
            suffixIcon: widget.showIcon ? Icon(widget.icon) : null,
            focusColor: Theme.of(context).primaryColor,
            label: widget.label ?? const Text("Date"),
          ),
    );
  }
}
