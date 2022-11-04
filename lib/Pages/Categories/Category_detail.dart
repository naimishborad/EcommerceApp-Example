import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomcons/Utils/ProductTile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../DetailPage.dart';

class Category_detail extends StatefulWidget {
  final String title;
  final String Category;
  Category_detail({Key? key, required this.title, required this.Category})
      : super(key: key);

  @override
  State<Category_detail> createState() => _Category_detailState();
}

class _Category_detailState extends State<Category_detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 43, 55, 65),
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Products')
            .where('Category', isEqualTo: widget.Category)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 1000,
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductTile(
                      image: snapshot.data.docs[index]['Image'],
                      title: snapshot.data.docs[index]['Title'],
                      price: snapshot.data.docs[index]['Price'],
                    
                      callback: () {
                        Get.to(DetailPage(
                              Title: snapshot.data.docs[index]
                                  ['Title'],
                              Image: snapshot.data.docs[index]
                                  ['Image'],
                              Dec: snapshot.data.docs[index]['Dec'],
                              Price: snapshot.data.docs[index]
                                  ['Price'],
                              Category: snapshot.data.docs[index]
                                  ['Category']),transition: Transition.fade,duration: Duration(seconds: 1));
                      });
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10,
                  );
                },
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      )),
    );
  }
}
