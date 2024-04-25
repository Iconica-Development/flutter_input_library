// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_input_library/src/inputs/number_picker/infinite_listview.dart';

typedef TextMapper = String Function(String numberText);

class NumberPicker extends StatefulWidget {
  const NumberPicker({
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.onChanged,
    super.key,
    this.itemCount = 3,
    this.step = 1,
    this.itemHeight = 50,
    this.itemWidth = 100,
    this.axis = Axis.vertical,
    this.textStyle,
    this.selectedTextStyle,
    this.haptics = false,
    this.decoration,
    this.zeroPad = false,
    this.textMapper,
    this.infiniteLoop = false,
  })  : assert(minValue <= value, 'value must be greater than minValue'),
        assert(value <= maxValue, 'value must be less than maxValue');

  /// Min value user can pick
  final int minValue;

  /// Max value user can pick
  final int maxValue;

  /// Currently selected value
  final int value;

  /// Called when selected value changes
  final ValueChanged<int> onChanged;

  /// Specifies how many items should be shown - defaults to 3
  final int itemCount;

  /// Step between elements. Only for integer datePicker
  /// Examples:
  /// if step is 100 the following elements may be 100, 200, 300...
  /// if min=0, max=6, step=3, then items will be 0, 3 and 6
  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final int step;

  /// height of single item in pixels
  final double itemHeight;

  /// width of single item in pixels
  final double itemWidth;

  /// Direction of scrolling
  final Axis axis;

  /// Style of non-selected numbers. If null, it uses Theme's bodyText2
  final TextStyle? textStyle;

  /// Style of non-selected numbers. If null, it uses Theme's headline5 with
  /// accentColor
  final TextStyle? selectedTextStyle;

  /// Whether to trigger haptic pulses or not
  final bool haptics;

  /// Build the text of each item on the picker
  final TextMapper? textMapper;

  /// Pads displayed integer values up to the length of maxValue
  final bool zeroPad;

  /// Decoration to apply to central box where the selected value is placed
  final Decoration? decoration;

  final bool infiniteLoop;

  @override
  NumberPickerState createState() => NumberPickerState();
}

class NumberPickerState extends State<NumberPicker> {
  late ScrollController _scrollController;

  late int value;

  @override
  void initState() {
    super.initState();

    value = widget.value;

    var initialOffset = (value - widget.minValue) ~/ widget.step * itemExtent;
    if (widget.infiniteLoop) {
      _scrollController =
          InfiniteScrollController(initialScrollOffset: initialOffset);
    } else {
      _scrollController = ScrollController(initialScrollOffset: initialOffset);
    }
    _scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    var indexOfMiddleElement = (_scrollController.offset / itemExtent).round();
    if (widget.infiniteLoop) {
      indexOfMiddleElement %= itemCount;
    } else {
      indexOfMiddleElement = indexOfMiddleElement.clamp(0, itemCount - 1);
    }
    var intValueInTheMiddle =
        _intValueFromIndex(indexOfMiddleElement + additionalItemsOnEachSide);

    if (value != intValueInTheMiddle) {
      setState(() {
        value = intValueInTheMiddle;
      });

      widget.onChanged(intValueInTheMiddle);
      if (widget.haptics) {
        await HapticFeedback.selectionClick();
      }
    }
    Future.delayed(
      const Duration(milliseconds: 100),
      _maybeCenterValue,
    );
  }

  @override
  void didUpdateWidget(NumberPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != value) {
      unawaited(_maybeCenterValue());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool get isScrolling => _scrollController.position.isScrollingNotifier.value;

  double get itemExtent =>
      widget.axis == Axis.vertical ? widget.itemHeight : widget.itemWidth;

  int get itemCount => (widget.maxValue - widget.minValue) ~/ widget.step + 1;

  int get listItemsCount => itemCount + 2 * additionalItemsOnEachSide;

  int get additionalItemsOnEachSide => (widget.itemCount - 1) ~/ 2;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: widget.axis == Axis.vertical
            ? widget.itemWidth
            : widget.itemCount * widget.itemWidth,
        height: widget.axis == Axis.vertical
            ? widget.itemCount * widget.itemHeight
            : widget.itemHeight,
        child: NotificationListener<ScrollEndNotification>(
          onNotification: (not) {
            if (not.dragDetails?.primaryVelocity == 0) {
              Future.microtask(_maybeCenterValue);
            }
            return true;
          },
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: widget.itemWidth,
                    height: widget.itemHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xFFD8D8D8).withOpacity(0.50),
                    ),
                  ),
                ),
                if (widget.infiniteLoop)
                  InfiniteListView.builder(
                    scrollDirection: widget.axis,
                    controller: _scrollController as InfiniteScrollController,
                    itemExtent: itemExtent,
                    itemBuilder: _itemBuilder,
                    padding: EdgeInsets.zero,
                  )
                else
                  ListView.builder(
                    itemCount: listItemsCount,
                    scrollDirection: widget.axis,
                    controller: _scrollController,
                    itemExtent: itemExtent,
                    itemBuilder: _itemBuilder,
                    padding: EdgeInsets.zero,
                  ),
                _NumberPickerSelectedItemDecoration(
                  axis: widget.axis,
                  itemExtent: itemExtent,
                  decoration: widget.decoration,
                ),
              ],
            ),
          ),
        ),
      );

  Widget _itemBuilder(BuildContext context, int index) {
    var themeData = Theme.of(context);
    var defaultStyle = widget.textStyle ?? themeData.textTheme.bodyMedium;
    var selectedStyle = widget.selectedTextStyle ??
        themeData.textTheme.headlineSmall
            ?.copyWith(color: themeData.highlightColor);

    var valueFromIndex = _intValueFromIndex(index % itemCount);
    var isExtra = !widget.infiniteLoop &&
        (index < additionalItemsOnEachSide ||
            index >= listItemsCount - additionalItemsOnEachSide);
    var itemStyle = valueFromIndex == value ? selectedStyle : defaultStyle;

    var child = isExtra
        ? const SizedBox.shrink()
        : Text(
            _getDisplayedValue(valueFromIndex),
            style: itemStyle,
          );

    return Container(
      width: widget.itemWidth,
      height: widget.itemHeight,
      alignment: Alignment.center,
      child: child,
    );
  }

  String _getDisplayedValue(int value) {
    var text = widget.zeroPad
        ? value.toString().padLeft(widget.maxValue.toString().length, '0')
        : value.toString();
    if (widget.textMapper != null) {
      return widget.textMapper!(text);
    } else {
      return text;
    }
  }

  int _intValueFromIndex(int index) {
    var newIndex = index;
    newIndex -= additionalItemsOnEachSide;
    newIndex %= itemCount;
    return widget.minValue + newIndex * widget.step;
  }

  Future<void> _maybeCenterValue() async {
    if (_scrollController.hasClients && !isScrolling) {
      var diff = value - widget.minValue;
      var index = diff ~/ widget.step;
      if (widget.infiniteLoop) {
        var offset = _scrollController.offset + 0.5 * itemExtent;
        var cycles = (offset / (itemCount * itemExtent)).floor();
        index += cycles * itemCount;
      }
      await _scrollController.animateTo(
        index * itemExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }
}

class _NumberPickerSelectedItemDecoration extends StatelessWidget {
  const _NumberPickerSelectedItemDecoration({
    required this.axis,
    required this.itemExtent,
    required this.decoration,
  });
  final Axis axis;
  final double itemExtent;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) => Center(
        child: IgnorePointer(
          child: Container(
            width: isVertical ? double.infinity : itemExtent,
            height: isVertical ? itemExtent : double.infinity,
            decoration: decoration,
          ),
        ),
      );

  bool get isVertical => axis == Axis.vertical;
}
