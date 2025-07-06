import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_generator_mobile/src/components/button_icon.dart';

class DisplayRecipeScreen extends StatelessWidget {
  final String recipe;
  const DisplayRecipeScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final lines =  recipe.split('\n');
    final titleLine =  recipe.isNotEmpty?lines.firstWhere((line) => line.startsWith('Dish:')):'';
    final title = titleLine.replaceFirst('Dish:', '').trim();
    final steps = lines
        .skipWhile((line) => !line.startsWith('Steps:'))
        .skip(1)
        .where((line) => line.trim().isNotEmpty)
        .toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // ✅ Important
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow[800],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Steps:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              ...steps.map((step) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  step,
                  style: TextStyle(fontSize: 18),
                ),
              )),

              SizedBox(height: 16),

              Row(
                children: [
                  ButtonIcon(onPress: () {
                    Clipboard.setData(ClipboardData(text: recipe)).then((_) {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Copied to Clipboard')),
                      );
                    });
                  }, icon: Icons.copy, width: 20, height: 20),

                  TextButton(onPressed: () {}, child: Text("Button 2")),
                  TextButton(onPressed: () {}, child: Text("Button 3")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
