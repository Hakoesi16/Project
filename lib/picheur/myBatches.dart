import 'package:flutter/material.dart';

class MyBatchesPage extends StatefulWidget {
  const MyBatchesPage({super.key});

  @override
  State<MyBatchesPage> createState() => _MyBatchesPageState();
}

class _MyBatchesPageState extends State<MyBatchesPage> {
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _selectedFilter = "All";

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
          "My Batches",
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
        shadowColor: Color(0x40013D73),
        elevation: 1,
        actions: [
          Container(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(right: 16),
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Color(0x1A0F68E6),
              shape: BoxShape.circle,
            ),
            child:IconButton(
              icon: Icon(Icons.add, color: Color(0xFF023E77)),
              onPressed: () {},
              alignment: AlignmentGeometry.center,

            ),
          ),
        ]
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Form(child: TextFormField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search batches...",
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide.none,
                ),
              ),
            )),
            Block(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ["All", "Pending", "Approved", "Rejected"]
                    .map((filter) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: _selectedFilter == filter
                          ? Color(0xFF023E77)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      filter,
                      style: TextStyle(
                        color: _selectedFilter == filter
                            ? Colors.white
                            : Color(0xFF475569),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )).toList(),
              ),
            )

          ],
        )
      ),
    );
  }
}

class Block extends StatelessWidget {
  const Block({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 20);
  }
}