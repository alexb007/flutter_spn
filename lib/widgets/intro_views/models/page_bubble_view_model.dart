import 'package:flutter/material.dart';

// View Model for page bubble

class PageBubbleViewModel {
  final String iconAssetPath;
  final Color iconColor;
  final bool isActive;
  final double activePercent;
  final Color activeBubbleColor;
  final Color bubbleBackgroundColor;
  final Widget bubbleInner;

  PageBubbleViewModel({
    this.bubbleInner,
    this.iconAssetPath,
    this.iconColor,
    this.isActive,
    this.activePercent,
    this.bubbleBackgroundColor,
    this.activeBubbleColor,
  }) : assert(bubbleBackgroundColor != null);
}
