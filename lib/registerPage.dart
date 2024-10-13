import 'package:firebase_replicate/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'authFunctions/authfunction.dart';





class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController name=TextEditingController();
  final TextEditingController password=TextEditingController();
  final TextEditingController emailId=TextEditingController();
  bool registerPage=true;

  @override
  Widget build(BuildContext context) {
    return  (registerPage)? PopScope(
      canPop: false,
      onPopInvoked: (val){
        setState(() {
          registerPage=false;

        });
      },
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [

            SizedBox(height: 30,),
            Text("Register",style: GoogleFonts.aBeeZee(
                fontSize:30,
                fontWeight:FontWeight.bold
            ),),

            SizedBox(height: 30,),

            TextField(
              controller: name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(



                  ),
                  hintText: "Name",
                  labelText: "Name"
              ),
            ),

            SizedBox(height: 30,),

            TextField(
              controller: emailId,
              decoration: InputDecoration(
                  border: OutlineInputBorder(



                  ),
                  hintText: "Email Id",
                  labelText: "Email Id"
              ),
            ),

            SizedBox(height: 30,),

            TextField(
              controller: password ,
              decoration: InputDecoration(
                  border: OutlineInputBorder(



                  ),
                  hintText: "Password",
                  labelText: "Password"
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
              Auth.register(username: name.text,password: password.text,emailId: emailId.text,context: context);



            }, child: Text("Submit"))


          ],


        ),
      ),
    ):LoginPage();

  }
}

/*
 Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [

            SizedBox(height: 30,),
            Text("Register",style: GoogleFonts.aBeeZee(
              fontSize:30,
              fontWeight:FontWeight.bold
            ),),

            SizedBox(height: 30,),

            TextField(
              controller: name,
              decoration: InputDecoration(
                border: OutlineInputBorder(



                ),
                hintText: "Name",
                labelText: "Name"
              ),
            ),

            SizedBox(height: 30,),

            TextField(
              controller: emailId,
              decoration: InputDecoration(
                  border: OutlineInputBorder(



                  ),
                  hintText: "Email Id",
                  labelText: "Email Id"
              ),
            ),

            SizedBox(height: 30,),

            TextField(
              controller: password ,
              decoration: InputDecoration(
                  border: OutlineInputBorder(



                  ),
                  hintText: "Password",
                  labelText: "Password"
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: (){



            }, child: Text("Submit"))


          ],


        ),
      ),
 */