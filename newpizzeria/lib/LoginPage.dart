import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newpizzeria/BottomNavigator.dart';
import 'package:newpizzeria/GoogleSignInProvider.dart';
import 'package:newpizzeria/HomePage.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visiblePassword = false;
  final TitleCo = TextEditingController();
  final DescriptionCo = TextEditingController();



  @override
  Widget build(BuildContext context) {
    double Width = MediaQuery.of(context).size.width;
    double Height = MediaQuery.of(context).size.height;
    return Consumer<GoogleSignInProvider>(builder: (context,model,_){
      final provider = Provider.of<GoogleSignInProvider>(context,listen: true);
      return Scaffold(
        body: Container(
          height: Height,
          width: Width,
          child: Stack(
            children: [
              Container(
                width: Width,
                height: Height / 2.164,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('images/Pizza.jpeg'))),
              ),
              Positioned(
                top: Height / 3.164,
                child: Container(
                  padding:
                  EdgeInsets.only(left: Width / 13.354, top: Height / 13.575),
                  height: Height - (Height / 3.164),
                  width: Width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Log into your',
                              style: TextStyle(
                                  fontSize: Width / 13.8, color: Colors.red),
                            ),
                            Text(
                              'Account',
                              style: TextStyle(
                                  fontSize: Width / 8.28, color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('images/Message.png'),
                                    SizedBox(width: 10,),
                                    Text('Email',style: TextStyle(fontSize: Width/25,fontFamily:'AveraStd' ),),

                                  ],
                                ),
                                Container(
                                  width: Width,
                                  child:  TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    obscureText: true,
                                    decoration: InputDecoration(

                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: 'Email',
                                        hintStyle: TextStyle(fontFamily:'AveraStd')

                                    ),
                                  ),),
                                Container(
                                  height: 1,
                                  width: Width,
                                  color: Color(0XFFF5F3F6),
                                ),
                              ],
                            ),
                            SizedBox(height: Height/28.9,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('images/lock.png'),
                                    SizedBox(width: 10,),
                                    Text('Passowrd',style: TextStyle(fontSize: Width/25,fontFamily:'AveraStd'),),

                                  ],
                                ),
                                Container(
                                  width: Width,
                                  child:  TextField(
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: visiblePassword?true:false,
                                    decoration: InputDecoration(

                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText:  'Password',
                                      hintStyle: TextStyle(fontFamily:'AveraStd'),


                                    ),
                                  ),),
                                Container(
                                  height: 1,
                                  width: Width,
                                  color: Color(0XFFF5F3F6),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: Width,
                            height:Height/17.92 ,
                            child: Center(
                              child: Container(
                                height:Height/17.92 ,
                                width: Width/1.38,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                child: Center(child: Text('Login',style: TextStyle(fontSize: 15,color: Colors.white),)),
                              ),
                            ),
                          ),
                          SizedBox(height: Height/56,),
                          InkWell(
                            onTap: (){
                            },
                            child: Container(
                              width: Width,
                              height:Height/17.92 ,
                              child: Center(
                                child: InkWell(
                                  onTap: (){

                                    provider.googleLogin();
                                    setState(() {
                                      print('ho${FirebaseAuth.instance.currentUser.email}');
                                    });
                                    if(FirebaseAuth.instance.currentUser.email.isEmpty == false)
                                    {
                                      Navigator.push(context, PageRouteBuilder(
                                          transitionDuration: Duration(milliseconds: 1000),
                                          transitionsBuilder: (BuildContext context,Animation<double> animation,Animation<double> secanimation,Widget child){
                                            return FadeTransition(opacity: animation,child: child,);

                                          },

                                          pageBuilder: (BuildContext context,Animation<double> animation,Animation<double> secanimation){
                                            return BottomNavigatorPage();
                                          }));

                                    }

                                  },
                                  child: Container(
                                    height:Height/17.92 ,
                                    width: Width/1.38,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(color: Colors.black),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    child: Center(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('images/gmail.png'),
                                          SizedBox(width: 10,),
                                          Text('Login With Google',style: TextStyle(fontSize:15 ),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
