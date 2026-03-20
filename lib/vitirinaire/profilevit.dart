import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../signin/cubit/authcubit.dart';
import '../signin/cubit/authstate.dart';

class ProfilePage extends StatefulWidget {
  final String token;

  const ProfilePage({super.key, required this.token});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _notifications = true;
  bool _darkMode = false;
  final Color primaryTeal = const Color(0xFF00A896); // Couleur Turquoise de la photo

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().fetchProfile(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Profile", style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileLoaded) {
            final user = state.user;

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<AuthCubit>().fetchProfile(widget.token);
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderCard(user),
                    const SizedBox(height: 24),
                    _buildSectionHeader("CREDENTIELS"),
                    const SizedBox(height: 8),
                    _buildCredentialsCard(user),
                    const SizedBox(height: 24),
                    _buildSectionHeader("COMMUNICATION"),
                    const SizedBox(height: 8),
                    _buildCommunicationCard(user),
                    const SizedBox(height: 24),
                    _buildSectionHeader("SETTINGS"),
                    const SizedBox(height: 8),
                    _buildSettingsCard(),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            );
          }

          if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () => context.read<AuthCubit>().fetchProfile(widget.token),
                    child: const Text("Retry"),
                  )
                ],
              ),
            );
          }

          return const Center(child: Text("No Profile Data Available"));
        },
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.w700, fontSize: 13),
    );
  }

  Widget _buildHeaderCard(Map<String, dynamic> user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: const Color(0xFFE3F2FD),
            backgroundImage: user["profilePicture"] != null ? NetworkImage(user["profilePicture"]) : null,
            child: user["profilePicture"] == null ? Icon(Icons.person, size: 60, color: primaryTeal) : null,
          ),
          const SizedBox(height: 12),
          Text(user["name"] ?? "Unknown", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text("ID: ${user["id"] ?? "N/A"} | LICENSE: ${user["license"] ?? "N/A"}",
              style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, size: 18, color: Colors.white),
                label: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryTeal,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(onPressed: () {}, icon: const Icon(Icons.share, color: Color(0xFF64748B))),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCredentialsCard(Map<String, dynamic> user) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          _infoTile(Icons.anchor_outlined, "ASSIGNED PORT", user["assignedPort"] ?? "Oran Port", trailing: _statusBadge()),
          const Divider(),
          _infoTile(Icons.badge_outlined, "SPECIALIZATION", user["specialization"] ?? "Aquatic Pathology"),
          const Divider(),
          _infoTile(Icons.directions_boat_outlined, "EXPERIENCE", user["experience"] ?? "12 Years Professional"),
          const Divider(),
          _infoTile(Icons.verified_user_outlined, "LICENSE EXPIRY", user["licenseExpiry"] ?? "Dec 31, 2024"),
        ],
      ),
    );
  }

  Widget _buildCommunicationCard(Map<String, dynamic> user) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          _infoTile(Icons.email_outlined, "Email Address", user["email"] ?? "project@esi-sba.dz"),
          const Divider(),
          _infoTile(Icons.phone_outlined, "Phone Number", user["phoneNumber"] ?? "+213 674854088"),
        ],
      ),
    );
  }

  Widget _buildSettingsCard() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          _settingsTile(Icons.lock_outline, "Change Password", trailing: const Icon(Icons.chevron_right, color: Colors.grey)),
          const Divider(height: 1),
          _settingsTile(Icons.language, "Language", trailing: const Text("English >", style: TextStyle(color: Colors.grey))),
          const Divider(height: 1),
          _settingsTile(Icons.notifications_none, "Notifications",
              trailing: Switch(value: _notifications, activeColor: primaryTeal, onChanged: (v) => setState(() => _notifications = v))),
          const Divider(height: 1),
          _settingsTile(Icons.dark_mode_outlined, "Dark Mode",
              trailing: Switch(value: _darkMode, activeColor: primaryTeal, onChanged: (v) => setState(() => _darkMode = v))),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value, {Widget? trailing}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: primaryTeal.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: primaryTeal, size: 24),
      ),
      title: Text(label, style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11, fontWeight: FontWeight.bold)),
      subtitle: Text(value, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A), fontSize: 14)),
      trailing: trailing,
    );
  }

  Widget _statusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(5)),
      child: const Text("ACTIVE", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _settingsTile(IconData icon, String title, {required Widget trailing}) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF64748B)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF0F172A))),
      trailing: trailing,
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.home_outlined, color: Colors.grey)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.anchor, color: Colors.grey)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_basket_outlined, color: Colors.grey)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.remove_red_eye_outlined, color: Colors.grey)),
          IconButton(onPressed: () {}, icon: Icon(Icons.person, color: primaryTeal, size: 30)),
        ],
      ),
    );
  }
}
