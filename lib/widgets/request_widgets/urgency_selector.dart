
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UrgencyLevel { Standard, Urgent, Critical }

final selectedUrgencyProvider = StateProvider<UrgencyLevel>((ref) => UrgencyLevel.Standard);

class UrgencySelector extends ConsumerWidget {
  const UrgencySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedUrgency = ref.watch(selectedUrgencyProvider);

    Color getChipColor(UrgencyLevel level) {
      switch (level) {
        case UrgencyLevel.Standard:
          return Colors.green;
        case UrgencyLevel.Urgent:
          return Colors.orange;
        case UrgencyLevel.Critical:
          return const Color(0xFFD32F2F);
      }
    }

    Border? getChipBorder(UrgencyLevel level) {
      if (level == UrgencyLevel.Critical && level == selectedUrgency) {
        return Border.all(color: Colors.red.shade900, width: 2.0);
      }
      return null;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: UrgencyLevel.values.map((level) {
        final isSelected = selectedUrgency == level;
        return InkWell(
          onTap: () {
            ref.read(selectedUrgencyProvider.notifier).state = level;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? getChipColor(level) : getChipColor(level).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: getChipBorder(level),
            ),
            child: Text(
              level.toString().split('.').last,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
