import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:spn_flutter/styles/text_styles.dart';
import 'package:spn_flutter/widgets/buttons/bottom_action_button.dart';
import 'package:spn_flutter/widgets/inputs/rating.dart';

class WalkReportBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WalkReportBodyState();
}

class _WalkReportBodyState extends State<WalkReportBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              OutlineDropdownButton(
                items: [
                  DropdownMenuItem(
                    child: Text('Accident'),
                  )
                ],
                hint: Text('Name of category'),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Place',
                    hasFloatingPlaceholder: true,
                    suffixIcon: Icon(Icons.place)),
                maxLength: 500,
              ),
              SizedBox(
                height: 64,
              ),
              Text(
                'Your assessment:',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 128),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your comment',
                  hasFloatingPlaceholder: true,
                ),
                maxLines: 3,
                maxLength: 500,
              )
            ],
          ),
        ),
        BottomActionButton(
          text: 'SAVE REPORT',
          onPressed: () {},
        )
      ],
    );
  }
}
