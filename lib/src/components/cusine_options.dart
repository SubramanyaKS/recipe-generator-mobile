import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_generator_mobile/src/utils/utils.dart';

import '../provider/recipe_provider.dart';

class CusineOptions extends StatelessWidget {
  const CusineOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    return Column(
      children: [
        const Text(
          'Cuisine Options',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: getCuisineOptions().map((cuisine) {
            return ChoiceChip(
              label: Text(cuisine),
              selected: recipeProvider.selectedcuisine == cuisine,
              onSelected: (selected) {
                // setState(() {
                selected ? recipeProvider.setCuisine(cuisine) : null;
                // });
              },

              selectedColor: Colors.orangeAccent.shade100,
              checkmarkColor: Colors.black,
            );
          }).toList(),
        ),
        // Text(recipeProvider.selectedcuisine),
      ],
    );
  }
}