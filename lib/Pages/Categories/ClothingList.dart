
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/ProductTile.dart';
import '../DetailPage.dart';

class ClothingList extends StatelessWidget {
  const ClothingList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Products')
          .where('Category', isEqualTo: 'Cloathing').where('InStock',isEqualTo: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
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
    );
  }
}
