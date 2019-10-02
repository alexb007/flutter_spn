import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spn_flutter/widgets/intro_views/models/page_bubble_view_model.dart';

/// This class contains the UI for page bubble.
class PageBubble extends StatelessWidget {
  //view model
  final PageBubbleViewModel viewModel;

  //Constructor
  PageBubble({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 24,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            width: lerpDouble(
                10,
                14,
                viewModel
                    .activePercent), //This method return in between values according to active percent.
            height: lerpDouble(20.0, 45.0, viewModel.activePercent),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //Alpha is used to create fade effect for background color
              color: viewModel.isActive
                  ? viewModel.activeBubbleColor
                  : viewModel.bubbleBackgroundColor,
            ), //BoxDecoration
            child: Opacity(
              opacity: viewModel.activePercent,
              child: (viewModel.iconAssetPath != null &&
                      viewModel.iconAssetPath != "")
                  // ignore: conflicting_dart_import
                  ? Image.asset(
                      viewModel.iconAssetPath,
                      color: viewModel.iconColor,
                    )
                  : viewModel.bubbleInner != null
                      ? Transform.scale(
                          scale: viewModel.activePercent.clamp(0.5, 1.0),
                          child: viewModel.bubbleInner,
                        )
                      : Container(),
            ), //opacity
          ), //Container
        ), //Padding
      ), //Center
    ); //Container
  }
}
