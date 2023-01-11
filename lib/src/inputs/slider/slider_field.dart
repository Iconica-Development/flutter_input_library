// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

/// Creates a slider with the given input parameters
class SliderFormField extends FormField<double> {
  SliderFormField({
    Key? key,
    required FormFieldSetter<double> onSaved,
    required FormFieldValidator<double> validator,
    void Function(double value)? onChanged,
    FocusNode? focusNode,
    double initialValue = 0.5,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            focusNode: focusNode,
            initialValue: initialValue,
            builder: (FormFieldState<double> state) {
              return Slider(
                value: state.value ?? initialValue,
                focusNode: focusNode,
                onChanged: (double value) {
                  onChanged?.call(value);

                  state.didChange(value);
                },
              );
            });
}
