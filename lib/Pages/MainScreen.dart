import 'package:ecomcons/Pages/Cart.dart';
import 'package:ecomcons/Pages/HomePage.dart';
import 'package:ecomcons/Pages/Order.dart';
import 'package:ecomcons/Pages/Saved.dart';
import 'package:flutter/material.dart';

import 'Settings.dart';

class Main extends StatefulWidget {
  Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  int curruntTab = 0;

  final List<Widget> screens = [
    HomePage(),
    Saved(),
    Cart(),
    Settings()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget curruntscreen = HomePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: curruntscreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          color:  Color.fromARGB(255, 43, 55, 65),
          child: Row(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10,),
                  MaterialButton(
                    onPressed: (){
                      setState(() {
                      curruntscreen =HomePage();
                      curruntTab = 0;
                    });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.dashboard,color: curruntTab==0?Colors.orange:Colors.grey),
                        Text("Home",style: TextStyle(color: curruntTab==0?Colors.orange:Colors.grey),)
                      ],
                    ),
                    minWidth: 40,
                  ),
                  SizedBox(width: 30,),
                  MaterialButton(
                    onPressed: (){
                      setState(() {
                      curruntscreen = Saved();
                      curruntTab = 1 ;
                    });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star,color: curruntTab==1?Colors.orange:Colors.grey),
                        Text("Saved",style: TextStyle(color: curruntTab==1?Colors.orange:Colors.grey),)
                      ],
                    ),
                    minWidth: 40,
                  )
                ],
              ),
              SizedBox(width: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MaterialButton(
                    onPressed: (){
                      setState(() {
                      curruntscreen = Cart();
                      curruntTab = 3;
                    });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart,color: curruntTab==3?Colors.orange:Colors.grey),
                        Text("Cart",style: TextStyle(color: curruntTab==3?Colors.orange:Colors.grey),)
                      ],
                    ),
                    minWidth: 40,
                  ),
                  SizedBox(width: 25,),
                  MaterialButton(
                    onPressed: (){
                      setState(() {
                      curruntscreen = OrderPage();
                      curruntTab = 4 ;
                    });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings,color: curruntTab==4?Colors.orange:Colors.grey),
                        Text("Orders",style: TextStyle(color: curruntTab==4?Colors.orange:Colors.grey),)
                      ],
                    ),
                    minWidth: 40,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
