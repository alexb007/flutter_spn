import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GenderRadio extends StatefulWidget {
  final List<GenderModel> children;
  final void Function(String val) onSelected;

  GenderRadio({this.children, this.onSelected});

  @override
  createState() {
    return new _GenderRadioState();
  }
}

class _GenderRadioState extends State<GenderRadio> {
  @override
  void initState() {
    super.initState();
  }

  Widget _getRadioButton(index) {
    return GestureDetector(
        child: Container(
          height: 140,
          width: 86,
          margin: new EdgeInsets.only(
            top: 8.0,
            right: 24.0,
          ),
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Material(
                child: Container(
                  child: new Center(
                      child: SvgPicture.asset(
                        widget.children[index].imageAsset,
                        color: widget.children[index].isSelected
                            ? Colors.white
                            : Colors.blueAccent,
                      )),
                  padding: EdgeInsets.all(16),
                  decoration: new BoxDecoration(
                    gradient: widget.children[index].isSelected
                        ? LinearGradient(colors: [
                      Color(0xFF2899EA),
                      Color(0xFF0077CB),
                    ])
                        : null,
                    border: new Border.all(
                        width: 1.0,
                        color: widget.children[index].isSelected
                            ? Colors.blueAccent
                            : Colors.grey),
                    borderRadius:
                    const BorderRadius.all(const Radius.circular(8.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                child: new Text(
                  widget.children[index].text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: widget.children[index].isSelected
                          ? Colors.blueAccent
                          : Colors.grey),
                ),
              )
            ],
          ),
        ),
        onTap: () => widget.children[index].onSelected()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(widget.children.length, (i) => i).map((index) {
        return _getRadioButton(index);
      }).toList(),
    );
  }
}

class GenderModel {
  bool isSelected;
  final String text;
  final String imageAsset;
  final onSelected;

  GenderModel({this.isSelected, this.text, this.imageAsset, this.onSelected});
}
