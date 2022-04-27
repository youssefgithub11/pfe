import 'package:auth/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
class ProductOverviewScreen extends StatefulWidget {
  
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shop"),
      backgroundColor: Colors.black),
    body: const Center(child: Text('Text')),
    
       drawer:AppDrawer() ,
    );
      
    
  }
}