import 'package:flutter/material.dart';
import 'package:spn_flutter/styles/clippers/oval_top_border_clipper.dart';
import 'package:spn_flutter/widgets/intro_views/models/page_view_model.dart';

/// This is the class which contains the Page UI.
class Page extends StatelessWidget {
  ///page details
  final PageViewModel pageViewModel;

  ///percent visible of page
  final double percentVisible;

  /// [MainAxisAligment]
  final MainAxisAlignment columnMainAxisAlignment;

  //Constructor
  Page({
    this.pageViewModel,
    this.percentVisible = 1.0,
    this.columnMainAxisAlignment = MainAxisAlignment.spaceAround,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      color: pageViewModel.pageColor,
      child: new Opacity(
        //Opacity is used to create fade in effect
        opacity: percentVisible,
        child: new OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitPage()
              : __buildLandscapePage();
        }), //OrientationBuilder
      ),
    );
  }

  /// when device is Portrait place title, image and body in a column
  Widget _buildPortraitPage() {
    return new Stack(
      children: <Widget>[
        Transform(
          transform: new Matrix4.translationValues(0.0, 0 * (1 - percentVisible), 0.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: pageViewModel.mainImage,
                  fit: BoxFit.cover
              ),
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: ClipPath(
            clipper: OvalTopBorderClipper(),
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.only(top: 48, left: 8, right: 8),
              height: 400,
              child: Column(
                children: <Widget>[
                  _TitlePageTransform(
                    percentVisible: percentVisible,
                    pageViewModel: pageViewModel,
                  ),
                  _BodyPageTransform(
                    percentVisible: percentVisible,
                    pageViewModel: pageViewModel,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  /// if Device is Landscape reorder with row and column
  Widget __buildLandscapePage() {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: new _ImagePageTransform(
            percentVisible: percentVisible,
            pageViewModel: pageViewModel,
          ),
        ), //Transform

        new Flexible(
          child: new Column(
            mainAxisAlignment: columnMainAxisAlignment,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new _TitlePageTransform(
                percentVisible: percentVisible,
                pageViewModel: pageViewModel,
              ), //Transform
              new _BodyPageTransform(
                percentVisible: percentVisible,
                pageViewModel: pageViewModel,
              ), //Transform
            ],
          ), // Column
        ),
      ],
    );
  }
}

/// Body for the Page.
class _BodyPageTransform extends StatelessWidget {
  final double percentVisible;

  final PageViewModel pageViewModel;

  const _BodyPageTransform({
    Key key,
    @required this.percentVisible,
    @required this.pageViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Transform(
      //Used for vertical transformation
      transform:
          new Matrix4.translationValues(0.0, 30.0 * (1 - percentVisible), 0.0),
      child: new Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          right: 10.0,
        ),
        child: DefaultTextStyle.merge(
          style: pageViewModel.bodyTextStyle,
          textAlign: TextAlign.center,
          child: pageViewModel.body,
        ),
      ), //Padding
    );
  }
}

/// Main Image of the Page
class _ImagePageTransform extends StatelessWidget {
  final double percentVisible;

  final PageViewModel pageViewModel;

  const _ImagePageTransform({
    Key key,
    @required this.percentVisible,
    @required this.pageViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Transform(
        //Used for vertical transformation
        transform:
            new Matrix4.translationValues(0.0, 0 * (1 - percentVisible), 0.0),
        child: FittedBox(
          fit: BoxFit.fill,
          child: new Container(
            decoration: BoxDecoration(color: Colors.red),
            child: FittedBox(
              fit: BoxFit.fill,
            ), //Loading main
          ),
        ));
  }
}

/// Title for the Page
class _TitlePageTransform extends StatelessWidget {
  final double percentVisible;

  final PageViewModel pageViewModel;

  const _TitlePageTransform({
    Key key,
    @required this.percentVisible,
    @required this.pageViewModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Transform(
      //Used for vertical transformation
      transform:
          new Matrix4.translationValues(0.0, 30.0 * (1 - percentVisible), 0.0),
      child: new Padding(
        padding: new EdgeInsets.only(
          top: 5.0,
          bottom: 30.0,
          left: 24.0,
          right: 24.0,
        ),
        child: DefaultTextStyle.merge(
          style: pageViewModel.titleTextStyle,
          child: pageViewModel.title,
        ),
      ), //Padding
    );
  }
}
