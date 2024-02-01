// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Generates a [TextFormField] for passwords. It requires a [FlutterFormInputController]
/// as the [controller] parameter and an optional [Widget] as [label]
class FlutterFormInputPassword extends StatefulWidget {
  final Widget? label;
  final FocusNode? focusNode;
  final TextStyle? style;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onFieldSubmitted;
  final bool enabled;
  final InputDecoration? decoration;

  const FlutterFormInputPassword({
    Key? key,
    this.label,
    this.focusNode,
    this.style,
    this.initialValue,
    this.inputFormatters,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
    this.decoration,
  }) : super(key: key);

  @override
  State<FlutterFormInputPassword> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<FlutterFormInputPassword> {
  bool obscured = true;

  @override
  Widget build(BuildContext context) {
    var suffixIcon = IconButton(
      onPressed: () {
        setState(() {
          obscured = !obscured;
        });
      },
      icon: Icon(obscured ? Icons.visibility_off : Icons.visibility),
    );

    var decoration = widget.decoration?.copyWith(suffixIcon: suffixIcon) ??
        InputDecoration(suffixIcon: suffixIcon);

    return TextFormField(
      style: widget.style,
      initialValue: widget.initialValue,
      inputFormatters: widget.inputFormatters,
      obscureText: obscured,
      focusNode: widget.focusNode,
      onSaved: (value) => widget.onSaved?.call(value),
      validator: (value) => widget.validator?.call(value),
      onChanged: (value) => widget.onChanged?.call(value),
      onFieldSubmitted: (value) => widget.onFieldSubmitted?.call(value),
      decoration: decoration,
      enabled: widget.enabled,
    );
  }
}
