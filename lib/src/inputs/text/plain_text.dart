// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterFormInputPlainText extends StatelessWidget {
  const FlutterFormInputPlainText({
    Key? key,
    this.label,
    this.focusNode,
    this.decoration,
    this.textAlignVertical,
    this.expands = false,
    this.maxLines = 1,
    this.scrollPadding,
    this.maxLength,
    this.keyboardType,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.style,
    this.formatInputs,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
    this.obscureText = false,
  }) : super(
          key: key,
        );

  final InputDecoration? decoration;
  final TextAlignVertical? textAlignVertical;
  final bool expands;
  final int? maxLines;
  final int? maxLength;
  final EdgeInsets? scrollPadding;
  final TextInputType? keyboardType;
  final Widget? label;
  final FocusNode? focusNode;
  final String? initialValue;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onFieldSubmitted;
  final TextStyle? style;
  final List<TextInputFormatter>? formatInputs;
  final bool enabled;
  final TextCapitalization textCapitalization;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    InputDecoration inputDecoration = decoration ??
        InputDecoration(
          label: label ?? const Text("Plain text"),
        );

    return TextFormField(
      style: style,
      inputFormatters: formatInputs,
      scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
      initialValue: initialValue,
      focusNode: focusNode,
      onSaved: (value) => onSaved?.call(value),
      validator: (value) => validator?.call(value),
      onChanged: (value) => onChanged?.call(value),
      onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
      decoration: inputDecoration,
      textAlignVertical: textAlignVertical,
      expands: expands,
      maxLines: maxLines,
      maxLength: maxLength,
      keyboardType: keyboardType,
      enabled: enabled,
      textCapitalization: textCapitalization,
      obscureText: obscureText,
    );
  }
}

class FlutterFormInputMultiLine extends StatelessWidget {
  const FlutterFormInputMultiLine({
    Key? key,
    this.label,
    this.focusNode,
    this.hint,
    this.maxCharacters,
    this.enabled = true,
    this.scrollPadding,
    this.keyboardType,
    this.initialValue,
    this.decoration,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.textCapitalization = TextCapitalization.sentences,
  }) : super(key: key);

  final Widget? label;
  final FocusNode? focusNode;
  final String? hint;
  final int? maxCharacters;
  final bool enabled;

  final InputDecoration? decoration;
  final EdgeInsets? scrollPadding;
  final TextInputType? keyboardType;
  final String? initialValue;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onFieldSubmitted;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FlutterFormInputPlainText(
            label: label,
            textAlignVertical: TextAlignVertical.top,
            expands: true,
            maxLines: null,
            focusNode: focusNode,
            maxLength: maxCharacters,
            initialValue: initialValue,
            scrollPadding: scrollPadding,
            keyboardType: keyboardType,
            onSaved: onSaved,
            validator: validator,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            decoration: decoration ??
                InputDecoration(
                  hintText: hint,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  isDense: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF979797)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF979797)),
                  ),
                  filled: true,
                ),
            enabled: enabled,
            textCapitalization: textCapitalization,
          ),
        ),
      ],
    );
  }
}
