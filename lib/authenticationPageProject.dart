import 'package:dio/dio.dart';
import 'package:firebase_replicate/InfoPage/authInfoPage.dart';
import 'package:firebase_replicate/projectFunction/getWifiIp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:network_info_plus/network_info_plus.dart';

import 'ModelClass/getUserProjAuthDetails.dart';

class AuthenticationPage extends StatefulWidget {

  final String userId;
  final String projectName;
  final String ip;


  const AuthenticationPage({super.key,required this.userId,required this.projectName,required this.ip});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {


  String? getIp="";
  List<GetUserAuthDetails> userAuthDetails=[];
  final NetworkInfo info=NetworkInfo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    getDataAuth();
    getServerIpAddress();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("AUTHENTICATION"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>InfoPageForAuth(ip: widget.ip, projectName: widget.projectName, uuid: widget.userId, description: "For Register with Email and password we need to make a POST request with body as {\'emailId\' : emailId,\'password\' : emailId, }", url: 'http://${widget.ip}:3030/${widget.userId}/${widget.projectName}/auth/reg',)));


          }, icon: Icon(Icons.info))
        ],

      ),

      body: Column(

        children: [



          SizedBox(height: 20,),
          Text("USERS",style: GoogleFonts.aBeeZee(
              fontSize:30
          ),),





          Expanded(
            child: RefreshIndicator(
              onRefresh: (){
               return getDataAuth();
              },
              child: ListView.builder(itemBuilder: (context,index){

                if(userAuthDetails.isEmpty)
                  {
                    return SizedBox();

                  }
                return ListTile(
                  trailing: IconButton(icon: Icon(Icons.info),onPressed: (){},),
                  contentPadding: EdgeInsets.all(30),
                  title: Text("${userAuthDetails[index].emailId}",style: GoogleFonts.aBeeZee(),),
                  subtitle: Container(
                  padding: EdgeInsets.only(top: 10),

                      child: Text("${userAuthDetails[index].password} \n ${userAuthDetails[index].createdAt}",style: GoogleFonts.aBeeZee())),



                );
              },itemCount: userAuthDetails.length,),
            ),
          ),
        ],
      )
      
    );
  }
  
  
  Future<dynamic> getDataAuth() async
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
    
  Response res=await dio.post('getProjectAuthDetails',data: {
    "userId":widget.userId,
    "projectName":widget.projectName
  });

 if(res.statusCode==200)
   {
     final result=res.data['result'];

     userAuthDetails=[];
     for(int i=0;i<result.length;i++)
       {
            userAuthDetails.add(GetUserAuthDetails.fromJson(result[i]));
       }

     setState(() {
       userAuthDetails;
     });




   }
 else
   {
     Fluttertoast.showToast(msg: "ERROR");
   }
  
  }


}
