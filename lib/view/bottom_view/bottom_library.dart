import 'package:ebook_app/controller/con_latest.dart';
import 'package:ebook_app/model/ebook/model_ebook.dart';
import 'package:ebook_app/model/functions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BotttomLibrary extends StatefulWidget {
  BotttomLibrary({Key? key}) : super(key: key);

  @override
  State<BotttomLibrary> createState() => _BotttomLibraryState();
}

class _BotttomLibraryState extends State<BotttomLibrary> {
  late Future<List<ModelEbook>> getLatest;
  List<ModelEbook> listLatest = [];

  @override
  void initState() {
    super.initState();
    getLatest = fetchLatest(listLatest);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        title: Text(
          'Library',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
            child: FutureBuilder<List<ModelEbook>>(
                future: getLatest,
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
                              onTap: () {},
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
                                      child: Text(snapshot.data![index].title, style: TextStyle(
                                        color: Colors.black,
                                        
                                      ),maxLines: 2,overflow: TextOverflow.ellipsis,),
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
