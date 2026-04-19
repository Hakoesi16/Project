import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InspectionHistoryPage extends StatefulWidget {
  const InspectionHistoryPage({super.key});

  @override
  State<InspectionHistoryPage> createState() => _InspectionHistoryPageState();
}

class _InspectionHistoryPageState extends State<InspectionHistoryPage> {
  // Variables
  List<InspectionItem> _inspections = [];
  bool _isLoading = false;
  String _selectedPeriod = "LAST 30 DAYS";
  String _selectedStatus = "ALL";
  String _selectedFishType = "ALL";

  // filtring list
  List<InspectionItem> get _filteredInspections =>
    _inspections.where((item) {
      if (_selectedStatus == "ALL") return true;
      return item.status == _selectedStatus;
    }).toList();

  // GET data
  Future<void> _getInspections() async {
    setState(() => _isLoading = true);

    try {
      final response = await http.get(
        Uri.parse("YOUR_BACKEND_URL/api/inspections"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          _inspections = data
              .map((item) => InspectionItem.fromJson(item))
              .toList();
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  //for trying
  final List<InspectionItem> _inspectionsTab = [
    InspectionItem(
      batchNumber: "Batch #VET-2024-082",
      date: "Jan 24, 2024 • 09:15 AM",
      status: "APPROVED",
    ),
    InspectionItem(
      batchNumber: "Batch #VET-2024-079",
      date: "Jan 22, 2024 • 03:45 PM",
      status: "REJECTED",
    ),
    InspectionItem(
      batchNumber: "Batch #VET-2024-075",
      date: "Jan 20, 2024 • 11:20 AM",
      status: "APPROVED",
    ),
    InspectionItem(
      batchNumber: "Batch #VET-2024-070",
      date: "Jan 18, 2024 • 01:50 PM",
      status: "APPROVED",
    ),
  ];

  @override
  void initState() {
    super.initState();
    //_getInspections();
  }

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
          "Inspection History",
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

            Row(
              children: [
                _filterChip("🗓 $_selectedPeriod ▾"),
                SizedBox(width: 8),
                _filterChip("STATUS: $_selectedStatus ▾"),
                SizedBox(width: 8),
                _filterChip("FISH TYPE: $_selectedFishType ▾"),
              ],
            ),

            Block(),

            Text(
              "RECENT INSPECTIONS",
              style: TextStyle(
                fontFamily: 'Inter',
                color: Color(0xFF64748B),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),

            Block(),

            _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _inspectionsTab.length,
                  itemBuilder: (context, index) => InspectionCard(
                    inspection: _inspectionsTab[index],
                  ),
                ),
          ],
        ),
      ),
    );
  }

  // Widget مستقل للفلتر
  Widget _filterChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        label,
        style: TextStyle(fontFamily: 'Inter',fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }
}


class InspectionCard extends StatelessWidget {
  final InspectionItem inspection;

  const InspectionCard({super.key, required this.inspection});

  Color _statusColor() {
    switch (inspection.status) {
      case "APPROVED":
        return Color(0xFF047857);
      case "REJECTED":
        return Color(0xFFBE123C);
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: inspection.status == "APPROVED"? Color(0xFFD1FAE5):Color(0xFFFFE4E6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  inspection.status == "APPROVED"
                      ? Icons.check_circle_outline
                      : Icons.cancel_outlined,
                  color: _statusColor(),
                ),
              ),
              
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      inspection.batchNumber,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      inspection.date,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: inspection.status == "APPROVED"? Color(0xFFD1FAE5):Color(0xFFFFE4E6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  inspection.status,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    color: _statusColor(),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.description_outlined, size: 18),
              label: Text("View Report"),
              style: ElevatedButton.styleFrom(
                backgroundColor: inspection.status == "APPROVED"
                    ? Color(0xFF00A896)
                    : Colors.grey[200],
                foregroundColor: inspection.status == "APPROVED"
                    ? Colors.white
                    : Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InspectionItem {
  final String batchNumber;
  final String date;
  final String status;

  InspectionItem({
    required this.batchNumber,
    required this.date,
    required this.status,
  });

  factory InspectionItem.fromJson(Map<String, dynamic> json) {
    return InspectionItem(
      batchNumber: json["batch_number"],
      date: json["date"],
      status: json["status"],
    );
  }
}

Widget _filterChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Color(0xFF00A896),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.grey[300]!),
    ),
    child: Text(
      label,
      style: TextStyle(fontFamily: 'Inter',color: Color(0xFF00A896),fontSize: 12, fontWeight: FontWeight.w600),
    ),
  );
}


class Block extends StatelessWidget {
  const Block({super.key});
  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 20);
  }
}