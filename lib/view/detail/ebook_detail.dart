import 'package:ebook_app/controller/con_detail.dart';
import 'package:ebook_app/model/functions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'package:ebook_app/model/ebook/model_ebook.dart';

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

  @override
  void initState() {
    super.initState();
    getDetail = fetchDetail(listDetail, widget.ebookId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white70,
          elevation: 0,
          title: Text(
            'Library',
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
                                                onTap: () {},
                                                child: Icon(Icons.bookmark_border)
                                              ),
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
                                              snaphot.data![index].free==1? Text('Free', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                              maxLines: 1,overflow: TextOverflow.ellipsis):Text('Premium', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                                              maxLines: 1,overflow: TextOverflow.ellipsis),
                                              Spacer(),
                                              GestureDetector(
                                                onTap: (){},
                                                child: Icon(
                                                  Icons.share, color: Colors.black
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
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
