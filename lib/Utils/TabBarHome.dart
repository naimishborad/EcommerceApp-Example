
import 'package:flutter/material.dart';

class TabBarHome extends StatelessWidget {
  const TabBarHome({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(isScrollable: true, controller: tabController, tabs: [
       Tab(
        child: Text(
          "All",
          style: TextStyle(color: Colors.white),
        ),
      ),
      Tab(
        child: Text(
          "Clothing",
          style: TextStyle(color: Colors.white),
        ),
      ),
      Tab(
        child: Text(
          "Footwear",
          style: TextStyle(color: Colors.white),
        ),
      ),
      Tab(
        child: Text(
          "Watches",
          style: TextStyle(color: Colors.white),
        ),
      ),
      Tab(
        child: Text(
          "Music",
          style: TextStyle(color: Colors.white),
        ),
      ),
      Tab(
        child: Text(
          "Electronics",
          style: TextStyle(color: Colors.white),
        ),
      ),
      Tab(
        child: Text(
          "More",
          style: TextStyle(color: Colors.white),
        ),
      )
    ]);
  }
}
