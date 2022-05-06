import 'package:ebook_app/view/textfield_main.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EbookLogin extends StatefulWidget {
  EbookLogin({Key? key}) : super(key: key);

  @override
  State<EbookLogin> createState() => _EbookLoginState();
}

class _EbookLoginState extends State<EbookLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool visibleLoading = false; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 70),
        child: Stack(
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/noimg.png',
                  width: 125,
                  height: 125,
                ),
                Text(
                  'Hello, Welecome back !',
                  style: TextStyle(color: Colors.blue, fontSize: 24),
                ),
                TextFiledMain(
                    hintText: 'Enter your email',
                    iconFiled: Icons.email_outlined,
                    textController: email),
                TextFiledMain(
                    hintText: 'Enter your password',
                    iconFiled: Icons.password_outlined,
                    textController: password,
                    typePassword: true),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(
                        right: 20, left: 20, top: 17, bottom: 5),
                    padding: EdgeInsets.symmetric(
                        vertical: 1.2.h, horizontal: 1.5.h),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: !visibleLoading
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Visibility(
                            visible: visibleLoading,
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          ),
                  ),
                ),
                Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(
                      right: 20, left: 20, bottom: 5, top: 1.5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have an account?',
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => EbookLogin()),
                              (route) => false);
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              ],
            )
          ],
        ),
      ),
    );
  }
}
