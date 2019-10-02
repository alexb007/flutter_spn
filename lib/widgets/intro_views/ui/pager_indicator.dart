import 'package:flutter/material.dart';
import 'package:spn_flutter/widgets/intro_views/models/page_bubble_view_model.dart';
import 'package:spn_flutter/widgets/intro_views/models/pager_indicator_view_model.dart';
import 'package:spn_flutter/widgets/intro_views/ui/page_bubble.dart';
import 'package:spn_flutter/widgets/intro_views/utils/constants.dart';

/// This class contains the UI elements associated with bottom page indicator.

class PagerIndicator extends StatelessWidget {
  //view model
  final PagerIndicatorViewModel viewModel;

  //Constructor
  PagerIndicator({
    this.viewModel,
  });

  List<Widget> _getBubbles(bubbles) {
    if (this.viewModel.transitionEnabled) {
      //Calculating the translation value of pager indicator while sliding.
      final baseTranslation =
          ((viewModel.pages.length * BUBBLE_WIDTH) / 2) - (BUBBLE_WIDTH / 2);
      var translation =
          baseTranslation - (viewModel.activeIndex * BUBBLE_WIDTH);

      if (viewModel.slideDirection == SlideDirection.leftToRight) {
        translation += BUBBLE_WIDTH * viewModel.slidePercent;
      } else if (viewModel.slideDirection == SlideDirection.rightToLeft) {
        translation -= BUBBLE_WIDTH * viewModel.slidePercent;
      }
      return [
        Transform(
          // used for horizontal transformation
          transform: Matrix4.translationValues(translation, 0.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bubbles,
          ), //Row
        )
      ];
    }
    return bubbles;
  }

  @override
  Widget build(BuildContext context) {
    //Extracting page bubble information from page view model
    List<PageBubble> bubbles = [];

    for (var i = 0; i < viewModel.pages.length; i++) {
      final page = viewModel.pages[i];

      //calculating percent active
      var percentActive;
      if (i == viewModel.activeIndex) {
        percentActive = 1.0 - viewModel.slidePercent;
      } else if (i == viewModel.activeIndex - 1 &&
          viewModel.slideDirection == SlideDirection.leftToRight) {
        percentActive = viewModel.slidePercent;
      } else if (i == viewModel.activeIndex + 1 &&
          viewModel.slideDirection == SlideDirection.rightToLeft) {
        percentActive = viewModel.slidePercent;
      } else {
        percentActive = 0.0;
      }

      //Adding to the list
      bubbles.add(PageBubble(
        viewModel: PageBubbleViewModel(
          iconAssetPath: page.iconImageAssetPath,
          iconColor: page.iconColor,
          isActive: (i == viewModel.activeIndex),
          activePercent: percentActive,
          bubbleBackgroundColor: page.bubbleBackgroundColor,
          bubbleInner: page.bubble,
          activeBubbleColor: viewModel.activeIndicatorColor,
        ),
      ));
    }

    //UI
    return Container(
      margin: EdgeInsets.only(bottom: 80),
      child: Column(
        children: <Widget>[
          Expanded(child: Container()),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _getBubbles(bubbles)), //Transform
        ], //Children
      ),
    );
  }
}
