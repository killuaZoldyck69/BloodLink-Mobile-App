import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UrgencyLevel { Standard, Urgent, Critical }

final selectedUrgencyProvider = StateProvider<UrgencyLevel>(
  (ref) => UrgencyLevel.Standard,
);

class UrgencySelector extends ConsumerWidget {
  const UrgencySelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedUrgency = ref.watch(selectedUrgencyProvider);

    Color getChipColor(UrgencyLevel level) {
      final scheme = Theme.of(context).colorScheme;
      switch (level) {
        case UrgencyLevel.Standard:
          return const Color(0xFF10B981); // green-500 (informational)
        case UrgencyLevel.Urgent:
          return const Color(0xFFF97316); // orange-500
        case UrgencyLevel.Critical:
          return scheme.primary; // Medical Red
      }
    }

    Border? getChipBorder(UrgencyLevel level) {
      final scheme = Theme.of(context).colorScheme;
      if (level == UrgencyLevel.Critical && level == selectedUrgency) {
        return Border.all(color: scheme.primary, width: 2.0);
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
              color: isSelected
                  ? getChipColor(level)
                  : getChipColor(level).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: getChipBorder(level),
            ),
            child: Text(
              level.toString().split('.').last,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyMedium?.color ??
                          Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
