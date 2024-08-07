// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_input_library/src/inputs/carousel/carousel_options.dart";
import "package:flutter_input_library/src/inputs/carousel/carousel_state.dart";
import "package:flutter_input_library/src/inputs/carousel/carousel_utils.dart";

abstract class FlutterInputCarouselController {
  factory FlutterInputCarouselController() => CarouselControllerImpl();
  bool get ready;

  Future<void> get onReady;

  Future<void> nextPage({Duration? duration, Curve? curve});

  Future<void> previousPage({Duration? duration, Curve? curve});

  void jumpToPage(int page);

  Future<void> animateToPage(int page, {Duration? duration, Curve? curve});

  void startAutoPlay();

  void stopAutoPlay();
}

class CarouselControllerImpl implements FlutterInputCarouselController {
  final Completer<void> _readyCompleter = Completer<void>();

  CarouselState? _state;

  set state(CarouselState? state) {
    _state = state;
    if (!_readyCompleter.isCompleted) {
      _readyCompleter.complete();
    }
  }

  void _setModeController() =>
      _state!.changeMode(CarouselPageChangedReason.controller);

  @override
  bool get ready => _state != null;

  @override
  Future<void> get onReady => _readyCompleter.future;

  /// Animates the controlled [CarouselSlider] to the next page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  @override
  Future<void> nextPage({
    Duration? duration = const Duration(milliseconds: 300),
    Curve? curve = Curves.linear,
  }) async {
    var isNeedResetTimer = _state!.options.pauseAutoPlayOnManualNavigate;
    if (isNeedResetTimer) {
      _state!.onResetTimer();
    }
    _setModeController();
    await _state!.pageController!.nextPage(duration: duration!, curve: curve!);
    if (isNeedResetTimer) {
      _state!.onResumeTimer();
    }
  }

  /// Animates the controlled [CarouselSlider] to the previous page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  @override
  Future<void> previousPage({
    Duration? duration = const Duration(milliseconds: 300),
    Curve? curve = Curves.linear,
  }) async {
    var isNeedResetTimer = _state!.options.pauseAutoPlayOnManualNavigate;
    if (isNeedResetTimer) {
      _state!.onResetTimer();
    }
    _setModeController();
    await _state!.pageController!
        .previousPage(duration: duration!, curve: curve!);
    if (isNeedResetTimer) {
      _state!.onResumeTimer();
    }
  }

  /// Changes which page is displayed in the controlled [CarouselSlider].
  ///
  /// Jumps the page position from its current value to the given value,
  /// without animation, and without checking if the new value is in range.
  @override
  void jumpToPage(int page) {
    var index = getRealIndex(
      _state!.pageController!.page!.toInt(),
      _state!.realPage - _state!.initialPage,
      _state!.itemCount,
    );

    _setModeController();
    var pageToJump = _state!.pageController!.page!.toInt() + page - index;
    return _state!.pageController!.jumpToPage(pageToJump);
  }

  /// Animates the controlled [CarouselSlider] from the current page to the
  /// given page.
  ///
  /// The animation lasts for the given duration and follows the given curve.
  /// The returned [Future] resolves when the animation completes.
  @override
  Future<void> animateToPage(
    int page, {
    Duration? duration = const Duration(milliseconds: 300),
    Curve? curve = Curves.linear,
  }) async {
    var isNeedResetTimer = _state!.options.pauseAutoPlayOnManualNavigate;
    if (isNeedResetTimer) {
      _state!.onResetTimer();
    }
    var index = getRealIndex(
      _state!.pageController!.page!.toInt(),
      _state!.realPage - _state!.initialPage,
      _state!.itemCount,
    );
    _setModeController();
    await _state!.pageController!.animateToPage(
      _state!.pageController!.page!.toInt() + page - index,
      duration: duration!,
      curve: curve!,
    );
    if (isNeedResetTimer) {
      _state!.onResumeTimer();
    }
  }

  /// Starts the controlled [CarouselSlider] autoplay.
  ///
  /// The carousel will only autoPlay if the [autoPlay] parameter
  /// in [CarouselOptions] is true.
  @override
  void startAutoPlay() {
    _state!.onResumeTimer();
  }

  /// Stops the controlled [CarouselSlider] from autoplaying.
  ///
  /// This is a more on-demand way of doing this. Use the [autoPlay]
  /// parameter in [CarouselOptions] to specify the autoPlay behaviour of the
  /// carousel.
  @override
  void stopAutoPlay() {
    _state!.onResetTimer();
  }
}
