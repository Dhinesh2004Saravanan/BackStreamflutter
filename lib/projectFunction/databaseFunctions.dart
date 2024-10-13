import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_replicate/ModelClass/getCollectionDetails.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'getWifiIp.dart';

class DataBaseHelper
{


  static  Future<List<CollectionDetails>> getAllDataForDisplay({required String uid,required String projectName}) async
  {
    List<CollectionDetails> collectionDetails = [];


    var Ipaddress = await getServerIpAddress();


    final dio = Dio(
        BaseOptions(
            baseUrl: 'http://${Ipaddress}:3030/',
            headers: {
              'Content-Type': 'application/json'
            }
        )
    );


    Response res = await dio.post('/getDatabaseData', data: {
      "id": uid,
      "projectName": projectName
    });

    var result = res.data["message"];

    for(int i=0;i<result.length;i++)
      {
        collectionDetails.add(CollectionDetails.fromJson(result[i]));
      }




    return collectionDetails;



  }


  static Future getDataForCollection({required String collectionName,required String id,required String projectName}) async
  {


    var Ipaddress = await getServerIpAddress();


    final dio = Dio(
        BaseOptions(
            baseUrl: 'http://${Ipaddress}:3030/${id}/${projectName}',
            headers: {
              'Content-Type': 'application/json'
            }
        )
    );


    Response res=await dio.post('/getAllDatas',data: {
      "collectionName":collectionName
    });

    print(res.data);

    var documents=(res.data["documents"]);


    return documents;



  }


  static Future updateDocs({required String id,required String projectName,required String collectionName,required Map d}) async
  {
    var Ipaddress = await getServerIpAddress();


    final dio = Dio(
        BaseOptions(
            baseUrl: 'http://${Ipaddress}:3030/${id}/${projectName}/${collectionName}',
            headers: {
              'Content-Type': 'application/json'
            }
        )

          //  Response res=await dio.post()
    );


    Response res=await dio.post('/update',data: d);

    print(res.data);






  }
  static Future<void> Deletedocs({required String id,required String projectName,required String collectionName,required Map d})async
  {
       var Ipaddress = await getServerIpAddress();





  }

}