import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomcons/Utils/AllTiletest.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/ProductTile.dart';
import '../DetailPage.dart';

class AllProducts extends StatefulWidget {
  AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> { 
  final ScrollController  scrollController = ScrollController();
  void onListen(){
    setState(() {
      
    });
  }
  @override
  void initState() {
    scrollController.addListener(onListen);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.removeListener(onListen);
    super.dispose();
  }
  final itemSize = 150;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Products').where('InStock',isEqualTo: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: 1000,
            child: ListView.separated(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                 final item = snapshot.data.docs[index];
                 final itemPositionOffset = index * itemSize;
                 final diffrence = scrollController.offset - itemPositionOffset;
                 final percent = 1- (diffrence / itemSize);
                 double opacity = percent;
                 if(percent > 1.0) opacity =1.0;
                 if(opacity <0.0) opacity = 0.0;
                return AllTile(
                  
                  opacity: opacity,
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
          return Center(child: Text("Loading....",style: TextStyle(color: Colors.white),));
        }
      },
    );;
  }
}