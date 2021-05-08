import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_care/color/color.dart';
import 'package:emp_care/screens/request_info.dart';
import 'package:emp_care/widgets/listItems.dart';
import 'package:flutter/material.dart';

class Requests extends StatefulWidget {
  @override
  _RequestsState createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
          child : Column(
            children: [
              Container(
                color: lightBlue,
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Leave request',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Icon(
                        Icons.search
                    )
                  ],
                ),
              ),

              SizedBox(height: 10,),


              StreamBuilder(
                stream: Firestore.instance.collection("LeaveRequests").where("status",isEqualTo: "Pending")
                    .orderBy("temStamp",descending: true).snapshots(),
                builder: (context,snapshot){
                  return snapshot.hasData ?  Column(
                    children: List.generate(snapshot.data.documents.length, (index) {
                      DocumentSnapshot doc = snapshot.data.documents[index];
                      return Column(
                        children: [
                          ListItems(
                            color:Colors.blue,
                            titleColor: Colors.white,
                            title: doc['userName'],
                            icon: Icons.info,
                            iconColor: Colors.white,
                            onPressed: (){
                               Navigator.push(context, MaterialPageRoute(
                                 builder: (context) =>
                                     RequestInfo(
                                       employeeName: doc['userName'],
                                       employeeId: doc['userId'],
                                       reason: doc['reason'],
                                       toDate: doc['toDate'],
                                       fromDate: doc['fromDate'],
                                       docId : doc.documentID,
                                     )
                               ));
                            },
                          ),
                          SizedBox(height: 10,),
                        ],
                      );
                    }),
                  ): Container();
                }
              ),







//              Container(
//                  child : Column(
//                    children: [
//                      Container(
//                        color: lightBlue,
//                        padding: EdgeInsets.all(10),
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: [
//                            Text(
//                              'Conference Requests',
//                              style: TextStyle(
//                                fontSize: 20,
//                                fontWeight: FontWeight.w400,
//                              ),
//                            ),
//                            Icon(
//                                Icons.search
//                            )
//                          ],
//                        ),
//                      ),
//
//                      SizedBox(height: 10,),
//
//                      ListItems(
//                        color:Colors.blue,
//                        titleColor: Colors.white,
//                        title: "YASH MEHTA",
//                        icon: Icons.info,
//                        iconColor: Colors.white,
//                        onPressed: (){},
//                      )
//
//
//                    ],
//                  )
//              ),


            ],
          )
      ),
    );
  }
}
