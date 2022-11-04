import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Databse extends ChangeNotifier{
  static getCartItems(){
   return FirebaseFirestore.instance
                        .collection('User')
                        .doc(
                            FirebaseAuth.instance.currentUser!.email.toString())
                        .collection('Cart')
                        .snapshots();
  }
}