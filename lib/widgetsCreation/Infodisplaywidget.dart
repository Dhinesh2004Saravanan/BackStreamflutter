import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';



class InfoDisplayWidget extends StatelessWidget {

  final String ip;
  final String projectName;
  final String uuid;
  final String url;
  final String description;
  const InfoDisplayWidget({super.key, required this.ip, required this.projectName, required this.uuid, required this.url, required this.description });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [


        Container(

          width: double.infinity,
          child: Text("${description}",style: GoogleFonts.aBeeZee(fontSize: 30),),
        ),
        SizedBox(height: 30,),

        InkWell(
    onTap: (){

      Clipboard.setData(ClipboardData(text: "${url}")).whenComplete((){

        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("MESSAGE COPIED TO CLIPBOARD"),
    action: SnackBarAction(label: "OK", onPressed: (){
      Navigator.of(context).pop();
    }),

    ));

    });
    },

          child:Text("${url}",style: GoogleFonts.aBeeZee(fontSize: 30,color: Colors.red) ,
        )
        )
      ],
    );
  }
}
