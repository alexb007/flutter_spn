import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String text, positiveButtonText, negativeButtonText;
  final void Function() positiveOnTap;
  final void Function() negativeOnTap;
  final Image image;

  CustomDialog(
      {@required this.text,
      @required this.positiveButtonText,
      this.negativeButtonText = '',
      this.positiveOnTap,
      this.negativeOnTap,
      this.image});

  List<MaterialButton> _getActionButtons() {
    var buttons = List<MaterialButton>();
    if (negativeButtonText != '') {
      buttons.add(MaterialButton(
        textColor: Colors.blueAccent,
        child: Text(negativeButtonText),
        onPressed: () => negativeOnTap(),
      ));
    }
    buttons.add(MaterialButton(
      textColor: Colors.blueAccent,
      child: Text(positiveButtonText),
      onPressed: () => positiveOnTap(),
    ));
    return buttons;
  }

  Widget dialogContext(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
          decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: _getActionButtons())),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4.0,
      backgroundColor: Colors.transparent,
      child: dialogContext(context),
    );
  }
}
