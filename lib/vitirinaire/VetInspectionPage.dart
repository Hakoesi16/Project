import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class VetInspectionPage extends StatefulWidget {
  const VetInspectionPage({super.key});

  @override
  State<VetInspectionPage> createState() => _VetInspectionPageState();
}

class _VetInspectionPageState extends State<VetInspectionPage> {
  //variables
  String? _selectedSmell;
  String? _selectedGillColor;
  String? _selectedFleshFirmness;
  bool _parasitesPresent = false;
  double _internalTemp = 1.2;
  double _freshnessScore = 85;
  TextEditingController _tempController = TextEditingController(text: "1.2");

  final List<String> _smellOptions = [
    "Neutral / Sea-like",
    "Strong",
    "Sour / Ammonia-like",
  ];

  final List<String> _gillColorOptions = [
    "Bright Red",
    "Brownish / Dark Red",
    "Gray / Green / Black",
  ];

  final List<String> _fleshFirmnessOptions = ["Firm", "Soft", "Very Soft"];

  //trial data
  VetInspection _inspection = VetInspection(
    batchId: "#FSH-99283",
    captainName: "Capt. Elias",
    vesselName: "Sea's King",
    latitude: 36.7,
    longitude: 3.1,
    photos: ["images/fish1.png", "images/fish2.png"],
  );

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7F9),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF0F172A),
        ),
        title: Text(
          "Vet Inspection",
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontFamily: "Inter",
            fontWeight: FontWeight.w700,
            fontSize: 24,
            letterSpacing: -0.6,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0x0F68E61A),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.qr_code_2,
                      color: Color(0xFF00A896),
                      size: 32,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Batch ID: #FSH-99283",
                        style: TextStyle(
                          color: Color(0xFF0F172A),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Capt. Elias • Vessel: Sea's King",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Block(),
            subTitle(title: 'CATCH LOCATION'),
            SizedBox(height: 130),

            Block(),
            subTitle(title: 'BATCH PHOTOS'),
            SizedBox(height: 140,),

            Block(),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Physical Assessment",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFF0F172A),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),

                  Block(),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Smell",style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF334155),
                            ),),
                            SizedBox(height: 6),
                            DropdownButtonFormField<String>(
                              value: _selectedSmell,
                              hint: Text("Select"),
                              items: _smellOptions.map((option) =>
                                DropdownMenuItem(
                                  value: option,
                                  child: Text(option, style: TextStyle(fontSize: 12)),
                                )
                              ).toList(),
                              onChanged: (value) => setState(() => _selectedSmell = value),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFD7FFE1),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Gill Color",style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF334155),
                            ),),
                            SizedBox(height: 6),
                            DropdownButtonFormField<String>(
                              value: _selectedGillColor,
                              hint: Text("Select"),
                              items: _gillColorOptions.map((option) =>
                                DropdownMenuItem(
                                  value: option,
                                  child: Text(option, style: TextStyle(fontSize: 12)),
                                )
                              ).toList(),
                              onChanged: (value) => setState(() => _selectedGillColor = value),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFFFFCD7),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Block(),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Flesh Firmness",style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF334155),
                            ),),
                            SizedBox(height: 6),
                            DropdownButtonFormField<String>(
                              value: _selectedFleshFirmness,
                              hint: Text("Select Flesh Firmness"),
                              items: _fleshFirmnessOptions.map((option) =>
                                DropdownMenuItem(
                                  value: option,
                                  child: Text(option, style: TextStyle(fontSize: 12)),
                                )
                              ).toList(),
                              onChanged: (value) => setState(() => _selectedFleshFirmness = value),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFFF8FAFC),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Color(0xFFE2E8F0)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Parasites Present",style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF334155),
                            ),),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => _parasitesPresent = true),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: _parasitesPresent
                                            ? Color(0x0F68E61A)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: _parasitesPresent
                                              ? Color(0xFF00A896)
                                              : Color(0xFFE2E8F0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Yes",
                                          style: TextStyle(
                                            color: _parasitesPresent
                                                ? Color(0xFF00A896)
                                                : Color(0xFF0F172A),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => setState(() => _parasitesPresent = false),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: !_parasitesPresent
                                            ? Color(0x0F68E61A)
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: !_parasitesPresent
                                              ? Color(0xFF00A896)
                                              : Color(0xFFE2E8F0),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "No",
                                          style: TextStyle(
                                            color: !_parasitesPresent
                                                ? Color(0xFF00A896)
                                                : Color(0xFF0F172A),
                                            fontFamily: 'Inter',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Block(),

                  Row(
                    children: [
                      Text("Internal Temperature (°C)",style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF334155),
                      ),),
                      Spacer(),
                      Text(
                        "${_tempController.text}°C",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF00A896),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  TextFormField(
                    controller: _tempController,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => setState(() {}),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF8FAFC),
                      suffixIcon: Icon(Icons.thermostat, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                    ),
                  ),

                  Block(),

                  Row(
                    children: [
                      Text("Overall Freshness Score",style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Color(0xFF334155),
                      ),),
                      Spacer(),
                      Text(
                        "${_freshnessScore.toInt()}/100",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          color: Color(0xFF00A896),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  LinearPercentIndicator(
                    percent: _freshnessScore / 100,
                    lineHeight: 10,
                    backgroundColor: Color(0xFFE2E8F0),
                    progressColor: Color(0xFF00A896),
                    barRadius: Radius.circular(8),
                    padding: EdgeInsets.zero,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text("POOR", style: TextStyle(color: Color(0xFF94A3B8), fontSize: 10,fontFamily: 'Inter',fontWeight: FontWeight.w700)),
                      Spacer(),
                      Text("EXCELLENT", style: TextStyle(color: Color(0xFF94A3B8), fontSize: 10,fontFamily: 'Inter',fontWeight: FontWeight.w700)),
                    ],
                  ), 

                  Block(),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.cancel_outlined),
                          label: Text("Reject",style: TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w700,fontSize: 16,color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFEF4444),
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: Color(0xFFEF4444),
                            elevation: 5,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.check_circle_outline),
                          label: Text("Approve",style: TextStyle(fontFamily: 'Inter',fontWeight: FontWeight.w700,fontSize: 16, color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF10B981),
                            foregroundColor: Colors.white,
                            minimumSize: Size(double.infinity, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadowColor: Color(0xFF10B981),
                            elevation: 5,
                          ),
                        ),
                      ),
                    ],
                  ),






                ],
              ),
            ),





          ],
        ),
      ),
    );
  }
}

class VetInspection {
  final String batchId;
  final String captainName;
  final String vesselName;
  final double latitude;
  final double longitude;
  final List<String> photos;
  String? smell;
  String? gillColor;
  String? fleshFirmness;
  bool? parasitesPresent;
  double? internalTemp;

  VetInspection({
    required this.batchId,
    required this.captainName,
    required this.vesselName,
    required this.latitude,
    required this.longitude,
    required this.photos,
    this.smell,
    this.gillColor,
    this.fleshFirmness,
    this.parasitesPresent,
    this.internalTemp,
  });
}

class Block extends StatelessWidget {
  const Block({super.key});
  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 20);
  }
}



class subTitle extends StatelessWidget {
  final String? title;
  subTitle({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$title",
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
        color: Color(0xFF94A3B8)
      ),
    );
  }
}