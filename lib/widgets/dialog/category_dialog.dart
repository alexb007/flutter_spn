import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:spn_flutter/data/Constants.dart';
import 'package:spn_flutter/models/category.dart';

class CategoryDialog extends StatefulWidget {
  final MapboxMapController mapController;
  final Category category;

  CategoryDialog({this.mapController, this.category});

  @override
  State<StatefulWidget> createState() => _CategoryDialogState();
}

class CategoryItem {
  Category category;
  bool isSelected;

  CategoryItem({this.category, this.isSelected = false});

  String get icon {
    var icon = 'assets/category/${category.code}';
    if (isSelected) return '${icon}_sl.png';
    return '$icon.png';
  }
}

class _CategoryDialogState extends State<CategoryDialog> {
  List<CategoryItem> categoryItems = [];
  var categories = [];

  @override
  void initState() {
    categories = widget.category != null
        ? widget.category.children
        : Constants.categories;
    categoryItems = categories.map((category) {
      return CategoryItem(
        category: category,
      );
    }).toList();
    super.initState();
  }

  Widget _getCategoryItem(context, index) {
    return new GestureDetector(
      onTap: () {
        if (categoryItems[index].category.children.length > 0) {
          showBottomSheet(
              context: context,
              builder: (context) => CategoryDialog(
                    mapController: widget.mapController,
                    category: categoryItems[index].category,
                  ));
        } else {
          setState(() {
            categoryItems[index].isSelected = !categoryItems[index].isSelected;
          });
        }
      },
      child: new SizedBox(
        width: 75,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new SizedBox(
              child: new Container(
                height: 60,
                width: 60,
                child: Image.asset(categoryItems[index].icon),
              ),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 1.0),
              child: new Text(
                categoryItems[index].category.title,
                style: TextStyle(fontSize: 10),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _getCategoryItems(context) {
    var index = 0;
    return categoryItems.map((category) {
      return _getCategoryItem(context, index++);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    String title =
        widget.category != null ? widget.category.title : 'Categories';

    Widget getCategories(context, index) {
      return new Wrap(runSpacing: 10.0, children: _getCategoryItems(context));
    }

    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      child: Container(
        height: 350,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.black,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              elevation: 1.0,
              title: Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              height: 270,
              child: Swiper(
                outer: false,
                itemBuilder: (context, index) => getCategories(context, index),
                pagination:
                    new SwiperPagination(margin: new EdgeInsets.all(5.0)),
                itemCount: (categories.length / 10).ceil(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
