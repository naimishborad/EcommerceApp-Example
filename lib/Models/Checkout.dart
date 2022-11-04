import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Checkout extends Equatable{
  final String fullName;
  final String email;
  final String address;
  final String city;
  final String zipCode;
  final String phoneNo;
  final List<DocumentSnapshot> products;
  final String? subTotal;
  final String deleveryFee;
  final String total;

  Checkout(this.fullName, this.email, this.address, this.city, this.zipCode, this.phoneNo, this.products, this.subTotal, this.deleveryFee, this.total);
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    fullName,
    email,
    address,
    city,
    zipCode,
    phoneNo,
    products,
    subTotal,
    deleveryFee,
    total
  ];
  // Map<String,dynamic> toDocument(){
  //   Map 
  // }
}