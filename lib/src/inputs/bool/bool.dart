// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

// ignore_for_file: avoid_positional_boolean_parameters

import "package:flutter/material.dart";

import "package:flutter_input_library/src/inputs/bool/bool_field.dart";

class FlutterFormInputBool extends StatelessWidget {
  const FlutterFormInputBool({
    super.key,
    this.label,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.initialValue = false,
    this.widgetType = BoolWidgetType.switchWidget,
    this.leftWidget,
    this.rightWidget,
  });

  final Widget? label;
  final Function(bool?)? onSaved;
  final String? Function(bool?)? validator;
  final Function(bool?)? onChanged;
  final bool? initialValue;
  final FocusNode? focusNode;
  final BoolWidgetType widgetType;
  final Widget? leftWidget;
  final Widget? rightWidget;

  @override
  Widget build(BuildContext context) => BoolFormField(
        onSaved: (value) => onSaved?.call(value),
        onChanged: (value) => onChanged?.call(value),
        validator: (value) => validator?.call(value),
        initialValue: initialValue ?? false,
        focusNode: focusNode,
        widgetType: widgetType,
        leftWidget: leftWidget,
        rightWidget: rightWidget,
      );
}

enum BoolWidgetType {
  switchWidget,
  checkbox,
}
