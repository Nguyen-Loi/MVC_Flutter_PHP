import 'package:ebook_app/controller/con_latest.dart';
import 'package:ebook_app/controller/con_pdf_by_cat.dart';
import 'package:ebook_app/model/ebook/model_ebook.dart';
import 'package:ebook_app/model/function/functions.dart';
import 'package:ebook_app/view/detail/ebook_detail.dart';
import 'package:ebook_app/widget/ebook_routes.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EbookCategory extends StatefulWidget {
  int catId;
  EbookCategory({required this.catId});

  @override
  State<EbookCategory> createState() => _BotttomLibraryState();
}

class _BotttomLibraryState extends State<EbookCategory> {
  late Future<List<ModelEbook>> getCategory;
  List<ModelEbook> listBookOfCategory = [];

  @override
  void initState() {
    super.initState();
    getCategory = fetchByCategory(listBookOfCategory, widget.catId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        title: Text(
          'Category',
          style: TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
            child: FutureBuilder<List<ModelEbook>>(
                future: getCategory,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: 5.5 / 9.0),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                pushPage(
                                    context,
                                    EbookDetail(
                                        ebookId: snapshot.data![index].id,
                                        status:
                                            snapshot.data![index].statusNews));
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        Functions.fixImage(
                                            snapshot.data![index].photo),
                                        fit: BoxFit.contain,
                                        height: 15.h,
                                        width: 24.w,
                                      ),
                                    ),
                                    SizedBox(height: 0.7),
                                    Container(
                                      width: 24.w,
                                      child: Text(
                                        snapshot.data![index].title,
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              ));
                        });
                  }
                  return Center(
                    child: CircularProgressIndicator(
                        strokeWidth: 1.5, color: Colors.blue),
                  );
                })),
      ),
    );
  }
}
