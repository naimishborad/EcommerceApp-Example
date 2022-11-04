import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomcons/Pages/Order.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderInfo extends StatefulWidget {
  OrderInfo({Key? key}) : super(key: key);

  @override
  State<OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
 
  int total = 0;
  Random random = new Random();
  final formkey = GlobalKey<FormState>();
  String _value = 'Cash On Delivey';
  TextEditingController nameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int randomNumber = random.nextInt(1000000);
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 43, 55, 65),
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Enter Information',
          style: TextStyle(color: Colors.black, fontFamily: 'roboto'),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        
        child: MaterialButton(
          onPressed: () async {
            if (formkey.currentState!.validate()) {
              final user = FirebaseAuth.instance.currentUser!;
              QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                  .collection('User')
                  .doc(user.email)
                  .collection('Cart')
                  .get();

              querySnapshot.docs.forEach((result) {
                total +=
                    int.parse(result['Price']) * int.parse(result['Quantity']);
              });
              final allData =
                  querySnapshot.docs.map((doc) => doc.data()).toList();
              final String format = DateFormat('y-MM-d').format(DateTime.now());
              Map<String, dynamic> orders = {
                'Orders': allData,
                'User' : user.displayName,
                'Name': nameController.text,
                'Block':blockController.text,
                'City':cityController.text,
                'Street':streetController.text,
                'Landmark' : landmarkController.text,
                'State': stateController.text,
                'Pincode':pincodeController.text,
                'Email': emailController.text,
                'Phone': phoneController.text,
                'Payment': _value,
                'Total': total,
                'OrderNumber': randomNumber,
                'Date': format,
                'Status' : 'pending'
              };
              FirebaseFirestore.instance
                  .collection('User')
                  .doc(user.email)
                  .collection('Orders')
                  .doc(randomNumber.toString())
                  .set(orders);


              FirebaseFirestore.instance
                  .collection('AllOrders')
                  .doc(randomNumber.toString())
                  .set(orders);

              FirebaseFirestore.instance
                  .collection('User')
                  .doc(user.email)
                  .collection('Cart')
                  .get()
                  .then((value) {
                for (DocumentSnapshot ds in value.docs) {
                  ds.reference.delete();
                }
              });
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => OrderPage()));
            }
            
          },
          child: Text(
            'Place Order',
            style: TextStyle(color: Colors.orange, fontSize: 20),
          ),
        ),
      ),
      
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter correct value";
                        }
                      },
                      controller: nameController,
                      style: TextStyle(color: Colors.orange),
                      decoration: InputDecoration(
                          prefixIconColor: Colors.orange,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          hintText: 'Enter Your Full Name',
                          label: Text(
                            'Name',
                            style: TextStyle(color: Colors.orange),
                          ),
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: blockController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter correct value";
                        }
                      },
                      style: TextStyle(color: Colors.orange),
                      decoration: InputDecoration(
                          prefixIconColor: Colors.orange,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(
                            Icons.house,
                            color: Colors.black,
                          ),
                          hintText: 'Enter Your Block/House',
                          label: Text(
                            'Block No/Name',
                            style: TextStyle(color: Colors.orange),
                          ),
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: streetController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter correct value";
                        }
                      },
                      style: TextStyle(color: Colors.orange),
                      decoration: InputDecoration(
                          prefixIconColor: Colors.orange,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(
                            Icons.streetview,
                            color: Colors.black,
                          ),
                          hintText: 'Enter Your Street',
                          label: Text(
                            'Street',
                            style: TextStyle(color: Colors.orange),
                          ),
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: landmarkController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter correct value";
                        }
                      },
                      style: TextStyle(color: Colors.orange),
                      decoration: InputDecoration(
                          prefixIconColor: Colors.orange,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(
                            Icons.landscape,
                            color: Colors.black,
                          ),
                          hintText: 'Enter landmark near you',
                          label: Text(
                            'Landmark',
                            style: TextStyle(color: Colors.orange),
                          ),
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: cityController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter correct value";
                        }
                      },
                      style: TextStyle(color: Colors.orange),
                      decoration: InputDecoration(
                          prefixIconColor: Colors.orange,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(
                            Icons.location_city,
                            color: Colors.black,
                          ),
                          hintText: 'Enter Your City',
                          label: Text(
                            'City',
                            style: TextStyle(color: Colors.orange),
                          ),
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: stateController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter correct value";
                        }
                      },
                      style: TextStyle(color: Colors.orange),
                      decoration: InputDecoration(
                          prefixIconColor: Colors.orange,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(
                            Icons.location_city,
                            color: Colors.black,
                          ),
                          hintText: 'Enter Your State',
                          label: Text(
                            'State',
                            style: TextStyle(color: Colors.orange),
                          ),
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: pincodeController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter correct value";
                        }
                      },
                      style: TextStyle(color: Colors.orange),
                      decoration: InputDecoration(
                          prefixIconColor: Colors.orange,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(
                            Icons.pin,
                            color: Colors.black,
                          ),
                          hintText: 'Enter Your Pincode',
                          label: Text(
                            'Pincode',
                            style: TextStyle(color: Colors.orange),
                          ),
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return "Enter correct email";
                        }
                      },
                      style: TextStyle(color: Colors.orange),
                      decoration: InputDecoration(
                          prefixIconColor: Colors.orange,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          hintText: 'Enter Your Email',
                          label: Text(
                            'Email',
                            style: TextStyle(color: Colors.orange),
                          ),
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter correct phone";
                        }
                      },
                      controller: phoneController,
                      style: TextStyle(color: Colors.orange),
                      decoration: InputDecoration(
                          prefixIconColor: Colors.orange,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          hintText: 'Enter Your Phone Number',
                          label: Text(
                            'Phone Number',
                            style: TextStyle(color: Colors.orange),
                          ),
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.5)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    'Mode Of Payment',
                    style: TextStyle(
                        
                        fontSize: 20,
                        fontFamily: 'roboto'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio(
                                value: 'Cash On Delivery',
                                groupValue: _value,
                                onChanged: (value) {
                                  setState(() {
                                    _value = value as String;
                                  });
                                }),
                            Text('Cash On Delivery')
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 'Upi',
                                groupValue: _value,
                                onChanged: (value) {
                                  setState(() {
                                    _value = value as String;
                                  });
                                }),
                            Text('Upi')
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 'Card',
                                groupValue: _value,
                                onChanged: (value) {
                                  setState(() {
                                    _value = value as String;
                                  });
                                }),
                            Text('Card')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
