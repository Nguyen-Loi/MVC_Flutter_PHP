import 'dart:io';
import 'package:ebook_app/view/textfield_main.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EbookRegister extends StatefulWidget {
  EbookRegister({Key? key}) : super(key: key);

  @override
  State<EbookRegister> createState() => EbookRegisterState();
}

class EbookRegisterState extends State<EbookRegister> {
  File _file = File('');
  final imgPicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 17.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Create your account right now', style: TextStyle(
                color: Colors.black, fontSize: 20
              ),),
              GestureDetector(
                onTap: (){},
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Icon(Icons.account_circle_outlined),
                  ),
                ),
              ),
             TextFiledMain(hintText: 'Enter your name', iconFiled: Icons.account_circle_outlined),
             TextFiledMain(hintText: 'Enter your email', iconFiled: Icons.email_outlined),
             TextFiledMain(hintText: 'Enter your password', iconFiled: Icons.lock_outline),
            ],
          ),
        ),
      ),
    );
  }
}

