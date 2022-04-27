import 'package:auth/screens/auth_screen.dart';
import 'package:auth/screens/gps.dart';
import 'package:auth/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class Presence extends StatefulWidget {
   static const routeName ='/presence';
  @override
  PresenceScreen createState() => new PresenceScreen();
}

class PresenceScreen extends State<Presence> {
 
  String phpMsg;
  String regInfo;

  TextEditingController nom = new TextEditingController();
  TextEditingController prenom = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController email= new TextEditingController();

  sendData() async{
    var url = 'http://192.168.43.222/flutter/index.php'; //or https
    var data = {"userlastname":nom.text,"username":prenom.text,"email" : email.text, "password" : pass.text};

    http.post(url, body:data)
        .then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    }).catchError((error) => print(error.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Inscription'),
        backgroundColor: Colors.teal,
      ),
      body:
       Container(
          padding : EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          // Column is a vertical, linear layout.
          child: Container(
            child: ListView(
              children: <Widget>[
                Text("                    "),
                Text("                    "),
                Text("                    "),
                Text("Entrez votre nom et prenom"),
                TextFormField(
                  controller: nom,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Entrez votre nom et prenom',
                       suffix:  IconButton(icon: Icon(Icons.verified_user_outlined), onPressed: () {}) ,
                      
                  ),
                ),
                Text("                    "),
                Text("date"),
                TextFormField(
                  controller: prenom,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '',
                       suffix:  IconButton(icon: Icon(Icons.date_range), onPressed: () {}) ,
                  ),
                ),
                Text("                    "),
                Text("Entrez votre adresse mail"),
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: ''
                  ),
                ),
                Text("                    "),
                Text("Entrez votre mot de passe"),
                TextFormField(
                  controller: pass,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '',
                    suffix:  IconButton(icon: Icon(Icons.visibility_off), onPressed: () {}) ,
                  ),
                ),
                Text("                    "),
                RaisedButton(
                  onPressed: () {
                    sendData();
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                  },
                  child: Text('Engistrement de présence'),
                ),
                 SizedBox(height: 10.0,),
    
  SizedBox(height: 10.0,),
      IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Gps()));
      }, 
      icon: Icon(Icons.shop,size: 40,),

      )
      
              ],
            ),
          )
      ),
      
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white.withOpacity(0.5),
        animationDuration:const Duration(seconds: 1) ,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
     
      
      destinations:const [
        NavigationDestination(
          
          selectedIcon:Icon(Icons.location_on),
          icon: Icon(Icons.location_on_outlined), 
          label: ''),
          
          
          
       NavigationDestination(
          selectedIcon:Icon(Icons.logout) ,
          icon: Icon(Icons.logout_outlined), 
          label: 'logout'),

  NavigationDestination(
          selectedIcon:Icon(Icons.person) ,
          icon: Icon(Icons.person), 
          label: 'calendrier'),


       NavigationDestination(
          selectedIcon:Icon(Icons.near_me_sharp),
          icon: Icon(Icons.near_me_sharp), 
          label: 'calendrier')
      ],   
        ),
     
        
    );
  }
}