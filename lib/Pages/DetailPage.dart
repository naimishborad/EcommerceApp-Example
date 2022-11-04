import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String Title;
  final String Image;
  final String Dec;
  final String Price;
  final String Category;
  DetailPage(
      {Key? key,
      required this.Title,
      required this.Image,
      required this.Dec,
      required this.Price,
      required this.Category})
      : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 43, 55, 65),
      backgroundColor: Colors.white,

      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                      child: Container(
                        child: Image.network(
                    widget.Image,
                    height: 300,
                    width: 300,
                  ),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: Colors.orange[100]),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: Column(
                        children: [
                          Text(
                            widget.Title,
                            style: TextStyle(
                              color: Colors.blueGrey[600],
                              fontFamily: 'roboto',
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Category :  ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'cool',
                                    fontSize: 22),
                              ),
                              Text(
                                widget.Category,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'cool',
                                    fontSize: 22),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Description:",
                                  style: TextStyle(
                                      fontFamily: 'roboto', fontSize: 18),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.Dec,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'louis'),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 20,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context, 
                                        builder: (context){
                                          return SizedBox(
                                            height: 600,
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(15.0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Description: "
                                                    ),
                                                    SizedBox(height: 10,),
                                                    Text(
                                                      widget.Dec
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );  
                                        });
                                    },
                                    child: Text(
                                      "Tap for more...",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontSize: 15,
                                          fontFamily: 'roboto'),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          //   Padding(
          //     padding: const EdgeInsets.only(bottom: 20,left: 9,right: 9),
          //     child: Container(
          //     height: 70,
          //     width: 500,
          //     decoration: BoxDecoration(
          //       color: Colors.orange,
          //       borderRadius: BorderRadius.circular(18)
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 15),
          //       child: Row(
          //         children: [
          //           Text(
          //             "Price: ",
          //             style: TextStyle(
          //               fontSize: 20
          //             ),
          //           ),
          //           Text(
          //             widget.Price,
          //             style: TextStyle(
          //               fontSize: 20
          //             ),
          //           ),
          //           Spacer(),
          //           Container(
          //             height: 40,
          //             width: 80,
          //             decoration: BoxDecoration(
          //               color: Colors.orange,
          //               borderRadius: BorderRadius.circular(10)
          //             ),
          //             child: Icon(Icons.add_shopping_cart),
          //           )
          //         ],
          //       ),
          //     ),
          // ),
          //   ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70,
          width: 500,
          decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  "Price: ",
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  widget.Price,
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      barrierColor: Colors.transparent,
                      backgroundColor: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 400,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text('Coming Soon'),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                    // DocumentReference documentReference =
                    //             FirebaseFirestore.instance
                    //                 .collection('User')
                    //                 .doc(FirebaseAuth.instance.currentUser!.email
                    //                     .toString())
                    //                 .collection('Cart')
                    //                 .doc(widget.Title);
                    //         Map<String, dynamic> add = {
                    //           'Title': widget.Title.toString(),
                    //           'Price': widget.Price.toString(),
                    //           'Image': widget.Image.toString(),
                    //           'Quantity' : 1.toString()
                    //         };
                    //         documentReference.set(add);
                  },
                  child: Container(
                    height: 40,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(Icons.add_shopping_cart),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
