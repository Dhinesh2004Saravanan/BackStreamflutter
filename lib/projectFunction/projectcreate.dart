


import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'getWifiIp.dart';

class ProjectCreate
{

  static late SharedPreferences _preferences;



  static List<String> projList=[];
  static Future<dynamic> createProject({required String id,required String projectName,required BuildContext context}) async {

    print(projectName);

    var Ipaddress=await getServerIpAddress();



    final _dio=Dio(
        BaseOptions(
            baseUrl: 'http://${Ipaddress}:3030/',
            headers: {
              'Content-Type':'application/json'
            }
        )
    );

    Response res=await _dio.post('addProject',data: {
  "id":id,
  "projectName":projectName
});


    if(res.statusCode==400)
      {
        print("error has occured");
      }
    else

      {


       var projNameList=res.data['projList'];
       _preferences=await SharedPreferences.getInstance();
       projList=[];
   for(int i=0;i<projNameList.length;i++)
     {
       projList.add(projNameList[i].toString());
     }

   await _preferences.setStringList('projectList', projList).then((value) {
     print('$value function is successful');
     Fluttertoast.showToast(msg: 'function success');
     Navigator.of(context).pop();
   });


      }
    return projList;

  }



}