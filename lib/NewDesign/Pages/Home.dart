import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomcons/NewDesign/Pages/CartPage.dart';
import 'package:ecomcons/Pages/Categories/All.dart';
import 'package:ecomcons/Pages/Categories/ClothingList.dart';
import 'package:ecomcons/Pages/Order.dart';
import 'package:ecomcons/Pages/Saved.dart';
import 'package:ecomcons/Services/AuthProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Pages/Categories/Acessories.dart';
import '../../Pages/Categories/Category.dart';
import '../../Pages/Categories/ElectronicsList.dart';
import '../../Pages/Categories/FootwearList.dart';
import '../../Pages/Categories/MusicList.dart';

class NhomePage extends StatefulWidget {
  NhomePage({Key? key}) : super(key: key);

  @override
  State<NhomePage> createState() => _NhomePageState();
}

class _NhomePageState extends State<NhomePage> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 7, vsync: this);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Ecommerce App"),
        actions: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    FirebaseAuth.instance.currentUser!.photoURL.toString()),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              Container(
                padding: EdgeInsets.all(15),
                child: Wrap(
                  runSpacing: 0,
                  children: [
                    ListTile(
                      leading: Icon(Icons.home_outlined),
                      title: Text("Home"),
                      onTap: () {
                        
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.favorite_border),
                      title: Text("Favourits"),
                      onTap: () {
                        Get.to(Saved(),transition: Transition.rightToLeft,duration: Duration(seconds: 1));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_cart_outlined),
                      title: Text("Cart"),
                      onTap: () {
                        Get.to(NCartPage(),transition: Transition.rightToLeft,duration: Duration(seconds: 1));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.shopping_bag_outlined),
                      title: Text("Orders"),
                      onTap: () {
                        Get.to(OrderPage(),transition: Transition.rightToLeft,duration: Duration(seconds: 1));
                      },
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                    ListTile(
                      leading: Icon(Icons.person_outline_outlined),
                      title: Text("Profile"),
                      onTap: () {
                        
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.settings_outlined),
                      title: Text("Settings"),
                      onTap: () {
                        
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout_outlined),
                      title: Text("Logout"),
                      onTap: () {
                        final provider = Provider.of<AuthProvider>(context,listen: false);
                        provider.signOut();
                      },
                    )
                  ],
                ),
              )
            ],  
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1)),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        width: 300,
                        child: TextField(
                          decoration: InputDecoration(
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.normal),
                              border: InputBorder.none,
                              hintText: "Search Products"),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 250,
              // color: Colors.amber,
              child: CarouselSlider(
                items: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://sp.yimg.com/ib/th?&id=ODL.e6db74fa3c8dabc985f36a39957a3d1b"))),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://images.pexels.com/photos/19090/pexels-photo.jpg?cs=srgb&dl=fashion-footwear-shoes-19090.jpg&fm=jpg"))),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://tse1.mm.bing.net/th?id=OIP.t0gayE0LXgL9cdP3XVeBuwHaE7&pid=Api&P=0"))),
                  ),
                ],
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
            ),
            TabBar(isScrollable: true, controller: tabController, tabs: [
              Tab(
                child: Text(
                  "All",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Clothing",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Footwear",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Watches",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Music",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Electronics",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "More",
                  style: TextStyle(color: Colors.black),
                ),
              )
            ]),
            SizedBox(
              height: 7,
            ),
            Container(
              height: 400,
              child: TabBarView(controller: tabController, children: [
                AllProducts(),
                ClothingList(),
                FootwearList(),
                AcessoriesList(),
                MusicList(),
                ElectronicsList(),
                Category()
              ]),
            )
          ],
        ),
      ),
    );
  }
  Widget buildHeader(BuildContext context){
    return Container(
      color: Colors.orange,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        children: [
          CircleAvatar(
            radius: 52,
            backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL.toString()),
          ),
          SizedBox(height: 12,),
          Text(FirebaseAuth.instance.currentUser!.displayName.toString(),style: TextStyle(color: Colors.white),),
          SizedBox(height: 8,),
          Text(FirebaseAuth.instance.currentUser!.email.toString(),style: TextStyle(color: Colors.white),),
          SizedBox(height: 15,)
        ],
      ),
    );
  }
}
