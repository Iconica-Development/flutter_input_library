// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'carousel_form.dart';

class FlutterFormInputCarousel extends ConsumerWidget {
  const FlutterFormInputCarousel({
    Key? key,
    required this.items,
    this.height = 425,
    this.onSaved,
    this.onChanged,
    this.initialValue,
    this.validator,
  }) : super(
          key: key,
        );

  final List<Widget> items;
  final double height;
  final Function(int?)? onSaved;
  final String Function(int?)? validator;
  final Function(int?)? onChanged;
  final int? initialValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CarouselFormField(
      onSaved: (value) => onSaved?.call(value),
      validator: (value) => validator?.call(value),
      onChanged: (value) => onChanged?.call(value),
      initialValue: initialValue ?? 0,
      items: items,
      height: height,
    );
  }
}
