import 'package:flutter/material.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:projetsndcp/picheur/myBatches.dart';

class BatchDetailspage extends StatefulWidget{
  final BatchItem batch;
  const BatchDetailspage({super.key, required this.batch});
  @override State<BatchDetailspage> createState() => _BatchDetailsState();
}

class _BatchDetailsState extends State<BatchDetailspage> {
  final List<Map<String, String>> events = [
    {
      "title": "Approved by Market Manager",
      "subtitle": "Oct 25, 09:15 AM • John Doe",
    },
    {
      "title": "Pending Review",
      "subtitle": "Oct 24, 06:45 AM • Quality Control",
    },
    {
      "title": "Batch Created",
      "subtitle": "Oct 24, 05:40 AM • Captain Sarah",
    },
  ];

  bool _approved = false;
  bool _pending = false;
  bool _rejected = false;

  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7F9),
      appBar: AppBar(
        leading: IconButton(onPressed: (){},icon: Icon(Icons.arrow_back),color: Color(0xFF0F172A)),
        title: Text("Batch Details", style: TextStyle(
          color: Color(0xFF0F172A),
          fontFamily: "Inter",
          fontWeight: FontWeight.w700,
          fontSize: 24,
          letterSpacing: -0.6,
        ),textAlign: TextAlign.center,),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: 396,
              height: 78,
              decoration: BoxDecoration(
                color: Color(0xFFECFDF5),
                borderRadius: BorderRadiusGeometry.circular(13),
                border: BoxBorder.all(
                  color: Color(0xFFD1FAE5),
                  width: 1.5,
                )
              ),
              child: Row(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle,color: Color(0xFF10B981),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("CURRENT STATUS", style: TextStyle(
                        color: Color(0xFF065F46),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                        letterSpacing: 0.6
                      ),),
                      Text("APPROVED", style: TextStyle(
                          color: Color(0xFF065F46),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                      ),),

                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              spacing: 5,
              children: [
                Icon(Icons.sailing_outlined,color: Color(0xFF023E77)),
                Text("Catch Details",style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(15),
              height: 86,
              width: 396,
              decoration: BoxDecoration(
                  color: Color(0xFFF8FAFC),
                  borderRadius: BorderRadiusGeometry.circular(13),
                  border: BoxBorder.all(
                    color: Color(0xFFE2E8F0),
                    width: 0.5,
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Fish name",style: TextStyle(
                    color: Color(0xFF64748B),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),),
                  Text("Sardine",style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),),
                ],
              ),
            ),
            SizedBox(height: 15),
            Row(
              spacing: 15,
              children: [
                Expanded(child:Container(
                  padding: EdgeInsets.all(15),
                  height: 86,
                  width: 396,
                  decoration: BoxDecoration(
                      color: Color(0xFFF8FAFC),
                      borderRadius: BorderRadiusGeometry.circular(13),
                      border: BoxBorder.all(
                        color: Color(0xFFE2E8F0),
                        width: 0.5,
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Weight",style: TextStyle(
                        color: Color(0xFF64748B),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),),
                      Text("45.5 kg",style: TextStyle(
                        color: Color(0xFF0F172A),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),),
                    ],
                  ),
                ),),
                Expanded(child: Container(
                  padding: EdgeInsets.all(15),
                  height: 86,
                  width: 396,
                  decoration: BoxDecoration(
                      color: Color(0xFFF8FAFC),
                      borderRadius: BorderRadiusGeometry.circular(13),
                      border: BoxBorder.all(
                        color: Color(0xFFE2E8F0),
                        width: 0.5,
                      )
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Value",style: TextStyle(
                        color: Color(0xFF64748B),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),),
                      Text("1,137.50 DA",style: TextStyle(
                        color: Color(0xFF023E77),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),),
                    ],
                  ),
                ),)
              ],
            ),
            SizedBox(height: 20),
            Row(
              spacing: 5,
              children: [
                Icon(Icons.article_outlined,color: Color(0xFF023E77)),
                Text("Log Details",style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(13),
              height: 172, 
              width: 389,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadiusGeometry.circular(13),
                border: BoxBorder.all(
                  color: Color(0xFFE2E8F0),
                  width: 0.5,
                )
              ),
              child: Column(
                children: [
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.calendar_today_outlined,color: Color(0xFF94A3B8),),
                          Text("Date & Time",style: TextStyle(
                            color: Color(0xFF475569),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),)
                        ],
                      ),
                      Text("Oct 24, 05:30 AM",style: TextStyle(
                        color: Color(0xFF0F172A),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),),
                    ],
                  )),
                  Divider(color: Color(0xFFF1F5F9), thickness: 1,),
                  Expanded(child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.directions_boat_outlined,color: Color(0xFF94A3B8),),
                          Text("Vessel Name ",style: TextStyle(
                            color: Color(0xFF475569),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),)
                        ],
                      ),
                      Text("Sea's King",style: TextStyle(
                        color: Color(0xFF0F172A),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),),
                    ],
                  )),
                  Divider(color: Color(0xFFF1F5F9), thickness: 1,),
                  Expanded(child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.calendar_today_outlined,color: Color(0xFF94A3B8),),
                          Text("Catch Method",style: TextStyle(
                            color: Color(0xFF475569),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),)
                        ],
                      ),
                      Text("Longline",style: TextStyle(
                        color: Color(0xFF0F172A),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),),
                    ],
                  )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              spacing: 5,
              children: [
                Icon(Icons.location_on_outlined,color: Color(0xFF023E77)),
                Text("Catch Location",style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
              ],
            ),
            SizedBox(height: 20),
            Container(
              height: 192,
              width: 394,
              decoration: BoxDecoration(
                color: Color(0xFFE2E8F0),
                borderRadius: BorderRadiusGeometry.circular(13),
                border: BoxBorder.all(
                  color: Color(0xFFE2E8F0),
                  width: 0.5,
                )
              ),
            ),
            SizedBox(height: 20),
            Row(
              spacing: 5,
              children: [
                Icon(Icons.photo_library_outlined,color: Color(0xFF023E77)),
                Text("Catch Photos",style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
                Spacer(),
                Text("View All (4)",style: TextStyle(
                  color: Color(0xFF023E77),
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),)
              ],
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 8,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(13),
                    child: Image.asset("images/fish1.png",
                      width: 139,
                      height: 127,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(13),
                    child: Image.asset("images/fish2.png",
                      width: 139,
                      height: 127,
                      fit: BoxFit.cover,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(13),
                    child: Image.asset("images/fish3.jpg",
                      width: 139,
                      height: 127,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              spacing: 5,
              children: [
                Icon(Icons.history,color: Color(0xFF023E77)),
                Text("Status History",style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),),
              ],
            ),
            SizedBox(height: 5),
            FixedTimeline.tileBuilder(
              theme: TimelineThemeData(
                nodePosition:  0,
                connectorTheme: ConnectorThemeData(
                  color: Colors.red,
                  thickness: 2,
                ),
              ),
              builder: TimelineTileBuilder.connected(
                itemCount: events.length,
                itemExtent: 80,

                connectorBuilder: (context, index, type) => SolidLineConnector(
                  color: Color(0xFF023E77),
                  thickness: 2,
                ),
                indicatorBuilder: (context, index) => DotIndicator(
                  color: index == 0? Color(0xFF023E77):Color(0xFFC4D3E0),
                  size: 16,
                  border: BoxBorder.all(
                    color: Color(0xFFFFFFFF),
                    width: 3.5,
                  ),
                ),
                contentsBuilder: (context, index) => Padding(
                    padding: EdgeInsetsGeometry.only(left: 8,top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${events[index]["title"]}",style: TextStyle(
                        color: Color(0xFF0F172A),
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        ),),
                        SizedBox(height: 1,),
                        Text("${events[index]["subtitle"]}",style: TextStyle(
                            color: Color(0xFF64748B),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                        )),
                      ],
                    ),
                ),
              )
            ),
            SizedBox(height: 20),
            Container(
              height: 56,
              width: 389,
              child:ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF023E77),
                  foregroundColor: Color(0xFFFFFFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(13),
                  ),
                  alignment: AlignmentGeometry.center,
                ),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save_alt_outlined,size: 20),
                    SizedBox(width: 10,),
                    Text("Download Receipt (PDF)", style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}