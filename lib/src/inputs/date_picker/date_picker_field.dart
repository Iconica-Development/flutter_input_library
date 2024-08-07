// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_input_library/src/inputs/date_picker/date_picker.dart";
import "package:intl/intl.dart";

class DateTimeInputField extends StatefulWidget {
  const DateTimeInputField({
    required this.inputType,
    required this.autovalidateMode,
    required this.dateFormat,
    required this.firstDate,
    required this.lastDate,
    required this.timePickerEntryMode,
    required this.style,
    this.decoration,
    super.key,
    this.label,
    this.showIcon = true,
    this.icon,
    this.initialDate,
    this.initialTime,
    this.initialDateTimeRange,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.enabled = true,
    this.onTapEnabled = true,
    this.selectableDayPredicate,
  });
  final TextStyle? style;
  final InputDecoration? decoration;
  final AutovalidateMode autovalidateMode;
  final FlutterFormDateTimeType inputType;
  final DateFormat dateFormat;
  final bool showIcon;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialDate;
  final TimeOfDay? initialTime;
  final DateTimeRange? initialDateTimeRange;
  final IconData? icon;
  final Widget? label;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final TimePickerEntryMode timePickerEntryMode;
  final bool enabled;
  final bool onTapEnabled;
  final bool Function(DateTime)? selectableDayPredicate;

  @override
  State<DateTimeInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateTimeInputField> {
  late final DateTime firstDate;
  late final DateTime lastDate;
  late final DateTime initialDate;
  late final DateTimeRange initialDateRange;
  late final TimeOfDay? initialTime;
  String currentValue = "";

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

  TimeOfDay get initialTimeOfDay => widget.initialTime ?? TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    Future<String> getInputFromUser(
      FlutterFormDateTimeType inputType, [
      DateFormat? dateFormat,
    ]) async {
      var userInput = "";
      switch (inputType) {
        case FlutterFormDateTimeType.date:
          if (context.mounted) {
            var unformatted = await showDatePicker(
              initialDate: initialDate,
              context: context,
              firstDate: firstDate,
              lastDate: lastDate,
              selectableDayPredicate: widget.selectableDayPredicate,
            );
            userInput = unformatted != null
                ? widget.dateFormat.format(unformatted)
                : userInput;
          }

        case FlutterFormDateTimeType.dateTime:
          await getInputFromUser(FlutterFormDateTimeType.date)
              .then((value) async {
            if (value != "") {
              var secondInput =
                  await getInputFromUser(FlutterFormDateTimeType.time);
              if (secondInput != "") {
                var date = widget.dateFormat.parse(value);
                var time = dateFormat != null
                    ? dateFormat.parse("01 01 1970 $secondInput")
                    : DateFormat("dd MM yyyy HH:mm")
                        .parse("01 01 1970 $secondInput");
                userInput = widget.dateFormat.format(
                  DateTime(
                    date.year,
                    date.month,
                    date.day,
                    time.hour,
                    time.minute,
                  ),
                );
              }
            }
          });

        case FlutterFormDateTimeType.range:
          if (context.mounted) {
            userInput = await showDateRangePicker(
              context: context,
              firstDate: firstDate,
              lastDate: lastDate,
              initialDateRange: initialDateRange,
            ).then(
              (value) => value != null
                  ? "${widget.dateFormat.format(value.start)} - "
                      "${widget.dateFormat.format(value.end)}"
                  : "",
            );
          }

        case FlutterFormDateTimeType.time:
          var locale = MaterialLocalizations.of(context);
          if (context.mounted) {
            userInput = await showTimePicker(
              initialEntryMode: widget.timePickerEntryMode,
              builder: (BuildContext context, Widget? child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child!,
              ),
              context: context,
              initialTime: initialTimeOfDay,
            ).then(
              (value) => value == null
                  ? ""
                  : locale.formatTimeOfDay(value, alwaysUse24HourFormat: true),
            );
          }
      }
      return userInput;
    }

    return TextFormField(
      style: widget.style,
      autovalidateMode: widget.autovalidateMode,
      keyboardType: TextInputType.none,
      readOnly: true,
      key: UniqueKey(),
      initialValue: currentValue.isEmpty ? widget.initialValue : currentValue,
      onSaved: (value) => widget.onSaved?.call(value),
      onTap: widget.onTapEnabled
          ? () async {
              var userInput = await getInputFromUser(
                widget.inputType,
                DateFormat("dd MM yyyy HH:mm"),
              );
              setState(() {
                currentValue = userInput != "" ? userInput : currentValue;
                widget.onChanged
                    ?.call(userInput != "" ? userInput : currentValue);
              });
            }
          : null,
      validator: (value) => widget.validator?.call(value),
      decoration: widget.decoration ??
          InputDecoration(
            suffixIcon: widget.showIcon ? Icon(widget.icon) : null,
            focusColor: Theme.of(context).primaryColor,
            label: widget.label ?? const Text("Date"),
          ),
      enabled: widget.enabled,
    );
  }
}
