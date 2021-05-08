import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestInfo extends StatefulWidget {

 final dynamic employeeId, employeeName, reason, fromDate, toDate,docId;

 RequestInfo({this.employeeId,this.employeeName,this.reason,this.fromDate,this.toDate,this.docId});

  @override
  _RequestInfoState createState() => _RequestInfoState();
}

class _RequestInfoState extends State<RequestInfo> {

  bool clicked = false;

  accept()async{
    await Firestore.instance.collection("LeaveRequests").document(widget.docId).updateData({
        "status" : "Accepted",
    });
    setState(() {
      clicked = false;
    });

    Navigator.pop(context);

  }
  reject()async{
    await Firestore.instance.collection("LeaveRequests").document(widget.docId).updateData({
      "status" : "Rejected",
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Request Info'),
       ),

      body: Container(
        padding: EdgeInsets.all(10),
         child: Column(
           children: [
             Container(
               padding: EdgeInsets.all(20),
               child: Container(
                   alignment: Alignment.center,
                   padding: EdgeInsets.all(20),
                   decoration: BoxDecoration(
                       border: Border.fromBorderSide(BorderSide(color: Colors.red))
                   ),
                   child : Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SelectableText(
                         "Emloyee Id  : ${widget.employeeId} " ,
                         style: TextStyle(
                             fontSize: 18
                         ),
                       ),

                       SelectableText(
                         "Employee Name : ${widget.employeeName} " ,
                         style: TextStyle(
                             fontSize: 18
                         ),
                       ),


                       SelectableText(
                         "Reason  : ${widget.reason}" ,
                         style: TextStyle(
                             fontSize: 18
                         ),
                       ),



                       SelectableText(
                         "From  : ${widget.fromDate}" ,
                         style: TextStyle(
                             fontSize: 18
                         ),
                       ),

                       SelectableText(
                         "From  : ${widget.toDate}" ,
                         style: TextStyle(
                             fontSize: 18
                         ),
                       ),

                     ],
                   )
               ),
             ),
             
             Container(
               child: clicked == false ?  MaterialButton(
                 minWidth: MediaQuery.of(context).size.width,
                 onPressed: (){
                   setState(() {
                     clicked = true;
                   });
                   accept();
                 },
                 color: Colors.green,
                 child: Text(
                     "Accept",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                 ),
               ) : CircularProgressIndicator(backgroundColor: Colors.green,)
             ),

             Container(

               child:clicked == false ?  MaterialButton(
                 minWidth: MediaQuery.of(context).size.width,
                 onPressed: (){
                   setState(() {
                     clicked = true;
                   });
                   reject();
                 },
                 color: Colors.redAccent,
                 child: Text(
                   "Reject",
                   style: TextStyle(
                     color: Colors.white,
                   ),
                 ),
               ): CircularProgressIndicator(backgroundColor: Colors.redAccent,)
             )
             
           ],
         ),
        
        
        
      ),



    );
  }
}
