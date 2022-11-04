import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomcons/Pages/OrderInfoPage.dart';
import 'package:ecomcons/Services/FirebaseProviders.dart';
import 'package:ecomcons/Utils/CartTile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final user = FirebaseAuth.instance.currentUser!;
  int total = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 43, 55, 65),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('User')
                .doc(FirebaseAuth.instance.currentUser!.email.toString())
                .collection('Cart')
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CartTile(
                      title: snapshot.data.docs[index]['Title'],
                      price: snapshot.data.docs[index]['Price'],
                      image: snapshot.data.docs[index]['Image'],
                      quantity: snapshot.data.docs[index]['Quantity'],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                );
              } else {
                return Text("");
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
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
                        total = 0;
                        snapshot.data!.docs.forEach((result) {
                          total += int.parse(result['Price']) *
                              int.parse(result['Quantity']);
                        });
                        return Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              'Total: Rs.${total.toString()}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ));
                      }
                    }),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () {
                     Navigator.of(context).push(MaterialPageRoute(builder: (_)=>OrderInfo()));
                    },
                    child: Text(
                      "Check Out",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
