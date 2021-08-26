import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newpizzeria/GoogleMapPage.dart';
import 'package:newpizzeria/GoogleSignInProvider.dart';
import 'package:newpizzeria/HomeProvider.dart';
import 'package:newpizzeria/LoginPage.dart';
import 'package:newpizzeria/ProductPage.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),


      ],
      child: MaterialApp(
        title: 'Flutter Demo',

        theme: ThemeData(
          fontFamily: 'AveraStd',
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            //builder: (context) => PageViewMain(),
            builder: (context) => LoginPage(),
          ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,

            child: Center(child: Image.asset('images/logo.png')),
          ),
        )
    );
  }
}
