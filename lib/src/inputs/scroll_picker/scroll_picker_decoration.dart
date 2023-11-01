// SPDX-FileCopyrightText: 2023 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter/material.dart';

class ScrollPickerDecoration {
  const ScrollPickerDecoration({
    this.scrollItemBuilder,
    this.highlightWidget,
    this.scrollItemTextStyle,
    this.numberOfVisibleItems = 5,
    this.itemHeight = 30,
    this.diameterRatio = 2.0,
    this.perspective = 0.002,
    this.overAndUnderCenterOpacity = 1.0,
    this.offAxisFraction = 0.0,
    this.useMagnifier = false,
    this.magnification = 1.0,
    this.squeeze = 1.0,
    this.renderChildrenOutsideViewport = false,
  });

  /// Ability to provide your own builder for the scroll items
  final Widget Function(BuildContext context, int index, dynamic value)?
      scrollItemBuilder;

  /// Override the standard highlight widget. (Grey container which is placed behind the selected item).
  final Widget? highlightWidget;

  /// Textstyle of the scroll items. Will be overridden if the [scrollItemBuilder] is set.
  final TextStyle? scrollItemTextStyle;

  /// Amount of visible items in the scroll wheel. Changing this changes the height of the widget.
  final int numberOfVisibleItems;

  /// Height of each item in the scrollwheel. Chaging this changes the height of the widget.
  final double itemHeight;

  /// A ratio between the diameter of the cylinder and the viewport's size in the main axis.
  ///
  /// A value of 1 means the cylinder has the same diameter as the viewport's size.
  ///
  /// A value smaller than 1 means items at the edges of the cylinder are entirely contained inside the viewport.
  ///
  /// A value larger than 1 means angles less than ±[pi] / 2 from the center of the cylinder are visible.
  ///
  /// The same number of children will be visible in the viewport regardless of the [diameterRatio]. The number of children visible is based on the viewport's length along the main axis divided by the children's [itemExtent]. Then the children are evenly distributed along the visible angles up to ±[pi] / 2.
  ///
  /// Just as it's impossible to stretch a paper to cover the an entire half of a cylinder's surface where the cylinder has the same diameter as the paper's length, choosing a [diameterRatio] smaller than [pi] will leave same gaps between the children.
  ///
  /// Defaults to an arbitrary but aesthetically reasonable number of 2.0.
  ///
  /// Must not be null and must be positive.
  final double diameterRatio;

  /// Size of each child in the main axis. Must not be null and must be positive.
  final double perspective;

  /// The opacity value that will be applied to the wheel that appears below and above the magnifier.
  ///
  /// The default value is 1.0, which will not change anything.
  ///
  /// Must be greater than or equal to 0, and less than or equal to 1.
  final double overAndUnderCenterOpacity;

  /// How much the wheel is horizontally off-center, as a fraction of its width. This property creates the visual effect of looking at a vertical wheel from its side where its vanishing points at the edge curves to one side instead of looking at the wheel head-on.
  ///
  /// The value is horizontal distance between the wheel's center and the vertical vanishing line at the edges of the wheel, represented as a fraction of the wheel's width.
  ///
  /// The value 0.0 means the wheel is looked at head-on and its vanishing line runs through the center of the wheel. Negative values means moving the wheel to the left of the observer, thus the edges curve to the right. Positive values means moving the wheel to the right of the observer, thus the edges curve to the left.
  ///
  /// The visual effect causes the wheel's edges to curve rather than moving the center. So a value of 0.5 means the edges' vanishing line will touch the wheel's size's left edge.
  ///
  /// Defaults to 0.0, which means looking at the wheel head-on. The visual effect can be unaesthetic if this value is too far from the range [-0.5, 0.5].
  final double offAxisFraction;

  /// Whether to use the magnifier for the center item of the wheel.
  final bool useMagnifier;

  /// The zoomed-in rate of the magnifier, if it is used.
  ///
  /// The default value is 1.0, which will not change anything. If the value is > 1.0, the center item will be zoomed in by that rate, and it will also be rendered as flat, not cylindrical like the rest of the list. The item will be zoomed out if magnification < 1.0.
  ///
  /// Must be positive.
  final double magnification;

  ///   The angular compactness of the children on the wheel.
  ///
  /// This denotes a ratio of the number of children on the wheel vs the number of children that would fit on a flat list of equivalent size, assuming [diameterRatio] of 1.
  ///
  /// For instance, if this RenderListWheelViewport has a height of 100px and [itemExtent] is 20px, 5 items would fit on an equivalent flat list. With a [squeeze] of 1, 5 items would also be shown in the RenderListWheelViewport. With a [squeeze] of 2, 10 items would be shown in the RenderListWheelViewport.
  ///
  /// Changing this value will change the number of children built and shown inside the wheel.
  ///
  /// Must not be null and must be positive.
  ///
  /// Defaults to 1.
  final double squeeze;

  /// Whether to paint children inside the viewport only.
  ///
  /// If false, every child will be painted. However the [Scrollable] is still the size of the viewport and detects gestures inside only.
  ///
  /// Defaults to false. Must not be null. Cannot be true if [clipBehavior] is not [Clip.none] since children outside the viewport will be clipped, and therefore cannot render children outside the viewport.
  final bool renderChildrenOutsideViewport;
}
