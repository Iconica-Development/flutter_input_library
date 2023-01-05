// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_input_library/src/inputs/date_picker/date_picker_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

enum FlutterFormDateTimeType {
  date,
  time,
  dateTime,
  range,
}

class FlutterFormInputDateTime extends ConsumerWidget {
  const FlutterFormInputDateTime({
    this.decoration,
    Key? key,
    this.label,
    this.showIcon = true,
    required this.inputType,
    required this.dateFormat,
    this.firstDate,
    this.lastDate,
    this.initialDate,
    this.initialDateTimeRange,
    this.icon = Icons.calendar_today,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.validator,
  }) : super(
          key: key,
        );
  final InputDecoration? decoration;
  final Widget? label;
  final bool showIcon;
  final FlutterFormDateTimeType inputType;
  final DateFormat dateFormat;
  final DateTime? initialDate;
  final DateTimeRange? initialDateTimeRange;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final IconData icon;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DateTimeInputField(
      decoration: decoration,
      label: label,
      icon: icon,
      firstDate: firstDate,
      lastDate: lastDate,
      inputType: inputType,
      dateFormat: dateFormat,
      initialDate: initialDate,
      initialDateTimeRange: initialDateTimeRange,
      initialValue: initialValue,
      onChanged: (value) => onChanged?.call(value),
      onSaved: (value) => onSaved?.call(value),
      showIcon: showIcon,
    );
  }
}
