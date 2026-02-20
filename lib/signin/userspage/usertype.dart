import 'package:flutter/material.dart';

class Userpage extends StatefulWidget {
  const Userpage({super.key});

  @override
  State<Userpage> createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // LOGO
            SizedBox(
              height: 150,
              child: Center(
                child: Image.asset(
                  "images/Logo2.png",
                  color: const Color(0xFF013D73),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // TITRE
            const Text(
              "Welcome back",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xFF1E1E1E),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Please select your account type to continue.",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 30),

            // PORTAL CARDS
            _buildPortalCard(
              icon: Icons.shopping_basket_outlined,
              title: "Buyer Portal",
              subtitle: "Browse and purchase fresh local catch",
              onTap: () {},
            ),
            const SizedBox(height: 15),
            _buildPortalCard(
              icon: Icons.directions_boat_outlined,
              title: "Fisherman Portal",
              subtitle: "List your catch and manage inventory",
              onTap: () {},
            ),
            const SizedBox(height: 15),
            _buildPortalCard(
              icon: Icons.admin_panel_settings_outlined,
              title: "Administrator Portal",
              subtitle: "Manage market operations and users",
              onTap: () {},
            ),

            const Spacer(),
            // FOOTER
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Text(
                    "By using Let's fishing, you agree to the",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Terms ",
                        style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
                      ),
                      Text("and ", style: TextStyle(color: Colors.grey[600])),
                      Text(
                        "Privacy Policy.",
                        style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
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

  // Widget réutilisable pour les cartes
  Widget _buildPortalCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD), // Fond bleu clair
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF013D73), size: 30),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      ),
    );
  }
}
