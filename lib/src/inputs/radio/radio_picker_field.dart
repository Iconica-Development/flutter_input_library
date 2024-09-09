import "package:flutter/material.dart";
import "package:flutter_input_library/src/inputs/radio/radio_picker.dart";

class RadioPicker extends StatefulWidget {
  const RadioPicker({
    required this.onChanged,
    required this.items,
    this.itemSpacing = 16.0,
    this.initialValue,
    super.key,
  });

  final RadioItem? initialValue;
  final Function(RadioItem) onChanged;
  final List<RadioItem> items;

  /// The spacing between each item.
  final double itemSpacing;

  @override
  State<RadioPicker> createState() => _RadioPickerState();
}

class _RadioPickerState extends State<RadioPicker> {
  late RadioItem? value = widget.initialValue;

  @override
  Widget build(BuildContext context) => Wrap(
        children: [
          for (var item in widget.items) ...[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                item.child,
                Radio<RadioItem>(
                  value: item,
                  groupValue: value,
                  onChanged: (v) {
                    if (v != null) {
                      setState(() {
                        value = v;
                      });
                      widget.onChanged(v);
                    }
                  },
                ),
              ],
            ),
            if (widget.items.last != item) ...[
              SizedBox(width: widget.itemSpacing),
            ],
          ],
        ],
      );
}
