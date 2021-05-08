import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_care/color/color.dart';
import 'package:emp_care/screens/post_announcement.dart';
import 'package:emp_care/widgets/indicator.dart';
import 'package:emp_care/widgets/listItems.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'conference.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int touchedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         child : SingleChildScrollView(
           scrollDirection: Axis.vertical,
           child: Column(
             children: [
               SizedBox(height: 20,),
               Container(
                 child : SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: Row(
                     children: [
                       SizedBox(width: 10,) ,
                       Container(
                         padding: EdgeInsets.all(20),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                           color: yellow,
                         ),
                         
                         width:  MediaQuery.of(context).size.width*0.70,

                           child : Column(
                             children: [
                               Container(
                                 alignment :  Alignment.centerLeft,
                                 child: Text(
                                     "ANNOUNCEMENT",
                                      style : TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                      )
                                 ),
                               ),
                               Container(
                                 alignment :  Alignment.centerLeft,
                                 child: Text(
                                     "Post Daily Announcements",
                                     style : TextStyle(
                                       fontSize: 16,
                                       fontWeight: FontWeight.w500,
                                     )
                                 ),
                               ),

                               SizedBox(height: 15,),
                               Container(
                                 alignment: Alignment.centerLeft,
                                 child: Image(
                                   height: 40,
                                   image: AssetImage('assets/icons/announcement.png'),
                                 ),
                               ),
                               SizedBox(height: 10,),
                               Container(
                                 alignment: Alignment.centerRight,
                                 child: MaterialButton(
                                   elevation: 1,
                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                   onPressed: (){
                                     Navigator.push(context, MaterialPageRoute(
                                       builder: (context) => PostAnnouncement()
                                     ));
                                   },
                                   color: Colors.redAccent,
                                   child: Text(
                                       "POST",
                                        style : TextStyle(
                                          color : white,
                                        )
                                   ),
                                 ),
                               ),

                             ],
                           )
                       ),
                       SizedBox(width: 10,) ,




                       Container(
                           padding: EdgeInsets.all(20),

                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(20),
                             color: blue,
                           ),

                           width:  MediaQuery.of(context).size.width*0.70,

                           child : Column(
                             children: [
                               Container(
                                 alignment :  Alignment.centerLeft,
                                 child: Text(
                                     "CONFERENCE",
                                     style : TextStyle(
                                       fontSize: 24,
                                       fontWeight: FontWeight.w500,
                                     )
                                 ),
                               ),
                               Container(
                                 alignment :  Alignment.centerLeft,
                                 child: Text(
                                     "Start a conference",
                                     style : TextStyle(
                                       fontSize: 16,
                                       fontWeight: FontWeight.w500,
                                     )
                                 ),
                               ),

                               SizedBox(height: 15,),
                               Container(
                                 alignment: Alignment.centerLeft,
                                 child: Image(
                                   height: 40,
                                   image: AssetImage('assets/icons/video_con.png'),
                                 ),
                               ),
                               SizedBox(height: 10,),
                               Container(
                                 alignment: Alignment.centerRight,
                                 child: MaterialButton(
                                   elevation: 1,
                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                   onPressed: (){
                                     Navigator.push(context, MaterialPageRoute(
                                       builder: (context) => Conference(),
                                     ));
                                   },
                                   color: Colors.blueAccent,
                                   child: Text(
                                       "START",
                                       style : TextStyle(
                                         color : white,
                                       )
                                   ),
                                 ),
                               ),

                             ],
                           )
                       ),
                       SizedBox(width: 15,)
                     ],
                   ),
                 )
               ),

              SizedBox(height: 10,),

              //Pie Chart..
              Container(
                height: 180,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 2,
                    ),
                    PieChart(
                      PieChartData(
                          pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                            setState(() {
                              if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                  pieTouchResponse.touchInput is FlPanEnd) {
                                touchedIndex = -1;
                              } else {
                                touchedIndex = pieTouchResponse.touchedSectionIndex;
                              }
                            });
                          }),
                          borderData: FlBorderData(
                            show: false,

                          ),



                          sectionsSpace: 0,
                          centerSpaceRadius: 30,
                          sections: showingSections()),
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Indicator(
                          color: Colors.red,
                          text: 'ON LEAVE',
                          isSquare: true,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Indicator(
                          color: Colors.green,
                          text: 'PRESENT',
                          isSquare: true,
                        ),
                        
                      ],
                    ),

                  ],
                ),
              ),


              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child  : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Recent Announcements",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                    ),
                    Image(
                      height: 24,
                      image: AssetImage('assets/icons/announcement.png'),
                    )

                  ],
                )
              ),

              SizedBox(height: 10,),


               StreamBuilder(
                   stream:  Firestore.instance.collection("Announcement").orderBy("time",descending: true).snapshots(),
                   builder: (context,snapshot) {
                     return snapshot.hasData ?  Column(
                         children: List.generate(snapshot.data.documents.length, (index) {
                           DocumentSnapshot document =snapshot.data.documents[index];
                           return Column(
                             children: [
                               ListItems(
                                 color: index%2!=0 ?  Colors.green : Colors.blue,
                                 titleColor: Colors.white,
                                 title: document['Announcement'],
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
           ),
         )
      )
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.green,
            value: 70,
            title: '70%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: red,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );

        default:
          return null;
      }
    });
  }



}
