import 'package:auth/screens/user_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:auth/screens/product_overview_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/user_product_screen.dart';
import 'package:auth/models/providers/auth.dart';


class AppDrawer extends StatelessWidget {
  


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(title: Text(' Sotetel Shop'),
        backgroundColor: Colors.black,
        automaticallyImplyLeading:false ,
        ),
        Divider(),
        ListTile(
          leading:Icon(Icons.shop) ,
          title: Text('shop'),
          iconColor: Colors.black,
          textColor: Colors.blue,

           //route name ('/')=> pageprincipale
          onTap:()=>  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductOverviewScreen())),

        ),
        Divider(),
        ListTile(
          leading:Icon(Icons.payment),
          title: Text('Orders'),
          iconColor: Colors.black,
          textColor: Colors.blue,

           //route name ('/')=> payment
          onTap:()=> Navigator.of(context).pushReplacementNamed(OrderScreen.routeName) ,
          ), 
           Divider(),
        ListTile(
          leading:Icon(Icons.edit) ,
          title: Text('Manage Products'),
           iconColor: Colors.black,
            textColor: Colors.blue,

           //route name ('/')
          onTap:()=> Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName) ,
          ), 
         Divider(), 
         ListTile(
          leading:Icon(Icons.exit_to_app) ,
          title: Text('Logout'),
          iconColor: Colors.black,
          textColor: Colors.blue,
           //route name ('/')=> exit
          onTap:() {
            //supprimer cette widget
            Navigator.of(context).pop();
              //route name ('/')=> exit
             Navigator.of(context).pushReplacementNamed('/');
             Provider.of<Auth>(context, listen:false).logout();
          } ,
          ),
         
      ],),
      
    );
  }
}