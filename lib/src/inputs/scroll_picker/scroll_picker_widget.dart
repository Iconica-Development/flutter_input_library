// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_input_library/src/inputs/scroll_picker/scroll_picker_decoration.dart';
import 'package:flutter_input_library/src/inputs/scroll_picker/scroll_picker_field.dart';

class FlutterFormInputScrollPicker<T> extends StatelessWidget {
  const FlutterFormInputScrollPicker({
    required this.values,
    required this.decoration,
    required this.childToString,
    this.onSaved,
    this.onChanged,
    this.initialIndex = 0,
    super.key,
  });

  /// Values that will be shown in the scroll picker.
  final List<T> values;

  /// Initial index to set the scroll picker too.
  final int? initialIndex;

  /// Function called when the save function is called on the parent form.
  final Function(T?)? onSaved;

  /// Function called when the value is changed by the user.
  final Function(T?)? onChanged;

  /// Converts the given value to a String.
  final String Function(T?) childToString;

  /// Decoration for the scroll picker.
  final ScrollPickerDecoration decoration;

  @override
  Widget build(BuildContext context) => ScrollPickerFormField<T>(
        values: values,
        initialIndex: initialIndex,
        decoration: decoration,
        childToString: childToString,
        onSaved: (value) => onSaved?.call(value),
        onChanged: (value) => onChanged?.call(value),
      );
}

class ScrollPickerFormField<T> extends FormField<T> {
  ScrollPickerFormField({
    required List<T> values,
    required ScrollPickerDecoration decoration,
    required FormFieldSetter<T> super.onSaved,
    required String Function(T) childToString,
    int? initialIndex,
    void Function(T value)? onChanged,
    super.key,
  }) : super(
          initialValue: values[initialIndex ?? (values.length / 2).floor()],
          builder: (FormFieldState<T> state) => ScrollPicker(
            list: values.map((e) => childToString(e)).toList(),
            decoration: decoration,
            initialIndex: initialIndex,
            onChanged: (int index) {
              onChanged?.call(values[index]);

              state.didChange(values[index]);
            },
          ),
        );
}
