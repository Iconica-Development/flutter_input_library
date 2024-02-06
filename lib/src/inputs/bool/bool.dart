// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

import 'package:flutter_input_library/src/inputs/bool/bool_field.dart';

class FlutterFormInputBool extends StatelessWidget {
  final Widget? label;
  final Function(bool?)? onSaved;
  final String? Function(bool?)? validator;
  final Function(bool?)? onChanged;
  final bool? initialValue;
  final FocusNode? focusNode;
  final BoolWidgetType widgetType;
  final Widget? leftWidget;
  final Widget? rightWidget;

  const FlutterFormInputBool({
    Key? key,
    this.label,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.focusNode,
    this.initialValue = false,
    this.widgetType = BoolWidgetType.switchWidget,
    this.leftWidget,
    this.rightWidget,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BoolFormField(
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
}

enum BoolWidgetType {
  switchWidget,
  checkbox,
}
