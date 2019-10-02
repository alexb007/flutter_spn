import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spn_flutter/screens/home/home_screen.dart';
import 'package:spn_flutter/styles/text_styles.dart';
import 'package:spn_flutter/widgets/buttons/gender_radio_button.dart';
import 'package:spn_flutter/widgets/inputs/outlined_input.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isChanged = false;
  int age = 25;
  String gender = 'MALE';
  bool usePRAM = true;
  String unit1 = '';
  String unit2 = '';

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      age = prefs.getInt("age") ?? 18;
      gender = prefs.getString("gender") ?? 'MALE';
      usePRAM = prefs.getBool("usepram") ?? true;
      unit1 = prefs.getString('unit1') ?? '';
      unit2 = prefs.getString('unit2') ?? '';
    });
    super.initState();
  }

  Iterable<int> get positiveIntegers sync* {
    int i = 0;
    while (true) yield i++;
  }

  @override
  Widget build(BuildContext context) {
    void _saveSettings() {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setBool('usepram', usePRAM);
        prefs.setString('gender', gender);
        prefs.setInt('age', age);
        prefs.setString('unit1', unit1);
        prefs.setString('unit2', unit2);
        prefs.setBool('first_run', false);
      });
      Navigator.of(context).pushReplacementNamed(HomeScreen.route);
    }

    Widget _ageDropDown() => Container(
          margin: EdgeInsets.only(top: 12),
          width: 126,
          child: DropdownButtonHideUnderline(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    side: BorderSide(
                        width: 1.0,
                        style: BorderStyle.solid,
                        color: Colors.grey)),
              ),
              child: DropdownButton<String>(
                items: positiveIntegers.skip(10).take(86).toList().map((item) {
                  return DropdownMenuItem(
                    value: '$item',
                    child: Text('$item'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    age = int.parse(value);
                  });
                },
                value: '$age',
              ),
            ),
          ),
        );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            flex: 1,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Enter your age:',
                      style: TextStyles.st9,
                      textAlign: TextAlign.start,
                    ),
                    _ageDropDown(),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Your gender:',
                      style: TextStyles.st9,
                      textAlign: TextAlign.start,
                    ),
                    GenderRadio(
                      children: [
                        GenderModel(
                            text: 'FEMALE',
                            imageAsset: 'assets/images/female.svg',
                            isSelected: gender == 'FEMALE',
                            onSelected: () {
                              _isChanged = true;
                              setState(() {
                                gender = 'FEMALE';
                              });
                            }),
                        GenderModel(
                            text: 'MALE',
                            imageAsset: 'assets/images/male.svg',
                            isSelected: gender == 'MALE',
                            onSelected: () {
                              _isChanged = true;
                              setState(() {
                                gender = 'MALE';
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Pram:',
                      style: TextStyles.st9,
                      textAlign: TextAlign.start,
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: usePRAM,
                          onChanged: (val) {
                            if (mounted) {
                              setState(() {
                                usePRAM = val;
                              });
                            }
                          },
                        ),
                        Text('I use the pram')
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Units:',
                      style: TextStyles.st9,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        OutlinedTextField(
                          onChanged: (val) {
                            if (mounted) {
                              setState(() {
                                unit1 = val;
                              });
                            }
                          },
                        ),
                        OutlinedTextField(
                          onChanged: (val) {
                            if (mounted) {
                              setState(() {
                                unit2 = val;
                              });
                            }
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          MaterialButton(
            color: Colors.blueAccent,
            disabledColor: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Text('SAVE', style: TextStyle(fontSize: 18)),
            textColor: Colors.white,
            onPressed: _isChanged ? _saveSettings : null,
          )
        ],
      ),
    );
  }
}
