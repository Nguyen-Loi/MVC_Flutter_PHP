import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ebook_app/controller/api.dart';
import 'package:ebook_app/model/function/functions.dart';
import 'package:ebook_app/view/component/itemSelectedProfile.dart';
import 'package:ebook_app/view/login/ebook_login.dart';
import 'package:ebook_app/widget/common_pref.dart';
import 'package:ebook_app/widget/ebook_routes.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BotttomProfile extends StatefulWidget {
  BotttomProfile({Key? key}) : super(key: key);

  @override
  State<BotttomProfile> createState() => _BotttomProfileState();
}

class _BotttomProfileState extends State<BotttomProfile> {
  String id = '', name = '', email = '', photoUser = '';
  late SharedPreferences preferences;

  File _file = File('');
  final imgPicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadLogin().then((value) {
      setState(() {
        id = value[0];
        name = value[1];
        email = value[2];
        getPhoto(id);
      });
    });
  }

  Future updatePhotoUser() async {
    var req = http.MultipartRequest(
        'POST', Uri.parse(ApiConstant().baseUrl() + ApiConstant().updatePhoto));
    req.fields['iduser'] = id;
    var photo = await http.MultipartFile.fromPath('photo', _file.path);
    req.files.add(photo);
    var reponse = await req.send();
    if (reponse.statusCode == 200) {
      setState(() {
        _file = File('');
      });
      getPhoto(id);
    } else {
      print('eror' + _file.path.toString());
    }
  }

  Future getPhoto(String idOfUser) async {
    var req = await Dio().post(
        ApiConstant().baseUrl() + ApiConstant().viewPhoto,
        data: {'id': idOfUser});
    var decode = req.data;
    if (decode != 'no_img') {
      setState(() {
        photoUser = decode;
      });
    } else {
      setState(() {
        photoUser = '';
      });
    }
  }

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              updatePhotoUser();
            },
            child: _file.path != ''
                ? Center(
                    child: Text(
                      'Update',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  )
                : Text(''),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 24, left: 10, right: 10),
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    imagePicker(context);
                  },
                  child: Container(
                    height: 15.h,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        photoUser != ''
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  Functions.fixImage('$photoUser'),
                                  fit: BoxFit.cover,
                                  width: 30.w,
                                  height: 30.h,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  'asset/images/register.png',
                                  fit: BoxFit.cover,
                                  width: 30.w,
                                  height: 30.h,
                                ),
                              ),
                        _file.path == ''
                            ? Text('')
                            : Text(
                                'Change to -> ',
                                style: TextStyle(color: Colors.black),
                              ),
                        _file.path == ''
                            ? Text('')
                            : Image.file(
                                _file,
                                fit: BoxFit.cover,
                                width: 30.w,
                                height: 30.h,
                              ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.email_outlined,
                      color: Colors.red,
                    ),
                    Container(
                      child: Text(
                        email,
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    )
                  ],
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(top: 25.sp),
                      child: Text(
                        'Ebook app support',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                      ),
                    )),
                itemSelectedProfile(title: 'About Ebook', onPressed: () {}),
                itemSelectedProfile(title: 'Give a Rating', onPressed: () {}),
                itemSelectedProfile(title: 'Share this App', onPressed: () {}),
                itemSelectedProfile(title: 'More app', onPressed: () {}),
                GestureDetector(
                  onTap: () {
                    removeLogin();
                    pushAndRemove(context, EbookLogin());
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 25.sp, bottom: 10.sp),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
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
