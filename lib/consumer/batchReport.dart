import 'package:flutter/material.dart';

class BatchReportPage extends StatefulWidget {
  const BatchReportPage({super.key});

  @override
  State<BatchReportPage> createState() => _BatchReportPageState();
}

class _BatchReportPageState extends State<BatchReportPage> {

  BatchReport _report = BatchReport(
    fishName         : "Sardine",
    batchNumber      : "Batch #FT-5829",
    fisherName       : "Captain Elias",
    catchDate        : "Oct 24, 2023",
    inspectionDate   : "Oct 25, 2023 04:00PM",
    inspectorName    : "Dr Ahmed Nacer",
    inspectorLicense : "ID LICENCE #MAR 5542",
    freshnessScore   : 85,
    smell            : "Neutral / Sea-like",
    eyeClarity       : "Clear / Bright",
    fleshFirmness    : "Firm",
    gillColor        : "Brownish / Dark Red",
    temperature      : 1.2,
    conclusion       : "The fish is exceptionally fresh and fully compliant with all marine safety standards. Suitable for immediate consumption.",
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7F9),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF0F172A),
        ),
        title: Text(
          "Batch Report",
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
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Block(),
          SubTitle(subTitle: "Batch Informations",),
          Block(),

          Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Fish Name + Batch Number
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _report.fishName,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFFD5A439),
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                              letterSpacing: -0.6,
                            ),
                          ),
                          Text(
                            _report.batchNumber,
                            style: TextStyle(
                              color: Color(0xFF3F484C),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        width: 205,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          border: BoxBorder.all(
                            color: Color(0xFFE2E8F0),
                          )
                        ),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "FISHER NAME",
                              style: TextStyle(
                                color: Color(0xFF6F787D),
                                fontSize: 10,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              _report.fisherName,
                              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,fontFamily: 'Inter',color: Color(0xFF191C1D)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Catch Date + Inspection Date
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          border: BoxBorder.all(
                            color: Color(0xFFE2E8F0),
                          )
                        ),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CATCH DATE",
                              style: TextStyle(
                                color: Color(0xFF6F787D),
                                fontSize: 10,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              _report.catchDate,
                              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,fontFamily: 'Inter',color: Color(0xFF191C1D)),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 205,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          border: BoxBorder.all(
                            color: Color(0xFFE2E8F0),
                          )
                        ),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "INSPECTION DATE",
                              style: TextStyle(
                                color: Color(0xFF6F787D),
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              _report.inspectionDate,
                              style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,fontFamily: 'Inter',color: Color(0xFF191C1D)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),

            Block(),

            SubTitle(subTitle: "Inspection Details",),
            Block(),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Inspector Details
                  Text(
                    "Inspector Details",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFF334155),
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.person_outlined,
                          color: Colors.amber[700],
                          size: 28,
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _report.inspectorName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _report.inspectorLicense,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Quality Inspection
                  Text(
                    "Quality Inspection",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFF334155),
                    ),
                  ),
                  SizedBox(height: 12),

                  // Freshness Score
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.star_outline,
                          color: Colors.amber[700],
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "OVERALL FRESHNESS SCORE",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${_report.freshnessScore}/100",
                                  style: TextStyle(
                                    color: Colors.amber[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            LinearProgressIndicator(
                              value: _report.freshnessScore / 100,
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation(Colors.amber[700]!),
                              minHeight: 6,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Divider(height: 24),

                  // Quality Items
                  _qualityItem(
                    icon  : Icons.air,
                    label : "SMELL",
                    value : _report.smell,
                  ),
                  Divider(height: 16),
                  _qualityItem(
                    icon  : Icons.visibility_outlined,
                    label : "EYE CLARITY",
                    value : _report.eyeClarity,
                  ),
                  Divider(height: 16),
                  _qualityItem(
                    icon  : Icons.back_hand_outlined,
                    label : "FLESH FIRMNESS",
                    value : _report.fleshFirmness,
                  ),
                  Divider(height: 16),
                  _qualityItem(
                    icon  : Icons.water_drop_outlined,
                    label : "GILL COLOR",
                    value : _report.gillColor,
                  ),
                  Divider(height: 16),
                  _qualityItem(
                    icon  : Icons.thermostat,
                    label : "TEMPERATURE",
                    value : "${_report.temperature}°C",
                  ),

                ],
              ),
            ),

            Block(),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.amber[200]!),
              ),
              child: Text(
                '"${_report.conclusion}"',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic,
                  fontSize: 13,
                ),
              ),
            ),

            SizedBox(height: 16),

            // ── Download Certificate Button ───────
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {},
                // //onPressed: () async {
                //   final url = Uri.parse(
                //     "YOUR_BACKEND_URL/api/batches/certificate.pdf",
                //   );
                //   if (await canLaunchUrl(url)) {
                //     await launchUrl(url, mode: LaunchMode.externalApplication);
                //   }
                // },
                icon: Icon(Icons.download_outlined),
                label: Text("Download Certificate (PDF)"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[700],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}

class Block extends StatelessWidget {
  const Block({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 12);
  }
}

class SubTitle extends StatelessWidget {
  final String? subTitle;

  const SubTitle({super.key, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$subTitle",
      style: TextStyle(
        color: Color(0xFF191C1D),
        fontFamily: "Inter",
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
    );
  }
}

class BatchReport {
  final String fishName;
  final String batchNumber;
  final String fisherName;
  final String catchDate;
  final String inspectionDate;
  final String inspectorName;
  final String inspectorLicense;
  final int freshnessScore;
  final String smell;
  final String eyeClarity;
  final String fleshFirmness;
  final String gillColor;
  final double temperature;
  final String conclusion;

  BatchReport({
    required this.fishName,
    required this.batchNumber,
    required this.fisherName,
    required this.catchDate,
    required this.inspectionDate,
    required this.inspectorName,
    required this.inspectorLicense,
    required this.freshnessScore,
    required this.smell,
    required this.eyeClarity,
    required this.fleshFirmness,
    required this.gillColor,
    required this.temperature,
    required this.conclusion,
  });

  factory BatchReport.fromJson(Map<String, dynamic> json) {
    return BatchReport(
      fishName         : json["fish_name"],
      batchNumber      : json["batch_number"],
      fisherName       : json["fisher_name"],
      catchDate        : json["catch_date"],
      inspectionDate   : json["inspection_date"],
      inspectorName    : json["inspector_name"],
      inspectorLicense : json["inspector_license"],
      freshnessScore   : json["freshness_score"],
      smell            : json["smell"],
      eyeClarity       : json["eye_clarity"],
      fleshFirmness    : json["flesh_firmness"],
      gillColor        : json["gill_color"],
      temperature      : json["temperature"].toDouble(),
      conclusion       : json["conclusion"],
    );
  }
}

Widget _qualityItem({
  required IconData icon,
  required String label,
  required String value,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.amber[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.amber[700], size: 20),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.grey, fontSize: 11),
            ),
            Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ],
        ),
        Spacer(),
        Container(
          width: 10, height: 10,
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
      ],
    ),
  );
}