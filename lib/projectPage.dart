import 'package:firebase_replicate/homepage.dart';
import 'package:firebase_replicate/projectDatabaseList.dart';
import 'package:firebase_replicate/widgetsCreation/ContentCard.dart';
import 'package:flutter/material.dart';

import 'authenticationPageProject.dart';



class ProjectPage extends StatefulWidget {
  final String projectName;
  final String userId;
  final String ip;

   ProjectPage({super.key,required,required this.projectName,required this.userId,required this.ip });

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.projectName.toString()),
      ),

      body: Column(
        children: [
          SizedBox(height: 30,),

          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AuthenticationPage(projectName:  widget.projectName,userId:widget.userId,ip: widget.ip,)));

              },

              child: ContentCard(purpose: "AUTHENTICATION",userId: widget.userId,projectName: widget.projectName)),
          SizedBox(height: 30,),

          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ProjectDataBaseList(projectName:  widget.projectName,userId:widget.userId,ip: widget.ip)));
              },

              child: ContentCard(purpose: "DATABASE",userId: widget.userId,projectName: widget.projectName))




        ],
      ),
    );
  }
}


