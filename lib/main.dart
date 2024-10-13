import 'dart:async';

import 'package:firebase_replicate/homepage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginPage.dart';



Future<void> main() async
{
  runApp(FrontSplash());

}



class FrontSplash extends StatelessWidget {
  const FrontSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  bool? isRegistered=false;
  late SharedPreferences _prefs;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBoolData();
    Timer(Duration(seconds: 1), ()
    {
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>(isRegistered!)?(HomePage()):LoginPage()));
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: Text("FIREBASE \n REPLICATE ",style: GoogleFonts.aBeeZee(
          fontSize:30
        ),),

      ),
    );
  }
  getBoolData() async
  {
    _prefs=await SharedPreferences.getInstance();
    isRegistered=await _prefs.getBool('isRegistered');
    if(isRegistered==null)
      {
        isRegistered=false;
      }
    else
      {
        isRegistered=true;
      }
    setState(() {
      isRegistered;
    });

    print("is registered status is ${isRegistered}");
  }
}


