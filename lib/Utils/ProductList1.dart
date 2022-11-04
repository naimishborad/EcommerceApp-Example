import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomcons/Pages/DetailPage.dart';
import 'package:flutter/material.dart';

import 'ProductTile.dart';

class ProductList extends StatefulWidget {
  ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Products').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){
                          return  SizedBox(
                            height: 400,
                            child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ProductTile(
                                 
                                    image: snapshot.data.docs[index]['Image'],
                                    title: snapshot.data.docs[index]['Title'],
                                    price: snapshot.data.docs[index]['Price'],
                                    callback: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (_)=>
                                      DetailPage(
                                        Title: snapshot.data.docs[index]['Title'], 
                                        Image: snapshot.data.docs[index]['Image'], 
                                        Dec: snapshot.data.docs[index]['Dec'], 
                                        Price: snapshot.data.docs[index]['Price'], 
                                        Category: snapshot.data.docs[index]['Category']
                                        )));
                                    }
                                  );
                                }, separatorBuilder: (BuildContext context, int index) { 
                                   return SizedBox(height: 10,);
                                 },
                              
                            ),
                          );
                        }
                        else{
                          return Text("Loading....");
                        }
                      },
    );
  }
}