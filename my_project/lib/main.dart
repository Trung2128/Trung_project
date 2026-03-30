import 'package:flutter/material.dart';
import 'package:my_project/screens/home/my_wrapper.dart';
import 'package:my_project/screens/login/my_login.dart';
import 'package:my_project/services/storage_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sách Hay App',
      home: FutureBuilder<String?>(
        future: StorageService.getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(color: Color(0xFF0CB39F)),
              ),
            );
          }

          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            return const WrapperScreen();
          }

          return const LoginScreen();
        },
      ),
    );
  }
}
