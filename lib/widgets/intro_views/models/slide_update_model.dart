import 'package:spn_flutter/widgets/intro_views/utils/constants.dart';

// model for slide update

class SlideUpdate {
  final UpdateType updateType;
  final SlideDirection direction;
  final double slidePercent;

  SlideUpdate(
    this.direction,
    this.slidePercent,
    this.updateType,
  );
}
