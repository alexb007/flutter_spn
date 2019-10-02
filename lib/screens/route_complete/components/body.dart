import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spn_flutter/styles/text_styles.dart';
import 'package:spn_flutter/widgets/buttons/bottom_action_button.dart';
import 'package:spn_flutter/widgets/inputs/rating.dart';

class RouteCompleteBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RouteCompleteBodyState();
}

class _RouteCompleteBodyState extends State<RouteCompleteBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 2)
              ]),
              width: MediaQuery.of(context).size.width,
              height: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
                child: Container(
                  padding: EdgeInsets.only(left: 24, right: 24, bottom: 16),
                  color: Colors.blue,
                  child: Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            'Walk results:',
                            textAlign: TextAlign.start,
                            style: TextStyles.st14,
                          ),
                          SizedBox(height: 24,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "05:45 h",
                                style: TextStyles.st13,
                              ),
                              Text(
                                "11.6 km",
                                style: TextStyles.st13,
                              ),
                              Text(
                                "11 054 steps",
                                style: TextStyles.st13,
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ),
            ),
            SizedBox(height: 16,),
            Text('Please rate this route', style: TextStyles.st15,),
            SizedBox(
              height: 8,
            ),
            FormField<int>(
              initialValue: 3,
              autovalidate: true,
              builder: (state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    StarRating(
                      onChanged: state.didChange,
                      value: state.value,
                    ),
                    state.errorText != null
                        ? Text(state.errorText,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Theme.of(context).errorColor))
                        : Container(),
                  ],
                );
              },
              validator: (value) => value < 2 ? 'rating too low' : null,
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Your comment',
                  hasFloatingPlaceholder: true,
                ),
                maxLength: 500,
              ),
            )
          ],
        ),
        BottomActionButton(
          text: 'SAVE ROUTE',
          onPressed: () {},
        )
      ],
    );
  }
}
