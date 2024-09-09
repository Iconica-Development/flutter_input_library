// SPDX-FileCopyrightText: 2024 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

// ignore: depend_on_referenced_packages
import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:flutter_input_library/src/inputs/radio/radio_picker_field.dart";

class FlutterFormInputRadioPicker extends StatelessWidget {
  const FlutterFormInputRadioPicker({
    required this.items,
    super.key,
    this.onSaved,
    this.onChanged,
    this.initialValue,
    this.itemSpacing = 16.0,
  });

  final Function(RadioItem?)? onSaved;
  final String? initialValue;
  final Function(RadioItem?)? onChanged;
  final List<RadioItem> items;
  final double itemSpacing;

  @override
  Widget build(BuildContext context) => RadioPickerFormField(
        onSaved: (value) => onSaved?.call(value),
        onChanged: (value) => onChanged?.call(value),
        initialValue: items.firstWhereOrNull((i) => i.value == initialValue),
        itemSpacing: itemSpacing,
        items: items,
      );
}

class RadioPickerFormField extends FormField<RadioItem?> {
  RadioPickerFormField({
    required FormFieldSetter<RadioItem> super.onSaved,
    required List<RadioItem> items,
    required double itemSpacing,
    void Function(RadioItem value)? onChanged,
    super.initialValue,
    super.key,
  }) : super(
          builder: (FormFieldState<RadioItem?> state) => RadioPicker(
            onChanged: (value) {
              onChanged?.call(value);

              state.didChange(value);
            },
            items: items,
            initialValue: initialValue,
            itemSpacing: itemSpacing,
          ),
        );
}

class RadioItem<T> {
  /// Creates an item for a radio menu.
  ///
  /// The [child] argument is required.
  const RadioItem({
    required this.child,
    required this.value,
    this.onTap,
  });

  /// Called when the dropdown menu item is tapped.
  final VoidCallback? onTap;

  /// The value to return if the user selects this menu item.
  ///
  /// Eventually returned in a call to [DropdownButton.onChanged].
  final T value;

  final Widget child;
}
