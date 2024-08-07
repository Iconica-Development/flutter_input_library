// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "package:flutter/material.dart";
import "package:flutter_input_library/src/inputs/slider/slider_field.dart";

class FlutterFormInputSlider extends StatelessWidget {
  const FlutterFormInputSlider({
    super.key,
    this.minValue = 0,
    this.maxValue = 100,
    this.onSaved,
    this.onChanged,
    this.initialValue,
    this.validator,
    this.focusNode,
  }) : assert(minValue < maxValue, "minValue must be less than maxValue");

  final int minValue;
  final int maxValue;
  final Function(double?)? onSaved;
  final String? Function(double?)? validator;
  final double? initialValue;
  final Function(double?)? onChanged;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) => SliderFormField(
        onSaved: (value) => onSaved?.call(value),
        validator: (value) => validator?.call(value),
        onChanged: (value) => onChanged?.call(value),
        initialValue: initialValue ?? 0.5,
        focusNode: focusNode,
      );
}
