import 'package:flutter/material.dart';

class DonorStatusCard extends StatefulWidget {
  const DonorStatusCard({super.key});

  @override
  State<DonorStatusCard> createState() => _DonorStatusCardState();
}

class _DonorStatusCardState extends State<DonorStatusCard> {
  bool _isAvailable = true;

  void _toggleAvailability(bool value) {
    setState(() {
      _isAvailable = value;
    });
    // Here you would call a backend function to update the user's availability
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SwitchListTile(
        title: const Text('Available to Donate'),
        value: _isAvailable,
        onChanged: _toggleAvailability,
        secondary: const Icon(Icons.bloodtype),
      ),
    );
  }
}
