// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:flutter/material.dart";

import "package:flutter_input_library/src/inputs/number_picker/number_picker_field.dart";

class FlutterFormInputNumberPicker extends StatelessWidget {
  const FlutterFormInputNumberPicker({
    super.key,
    this.minValue = 0,
    this.maxValue = 100,
    this.onSaved,
    this.onChanged,
    this.initialValue,
    this.validator,
    this.axis = Axis.vertical,
  }) : assert(minValue < maxValue, "minValue must be less than maxValue");

  final int minValue;
  final int maxValue;
  final Function(int?)? onSaved;
  final String? Function(int?)? validator;
  final int? initialValue;
  final Function(int?)? onChanged;
  final Axis axis;

  @override
  Widget build(BuildContext context) => NumberPickerFormField(
        minValue: minValue,
        maxValue: maxValue,
        onSaved: (value) => onSaved?.call(value),
        validator: (value) => validator?.call(value),
        onChanged: (value) => onChanged?.call(value),
        initialValue: initialValue ?? 0,
        axis: axis,
      );
}

class NumberPickerFormField extends FormField<int> {
  NumberPickerFormField({
    required FormFieldSetter<int> super.onSaved,
    required FormFieldValidator<int> super.validator,
    super.key,
    void Function(int value)? onChanged,
    int super.initialValue = 0,
    int minValue = 0,
    int maxValue = 100,
    Axis axis = Axis.vertical,
  }) : super(
          builder: (FormFieldState<int> state) => NumberPicker(
            minValue: minValue,
            maxValue: maxValue,
            value: initialValue,
            onChanged: (int value) {
              onChanged?.call(value);

              state.didChange(value);
            },
            itemHeight: 35,
            itemWidth: 35,
            itemCount: 5,
            axis: axis,
          ),
        );
}
