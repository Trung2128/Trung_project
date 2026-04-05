import 'package:flutter/material.dart';
import 'package:duan_thi/model/profile_model.dart';

class ProfileScreen extends StatelessWidget {
  final Profile profile;
  const ProfileScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              const HomeHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    // Avatar với vòng viền màu Cam
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFFFF8C00), Color(0xFFFF5E00)],
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: const Color(0xFF1E1E1E),
                        backgroundImage: NetworkImage(profile.image),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "${profile.firstName} ${profile.lastName}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      profile.email,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Các thẻ thông tin với style tối hiện đại
                    infoCard("Thông tin cá nhân", Icons.person_rounded, [
                      infoItem("Username", profile.maidenName),
                      infoItem("Tuổi", profile.age.toString()),
                      infoItem("Giới tính", profile.gender),
                      infoItem("Ngày sinh", profile.birthDate),
                      infoItem("Số điện thoại", profile.phone),
                    ]),
                    const SizedBox(height: 15),

                    infoCard("Thể trạng", Icons.monitor_weight_rounded, [
                      infoItem("Chiều cao", "${profile.height} cm"),
                      infoItem("Cân nặng", "${profile.weight} kg"),
                    ]),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget infoCard(String title, IconData icon, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFFF8C00), size: 20),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF8C00),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: Colors.white10, thickness: 1),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget infoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white38, fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? "N/A" : value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Header nghệ thuật đồng bộ với Login
        Container(
          height: 90,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF8C00), Color(0xFFFF5E00)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(120, 30),
              bottomRight: Radius.elliptical(120, 30),
            ),
          ),
        ),
        // Vòng tròn trang trí
        Positioned(
          top: -20,
          right: -20,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
        ),
        // Nội dung Header
        SafeArea(
          child: SizedBox(
            height: 80,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 48,
                      ), // Bù khoảng cách cho nút back
                      child: const Text(
                        'Hồ sơ của tôi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
