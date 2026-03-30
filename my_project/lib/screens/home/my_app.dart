import 'package:flutter/material.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({super.key});

  Future<Map<String, String>> _loadAppInfo() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return {
      'cache': '24.5 MB',
      'version': '1.0.2 (Build 45)',
      'environment': 'Production',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cài đặt ứng dụng",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF0CB39F),
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _loadAppInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Không thể tải thông tin"));
          }

          final data = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSectionTitle("Hệ thống"),
              ListTile(
                leading: const Icon(Icons.storage),
                title: const Text("Bộ nhớ đệm (Cache)"),
                subtitle: Text("Đang sử dụng: ${data['cache']}"),
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text("Phiên bản ứng dụng"),
                subtitle: Text("4.12.4"),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }
}
