// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:flutter/material.dart";
import "package:flutter_input_library/src/inputs/date_picker/date_picker_field.dart";
import "package:intl/intl.dart";

enum FlutterFormDateTimeType {
  date,
  time,
  dateTime,
  range,
}

class FlutterFormInputDateTime extends StatelessWidget {
  const FlutterFormInputDateTime({
    required this.inputType,
    required this.dateFormat,
    this.decoration,
    this.style,
    super.key,
    this.label,
    this.showIcon = true,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.initialDateTimeRange,
    this.initialTime,
    this.icon = Icons.calendar_today,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.timePickerEntryMode = TimePickerEntryMode.dial,
    this.enabled = true,
    this.onTapEnabled = true,
    this.selectableTimePredicate,
  });
  final TextStyle? style;
  final InputDecoration? decoration;
  final Widget? label;
  final bool showIcon;
  final FlutterFormDateTimeType inputType;
  final DateFormat dateFormat;
  final DateTime? initialDate;
  final DateTimeRange? initialDateTimeRange;
  final TimeOfDay? initialTime;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final IconData icon;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final AutovalidateMode autovalidateMode;
  final TimePickerEntryMode timePickerEntryMode;
  final bool enabled;
  final bool onTapEnabled;
  final bool Function(DateTime)? selectableTimePredicate;

  @override
  Widget build(BuildContext context) => DateTimeInputField(
        style: style,
        decoration: decoration,
        autovalidateMode: autovalidateMode,
        validator: validator,
        label: label,
        icon: icon,
        firstDate: firstDate,
        lastDate: lastDate,
        inputType: inputType,
        dateFormat: dateFormat,
        initialDate: initialDate,
        initialDateTimeRange: initialDateTimeRange,
        initialTime: initialTime,
        initialValue: initialValue,
        onChanged: (value) => onChanged?.call(value),
        onSaved: (value) => onSaved?.call(value),
        showIcon: showIcon,
        timePickerEntryMode: timePickerEntryMode,
        enabled: enabled,
        onTapEnabled: onTapEnabled,
        selectableDayPredicate: selectableTimePredicate,
      );
}
