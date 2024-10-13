import 'package:firebase_replicate/authenticationPageProject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentCard extends StatelessWidget {
  final String purpose;
  final String userId;
  final String projectName;
  const ContentCard({super.key,required this.purpose,required this.userId,required this.projectName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(

        child: Container(

          alignment: Alignment.center,
          width: double.infinity,
          height: 100,
          child: Text(purpose,style: GoogleFonts.aBeeZee(
            fontSize:30
          ),),
        ),
      ),
    );
  }
}

