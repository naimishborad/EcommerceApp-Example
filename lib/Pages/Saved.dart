import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../Utils/SavedTile.dart';

class Saved extends StatefulWidget {
  Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('Favourite Products',style: TextStyle(color: Colors.black,fontSize: 20),),
        backgroundColor: Colors.transparent,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.email.toString()).collection('Saved').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return ListView.separated(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return SavedTile(
                  title: snapshot.data.docs[index]['Title'], 
                  price: snapshot.data.docs[index]['Price'], 
                  image: snapshot.data.docs[index]['Image']
                  );
              },
              separatorBuilder: (BuildContext context, int index) { 
                                   return SizedBox(height: 10,);
                                 },
              
            );
          } 
          else{
            return Text("");
          }
        },
      ),
    );
  }
}


