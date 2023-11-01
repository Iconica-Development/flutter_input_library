// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';
import 'package:flutter_input_library/src/inputs/scroll_picker/scroll_picker_decoration.dart';

class ScrollPicker extends StatefulWidget {
  const ScrollPicker({
    required this.list,
    required this.onChanged,
    required this.decoration,
    this.initialIndex,
    Key? key,
  }) : super(key: key);

  final List<String> list;
  final void Function(int index) onChanged;
  final ScrollPickerDecoration decoration;

  final int? initialIndex;

  @override
  State<ScrollPicker> createState() => _ScrollPickerState();
}

class _ScrollPickerState extends State<ScrollPicker> {
  late FixedExtentScrollController scrollController;

  late double pickerHeight;

  late int selectedIndex;

  @override
  void initState() {
    super.initState();

    var initialIndex = widget.initialIndex;

    if (initialIndex != null &&
        initialIndex > 0 &&
        initialIndex < widget.list.length) {
      selectedIndex = initialIndex;
    } else {
      selectedIndex = (widget.list.length / 2).floor();
    }

    pickerHeight =
        widget.decoration.itemHeight * widget.decoration.numberOfVisibleItems;

    scrollController = FixedExtentScrollController(
      initialItem: selectedIndex,
    );

    scrollController.addListener(() {
      var newIndex =
          (scrollController.offset / widget.decoration.itemHeight).round();

      if (newIndex != selectedIndex) {
        widget.onChanged.call(
            (scrollController.offset / widget.decoration.itemHeight).round());

        selectedIndex = newIndex;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Center(
            child: widget.decoration.highlightWidget ??
                Container(
                  height: widget.decoration.itemHeight,
                  decoration: ShapeDecoration(
                    color: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
          ),
        ),
        SizedBox(
          height: pickerHeight,
          child: ListWheelScrollView.useDelegate(
            physics: const FixedExtentScrollPhysics(),
            diameterRatio: widget.decoration.diameterRatio,
            itemExtent: widget.decoration.itemHeight,
            controller: scrollController,
            perspective: widget.decoration.perspective,
            overAndUnderCenterOpacity:
                widget.decoration.overAndUnderCenterOpacity,
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) =>
                  widget.decoration.scrollItemBuilder
                      ?.call(context, index, widget.list[index]) ??
                  Center(
                    child: Text(
                      widget.list[index],
                      style: widget.decoration.scrollItemTextStyle,
                    ),
                  ),
              childCount: widget.list.length,
            ),
            offAxisFraction: widget.decoration.offAxisFraction,
            useMagnifier: widget.decoration.useMagnifier,
            magnification: widget.decoration.magnification,
            squeeze: widget.decoration.squeeze,
            renderChildrenOutsideViewport:
                widget.decoration.renderChildrenOutsideViewport,
          ),
        ),
      ],
    );
  }
}
