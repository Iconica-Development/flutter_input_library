// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

class SwitchFormField extends FormField<bool> {
  SwitchFormField({
    Key? key,
    required FormFieldSetter<bool> onSaved,
    required FormFieldValidator<bool> validator,
    FocusNode? focusNode,
    bool initialValue = false,
    bool autovalidate = false,
    void Function(bool? value)? onChanged,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            focusNode: focusNode,
            builder: (FormFieldState<bool> state) {
              return SwitchWidget(
                initialValue: initialValue,
                state: state,
                focusNode: focusNode,
                onChanged: onChanged,
              );
            });
}

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({
    this.initialValue = false,
    required this.state,
    this.onChanged,
    this.focusNode,
    super.key,
  });

  final bool initialValue;
  final FormFieldState<bool> state;
  final FocusNode? focusNode;
  final void Function(bool? value)? onChanged;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  late bool value = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return Switch(
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
}
