import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'color/color.dart';

class AssignTask extends StatefulWidget {
  final dynamic  userId;
  AssignTask({this.userId});
  @override
  _AssignTaskState createState() => _AssignTaskState();
}

class _AssignTaskState extends State<AssignTask> {

  bool clicked = false;

  final taskText = TextEditingController();

  Firestore db = Firestore.instance;


  submit() async{
    await db.collection("Tasks").document().setData({

      "Task" :  taskText.text,
      "time" : Timestamp.now().toDate().toString(),
      "timeStamp " : Timestamp.now(),
      "userId" : widget.userId,
    });

    setState(() {

      clicked = false;

      taskText.text = "";
    });

    Navigator.pop(context);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: black,
          ),
          backgroundColor: Colors.blue,
          title: Text(
              "Assign Task",
              style : TextStyle(
                color: Colors.white,
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
                    controller: taskText,

                    style: TextStyle(
                        fontSize: 20
                    ),
                    minLines:10 ,
                    maxLines: 200,
                    decoration: InputDecoration(
                      labelText: "Write the TASK",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),

                clicked == false ? MaterialButton(
                  onPressed: (){

                    if(taskText.text.isNotEmpty){
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

