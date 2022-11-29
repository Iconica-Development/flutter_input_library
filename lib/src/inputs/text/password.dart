// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Generates a [TextFormField] for passwords. It requires a [FlutterFormInputController]
/// as the [controller] parameter and an optional [Widget] as [label]
class FlutterFormInputPassword extends ConsumerStatefulWidget {
  final Widget? label;
  final String? initialValue;
  final Function(String?)? onSaved;
  final String Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onFieldSubmitted;

  const FlutterFormInputPassword({
    Key? key,
    this.label,
    this.initialValue,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  ConsumerState<FlutterFormInputPassword> createState() =>
      _PasswordTextFieldState();
}

class _PasswordTextFieldState extends ConsumerState<FlutterFormInputPassword> {
  bool obscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      obscureText: obscured,
      onSaved: (value) => widget.onSaved?.call(value),
      validator: (value) => widget.validator?.call(value),
      onChanged: (value) => widget.onChanged?.call(value),
      onFieldSubmitted: (value) => widget.onFieldSubmitted?.call(value),
      decoration: InputDecoration(
        label: widget.label ?? const Text("Password"),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscured = !obscured;
            });
          },
          icon: Icon(obscured ? Icons.visibility_off : Icons.visibility),
        ),
      ),
    );
  }
}
