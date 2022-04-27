import 'package:auth/models/providers/auth.dart';
import 'package:auth/models/providers/cart.dart';
import 'package:auth/models/providers/orders.dart';
import 'package:auth/models/providers/presence.dart';
import 'package:auth/models/providers/products.dart';
import 'package:auth/screens/cart_screen.dart';
import 'package:auth/screens/gps.dart';
import 'package:auth/screens/edit_product_screen.dart';
import 'package:auth/screens/gps.dart';
import 'package:auth/screens/orders_screen.dart';
import 'package:auth/screens/product_detail_screen.dart';
import 'package:auth/screens/splash_screen.dart';
import 'package:auth/screens/user_products_screen.dart';
import 'package:auth/screens/product_overview_screen.dart';
import 'package:auth/screens/presence.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import './screens/auth_screen.dart';

void main() => runApp(  MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return MultiProvider(
     providers: [
       ChangeNotifierProvider.value(value:Auth()),
        ChangeNotifierProvider.value(value:Products()),
         ChangeNotifierProvider.value(value:Cart()),
          ChangeNotifierProvider.value(value:Orders()),
          ChangeNotifierProvider.value(value:Presenceitem()),
     ],
     child: Consumer<Auth>(builder:(ctx, auth, _) => MaterialApp(
     debugShowCheckedModeBanner:false ,
     theme: ThemeData(
       primarySwatch: Colors.blueGrey,
     accentColor:Colors.deepOrange,
      fontFamily: 'Lato'
      
      ),
     home: auth.isAuth? Presence(): FutureBuilder(
       future: auth.tryAutoLogin(),
       builder: (ctx , AsyncSnapshot authSnapshot)=>
       authSnapshot.connectionState ==ConnectionState.waiting? 
       SplashScreen()
       :Authscreen() ,
     ),
      routes: {
       ProductDetailScreen.routeName: (_)=> ProductDetailScreen(),
       CartScreen.routeName: (_)=> CartScreen(),
      OrderScreen.routeName: (_)=> OrderScreen(),
       UserProductsScreen.routeName: (_)=> UserProductsScreen(),
      EditProductScreen.routeName: (_)=> EditProductScreen(),
    Presence.routeName: (_)=> Presence(),
        Gps.routeName: (_)=> Gps(),



     },
     ),
    
   ),
   ); 
  
}}




