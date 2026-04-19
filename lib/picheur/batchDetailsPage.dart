import 'package:flutter/material.dart';
import 'package:projetsndcp/picheur/objects.dart';

class BatchDetailspage extends StatefulWidget {
  final BatchItem batch;
  const BatchDetailspage({super.key, required this.batch});
  @override
  State<BatchDetailspage> createState() => _BatchDetailsState();
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
    {"title": "Batch Created", "subtitle": "Oct 24, 05:40 AM • Captain Sarah"},
  ];

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
          "Batch Details",
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 78,
              decoration: BoxDecoration(
                color: const Color(0xFFECFDF5),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: const Color(0xFFD1FAE5), width: 1.5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, color: Color(0xFF10B981)),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "CURRENT STATUS",
                        style: TextStyle(
                          color: Color(0xFF065F46),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          letterSpacing: 0.6,
                        ),
                      ),
                      Text(
                        widget.batch.status.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF065F46),
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.sailing_outlined, color: Color(0xFF023E77)),
                const SizedBox(width: 5),
                const Text(
                  "Catch Details",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              height: 86,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Fish name",
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    widget.batch.fishName,
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 86,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(color: const Color(0xFFE2E8F0), width: 0.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Weight",
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${widget.batch.quantity} kg", // Corrigé : quantity au lieu de weight
                          style: const TextStyle(
                            color: Color(0xFF0F172A),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 86,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(color: const Color(0xFFE2E8F0), width: 0.5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Value",
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${widget.batch.total} DA", // Corrigé : total au lieu de price
                          style: const TextStyle(
                            color: Color(0xFF023E77),
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.article_outlined, color: Color(0xFF023E77)),
                const SizedBox(width: 5),
                const Text(
                  "Log Details",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontFamily: "Inter",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(13),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: const Color(0xFFE2E8F0), width: 0.5),
              ),
              child: Column(
                children: [
                  _buildLogTile(Icons.calendar_today_outlined, "Date & Time", widget.batch.date),
                  const Divider(color: Color(0xFFF1F5F9), thickness: 1),
                  _buildLogTile(Icons.directions_boat_outlined, "Vessel Name", "Sea's King"),
                  const Divider(color: Color(0xFFF1F5F9), thickness: 1),
                  _buildLogTile(Icons.anchor_outlined, "Catch Method", widget.batch.catchMethod ?? "Longline"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Color(0xFF023E77)),
                const SizedBox(width: 5),
                const Text(
                  "Catch Location",
                  style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 192,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Center(child: Icon(Icons.map, size: 50, color: Colors.grey)),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.photo_library_outlined, color: Color(0xFF023E77)),
                const SizedBox(width: 5),
                const Text(
                  "Catch Photos",
                  style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const Spacer(),
                const Text(
                  "View All (4)",
                  style: TextStyle(color: Color(0xFF023E77), fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFishImage("images/fish1.png"),
                  const SizedBox(width: 8),
                  _buildFishImage("images/fish2.png"),
                  const SizedBox(width: 8),
                  _buildFishImage("images/fish3.jpg"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.history, color: Color(0xFF023E77)),
                const SizedBox(width: 5),
                const Text(
                  "Status History",
                  style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Version manuelle de la timeline (pour éviter l'erreur de package)
            Column(
              children: List.generate(events.length, (index) => _buildTimelineTile(index)),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF023E77),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save_alt_outlined, size: 20),
                    SizedBox(width: 10),
                    Text("Download Receipt (PDF)", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF94A3B8)),
              const SizedBox(width: 10),
              Text(label, style: const TextStyle(color: Color(0xFF475569), fontWeight: FontWeight.w500, fontSize: 16)),
            ],
          ),
          Text(value, style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w600, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildFishImage(String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Image.asset(path, width: 139, height: 127, fit: BoxFit.cover),
    );
  }

  Widget _buildTimelineTile(int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: index == 0 ? const Color(0xFF023E77) : const Color(0xFFC4D3E0),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
            ),
            if (index != events.length - 1)
              Container(width: 2, height: 50, color: const Color(0xFF023E77)),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(events[index]["title"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(events[index]["subtitle"]!, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
