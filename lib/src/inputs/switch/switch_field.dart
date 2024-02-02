// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

class SwitchFormField extends FormField<bool> {
  SwitchFormField({
    required FormFieldSetter<bool> super.onSaved,
    required FormFieldValidator<bool> super.validator,
    super.key,
    FocusNode? focusNode,
    bool super.initialValue = false,
    // ignore: avoid_positional_boolean_parameters
    void Function(bool? value)? onChanged,
  }) : super(
          builder: (FormFieldState<bool> state) => SwitchWidget(
            initialValue: initialValue,
            state: state,
            focusNode: focusNode,
            onChanged: onChanged,
          ),
        );
}

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({
    required this.state,
    this.initialValue = false,
    this.onChanged,
    this.focusNode,
    super.key,
  });

  final bool initialValue;
  final FormFieldState<bool> state;
  final FocusNode? focusNode;
  // ignore: avoid_positional_boolean_parameters
  final void Function(bool? value)? onChanged;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  late bool value = widget.initialValue;

  @override
  Widget build(BuildContext context) => Switch(
        value: value,
        focusNode: widget.focusNode,
        onChanged: (bool value) {
          widget.onChanged?.call(value);

          widget.state.didChange(value);

          setState(() {
            this.value = value;
          });
        },
      );
}
