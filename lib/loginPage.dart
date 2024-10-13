import 'dart:math';

import 'package:firebase_replicate/authFunctions/authfunction.dart';
import 'package:firebase_replicate/registerPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final TextEditingController emailId=TextEditingController();
  final TextEditingController password=TextEditingController();
  bool loginPage=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: (loginPage==true)?SafeArea(

        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              SizedBox(height: 30,),
              Text("LOGIN",style: GoogleFonts.aBeeZee(
                fontSize:30,

              )),

              SizedBox(height: 30,),


              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: emailId,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(

                    ),
                    hintText: "EMAIL ID",
                    labelText: "EMAIL"
                  ),
                ),



              ),

              SizedBox(height: 30,),


              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(

                      ),
                      hintText: "PASSWORD",
                      labelText: "PASSWORD"
                  ),
                ),



              ),
              
              SizedBox(height: 30,),
              ElevatedButton(onPressed: (){
                Auth.login();
              }, child: Text("submit")),
              SizedBox(height: 20,),
              RichText(text:
              TextSpan(text: "Dont have an account ?",style: GoogleFonts.aBeeZee(color:Colors.black),
                  children: [
                    TextSpan(text: "Register ",style: TextStyle(
                      color: (loginPage)?Colors.red:Colors.blue
                    ),recognizer: TapGestureRecognizer(

                    )..onTap=(){
                      print("Clicked");
                      setState(() {
                        loginPage=false;
                      });
                      print(loginPage);
                    }



                    )

              ]
              )
              )
            ],
          ),
        ),
      ):RegisterPage(),
    );
  }
}
