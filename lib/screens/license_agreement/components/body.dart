import 'package:flutter/material.dart';
import 'package:spn_flutter/data/db/initial_data.dart';
import 'package:spn_flutter/screens/settings/settings.dart';
import 'package:spn_flutter/styles/text_styles.dart';
import 'package:spn_flutter/widgets/buttons/bottom_action_button.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyState();
}

class LicenseData {
  static const String agreement =
      'This Regulation establishes the rules related to the protection'
      ' of individuals in the processing of personal data and the '
      'rules relating to the free movement of personal data. '
      'The Regulation also protects the fundamental rights and '
      'freedoms of individuals, and in particular their right '
      'to protection of personal data.';
  static const String hint = "To continue using the app,"
      "you need to agree to the terms of use";
}

class _BodyState extends State<Body> {
  bool isAgree = false;

  void _continue(context) async {
    await initializeData();
    Navigator.of(context).pushReplacementNamed(SettingsScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(
          top: 48,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 32, left: 32, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'GDPR',
                    textAlign: TextAlign.start,
                    style: TextStyles.st6,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    LicenseData.agreement,
                    style: TextStyles.st7,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CheckboxListTile(
                    value: isAgree,
                    onChanged: (val) {
                      if (mounted) {
                        setState(() {
                          isAgree = val;
                        });
                      }
                    },
                    title: Text("Agree"),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                Padding(
                    padding: EdgeInsets.only(
                        top: 8, bottom: 20, left: 32, right: 32),
                    child: Text(
                      LicenseData.hint,
                      style: TextStyles.st8,
                    )),
                BottomActionButton(
                  text: 'CONTINUE',
                  onPressed: isAgree ? () => _continue(context) : null,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
