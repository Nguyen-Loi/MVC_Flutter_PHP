import 'package:dio/dio.dart';
import 'package:ebook_app/controller/api.dart';
import 'package:ebook_app/controller/con_detail.dart';
import 'package:ebook_app/controller/con_save_favorite.dart';
import 'package:ebook_app/widget/common_pref.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ebook_app/model/function/functions.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:package_info/package_info.dart';
import 'package:ebook_app/model/ebook/model_ebook.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class EbookDetail extends StatefulWidget {
  int ebookId;
  int status;
  EbookDetail({
    Key? key,
    required this.ebookId,
    required this.status,
  }) : super(key: key);

  @override
  State<EbookDetail> createState() => _EbookDetailState();
}

class _EbookDetailState extends State<EbookDetail> {
  late Future<List<ModelEbook>> getDetail;
  List<ModelEbook> listDetail = [];

  String id = '', name = '', email = '', checkFavorite = '0';

  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    getDetail = fetchDetail(listDetail, widget.ebookId);
    loadLogin().then((value) {
      id = value[0];
      name = value[1];
      email = value[2];
      checkFavorites(id);
    });
  }

  checkFavorites(String userId) async {
    var data = {'id_course': widget.ebookId, 'id_user': userId};
    var checkFav = await Dio().post(
        ApiConstant().baseUrl() + ApiConstant().checkFavorite,
        data: data);
    var reponse = checkFav.data;
    setState(() {
      checkFavorite = reponse;
    });
  }

  _share() async {
    PackageInfo pi = await PackageInfo.fromPlatform();
    Share.share(
        'Reading ebook for free on ${pi.appName} \n Dowload now: https://play.google.com/store/apps/details?id=${pi.packageName}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white70,
          elevation: 0,
          title: Text(
            'Detail',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Container(
          child: FutureBuilder<List<ModelEbook>>(
            future: getDetail,
            builder: (context, snaphot) {
              if (snaphot.connectionState == ConnectionState.done) {
                return Stack(
                  children: [
                    ListView.builder(
                        itemCount: snaphot.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(14),
                                height: 25.h,
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Image.network(
                                        Functions.fixImage(
                                            snaphot.data![index].photo),
                                        fit: BoxFit.contain,
                                        width: 35.w,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Flexible(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snaphot.data![index].title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                                color: Colors.black),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 1.3.h,
                                          ),
                                          Text(
                                            'Author: ${snaphot.data![index].authorName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: Colors.black),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(
                                            height: 1.3.h,
                                          ),
                                          Text(
                                            'Publisher: ${snaphot.data![index].publisherName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: Colors.black),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Spacer(),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                  onTap: () async {
                                                    await showDialog(
                                                        context: context,
                                                        builder: (myFavorite) =>
                                                            FutureProgressDialog(
                                                                saveToFavorite(
                                                                    context:
                                                                        myFavorite,
                                                                    idCourse: widget
                                                                        .ebookId
                                                                        .toString(),
                                                                    idUser:
                                                                        id))).then(
                                                        (value) async {
                                                      preferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      dynamic fav = preferences
                                                          .get('saveFavorite');
                                                      setState(() {
                                                        checkFavorite = fav;
                                                      });
                                                    });
                                                  },
                                                  child: checkFavorite ==
                                                          'already'
                                                      ? Icon(Icons.bookmark,
                                                          color: Colors.blue,
                                                          size: 21.sp)
                                                      : Icon(
                                                          Icons.bookmark_border,
                                                          color: Colors.blue,
                                                          size: 21.sp)),
                                              SizedBox(
                                                width: 1.3.h,
                                              ),
                                              Text(
                                                ' ${snaphot.data![index].pages} pages',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15,
                                                    color: Colors.black),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                width: 1.5.h,
                                              ),
                                              snaphot.data![index].free == 1
                                                  ? Text('Free',
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis)
                                                  : Text('Premium',
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                              Spacer(),
                                              GestureDetector(
                                                onTap: () {
                                                  _share();
                                                },
                                                child: Icon(Icons.share,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 3.h,
                              ),
                              widget.status == 0
                                  ? Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Colors.blue),
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Text(
                                          'Coming Soon',
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.only(left: 14, right: 14),
                                    )
                                  : listDetail[index].free == 1
                                      ? GestureDetector(
                                          onTap: () {
                                            print(
                                                '${snaphot.data![index].pdf}');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SfPdfViewer.network(
                                                    '${Functions.fixImage(snaphot.data![index].pdf)}',
                                                  ),
                                                ));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Colors.blue),
                                            child: Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Text(
                                                  'Read Ebook (Free)',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                )),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.only(
                                                left: 14, right: 14),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SfPdfViewer.network(
                                                    '${Functions.fixImage(snaphot.data![index].pdf)}',
                                                  ),
                                                ));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                color: Colors.blue),
                                            child: Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Text(
                                                  'Read Ebook (Premium)',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                )),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: EdgeInsets.only(
                                                left: 14, right: 14),
                                          ),
                                        ),
                              SizedBox(
                                height: 3.h,
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 3.h),
                                margin: EdgeInsets.symmetric(horizontal: 14),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: Colors.black12),
                                child: Column(
                                  children: [
                                    Text(
                                      'Description',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Html(
                                        data:
                                            '${snaphot.data![index].description}')
                                  ],
                                ),
                              ),
                              SizedBox(height: 3.h)
                            ],
                          );
                        })
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: Colors.blue,
                ),
              );
            },
          ),
        ));
  }
}
