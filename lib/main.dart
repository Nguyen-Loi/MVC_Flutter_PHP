import 'package:ebook_app/view/bottom_view.dart';
import 'package:ebook_app/view/home.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Home(),
      );
    });
  }
}
