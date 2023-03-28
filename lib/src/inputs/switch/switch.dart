// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

import 'package:flutter_input_library/src/inputs/switch/switch_field.dart';

class FlutterFormInputSwitch extends StatelessWidget {
  final Widget? label;
  final Function(bool?)? onSaved;
  final String? Function(bool?)? validator;
  final Function(bool?)? onChanged;
  final bool? initialValue;
  final FocusNode? focusNode;

  const FlutterFormInputSwitch({
    Key? key,
    this.label,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.initialValue = false,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SwitchFormField(
      onSaved: (value) => onSaved?.call(value),
      onChanged: (value) => onChanged?.call(value),
      validator: (value) => validator?.call(value),
      initialValue: initialValue ?? false,
      focusNode: focusNode,
    );
  }
}
