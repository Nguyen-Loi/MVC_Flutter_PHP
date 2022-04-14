import 'package:card_swiper/card_swiper.dart';
import 'package:ebook_app/controller/con_category.dart';
import 'package:ebook_app/controller/con_coming.dart';
import 'package:ebook_app/controller/con_latest.dart';
import 'package:ebook_app/controller/con_slider.dart';
import 'package:ebook_app/model/category/model_category.dart';
import 'package:ebook_app/model/ebook/model_ebook.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:ebook_app/model/functions.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<ModelEbook>> getSlider;
  List<ModelEbook> listSlider = [];

  late Future<List<ModelEbook>> getLatest;
  List<ModelEbook> listLatest = [];

  late Future<List<ModelEbook>> getComing;
  List<ModelEbook> listComing = [];

  late Future<List<ModelCategory>> getCategory;
  List<ModelCategory> listCategory = [];

  @override
  void initState() {
    super.initState();
    getSlider = fetchSlider(listSlider);
    getLatest = fetchLatest(listLatest);
    getComing = fetchComing(listComing);
    getCategory = fetchCategory(listCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: getSlider,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ModelEbook>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      //*Slider
                      Container(
                        child: FutureBuilder<List<ModelEbook>>(
                            future: getSlider,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                //Create design in here
                                return SizedBox(
                                  height: 27.0.h,
                                  child: Swiper(
                                      itemCount: snapshot.data!.length,
                                      autoplay: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Container(
                                              child: Stack(children: [
                                                ClipRRect(
                                                  child: Image.network(
                                                      Functions.fixImage(
                                                          snapshot.data![index]
                                                              .photo),
                                                      fit: BoxFit.fill,
                                                      width: 100.0.w),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  15),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  15),
                                                        ),
                                                        gradient:
                                                            LinearGradient(
                                                                end: Alignment(
                                                                    0.0, -1),
                                                                begin:
                                                                    Alignment(
                                                                        0, 0.2),
                                                                colors: [
                                                              Colors.black54,
                                                              Colors.black
                                                                  .withOpacity(
                                                                      0.1),
                                                            ])),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      child: Text(
                                                        snapshot
                                                            .data![index].title,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 17,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              }
                              return Container();
                            }),
                      ),
                      //* Latest book
                      Container(
                        child: FutureBuilder<List<ModelEbook>>(
                          future: getLatest,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      'Latest book',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 27.h,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index == snapshot.data!.length) {
                                          return GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                                width: 24.w,
                                                padding:
                                                    EdgeInsets.only(top: 15.w),
                                                child: Text(
                                                  'See All',
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 16),
                                                  textAlign: TextAlign.center,
                                                )),
                                          );
                                        }
                                        return GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.all(6),
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    Functions.fixImage(snapshot
                                                        .data![index].photo),
                                                    fit: BoxFit.cover,
                                                    height: 15.h,
                                                    width: 24.w,
                                                  ),
                                                ),
                                                SizedBox(height: 0.5.h),
                                                Container(
                                                  width: 24.w,
                                                  child: Text(
                                                    snapshot.data![index].title,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                      ),
                      //* Cooming soon
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: FutureBuilder<List<ModelEbook>>(
                            future: getComing,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return snapshot.data!.length == 0
                                    ? Container()
                                    : Container(
                                        color: Colors.blueGrey.withOpacity(0.5),
                                        padding: EdgeInsets.only(top: 2.0.h),
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5.h),
                                                  child: Text(
                                                    'Coming soon',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 35,
                                                        letterSpacing: 10),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height: 24.h,
                                                child: ListView.builder(
                                                    itemCount:
                                                        snapshot.data!.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {},
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Image
                                                                    .network(
                                                                  Functions.fixImage(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .photo),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 15.h,
                                                                  width: 24.w,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      0.5.h),
                                                              Container(
                                                                width: 24.w,
                                                                child: Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .title,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }))
                                          ],
                                        ),
                                      );
                              }
                              return Container();
                            }),
                      ),
                      //*Category
                      Container(
                        child: FutureBuilder<List<ModelCategory>>(future: getCategory,builder: (context, snapshot){
                          if(snapshot.connectionState==ConnectionState.done){
                            return Column(
                              children: [
                                Padding(padding: EdgeInsets.all(8), child: Text('Category', style: TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.black
                                ),),),
                                SizedBox(
                                  height: 14.h,
                                  child: ListView.builder(shrinkWrap: true,itemCount: snapshot.data!.length,scrollDirection: Axis.horizontal, itemBuilder: (context, index){
                                    return GestureDetector(
                                             onTap: (){},
                                             child: Container(
                                               padding: EdgeInsets.all(5.0),
                                               child: Stack(
                                                 children: [
                                                   ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Image
                                                                    .network(
                                                                  Functions.fixImage(
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .photoCat),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 15.h,
                                                                  width: 24.w,
                                                                ),
                                                              )
                                                 ],
                                               ),
                                             ),
                                    );
                                  }),
                                )
                                
                              ],
                            );
                          }
                          return Container();
                        },
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: Text('Loading'),
                );
              }),
        ),
      ),
    );
  }
}
