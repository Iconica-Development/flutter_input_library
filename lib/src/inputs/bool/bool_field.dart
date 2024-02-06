// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_input_library/flutter_input_library.dart';

class BoolFormField extends FormField<bool> {
  BoolFormField({
    Key? key,
    required FormFieldSetter<bool> onSaved,
    required FormFieldValidator<bool> validator,
    FocusNode? focusNode,
    bool initialValue = false,
    bool autovalidate = false,
    void Function(bool? value)? onChanged,
    BoolWidgetType widgetType = BoolWidgetType.switchWidget,
    Widget? leftWidget,
    Widget? rightWidget,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return BoolWidget(
                initialValue: initialValue,
                state: state,
                focusNode: focusNode,
                onChanged: onChanged,
                widgetType: widgetType,
                errorText: state.errorText,
                leftWidget: leftWidget,
                rightWidget: rightWidget,
              );
            });
}

class BoolWidget extends StatefulWidget {
  const BoolWidget({
    this.initialValue = false,
    required this.state,
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
        break;

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
        break;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
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
