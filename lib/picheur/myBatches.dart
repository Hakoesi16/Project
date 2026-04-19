import 'package:flutter/material.dart';
import 'package:projetsndcp/picheur/batchDetailsPage.dart';
import 'package:projetsndcp/picheur/objects.dart';
import 'package:projetsndcp/picheur/profil.dart';
import 'Weather&Safety.dart';
import 'homepage.dart';

class MyBatchesPage extends StatefulWidget {
  const MyBatchesPage({super.key});

  @override
  State<MyBatchesPage> createState() => _MyBatchesPageState();
}

class _MyBatchesPageState extends State<MyBatchesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _selectedFilter = "All";

  final List<BatchItem> _batches = [
    BatchItem(
      fishName: "Sardine",
      quantity: 45.5,
      date: "Oct 24, 05:30 AM",
      pricePerKg: 320.50,
      total: 1370.50,
      status: "APPROVED",
    ),
  ];

  List<BatchItem> get _filteredBatches => _batches.where((batch) {
    final matchFilter =
        _selectedFilter == "All" ||
            batch.status == _selectedFilter.toUpperCase();
    final matchSearch = batch.fishName.toLowerCase().contains(
      _searchQuery.toLowerCase(),
    );
    return matchFilter && matchSearch;
  }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: const Color(0xFF0F172A),
        ),
        title: const Text(
          "My Batches",
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontFamily: "Inter",
            fontWeight: FontWeight.w700,
            fontSize: 24,
            letterSpacing: -0.6,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Color(0xFF023E77)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search batches...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Block(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ["All", "Pending", "Approved", "Rejected"]
                    .map(
                      (filter) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: _selectedFilter == filter
                            ? const Color(0xFF023E77)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        filter,
                        style: TextStyle(
                          color: _selectedFilter == filter
                              ? Colors.white
                              : const Color(0xFF475569),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ).toList(),
              ),
            ),
            const Block(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredBatches.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BatchDetailspage(batch: _filteredBatches[index]),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: BatchCard(batch: _filteredBatches[index]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage())),
            icon: _navIcon(Icons.home, false),
          ),
          IconButton(
            onPressed: () {}, // Déjà sur cette page
            icon: _navIcon(Icons.anchor, true),
          ),
          IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WeatherSafetypage(),
              ),);
          }, icon: _navIcon(Icons.remove_red_eye, false)),
          IconButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),);
          }, icon: _navIcon(Icons.person, false)),
        ],
      ),
    );
  }

  Widget _navIcon(IconData icon, bool isActive) {
    return Icon(
      icon,
      color: isActive ? const Color(0xFF023E77) : Colors.grey,
      size: isActive ? 30 : 24,
    );
  }
}

class Block extends StatelessWidget {
  const Block({super.key});
  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 20);
  }
}

class BatchCard extends StatelessWidget {
  final BatchItem batch;
  const BatchCard({super.key, required this.batch});

  Color _statusColor() {
    switch (batch.status) {
      case "APPROVED": return const Color(0xFF047857);
      case "PENDING": return const Color(0xFFB45309);
      case "REJECTED": return const Color(0xFFBE123C);
      default: return Colors.grey;
    }
  }

  Color _statusColorCon() {
    switch (batch.status) {
      case "APPROVED": return const Color(0xFFD1FAE5);
      case "PENDING": return const Color(0xFFFEF3C7);
      case "REJECTED": return const Color(0xFFFFE4E6);
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  batch.imageUrl ?? "images/grey.jpg",
                  width: 60, height: 60, fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(batch.fishName, style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 4),
                    Text("${batch.quantity} kg\n${batch.date}", style: const TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: _statusColorCon(), borderRadius: BorderRadius.circular(6)),
                child: Text(batch.status, style: TextStyle(color: _statusColor(), fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text("${batch.pricePerKg} DA/kg", style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Total", style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                  Text("${batch.total} DA", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF023E77))),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
