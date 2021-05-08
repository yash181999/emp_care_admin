import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_care/color/color.dart';
import 'package:flutter/material.dart';

class PostAnnouncement extends StatefulWidget {
  @override
  _PostAnnouncementState createState() => _PostAnnouncementState();
}

class _PostAnnouncementState extends State<PostAnnouncement> {
  @override
  Widget build(BuildContext context) {



    bool clicked = false;

    final announcementText = TextEditingController();

    Firestore db = Firestore.instance;


    submit() async{
       await db.collection("Announcement").document().setData({

           "Announcement" :  announcementText.text,
           "time" : Timestamp.now().toDate().toString(),
           "timeStamp " : Timestamp.now(),

       });

       setState(() {

         clicked = false;

         announcementText.text = "";
       });

       Navigator.pop(context);

    }


    return Scaffold(
        appBar: AppBar(
           iconTheme: IconThemeData(
             color: black,
           ),
           backgroundColor: yellow,
           title: Text(
             "Post Announcement",
             style : TextStyle(
               color: Colors.black,
             )
           ),
        ),


        body : Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
               children: [
                 Container(
                   padding: EdgeInsets.all(20),
                   child: TextFormField(
                     controller: announcementText,

                     style: TextStyle(
                       fontSize: 20
                     ),
                     minLines:10 ,
                     maxLines: 200,
                     decoration: InputDecoration(
                       labelText: "Write the Announcement",
                        border: OutlineInputBorder(),
                     ),
                   ),
                 ),

                 clicked == false ? MaterialButton(
                   onPressed: (){

                     if(announcementText.text.isNotEmpty){
                       setState(() {
                           clicked = true;
                       });
                       submit();
                     }

                   },
                   color: red,
                   minWidth: MediaQuery.of(context).size.width*0.80,
                   height: 50,
                   child: Text(
                       "POST",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                   ),
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(20),
                   ),
                 ) : CircularProgressIndicator(),
               ],
            ),
          ),
        )





    );
  }
}
