import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomcons/Pages/Categories/Category_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Category extends StatefulWidget {
  Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        height: 300,
        child: StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('Category').snapshots(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if(snapshot.hasData){
                              return  SizedBox(
                                height: 400,
                                child: ListView.separated(
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return CategoryTile(
                                        title: snapshot.data.docs[index]['Title'], 
                                        Image: snapshot.data.docs[index]['Image'],
                                        Category: snapshot.data.docs[index]['Category'],
                                        );
                                    }, separatorBuilder: (BuildContext context, int index) { 
                                       return SizedBox(height: 10,);
                                     },
                                  
                                ),
                              );
                            }
                            else{
                              return CircularProgressIndicator();
                            }
                          },
        ),
      ),
    );
  }
}


class CategoryTile extends StatefulWidget {
  final String title;
  final String Image;
  final String Category;
  CategoryTile({Key? key, required this.title, required this.Image, required this.Category}) : super(key: key);

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (){
          Get.to(Category_detail(title:widget.title,Category: widget.Category,),transition: Transition.fade,duration: Duration(seconds: 1));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: 30,   
                child: Text(widget.Category,style: TextStyle(color: Colors.black,fontSize: 17,fontFamily: 'roboto'),)
              ),
              Divider(color: Colors.black,)
            ],
          ),
        ),
    );
  }
}