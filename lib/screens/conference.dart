import 'package:camera/camera.dart';
import 'package:emp_care/color/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'meeting/meeting_form.dart';

class Conference extends StatefulWidget {
  @override
  _ConferenceState createState() => _ConferenceState();
}
List<CameraDescription> cameras;
class _ConferenceState extends State<Conference> {

  CameraController controller;
  bool clicked = false;
  bool clickedMic = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCamera();
  }

  getCamera() async {
    cameras = await availableCameras();
    controller =  CameraController(cameras[1], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


  Widget onCamera() {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio:
        controller.value.aspectRatio,
        child: CameraPreview(controller));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.blueAccent,
         title: Text("Conference"),
       ),

      body: Container(
        
         child : Column(
           children: [
             Flexible(
               flex:15,
               child : Container(
                 width: MediaQuery.of(context).size.width,
                 child : Stack(
                     children : [
                       Container(child: clicked == false ? onCamera()  :Container(color: Colors.grey,), width: MediaQuery.of(context).size.width,),
                       Opacity(
                           opacity: 0.2,
                           child : Container(
                             color: Colors.blueGrey,
                           )
                       ),
                       Container(
                         padding: EdgeInsets.all(20),
                         alignment: Alignment.bottomCenter,
                         child : Row(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           children: [
                             Container(
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(50),
                                 color: clicked == false ?  Colors.transparent : red,
                                 border: Border.fromBorderSide(BorderSide(color: Colors.white)),
                               ),

                               child: IconButton(
                                 onPressed: (){
                                   clicked == true ?  setState(() {
                                        clicked = false;
                                    }) : setState((){
                                        clicked = true;
                                   });
                                 },
                                 icon: Icon(
                                   clicked == true ? Icons.videocam_off : Icons.videocam,
                                   color: white,
                                 ),
                               ),



                             ),
                             Container(
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(50),
                                 color: clickedMic == false ?  Colors.transparent : red,
                                 border: Border.fromBorderSide(BorderSide(color: Colors.white)),
                               ),

                               child: IconButton(
                                 onPressed: (){
                                   clickedMic == true ?  setState(() {
                                     clickedMic = false;
                                   }) : setState((){
                                     clickedMic = true;
                                   });
                                 },
                                 icon: Icon(
                                   clickedMic == true ? Icons.mic_off: Icons.mic,
                                   color: white,
                                 ),
                               ),
                             ),
                           ],
                         )
                       ),



                     ]
                 )
               )
             ),
             Flexible(
               flex:2,
               child: Container(
                 color: blue,
                 padding: EdgeInsets.all(20),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     OutlineButton(
                       highlightColor: Colors.green,
                       onPressed: (){
                         Navigator.push(context, MaterialPageRoute(
                            builder :  (context) => MeetingForm()
                         ));
                       },
                       child: Text("Start a new meeting"),
                     ),

                     SizedBox(width: 10,),

                     OutlineButton(
                       highlightColor: red,
                       onPressed: (){

                       },
                       child: Text("Generate a meeting link"),
                     )

                   ],
                 ),
               )
             ),

           ],
         )
      ),
    );
  }
}
