// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

import 'package:flutter_input_library/src/inputs/carousel/carousel_form.dart';

class FlutterFormInputCarousel extends StatelessWidget {
  const FlutterFormInputCarousel({
    required this.items,
    super.key,
    this.height = 425,
    this.onSaved,
    this.onChanged,
    this.initialValue,
    this.validator,
  });

  final List<Widget> items;
  final double height;
  final Function(int?)? onSaved;
  final String? Function(int?)? validator;
  final Function(int?)? onChanged;
  final int? initialValue;

  @override
  Widget build(BuildContext context) => CarouselFormField(
        onSaved: (value) => onSaved?.call(value),
        validator: (value) => validator?.call(value),
        onChanged: (value) => onChanged?.call(value),
        initialValue: initialValue ?? 0,
        items: items,
        height: height,
      );
}
