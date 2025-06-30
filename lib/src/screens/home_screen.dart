import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_generator_mobile/src/components/cusine_options.dart';
import 'package:recipe_generator_mobile/src/components/display_recipe_screen.dart';
import 'package:recipe_generator_mobile/src/provider/recipe_provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('RapidRecipe AI'),
          backgroundColor: Colors.orange,
        ),
        body: SafeArea(
            child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              'Recipe Generator',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: 'Enter ingredients',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  ClipOval(
                    child: Material(
                      color: Colors.orange, // Button color
                      child: InkWell(
                        splashColor: Colors.red, // Splash color
                        onTap: () {
                          if(_textController.text.trim().isNotEmpty) {
                            recipeProvider.addIngredient(_textController.text.trim());
                            _textController.clear();
                          }
                        },
                        child: SizedBox(width: 56, height: 56, child: Icon(Icons.add,color: Colors.white,)),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Selected Ingredients:',
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
            ),
            recipeProvider.ingredients.isEmpty
                ? const Text('No ingredients selected yet.')
                : Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: recipeProvider.ingredients.map((label) {
                return Chip(
                  label: Text(label),
                  onDeleted: () {
                    setState(() {
                      recipeProvider.ingredients.remove(label);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Removed "$label"'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  deleteIcon: const Icon(Icons.cancel), // Custom delete icon
                  deleteButtonTooltipMessage: 'Delete this tag', // Tooltip for accessibility
                  backgroundColor: Colors.orangeAccent[100],
                  // labelStyle: TextStyle(color: Colors.blue[800]),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            CusineOptions(),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
               recipeProvider.generateRecipe();
              },
              child: Text(
                'Generate',
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 30,
            ),

            // Text(
            //   _selectedFruit == null
            //       ? 'No fruit selected'
            //       : 'You selected: $_selectedFruit',
            //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            // ),

            recipeProvider.recipe.trim().isNotEmpty
                ? Expanded(
                    child: DisplayRecipeScreen(recipe: recipeProvider.recipe))
                : SizedBox.shrink(),
            // Spacer(),
          ],
        )));
  }
}
