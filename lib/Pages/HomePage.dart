import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomcons/Pages/Categories/All.dart';
import 'package:ecomcons/Pages/Categories/Category.dart';
import 'package:ecomcons/Utils/ProductList1.dart';
import 'package:flutter/material.dart';

import '../Utils/ProductTile.dart';
import '../Utils/TabBarHome.dart';
import 'Categories/Acessories.dart';
import 'Categories/ClothingList.dart';
import 'Categories/ElectronicsList.dart';
import 'Categories/FootwearList.dart';
import 'Categories/MusicList.dart';
import 'DetailPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 7, vsync: this);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 43, 55, 65),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Shopping App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 43, 55, 65),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBarHome(tabController: tabController),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                AllProducts(),
                ClothingList(),
                FootwearList(),
                AcessoriesList(),
                MusicList(),
                ElectronicsList(),
                Category()
              ]),
            ),
           
          ],
        ),
      ),
    );
  }
}
