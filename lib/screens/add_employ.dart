import 'package:emp_care/color/color.dart';
import 'package:emp_care/database/auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:random_string/random_string.dart';

class AddEmploy extends StatefulWidget {
  @override
  _AddEmployState createState() => _AddEmployState();
}

class _AddEmployState extends State<AddEmploy> {

  AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final phoneTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();
  final idProofTextEditingController = TextEditingController();
  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final loginPassword = TextEditingController();
  final loginEmail = TextEditingController();


  bool clicked = false;

  String passwordText = "";

   submitButton() async {

      if(_formKey.currentState.validate()) {


           String password = randomAlphaNumeric(8);
           setState(() {
             passwordText = password;
           });
          dynamic userId = await _authService.registerWithEmailAndPassword(
            email: emailTextEditingController.text,
            password: password,
            name: nameTextEditingController.text,
            address : addressTextEditingController.text,
            phone: phoneTextEditingController.text,
            idProof:  idProofTextEditingController.text,
          );


          await sendEmail();

          setState(() {
            nameTextEditingController.text = "";
            emailTextEditingController.text = "";
            addressTextEditingController.text = "";
            password = "";
            passwordText= "";
            phoneTextEditingController.text = "";
            idProofTextEditingController.text = "";
            clicked = false;
        });



      }


  }


  sendEmail() async{
    String username = 'bloodbankmeaww@gmail.com';
    String password = 'qwertyuiop@123';

    final smtpServer = gmail(username, password);
    // Use the SmtpServer class to configure an SMTP server:
    // final smtpServer = SmtpServer('smtp.domain.com');
    // See the named arguments of SmtpServer for further configuration
    // options.

    // Create our message.
    final message = Message()
      ..from = Address(username, nameTextEditingController.text)
      ..recipients.add(emailTextEditingController.text)
      ..subject = 'EMPCARE'
      ..text = 'Login credentials'
      ..html = "<h1>Credentials</h1>\n<p> Your Email Id is : ${emailTextEditingController.text} <br> Password is : ${passwordText.toString()} </p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    // DONE

    final equivalentMessage = Message()
      ..from = Address(username, 'Your name')
      ..recipients.add(Address('destination@example.com'))
      ..ccRecipients.addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
      ..bccRecipients.add('bccAddress@example.com')
      ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

    final sendReport2 = await send(equivalentMessage, smtpServer);

    // Sending multiple messages with the same connection
    //
    // Create a smtp client that will persist the connection
    var connection = PersistentConnection(smtpServer);

    // Send the first message
    await connection.send(message);

    // send the equivalent message
    await connection.send(equivalentMessage);

    // close the connection
    await connection.close();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
       body : Center(
         child: SingleChildScrollView(
           scrollDirection: Axis.vertical,
           child: Container(
             padding: EdgeInsets.all(50),
             width: MediaQuery.of(context).size.width,
             alignment: Alignment.center,
             child : Form(
               key : _formKey,
               child: Column(

                 children: [

                   SizedBox(height : 25),

                   Container(child:
                        Text("ADD A NEW EMPLOYEE",
                          style :TextStyle(fontWeight: FontWeight.w500, fontSize: 20,)
                        )
                   ),

                   SizedBox(height: 30),


                   TextFormField(
                     controller: nameTextEditingController,
                     validator: (value) {
                       if(value.isEmpty) {
                         return "Field is empty";
                       }

                       return null;
                     },
                     decoration: InputDecoration(
                         border : OutlineInputBorder(),
                         labelText: "FULL NAME"
                     ),
                   ),

                   SizedBox(height: 30),


                   TextFormField(
                     controller: emailTextEditingController,
                     validator: (value) {
                       if(value.isEmpty) {
                         return "Field is empty";
                       }
                       if(!RegExp(r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                           .hasMatch(value)) {
                         return "Invalid Email";
                       }

                       return null;
                     },
                     decoration: InputDecoration(

                       border : OutlineInputBorder(),
                       labelText: "EMAIL ID"
                     ),
                   ),

                   SizedBox(height: 30),


                   TextFormField(
                     controller: phoneTextEditingController,
                     validator: (value) {
                       if(value.isEmpty) {
                         return "Field is empty";
                       }
                       if(value.toString().length > 10 || value.toString().length < 10){
                         return "Invalid Phone Number";
                       }

                       return null;
                     },
                     decoration: InputDecoration(
                         border : OutlineInputBorder(),
                         labelText: "PHONE NUMBER"
                     ),
                   ),


                   SizedBox(height: 30),

                   TextFormField(
                     controller: addressTextEditingController,
                     validator: (value) {
                       if(value.isEmpty) {
                         return "Field is empty";
                       }


                       return null;
                     },
                     decoration: InputDecoration(
                         border : OutlineInputBorder(),
                         labelText: "ADDRESS"
                     ),
                   ),

                   SizedBox(height: 30),

                   TextFormField(
                     controller: idProofTextEditingController,
                     validator: (value) {
                       if(value.isEmpty) {
                         return "Field is empty";
                       }
                       return null;
                     },
                     decoration: InputDecoration(
                         border : OutlineInputBorder(),
                         labelText: "ID PROOF"
                     ),
                   ),

                   SizedBox(height: 30),

                   clicked == false ? Container(
                     width: MediaQuery.of(context).size.width*0.30,
                     height: 40,
                     child: MaterialButton(
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                       color: purple,
                       onPressed: () {
                         if(_formKey.currentState.validate()) {
                           setState(() {
                             clicked = true;
                           });
                           submitButton();
                         }

                       },
                       child: Text("SUBMIT",
                           style : TextStyle(color: white)
                       ),
                     ),
                   ) : CircularProgressIndicator()

                 ],
               ),
             )
           ),
         ),
       )
    );
  }
}
