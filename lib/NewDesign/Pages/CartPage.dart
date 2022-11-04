import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:get/get.dart';

import '../../Pages/OrderInfoPage.dart';
import '../../Services/FirebaseProviders.dart';

class NCartPage extends StatefulWidget {
  NCartPage({Key? key}) : super(key: key);

  @override
  State<NCartPage> createState() => _NCartPageState();
}

class _NCartPageState extends State<NCartPage> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Cart"),
      ),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('User')
              .doc(FirebaseAuth.instance.currentUser!.email.toString())
              .collection('Cart')
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 2.0,
                            spreadRadius: 1.0,
                            offset: Offset(
                                1.0, 1.0), // shadow direction: bottom right
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                child: Image.network(
                                    snapshot.data.docs[index]["Image"]),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Container(
                                  height: 150,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        snapshot.data.docs[index]["Title"],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text("Rs: "),
                                          Text(snapshot.data.docs[index]
                                              ["Price"])
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text("Qty :  "),
                                          Text(snapshot.data.docs[index]
                                              ["Quantity"])
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                    barrierColor:
                                                        Colors.transparent,
                                                    backgroundColor:
                                                        Colors.white,
                                                    elevation: 10,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0),
                                                    ),
                                                    context: context,
                                                    builder: (context) {
                                                      return SizedBox(
                                                        height: 500,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 15,
                                                              ),
                                                              Container(
                                                                height: 200,
                                                                width: 200,
                                                                child: Image.network(snapshot
                                                                            .data
                                                                            .docs[
                                                                        index]
                                                                    ["Image"]),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(snapshot.data
                                                                          .docs[
                                                                      index]
                                                                  ["Title"]),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Rs :  ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .orange,
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                  Text(
                                                                      snapshot.data
                                                                              .docs[index]
                                                                          [
                                                                          "Price"],
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .orange,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    "Quantity :  ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            15),
                                                                  ),
                                                                  CustomNumberPicker(
                                                                    valueTextStyle:
                                                                        TextStyle(
                                                                            fontSize:
                                                                                18),
                                                                    customAddButton:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              10),
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.orange,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          "+",
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    customMinusButton:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              10),
                                                                      child:
                                                                          Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        width:
                                                                            50,
                                                                        height:
                                                                            30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Colors.red,
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          "-",
                                                                          style: TextStyle(
                                                                              fontSize: 20,
                                                                              color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    initialValue:
                                                                        int.parse(snapshot
                                                                            .data
                                                                            .docs[index]["Quantity"]),
                                                                    maxValue:
                                                                        10,
                                                                    minValue: 1,
                                                                    step: 1,
                                                                    onValue:
                                                                        (value) {
                                                                      // print(value
                                                                      //     .toString());
                                                                        setState(() {
                                                                          qty = int.parse(value.toString());
                                                                        });
                                                                        print(qty);
                                                                          //  FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser!.email).collection("Cart").doc(snapshot.data.docs[index]["Title"].toString()).update({
                                                                          //     "Quantity": value.toString()
                                                                          //   });
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  MaterialButton(
                                                                    color: Colors.orange,
                                                                    minWidth: 100,
                                                                    elevation: 0,
                                                                      onPressed:
                                                                          () {
                                                                            FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser!.email).collection("Cart").doc(snapshot.data.docs[index]["Title"].toString()).update({
                                                                              "Quantity": qty.toString()
                                                                            }).then((value) => Navigator.pop(context));
                                                                          },
                                                                      child: Text(
                                                                          "Save")),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance
                                                    .collection("User")
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.email
                                                        .toString())
                                                    .collection("Cart")
                                                    .doc(snapshot.data
                                                        .docs[index]["Title"])
                                                    .delete();
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Text("Nothing to show here.....");
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder(
                    stream: Databse.getCartItems(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else {
                        int total = 0;
                        snapshot.data!.docs.forEach((result) {
                          total += int.parse(result['Price']) *
                              int.parse(result['Quantity']);
                        });
                        return Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              'Total: Rs.${total.toString()}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ));
                      }
                    }),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: Colors.white),
                    onPressed: () {
                      Get.to(OrderInfo(),transition: Transition.fade,duration: Duration(seconds: 2));
                    },
                    child: Text(
                      "Check Out",
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
