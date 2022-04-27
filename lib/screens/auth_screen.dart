// ignore_for_file: deprecated_member_use


import 'dart:math';

import 'package:auth/models/providers/auth.dart';
import 'package:auth/models/providers/presence.dart';
import 'package:auth/screens/presence.dart';
import 'package:auth/screens/product_detail_screen.dart';
import 'package:auth/screens/product_overview_screen.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import 'package:flutter/material.dart';
import 'orders_screen.dart';



class Authscreen  extends StatelessWidget {
  static const routeName = '/auth';
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
       body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:[
                Color.fromRGBO(0, 0, 0, 0.7),
                Color.fromRGBO(0, 0, 0, 0.5),
              ],
              begin:Alignment.topLeft, 
              end: Alignment.bottomRight,
              stops:[0, 1],

            ) ,
          ),
          ),
        SingleChildScrollView(
          child: Container(
            height:deviceSize.height,
            width: deviceSize.width,
            child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
              Flexible(child:Container(
                margin:EdgeInsets.only(bottom: 20),
                padding:EdgeInsets.symmetric(vertical:8, horizontal:94),
                transform:Matrix4.rotationZ(-8 * pi/180)..translate(-10.0),
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(20),
                  
                  boxShadow: [BoxShadow(blurRadius: 8 ,color: Colors.black26,
                  offset: Offset(0,2))]
                
                  ),
                child: Text("Sotetel Login"
                , style: TextStyle(
                  color: Theme.of(context).accentTextTheme.headline6.color,
                  fontSize: 50,
                  fontFamily:'Anton', 
                ),
                ),
            ),
            
            ),
            Flexible(flex: deviceSize.width>600? 2:1,child:AuthCard())
             ],
            ),
          ),
        )
        ] ,

       ),
    );
  }
}
class AuthCard extends StatefulWidget {
 
  @override
  _AuthCardState createState() => _AuthCardState();
}
enum AuthMode{
  Login, SignUp
}
class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState>_formKey = GlobalKey();
  AuthMode _authMode =AuthMode.Login;

  Map<String,String> _authData = {
     'email':'',
     'password':'',

  };
  var _isLoading =false;

  final _passwordController = TextEditingController();
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;

   @override
    void initState(){
      super.initState();
      _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 300),);
      _slideAnimation = Tween<Offset>
      (begin: Offset(0, -0.15),
         end: Offset(0, 0),
        ).animate(CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));


        _opacityAnimation =Tween<double>(

         begin: 0.0,
         end: 1.0,
        ).animate(
          CurvedAnimation(
          parent: _controller, curve: Curves.easeIn),

           );   
    }

   @override
   void dispose(){
    super.dispose();
     _controller.dispose();
   }
    Future<void> _submit() async{
      if (!_formKey.currentState.validate()){
        return;
      }
      FocusScope.of(context).unfocus();
      _formKey.currentState.save();
      setState(() {
        _isLoading =true;

      });
      
      try{
        if(_authMode==AuthMode.Login){
        await Provider.of<Auth>(context,listen: false)
        .login(_authData['email'],_authData['password'] );
        
          } else {
           await  Provider.of<Auth>(context, listen: false)
           .signUp(_authData['email'],_authData['password'] );
 
}


      }on HttpException catch(error){
        var errorMessage = 'Authentifaction failed';
        if(error.toString().contains('EMAIL_EXISTS')){
          errorMessage='This email addres is already in use. ';
        }else if (error.toString().contains('INVALID-EMAIL')){
          errorMessage='This is not a valid email adress ';
          }else if (error.toString().contains('WEAK-PASSWORD')){
          errorMessage='This password is too weak ';
           }else if (error.toString().contains('EMAIL_NOT_FOUND')){
          errorMessage='could not find a user with that email. ';
           }else if (error.toString().contains('INVALID_PASSWORD')){
          errorMessage='Invalid password. ';
          
           }
        _showErrorDialog(errorMessage);
      } catch(error){
        const errorMessage ='Could not authenticate you. Please try again later.';
        _showErrorDialog(errorMessage);
        _isLoading = false;
      }
        
    }
      void _showErrorDialog(String message) {
        showDialog(
          context: context,
          builder:(ctx)=>AlertDialog(
          title: Text('An error occured!'),
          content: Text(message),
          actions: [
            FlatButton(
              child: Text('okay!'),
              onPressed: ()=>Navigator.of(ctx).pop,
        )
          ],
          ),
        );
        
        }
     void _switchAuthmode(){
      if (_authMode == AuthMode.Login){
setState(() {
  _authMode = AuthMode.SignUp;
});
_controller.forward();
      }
      else {
        setState(() {
        
       _authMode = AuthMode.Login;
    
});
_controller.reverse();
      }
     }
    
  @override
  Widget build(BuildContext context) {
        final deviceSize = MediaQuery.of(context).size;

    return Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10,),),
    elevation: 8.0, child:AnimatedContainer(duration:Duration(milliseconds: 300) ,
    curve:Curves.easeIn,
    height: _authMode==AuthMode.SignUp? 700:700,
    constraints: BoxConstraints(minHeight:_authMode== AuthMode.SignUp? 800:800, ),
    width:deviceSize.width*0.75 ,
    padding: EdgeInsets.all(16),
    child: Form(key: _formKey,
    child:SingleChildScrollView(child:Column(children: [
      TextFormField(decoration:InputDecoration(labelText: 'E-mail') ,
      keyboardType: TextInputType.emailAddress,
      validator: (val){
        if(val.isEmpty || !val.contains('@')){

          return 'Invalid email';
        }return null;
      },
      onSaved:(val){
       _authData['email']=val;
       },
      ),
      TextFormField(decoration:InputDecoration(labelText: 'Password') ,
      obscureText: true,
      controller: _passwordController,
      validator: (val){
        if(val.isEmpty || val.length<5){

          return ' Password is too short!';
        }return null;
      },
      onSaved:(val){
       _authData['password']=val;
       },
      ),
      AnimatedContainer( 
        constraints:BoxConstraints(
          minHeight: _authMode==AuthMode.SignUp?60 : 0,
          maxHeight: _authMode==AuthMode.SignUp?120 : 0,
          ),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
          child: FadeTransition(
            opacity: _opacityAnimation,
             child: SlideTransition(
               position: _slideAnimation,
               child: TextFormField(
                 enabled: _authMode==AuthMode.SignUp,
                 decoration: InputDecoration(labelText: 'Confirm Password'),
                 obscureText: true,
                  validator:_authMode==AuthMode.SignUp
                  ?(val)
            {
        if(val!=_passwordController.text ){

          return ' Password do not match!';
        }return null;
      }: null,
     
      ), 
               ),
          ),
          ),
      SizedBox(height: 20),
       if (_isLoading)CircularProgressIndicator(),
         RaisedButton(
         child: Text(_authMode==AuthMode.Login?'LOGIN': 'SIGNUP' ),
         
         onPressed:_submit,
         shape:RoundedRectangleBorder(
           borderRadius:BorderRadius.circular(30),
         ),
         padding:EdgeInsets.symmetric(horizontal: 30,vertical: 8),
         color: Colors.black,
        textColor:Theme.of(context).primaryTextTheme.headline6.color,
        ),
        
       FlatButton(
         child: Text('${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
         onPressed:_switchAuthmode ,

         padding: EdgeInsets.symmetric(horizontal: 30,vertical: 4),
         
        textColor:Theme.of(context).primaryColor,
       ),
       
       SizedBox(height: 10.0,),
      IconButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductOverviewScreen()));
      }, 
      icon: Icon(Icons.shop,size: 40,),

      )
      
       
    ],
    ),
    ),
    ),
    ),
    );
  }


}
