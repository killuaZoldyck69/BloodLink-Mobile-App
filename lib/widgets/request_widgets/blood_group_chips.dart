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
              selectedColor: Theme.of(context).colorScheme.primary,
              labelStyle: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyMedium?.color ??
                          Theme.of(context).colorScheme.onSurface,
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
