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

  void imagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                leading: Icon(
                  Icons.library_add,
                  color: Colors.blue,
                ),
                title: Text(
                  'Photo from Gallery',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  imageFromGallery();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.camera,
                  color: Colors.blue,
                ),
                title: Text(
                  'Photo from camera',
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  imageFromCamera();
                     Navigator.pop(context);
                },
              ),
            ],
          ));
        });
  }

  imageFromGallery() async {
    var imgFromGallery = await imgPicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 100,
        maxWidth: 100);
    setState(() {
      if (imgFromGallery != null) {
        _file = File(imgFromGallery.path);
      } else {
        print('This file dont have any data');
      }
    });
  }

  imageFromCamera() async {
    var imgFromCamera = await imgPicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxHeight: 100,
        maxWidth: 100);
    setState(() {
      if (imgFromCamera != null) {
        _file = File(imgFromCamera.path);
      } else {
        print('This file dont have any data');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 17.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Create your account right now',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              GestureDetector(
                onTap: () {
                  imagePicker(context);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: _file.path == ''
                          ? Image.asset(
                              'asset/images/register.png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _file,
                              width: 30,
                              height: 30,
                              fit: BoxFit.cover,
                            )),
                ),
              ),
              TextFiledMain(
                  hintText: 'Enter your name',
                  iconFiled: Icons.account_circle_outlined),
              TextFiledMain(
                  hintText: 'Enter your email',
                  iconFiled: Icons.email_outlined),
              TextFiledMain(
                  hintText: 'Enter your password',
                  iconFiled: Icons.lock_outline),
            ],
          ),
        ),
      ),
    );
  }
}
