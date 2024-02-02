// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';

import 'package:flutter_input_library/src/inputs/switch/switch_field.dart';

class FlutterFormInputSwitch extends StatelessWidget {
  const FlutterFormInputSwitch({
    super.key,
    this.label,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.initialValue = false,
  });
  final Widget? label;
  final Function(bool?)? onSaved;
  final String? Function(bool?)? validator;
  final Function(bool?)? onChanged;
  final bool? initialValue;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) => SwitchFormField(
        onSaved: (value) => onSaved?.call(value),
        onChanged: (value) => onChanged?.call(value),
        validator: (value) => validator?.call(value),
        initialValue: initialValue ?? false,
        focusNode: focusNode,
      );
}
