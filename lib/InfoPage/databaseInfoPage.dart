
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgetsCreation/Infodisplaywidget.dart';

class DatabaseInfoPage extends StatelessWidget {
  final String ip;
  final String projectName;
  final String uuid;
  final String url;
  final String description;
  const DatabaseInfoPage({super.key, required this.ip, required this.projectName, required this.uuid, required this.url, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("DOCUMENTATION"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: 20,),
            // for register with email and password
            InfoDisplayWidget(ip: ip, projectName: projectName, uuid: uuid, url: url, description: description),
            Text("BODY OF POST: {Your Own Data in Key-Value Pairs}  }",style: GoogleFonts.aBeeZee(fontSize: 25,color: Colors.blue),),

        Divider(thickness: 3,),
            SizedBox(height: 20,),

           InfoDisplayWidget(ip: ip, projectName: projectName, uuid: uuid, url: "http://${ip}:3030/${uuid}/${projectName}/OwnCollectionName/get", description: " For getting a result with particular  conditions [POST METHOD] is used")

            ,Text("By declaring Body tag as ",style: GoogleFonts.aBeeZee(fontSize: 25),),
            Text("BODY OF POST: {'where':{ fields condition }  }",style: GoogleFonts.aBeeZee(fontSize: 25,color: Colors.blue),)

            ,SizedBox(height: 20,),
            Divider(thickness: 3,),
            SizedBox(height: 20,),
            InfoDisplayWidget(ip: ip, projectName: projectName, uuid: uuid, url: "http://${ip}:3030/${uuid}/${projectName}/OWNCOLLECTION_NAME/update", description: " For updating The fields of Database we have to use  request with Body"),

            Text("BODY OF POST :{'where':{ fields condition } ,'update':{fields in Key Value Pair} }",style: GoogleFonts.aBeeZee(fontSize: 25,color: Colors.blue),)




            // for login
          ],
        ),
      ),
    );
  }
}