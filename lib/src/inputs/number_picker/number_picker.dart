// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

import 'number_picker_field.dart';

class FlutterFormInputNumberPicker extends StatelessWidget {
  const FlutterFormInputNumberPicker({
    Key? key,
    Widget? label,
    this.minValue = 0,
    this.maxValue = 100,
    this.onSaved,
    this.onChanged,
    this.initialValue,
    this.validator,
  })  : assert(minValue < maxValue),
        super(
          key: key,
        );

  final int minValue;
  final int maxValue;
  final Function(int?)? onSaved;
  final String? Function(int?)? validator;
  final int? initialValue;
  final Function(int?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return NumberPickerFormField(
      minValue: minValue,
      maxValue: maxValue,
      onSaved: (value) => onSaved?.call(value),
      validator: (value) => validator?.call(value),
      onChanged: (value) => onChanged?.call(value),
      initialValue: initialValue ?? 0,
    );
  }
}

class NumberPickerFormField extends FormField<int> {
  NumberPickerFormField({
    Key? key,
    required FormFieldSetter<int> onSaved,
    required FormFieldValidator<int> validator,
    void Function(int value)? onChanged,
    int initialValue = 0,
    bool autovalidate = false,
    int minValue = 0,
    int maxValue = 100,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<int> state) {
              return NumberPicker(
                minValue: minValue,
                maxValue: maxValue,
                value: initialValue,
                onChanged: (int value) {
                  onChanged?.call(value);

                  state.didChange(value);
                },
                itemHeight: 35,
                itemCount: 5,
              );
            });
}
