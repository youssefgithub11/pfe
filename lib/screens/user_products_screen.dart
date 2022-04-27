import 'package:auth/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
class UserProductsScreen  extends StatelessWidget {
 static const routeName ='/user-products-screen';




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("UserProductsScreen")),
      body: Center(child: Text('UserProductsScreen')), 
      drawer: AppDrawer(),
    );
  }
}