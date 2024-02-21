// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:flutter_input_library/flutter_input_library.dart';

class BoolFormField extends FormField<bool> {
  BoolFormField({
    required FormFieldSetter<bool> super.onSaved,
    required FormFieldValidator<bool> super.validator,
    super.key,
    FocusNode? focusNode,
    bool super.initialValue = false,
    void Function(bool? value)? onChanged,
    BoolWidgetType widgetType = BoolWidgetType.switchWidget,
    Widget? leftWidget,
    Widget? rightWidget,
  }) : super(
          builder: (FormFieldState<bool> state) => BoolWidget(
            initialValue: initialValue,
            state: state,
            focusNode: focusNode,
            onChanged: onChanged,
            widgetType: widgetType,
            errorText: state.errorText,
            leftWidget: leftWidget,
            rightWidget: rightWidget,
          ),
        );
}

class BoolWidget extends StatefulWidget {
  const BoolWidget({
    required this.state,
    this.initialValue = false,
    this.onChanged,
    this.focusNode,
    this.widgetType = BoolWidgetType.switchWidget,
    this.errorText,
    this.leftWidget,
    this.rightWidget,
    super.key,
  });

  final bool initialValue;
  final FormFieldState<bool> state;
  final FocusNode? focusNode;
  final void Function(bool? value)? onChanged;
  final BoolWidgetType widgetType;
  final String? errorText;
  final Widget? leftWidget;
  final Widget? rightWidget;

  @override
  State<BoolWidget> createState() => _BoolWidgetState();
}

class _BoolWidgetState extends State<BoolWidget> {
  late Widget child;
  late bool value = widget.initialValue;

  void onChanged(bool value) {
    widget.onChanged?.call(value);

    widget.state.didChange(value);

    setState(() {
      this.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    late Widget child;

    switch (widget.widgetType) {
      case BoolWidgetType.switchWidget:
        child = Switch(
          value: value,
          focusNode: widget.focusNode,
          onChanged: onChanged,
        );

      case BoolWidgetType.checkbox:
        child = Checkbox(
          value: value,
          focusNode: widget.focusNode,
          onChanged: (bool? value) {
            if (value != null) {
              onChanged(value);
            }
          },
        );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.leftWidget ?? const SizedBox.shrink(),
            child,
            widget.rightWidget ?? const SizedBox.shrink(),
          ],
        ),
        if (widget.errorText != null) ...[
          Text(
            widget.errorText!,
            style: theme.inputDecorationTheme.errorStyle,
          ),
        ],
      ],
    );
  }
}
