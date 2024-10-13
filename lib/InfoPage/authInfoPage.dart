import 'package:firebase_replicate/widgetsCreation/Infodisplaywidget.dart';
import 'package:flutter/material.dart';

class InfoPageForAuth extends StatelessWidget {
  final String ip;
  final String projectName;
  final String uuid;
  final String url;
  final String description;
  const InfoPageForAuth({super.key, required this.ip, required this.projectName, required this.uuid, required this.url, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("DOCUMENTATION"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          SizedBox(height: 20,),
          // for register with email and password
          InfoDisplayWidget(ip: ip, projectName: projectName, uuid: uuid, url: url, description: description),


          SizedBox(height: 20,),
          InfoDisplayWidget(ip: ip, projectName: projectName, uuid: uuid, url: "http://${ip}:3030/${uuid}/${projectName}/auth/log", description: " For Login with Email and Password we also need to do a POST REQUEST with body \n {'\emailId\':your_emailId,\'password\':your_password }")


          // for login
        ],
      ),
    );
  }
}
