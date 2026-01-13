
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedBloodGroupProvider = StateProvider<String?>((ref) => null);

class BloodGroupChips extends ConsumerWidget {
  const BloodGroupChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGroup = ref.watch(selectedBloodGroupProvider);
    final bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: bloodGroups.map((group) {
          final isSelected = selectedGroup == group;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ChoiceChip(
              label: Text(group),
              selected: isSelected,
              onSelected: (selected) {
                ref.read(selectedBloodGroupProvider.notifier).state = group;
              },
              selectedColor: const Color(0xFFD32F2F),
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
              ),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12),
            ),
          );
        }).toList(),
      ),
    );
  }
}
