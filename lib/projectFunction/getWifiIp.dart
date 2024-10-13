

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<String> getServerIpAddress() async
{

  final Dio dio=Dio(
      BaseOptions(
          baseUrl: 'http://192.168.153.231:3030',
          headers: {
            'Content-Type':'application/json'
          }
      )
  );


  Response res=await dio.get('/getIp');
  String ip=await res.data['ip']?? "";
  Fluttertoast.showToast(msg: ip.toString());
  return ip;
}