import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_generator_mobile/src/components/display_recipe_screen.dart';
import 'package:recipe_generator_mobile/src/provider/recipe_provider.dart';
import '../components/texticon_button.dart';

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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      recipeProvider.addIngredient(_textController.text);
                      _textController.clear();
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Selected Ingredients:',
              style: TextStyle(fontSize: 16),
            ),
            Container(
              color: Colors.grey[100],
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40, // adjust as needed
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recipeProvider.ingredients.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: TextIconButton(
                          label: recipeProvider.ingredients[index],
                          onPress: () {
                            recipeProvider.removeIngredientByIndex(index);
                          },
                          icon: Icons.cancel_outlined,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
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

            recipeProvider.recipe.isNotEmpty
                ? Expanded(
                    child: DisplayRecipeScreen(recipe: recipeProvider.recipe))
                : SizedBox.shrink(),
            // Spacer(),
          ],
        )));
  }
}
