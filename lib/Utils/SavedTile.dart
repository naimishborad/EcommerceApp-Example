import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SavedTile extends StatefulWidget {
  final String title;
  final String price;
  final String image;
  SavedTile(
      {Key? key, required this.title, required this.price, required this.image})
      : super(key: key);

  @override
  State<SavedTile> createState() => _SavedTileState();
}

class _SavedTileState extends State<SavedTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 2.0,
            spreadRadius: 1.0,
            offset: Offset(1.0, 1.0), // shadow direction: bottom right
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                    child: Image.network(
                  widget.image,
                  height: 150,
                  width: 100,
                )),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                    ),
                    IconButton(
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('User')
                              .doc(FirebaseAuth.instance.currentUser!.email
                                  .toString())
                              .collection('Saved')
                              .doc(widget.title)
                              .delete();
                        },
                        icon: Icon(Icons.star))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 250,
                  child: Text(
                    widget.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.orange,
                        fontFamily: 'roboto',
                        fontSize: 17),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Rs. ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'roboto'),
                      ),
                      Text(
                        widget.price,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'roboto'),
                      ),
                      SizedBox(
                        width: 140,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 170),
                  child: MaterialButton(
                    elevation: 0,
                    color: Colors.black,
                    onPressed: () {},
                    child: Icon(
                      Icons.add_shopping_cart_rounded,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
