

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_care/color/color.dart';
import 'package:emp_care/screens/meeting/videoCall.dart';
import 'package:emp_care/screens/video_calling_agora/pages/index.dart';
import 'package:emp_care/widgets/listItems.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class MeetingForm extends StatefulWidget {
  @override
  _MeetingFormState createState() => _MeetingFormState();
}



class _MeetingFormState extends State<MeetingForm> {

  var clicked = new List();
  var linkToSend = new List();
  var allIds = new List();

  bool clickedBtn = false;

  String randomId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      randomId = randomAlpha(8);
    });
  }

  sendMeetingLink() async{
    var db = Firestore.instance.collection("Meeting").document(randomId);
   if(linkToSend.isNotEmpty) {
       await  db.setData({
         "To": linkToSend,
         "From": "Admin",
         "Time": Timestamp.now(),
         "meetingId": randomId,
         "status" : "online",
       });
       setState(() {
         clickedBtn = false;

       });
       Navigator.pushReplacement(context, MaterialPageRoute(
           builder: (context) => IndexPage(videoId: randomId,)
       ));

   }
   else{

       await db.setData({
         "To": allIds,
         "From": "Admin",
         "Time": Timestamp.now(),
         "meetingId": randomId,
         "status" : "online",
       });
       setState(() {
         clickedBtn = false;
       });
       Navigator.pushReplacement(context, MaterialPageRoute(
           builder: (context) => IndexPage(videoId: randomId,)
       ));
   }




  }



  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child : Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.fromBorderSide(BorderSide(color: Colors.red))
                  ),
                  child : SelectableText(
                      "Your Meeting Code is :  ${randomId}",
                       style: TextStyle(
                         fontSize: 18
                       ),
                  )
                ),
              ),

              Container(
                child : clickedBtn == false ?  MaterialButton(
                  onPressed: (){

                      sendMeetingLink();
                      setState(() {
                        clickedBtn = true;
                      });

                  },
                  minWidth: 150,
                  child :  Text( linkToSend.isEmpty ? "Send to all" : "Send Selected" ),
                  color: yellow,
                ) :  CircularProgressIndicator(backgroundColor: yellow,),
              ) ,

              Container(
                color: lightBlue,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Employees to share code',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    IconButton(
                       icon : Icon( Icons.search ),
                      onPressed: (){
                         print(linkToSend);
                      },
                    )
                  ],
                ),
              ),

              SizedBox(height: 5,),


              Flexible(
                child: StreamBuilder(
                  stream: Firestore.instance.collection("Users").orderBy("name").snapshots(),

                  builder: (context, snapshot){


                    return snapshot.hasData?  ListView.builder(itemCount: snapshot.data.documents.length,itemBuilder: (context, index){

                      DocumentSnapshot document = snapshot.data.documents[index];

                      clicked.add(0);
                      allIds.add(document.documentID);
                      String text = document['name'].toString().toUpperCase();
                      var tick = clicked[index];

                       return Column(
                         children: [
                           ListItems(

                                 color: tick == 0 ? blue : yellow,
                                 onPressed: (){
                                   setState(() {
                                      clicked[index] == 0 ?  clicked[index] = 1 : clicked[index] = 0;
                                      if(clicked[index] == 1) {
                                         linkToSend.add(document.documentID.toString());
                                      }
                                      else{
                                        linkToSend.remove(document.documentID.toString());
                                      }
                                   });
                                   print(tick);
                                 },

                                 title: text,

                                 icon:  clicked[index] == 1 ? Icons.check : null,

                               ),
                           SizedBox(height: 10,)
                         ],
                       );

                    })   : Container();
                  }

                ),
              )


            ],
          )
        ),
      ),
    );
  }
}
