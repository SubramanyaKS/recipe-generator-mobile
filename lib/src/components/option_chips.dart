import 'package:flutter/material.dart';

class OptionChips extends StatelessWidget {
  final String title;
  final List<String> options;
  final String? selectedOption;
  final Function(String selected) onSelected;

  const OptionChips({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: options.map((option) {
            return ChoiceChip(
              label: Text(option),
              selected: selectedOption == option,
              onSelected: (selected) {
                if (selected) {
                  onSelected(option);
                }
              },
              selectedColor: Colors.orangeAccent.shade100,
              checkmarkColor: Colors.black,
            );
          }).toList(),
        ),
      ],
    );
  }
}
