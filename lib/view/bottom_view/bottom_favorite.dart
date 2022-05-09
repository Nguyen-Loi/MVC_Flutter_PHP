import 'package:ebook_app/controller/con_favorite.dart';
import 'package:ebook_app/controller/con_latest.dart';
import 'package:ebook_app/model/ebook/model_ebook.dart';
import 'package:ebook_app/model/function/functions.dart';
import 'package:ebook_app/view/detail/ebook_detail.dart';
import 'package:ebook_app/widget/common_pref.dart';
import 'package:ebook_app/widget/ebook_routes.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BotttomFavorite extends StatefulWidget {
  @override
  State<BotttomFavorite> createState() => _BotttomFavoriteState();
}

class _BotttomFavoriteState extends State<BotttomFavorite> {
 Future<List<ModelEbook>>? getFavorite;
  List<ModelEbook> listFavorite = [];

  String id = '', name = '', email = '';

  @override
  void initState() {
    super.initState();
      
    loadLogin().then((value) {
      setState(() {
        id = value[0];
        name = value[1];
        email = value[2];
        getFavorite = fetchFavorite(listFavorite, id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        title: Text(
          'Favorite',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
            child: FutureBuilder<List<ModelEbook>>(
                future: getFavorite,
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
