import 'dart:ui';

import 'package:spn_flutter/widgets/intro_views/models/page_view_model.dart';
import 'package:spn_flutter/widgets/intro_views/utils/constants.dart';

//view model for page indicator

class PagerIndicatorViewModel {
  final List<PageViewModel> pages;
  final int activeIndex;
  final SlideDirection slideDirection;
  final double slidePercent;
  final transitionEnabled;
  final Color activeIndicatorColor;

  PagerIndicatorViewModel(this.pages, this.activeIndex, this.slideDirection,
      this.slidePercent, this.transitionEnabled, this.activeIndicatorColor);
}
