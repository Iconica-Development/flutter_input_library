// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_input_library/src/inputs/carousel/carousel_slider.dart';

class CarouselFormField extends FormField<int> {
  CarouselFormField({
    required FormFieldSetter<int> super.onSaved,
    required FormFieldValidator<int> super.validator,
    required List<Widget> items,
    super.key,
    void Function(int value)? onChanged,
    int super.initialValue = 0,
    double height = 425,
  }) : super(
          builder: (FormFieldState<int> state) => CarouselSlider(
            options: CarouselOptions(
              initialPage: initialValue,
              onPageChanged: (index, reason) {
                onChanged?.call(index);

                state.didChange(index);
              },
              height: height,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
            ),
            items: items.map((Widget item) => item).toList(),
          ),
        );
}
