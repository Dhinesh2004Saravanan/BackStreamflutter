



import 'package:dio/dio.dart';
import 'package:firebase_replicate/projectFunction/projectcreate.dart';
import 'package:firebase_replicate/projectPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController projectName=TextEditingController();
  late SharedPreferences _preferences;

  String? uid="";
  late List<String>? projectNames=[];
   String? ip="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWifi();
    getUserId();




  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("LIST OF PROJECTS"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'CREATE A PROJECT',

        onPressed: (){

        getProjectDetails();


      },),


      body: RefreshIndicator(

        onRefresh: () {
          return getUserId();
        },
        child: (projectNames==null)?(SizedBox()):


        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:3, // Number of columns in the grid
                crossAxisSpacing: 10, // Spacing between columns
                mainAxisSpacing: 10, // Spacing between rows
                childAspectRatio: 2 // * ratio to width and height  if greater than 1 then wider else  // Adjust aspect ratio as needed
            ),
            itemCount: projectNames?.length,
            itemBuilder: (context, index) {
              if (projectNames!.isEmpty) {
                return SizedBox();
              }
              return InkWell(
                  onTap: () {
                    // Handle item tap
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ProjectPage(projectName: projectNames![index].toString(),userId:uid!,ip: ip!,)));
                  },
                  child: Card(

                      child: Container(

                        alignment: Alignment.center,
                          padding: EdgeInsets.all(30),
                          margin: EdgeInsets.only(bottom: 10),child: Text(
                          "${projectNames?[index].toString()}",
                          style: GoogleFonts.aBeeZee(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),
                      )
                      )
                  )
              );
            }
        ),
      ),
    );
  }


  Future<void> getProjectDetails() async
  {
    showDialog(context: context, builder: (context){
      return AlertDialog(

        title: Text('NEW PROJECT'),
        content: TextField(
          controller: projectName,
          decoration: InputDecoration(
            border: OutlineInputBorder(

            ),
            hintText: "project ",
            labelText: 'Project Name'
          ),
        ),


        actions: [
          TextButton(onPressed: (){
            print('create function is invoked');
            ProjectCreate.createProject(id: uid!,projectName: projectName.text,context: context);




          }, child: Text('CREATE')),
          TextButton(onPressed: (){
            print('withdraw function is invoked');
            Navigator.of(context).pop();

          }, child: Text('WITHDRAW')),

        ],

      );

    });
  }
  Future<void> getUserId() async
  {
    _preferences=await SharedPreferences.getInstance();
     uid=await _preferences.getString('uniqueId');
     setState(() {
       uid;
     });
     print("uuid is ${uid}");


     projectNames=await _preferences.getStringList('projectList');
     if(projectNames==null)
       {
         projectNames=[];
         Fluttertoast.showToast(msg: "ERROR EMPTY NULL");
       }
     else
       {

         projectNames;
       }
     setState(() {
       projectNames;
     });
     print("project Names will be is ${projectNames}");

  }



  Future<void> getWifi() async
  {
    final Dio dio=Dio(
      BaseOptions(
        baseUrl: 'http://192.168.1.34:3030',
        headers: {
          'Content-Type':'application/json'
        }
      )
    );


    Response res=await dio.get('/getIp');
    ip=res.data['ip'];
    Fluttertoast.showToast(msg: ip.toString());
  }
}
