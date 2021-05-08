import 'package:emp_care/assignTask.dart';
import 'package:emp_care/color/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeInfo extends StatefulWidget {
  final dynamic employeeId, email , name, leaves, address, phone;
  EmployeeInfo({this.employeeId,this.email,this.leaves,this.address,this.phone,this.name});

  @override
  _EmployeeInfoState createState() => _EmployeeInfoState();
}

class _EmployeeInfoState extends State<EmployeeInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
           title: Text("Employee Info"),
        ),

        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
               Container(
                 padding: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   color: blue,
                 ),

                 child: Row(
                   children: [
                     CircleAvatar(
                       maxRadius: 30,
                       backgroundImage: AssetImage(
                         'assets/images/dummy_profile.jpg'
                       ),
                     ),

                     SizedBox(width: 30,),

                     Text(
                       widget.name,
                       style: TextStyle(
                         fontSize: 20
                       ),
                     )
                   ],
                 ),
               ),
              SizedBox(height: 10,),

              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    SelectableText(
                      "Email : ${widget.email}" ,
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),

                    SizedBox(height: 10,),

                    SelectableText(
                      "Employee Id  : ${widget.employeeId} " ,
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),

                    SizedBox(height: 10,),

                    SelectableText(
                      "Address : ${widget.address}" ,
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),


                    SizedBox(height: 10,),

                    SelectableText(
                      "Leaves Remaining : ${widget.leaves}" ,
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),


                    SizedBox(height: 10,),

                    SelectableText(
                      "Phone : ${widget.phone}" ,
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10,),

              MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                height: 40,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AssignTask(userId : widget.employeeId),
                  ));
                },
                color: Colors.blue,
                child: Text(
                    "ASSIGN A TASK",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                ),
              )


            ],
          ),
        ),

    );
  }
}

