import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class itemSelectedProfile extends StatelessWidget {
  final String title;
  final Function() onPressed;
  const itemSelectedProfile({
    Key? key,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Container(
          margin: EdgeInsets.only(top: 15.sp),
          child: GestureDetector(
            onTap: onPressed,
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ));
  }
}
