import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartTile extends StatefulWidget {
  final String title;
  final String price;
  final String image;
  final String quantity;
  CartTile({Key? key, required this.title, required this.price, required this.image, required this.quantity}) : super(key: key);

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  TextEditingController quantity =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
                BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 2.0,
                spreadRadius: 1.0,
                offset: Offset(1.0, 1.0), // shadow direction: bottom right
            )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(15)
            ),
        child: Row(
                  children: [
                   Column(
                     children: [
                       Container(
                        child: Image.network(widget.image,height: 150,width: 100,)),
                     ],
                   ),
                   SizedBox(width: 10,),
                   Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Container(
                        width: 250,
                        child: Text(widget.title,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.orange,fontFamily : 'roboto',fontSize: 17),),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Rs. ",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'roboto'),),
                            Text(widget.price,style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'roboto'),),
                            SizedBox(width: 140,),
                            
                          ],
                        ),  
                      ),
                      SizedBox(height: 10,),
                        Row(
                          children: [
                            Text('Qty : '),
                            Text(widget.quantity),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: (){
                                showDialog(
                                  context: context, 
                                  builder: (context){
                                    return AlertDialog(
                                      content: TextField(
                                        controller: quantity,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Quantity',
                                          label: Text("Quantity"),
                                          border: OutlineInputBorder()
                                        ),
                                      ),
                                      title: Text("Set Quantity"),
                                      actions: [
                                        MaterialButton(
                                          elevation: 0,
                                          color: Colors.black,
                                          onPressed: (){
                                            Map<String,dynamic> set= {
                                              'Quantity' : quantity.text
                                            };
                                            FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.email.toString()).collection('Cart').doc(widget.title).update(set);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Set",style: TextStyle(color: Colors.white),),
                                          )
                                      ],
                                    );
                                  }
                                  );
                              },
                              child: Icon(Icons.edit)),
                          ],
                        ),
                         Padding(
                           padding: const EdgeInsets.only(left: 150),
                           child: MaterialButton(
                                elevation: 0,
                                color: Colors.black,
                                onPressed: (){
                                     FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.email.toString()).collection('Cart').doc(widget.title).delete();  
                      },child: Icon(Icons.delete,color: Colors.white,),),
                         ),
                    ],
                   )
                  ],
                ),
      ),
    );
  }
}