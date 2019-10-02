import 'package:flutter/material.dart';

class RouteCompleteAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 2)
      ]),
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
        child: Container(
          color: Colors.blueAccent,
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Text(
                    "Foodbar",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),

                Flexible(
                  flex: 1,
                  child: MaterialButton(
                    textColor: Colors.white,
                    onPressed: () {},
                    child: Text('DONE'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
