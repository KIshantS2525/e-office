import 'package:flutter/material.dart';

class AdminHomePage extends StatelessWidget {
  final String username;

  AdminHomePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home'),
      ),
      body: Center(
        child: Text('Welcome, Admin!'),
      ),
    );
  }
}
