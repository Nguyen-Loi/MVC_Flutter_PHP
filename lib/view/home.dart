import 'package:card_swiper/card_swiper.dart';
import 'package:ebook_app/controller/con_latest.dart';
import 'package:ebook_app/controller/con_slider.dart';
import 'package:ebook_app/model/model_ebook.dart';
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

  @override
  void initState() {
    super.initState();
    getSlider = fetchSlider(listSlider);
    getLatest = fetchLatest(listLatest);
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
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
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
                                                    overflow: TextOverflow.ellipsis,
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
