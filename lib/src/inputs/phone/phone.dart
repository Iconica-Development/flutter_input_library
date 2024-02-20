// SPDX-FileCopyrightText: 2024 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_input_library/flutter_input_library.dart';

class FlutterFormInputPhone extends StatefulWidget {
  const FlutterFormInputPhone({
    super.key,
    this.label,
    this.decoration,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.style,
    this.enabled = true,
    this.priorityCountries = const ['NL', 'BE', 'LU'],
    this.countrySelectorUnderline,
    this.countrySelectorWidth = 100,
  });

  final InputDecoration? decoration;
  final Widget? label;
  final String? initialValue;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onFieldSubmitted;
  final TextStyle? style;
  final bool enabled;
  final List<String>? priorityCountries;
  final Widget? countrySelectorUnderline;
  final double countrySelectorWidth;

  @override
  State<FlutterFormInputPhone> createState() => _FlutterFormInputPhoneState();
}

class _FlutterFormInputPhoneState extends State<FlutterFormInputPhone> {
  final List<Country> _countryList = [];
  late Country _selectedCountry;

  String? validatorMessage;

  @override
  void initState() {
    super.initState();
    for (var country in countries) {
      _countryList.add(country);
    }

    if (widget.priorityCountries != null) {
      for (var countryCode in widget.priorityCountries!.reversed.toList()) {
        _countryList.removeWhere(
          (country) => country.code.toLowerCase() == countryCode.toLowerCase(),
        );

        var insertedCountry = countries.firstWhereOrNull(
          (country) => country.code.toLowerCase() == countryCode.toLowerCase(),
        );

        if (insertedCountry != null) {
          _countryList.insert(0, insertedCountry);
        }
      }
    }

    _selectedCountry = _countryList.first;
  }

  @override
  Widget build(BuildContext context) {
    var inputDecoration = widget.decoration ??
        InputDecoration(
          label: widget.label ?? const Text('Phone number'),
        );

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 16),
          width: widget.countrySelectorWidth,
          child: DropdownButton(
            value: _selectedCountry,
            style: widget.style,
            underline: widget.countrySelectorUnderline,
            items: [
              for (var country in _countryList) ...[
                DropdownMenuItem(
                  value: country,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(country.flag),
                      const SizedBox(
                        width: 4,
                      ),
                      Text('+${country.dialCode}'),
                    ],
                  ),
                ),
              ],
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedCountry = value;
                });
              }
            },
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: FlutterFormInputPlainText(
            style: widget.style,
            initialValue: widget.initialValue,
            onSaved: (value) =>
                widget.onSaved?.call('${_selectedCountry.dialCode}$value'),
            validator: (value) =>
                widget.validator?.call('${_selectedCountry.dialCode}$value'),
            onChanged: (value) =>
                widget.onChanged?.call('${_selectedCountry.dialCode}$value'),
            onFieldSubmitted: (value) => widget.onFieldSubmitted
                ?.call('${_selectedCountry.dialCode}$value'),
            decoration: inputDecoration.copyWith(),
            keyboardType: TextInputType.phone,
            enabled: widget.enabled,
          ),
        ),
      ],
    );
  }
}
