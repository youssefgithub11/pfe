import 'dart:convert';

import 'package:auth/models/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;


class OrderItem{
   final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  

  OrderItem({
    @required this.id, 
   @required  this.amount, 
   @required this.products, 
   @required this.dateTime, 
   
});

}

class Orders with ChangeNotifier{
List<OrderItem> _orders =[ ];

String authToken;
String userId;

getData(String authToken,String uId , List<OrderItem> orders){
  authToken = authToken ; 
  userId = uId;
  _orders = orders;
  notifyListeners();
}
List<OrderItem> get orders{
  return [..._orders];
}
Future<void> fetchAndSetOrders ()async{
// ajouter a mon carte les offres 
 var url ="https://sotetel-shop-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken&filteredString";

 try{
 final res = await http.get(url);
 final extractData = json.decode(res.body) as Map<String, dynamic>;
 if(extractData == null){
  return;
 }
 

final List<OrderItem> loadedOrders = [];
extractData.forEach((orderId, orderData) { 
loadedOrders.add(
  OrderItem(
    id: orderId, 
amount: orderData['amount'],
  dateTime: DateTime.parse(orderData['dateTime']),
  products:(orderData['products'] as List<dynamic>)
  .map((item) => CartItem(
    id: item ['id'], 
    title: item ['title'], 
    quantity:item ['quantity'],
     price:item ['price']
     ))
     .toList(),

  ),
);
});
_orders = loadedOrders.reversed.toList();
notifyListeners();
   
}catch(e){
  throw e; 

}}
}