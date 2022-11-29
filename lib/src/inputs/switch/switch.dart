// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

import 'package:flutter_input_library/src/inputs/switch/switch_field.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlutterFormInputSwitch extends ConsumerWidget {
  final Widget? label;
  final Function(bool?)? onSaved;
  final String Function(bool?)? validator;
  final Function(bool?)? onChanged;
  final bool? initialValue;

  const FlutterFormInputSwitch({
    Key? key,
    this.label,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.initialValue = false,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchFormField(
      onSaved: (value) => onSaved?.call(value),
      onChanged: (value) => onChanged?.call(value),
      validator: (value) => validator?.call(value),
      initialValue: initialValue ?? false,
    );
  }
}
