import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.all(10),
            child: StreamBuilder(
              stream: Firestore.instance.collection("Feedback").orderBy("timeStamp",descending: true).snapshots(),
              builder: (context,snapshot){
                return snapshot.hasData ?  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(snapshot.data.documents.length, (index) {
                    DocumentSnapshot doc = snapshot.data.documents[index];
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Candidate Name : ${doc['Candidate Name']}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize : 18,
                                ),
                              ),

                              SizedBox(height : 5),

                              Text(
                                "Interview Name : ${doc['Interviewer Name']}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize : 18,
                                ),
                              ),

                              SizedBox(height : 5),

                              Text(
                                "Rating : ${doc['Rating']}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize : 18,
                                ),
                              ),

                              SizedBox(height : 5),


                              Text(
                                "Role : ${'Role'}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize : 18,
                                ),
                              ),

                              SizedBox(height : 5),


                              Text(
                                "Comment : ${doc['comment']}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize : 18,
                                ),
                              ),

                              SizedBox(height : 5),

                            ],
                          ),
                        ),
                        SizedBox(height : 10),
                      ],
                    );
                  }),
                ): Container();
              }

            ),
          ),
       ),
    );
  }
}
