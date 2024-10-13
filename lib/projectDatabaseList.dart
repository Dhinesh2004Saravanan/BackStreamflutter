import 'package:firebase_replicate/projectFunction/databaseFunctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'InfoPage/databaseInfoPage.dart';
import 'widgetsCreation/Infodisplaywidget.dart';
import 'ModelClass/getCollectionDetails.dart';

class ProjectDataBaseList extends StatefulWidget {

  final String projectName;
  final String ip;
  final String userId;

  const ProjectDataBaseList({super.key, required this.projectName, required this.ip, required this.userId});

  @override
  State<ProjectDataBaseList> createState() => _ProjectDataBaseListState();
}

class _ProjectDataBaseListState extends State<ProjectDataBaseList>
{


  List presentedData = [];
  String currentCollectionName = "";
  Map<String, dynamic> getUpdateData = {};


  List<TextEditingController> textControllers = [];

  List<CollectionDetails> collectionDetails = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    DataBaseHelper.getAllDataForDisplay(
        uid: widget.userId, projectName: widget.projectName).then((value) {
      collectionDetails = value;
      setState(() {
        collectionDetails;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (ctx) =>
                DatabaseInfoPage(ip: widget.ip,
                  projectName: widget.projectName,
                  uuid: widget.userId,
                  url: "http://${widget.ip}:3030/${widget.userId}/${widget
                      .projectName}/addData/OwncollectionName",
                  description: "For adding the data into the DataBase we need to make a POST request Mentioning your collection Name in OwnCollectionName",)));
          }, icon: Icon(Icons.info))
        ],

        title: Text(widget.projectName),


      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await DataBaseHelper.getDataForCollection(
              collectionName: currentCollectionName,
              id: widget.userId,
              projectName: widget.projectName).then((val) {
            presentedData = val;
            setState(() {
              presentedData;
            });
          });


          return DataBaseHelper.getAllDataForDisplay(
              uid: widget.userId, projectName: widget.projectName).then((
              value) {
            collectionDetails = value;
            setState(() {
              collectionDetails;
            });
          });
        },
        child: Column(

          children: [

            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20, left: 20),
                child: Text("DATABASE ", style: GoogleFonts.aBeeZee(
                    fontSize: 30
                ),)),


            SizedBox(height: 30,),


            Expanded(
              child: Row(

                children: [

                  // * collection Name
                  Container(

                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 4,
                    height: double.infinity,


                    child: ListView.builder(itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            currentCollectionName =
                                collectionDetails[index].name;
                          });
                          print("tap function is invoked");
                          DataBaseHelper.getDataForCollection(
                              collectionName: collectionDetails[index].name,
                              projectName: widget.projectName,
                              id: widget.userId).then((value) {
                            setState(() {
                              presentedData = value;
                            });
                          });
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero
                            ),
                            child: Container(

                                padding: EdgeInsets.all(20),
                                child: Text(collectionDetails[index].name,
                                  style: GoogleFonts.aBeeZee(fontSize: 25),))),
                      );
                    }, itemCount: collectionDetails.length,),
                  )


                  // * Data
                  , Container(
                    margin: EdgeInsets.only(left: 15),
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 3 / 4 - 50,
                    height: double.infinity,
                    child: ListView.builder(itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          trailing: Container(
                            width: 100,
                            child: Row(
                              children: [

                                IconButton(onPressed: () {
                                  // DataBaseHelper.updateDocs(id: widget.userId, projectName: widget.projectName
                                  //     , collectionName: currentCollectionName, d: {})


                                  List<String> entities = presentedData[index]
                                      .keys.toList();

                                  print(entities);
                                  int i = -1;


                                  showDialog(
                                      context: context, builder: (context) {
                                    return AlertDialog(
                                      title: Text("UPDATE VALUE"),
                                      content: Column(

                                          children: generateWidgets(
                                              entities, presentedData[index])

                                      ),


                                      actions: [
                                        TextButton(onPressed: () async
                                        {
                                          for (int i = 0; i <
                                              entities.length - 1; i++) {
                                            getUpdateData[entities[i + 1]] =
                                                textControllers[i].text;
                                          }

                                          await DataBaseHelper.updateDocs(
                                              id: widget.userId,
                                              projectName: widget.projectName,
                                              collectionName: currentCollectionName,
                                              d: {
                                                "where": {
                                                  "_id": presentedData[index]['_id']
                                                }, "update": getUpdateData
                                              }).whenComplete(() async {
                                            await DataBaseHelper
                                                .getDataForCollection(
                                                collectionName: currentCollectionName,
                                                id: widget.userId,
                                                projectName: widget.projectName)
                                                .then((val) {
                                              presentedData = val;
                                              setState(() {
                                                presentedData;
                                              });
                                            });
                                          });
                                          getUpdateData.clear();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                              SnackBar(content: Text(
                                                  "Updated Success")));
                                          Navigator.of(context).pop();
                                        }, child: Text("OK")),
                                        TextButton(onPressed: () {
                                          Navigator.of(context).pop();
                                        }, child: Text("EXIT"))
                                      ],
                                    );
                                  });
                                }, icon: Icon(Icons.edit)),
                                SizedBox(width: 10,),
                                IconButton(onPressed: () {
                                  showDialog(
                                      context: context, builder: (context) {
                                    return AlertDialog(
                                      title: Text("DELETE VALUE"),

                                      actions: [
                                        TextButton(onPressed: () {
                                          print(
                                              "delete called for successfully");
                                        }, child: Text("OK")),

                                        TextButton(onPressed: () {
                                          Navigator.of(context).pop();
                                        }, child: Text("EXIT"))
                                      ],
                                    );
                                  });
                                }, icon: Icon(Icons.delete)),
                              ],
                            ),
                          ),
                          title: Text(presentedData[index].toString()),
                        ),
                      );
                    }, itemCount: presentedData.length,),
                  )


                ],
              ),
            )


          ],
        ),
      ),

    );
  }


  List<Widget> generateWidgets(entities, info) {
    List<Widget> temp = [];

    print(info);


    for (int i = 0; i < entities.length - 1; i++) {
      textControllers.add(TextEditingController());

      temp.add(Container(
        margin: EdgeInsets.all(15),

        child: TextField(

          controller: textControllers[i],
          decoration: InputDecoration(
              border: OutlineInputBorder(

              ),
              hintText: entities[i + 1],
              labelText: entities[i + 1]

          ),
        ),
      ));

      textControllers[i].text = info[entities[i + 1]];
      print(info[entities[i + 1]]);
    }


    return temp;
  }
}
