import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Widget _buildSideButton(IconData icon) {
      return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(30),
          backgroundColor: Color.fromRGBO(82, 121, 111, 1),
        ),
        child: Icon(icon, size: 24),
      );
    }

    Widget _buildCenterButton(IconData icon) {
      return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(40),
          backgroundColor: Color.fromRGBO(82, 121, 111, 1),
        ),
        child: Icon(icon, size: 30),
      );
    }

    Widget mainContent = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Transform.translate(
          offset: const Offset(0, 40),
          child: _buildCenterButton(Icons.camera_alt),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSideButton(Icons.history),
            const SizedBox(width: 45),
            _buildSideButton(Icons.bookmark),
          ],
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ogni opera ha una storia: scopriamola insieme.',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(children: [Expanded(child: mainContent)]),
    );
  }
}
