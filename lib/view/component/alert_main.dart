import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Future msgAlert(
    {required String title,
    required String description,
    required AlertType alertType,
    required BuildContext context,
    required Function() onPressed
    }) {
  return Alert(
      context: context,
      type: alertType,
      onWillPopActive: true,
      title: title,
      desc: description,
      style: AlertStyle(
        animationType: AnimationType.fromBottom,
        backgroundColor: Colors.white,
        titleStyle: TextStyle(color: Colors.black),
        descStyle: TextStyle(color: Colors.black54),
      ),
      buttons: [
        DialogButton(
          padding: EdgeInsets.all(1),
          onPressed: onPressed,
          child: Container(
            height: 45,
            width: 100,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: Colors.blueAccent, width: 1),
            ),
            child: Center(
                child: Text('Okey',
                    style: TextStyle(fontSize: 16, color: Colors.white))),
          ),
        )
      ]).show();
}
