// SPDX-FileCopyrightText: 2022 Iconica
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
    Key? key,
  }) : super(key: key);

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
  Widget build(BuildContext context) {
    return ScrollPickerFormField<T>(
      values: values,
      initialIndex: initialIndex,
      decoration: decoration,
      childToString: childToString,
      onSaved: (value) => onSaved?.call(value),
      onChanged: (value) => onChanged?.call(value),
    );
  }
}

class ScrollPickerFormField<T> extends FormField<T> {
  ScrollPickerFormField({
    required List<T> values,
    int? initialIndex,
    required ScrollPickerDecoration decoration,
    required FormFieldSetter<T> onSaved,
    void Function(T value)? onChanged,
    required String Function(T) childToString,
    Key? key,
  }) : super(
          key: key,
          onSaved: onSaved,
          initialValue: values[initialIndex ?? (values.length / 2).floor()],
          builder: (FormFieldState<T> state) {
            return ScrollPicker(
              list: values.map((e) => childToString(e)).toList(),
              decoration: decoration,
              initialIndex: initialIndex,
              onChanged: (int index) {
                onChanged?.call(values[index]);

                state.didChange(values[index]);
              },
            );
          },
        );
}
