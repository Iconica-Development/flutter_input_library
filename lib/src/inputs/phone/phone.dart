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
    this.numberFieldStyle,
    this.dialCodeSelectorStyle,
    this.enabled = true,
    this.priorityCountries = const ['NL', 'BE', 'LU'],
    this.dialCodeSelectorUnderline,
    this.dialCodeSelectorWidth = 100,
    this.dialCodeWrapper,
  });

  final InputDecoration? decoration;
  final Widget? label;
  final PhoneNumber? initialValue;
  final Function(PhoneNumber?)? onSaved;
  final String? Function(PhoneNumber?)? validator;
  final Function(PhoneNumber?)? onChanged;
  final Function(PhoneNumber?)? onFieldSubmitted;
  final TextStyle? numberFieldStyle;
  final TextStyle? dialCodeSelectorStyle;
  final bool enabled;
  final List<String>? priorityCountries;
  final Widget? dialCodeSelectorUnderline;
  final double dialCodeSelectorWidth;
  final Widget Function(Widget child)? dialCodeWrapper;

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

    _selectedCountry = _countryList.firstWhereOrNull(
          (country) => widget.initialValue?.dialCode == country.dialCode,
        ) ??
        _countryList.first;
  }

  @override
  Widget build(BuildContext context) {
    var inputDecoration = widget.decoration ??
        InputDecoration(
          label: widget.label ?? const Text('Phone number'),
        );

    var dropDownButton = DropdownButton(
      value: _selectedCountry,
      style: widget.dialCodeSelectorStyle,
      underline: widget.dialCodeSelectorUnderline,
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
    );

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 16),
          width: widget.dialCodeSelectorWidth,
          child: widget.dialCodeWrapper?.call(dropDownButton) ?? dropDownButton,
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: FlutterFormInputPlainText(
            style: widget.numberFieldStyle,
            initialValue: widget.initialValue?.number,
            onSaved: (value) => widget.onSaved?.call(
              PhoneNumber(dialCode: _selectedCountry.dialCode, number: value),
            ),
            validator: (value) => widget.validator?.call(
              PhoneNumber(dialCode: _selectedCountry.dialCode, number: value),
            ),
            onChanged: (value) => widget.onChanged?.call(
              PhoneNumber(dialCode: _selectedCountry.dialCode, number: value),
            ),
            onFieldSubmitted: (value) => widget.onFieldSubmitted?.call(
              PhoneNumber(dialCode: _selectedCountry.dialCode, number: value),
            ),
            decoration: inputDecoration,
            keyboardType: TextInputType.phone,
            enabled: widget.enabled,
          ),
        ),
      ],
    );
  }
}
