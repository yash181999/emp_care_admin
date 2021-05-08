import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_care/color/color.dart';
import 'package:emp_care/employ_info.dart';
import 'package:emp_care/widgets/listItems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Members extends StatefulWidget {
  @override
  _MembersState createState() => _MembersState();
}

class _MembersState extends State<Members> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
         child : Column(
           children: [
             Container(
               color: lightBlue,
               padding: EdgeInsets.all(10),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text(
                       'Employees List',
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
               stream:  Firestore.instance.collection("Users").snapshots(),
               builder: (context,snapshot) {
                 return snapshot.hasData ?  Column(
                   children: List.generate(snapshot.data.documents.length, (index) {
                     DocumentSnapshot document =snapshot.data.documents[index];
                       return Column(
                         children: [
                           ListItems(
                             onPressed: (){
                               Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => EmployeeInfo(
                                      employeeId : document.documentID.toString(),
                                      name: document['name'],
                                      phone: document['phone'],
                                      leaves: document['leavesRemaining'],
                                      email: document['email'],
                                      address: document['address'],

                                  ),
                               ));
                             },
                             color: index%2!=0 ?  Colors.green : Colors.blue,
                             titleColor: Colors.white,
                             title: document['name'].toString().toUpperCase(),
                             icon: Icons.info,
                             iconColor: Colors.white,
                           ),

                           SizedBox(height: 10,),

                         ],
                       );
                   })
                 ) : Container();
               }
             )



           ],
         )
       ),
    );
  }
}
