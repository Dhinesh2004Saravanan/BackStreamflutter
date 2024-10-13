import 'package:dio/dio.dart';
import 'package:firebase_replicate/projectFunction/getWifiIp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homepage.dart';



class Auth
{


  static late SharedPreferences _preferences;




  static Future<void> register({required String username,required String emailId,required String password,required BuildContext context}) async
  {
    var Ipaddress=await getServerIpAddress();



     final dio=Dio(
        BaseOptions(
            baseUrl: 'http://${Ipaddress}:3030/',
            headers: {
              'Content-Type':'application/json'
            }
        )
    );

    _preferences=await SharedPreferences.getInstance();
      Response res=await dio.post('auth/register',data: {

        'username':username,
        'emailId':emailId,
        'password':password
      });

      if(res.statusCode==400)
        {
          print("error has occured");
          Fluttertoast.showToast(msg: res.data['message']);
          return;
        }
      else
        {
          var resultData=res.data;
          print(resultData);
         await _preferences.setString('uniqueId', resultData['uniqueId']);

         await  _preferences.setBool('isRegistered', resultData['status']);
          Fluttertoast.showToast(msg: "REGISTERED SUCCESSFUL");
          Navigator.push(context, MaterialPageRoute(builder: (ctx)=>HomePage()));


        }

  }
  static Future<void> login() async
  {
    var Ipaddress=await getServerIpAddress();



    final dio=Dio(
        BaseOptions(
            baseUrl: 'http://${Ipaddress}:3030/',
            headers: {
              'Content-Type':'application/json'
            }
        )
    );
  }
}