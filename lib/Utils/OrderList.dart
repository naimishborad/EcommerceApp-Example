

import 'package:ecomcons/Models/Order.dart';
import 'package:flutter/material.dart';

class OrderList extends StatefulWidget {
  final List<Order> orders;
  OrderList({Key? key, required this.orders}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: ((context, index) {
        return SizedBox(height: 10,);
      }),
      itemCount: widget.orders.length.toInt(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                
                Column(
                  children: [
                    Container(
                        child: Image.network(
                      widget.orders[index].image,
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
                    Container(
                      width: 250,
                      child: Text(
                        widget.orders[index].title,
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
                            widget.orders[index].price,
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
                    
                  ],
                )
              ],
            ));
      },
    );
  }
}

