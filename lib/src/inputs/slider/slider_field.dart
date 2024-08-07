// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:flutter/material.dart";

/// Creates a slider with the given input parameters
class SliderFormField extends FormField<double> {
  SliderFormField({
    required FormFieldSetter<double> super.onSaved,
    required FormFieldValidator<double> super.validator,
    super.key,
    void Function(double value)? onChanged,
    FocusNode? focusNode,
    double super.initialValue = 0.5,
  }) : super(
          builder: (FormFieldState<double> state) => Slider(
            value: state.value ?? initialValue,
            focusNode: focusNode,
            onChanged: (double value) {
              onChanged?.call(value);

              state.didChange(value);
            },
          ),
        );
}
