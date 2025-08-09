import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_generator_mobile/src/components/button_icon.dart';
import 'package:recipe_generator_mobile/src/components/display_recipe_screen.dart';
import 'package:recipe_generator_mobile/src/components/drawer_component.dart';
import 'package:recipe_generator_mobile/src/provider/recipe_provider.dart';
import 'package:recipe_generator_mobile/src/services/speech.dart';
import 'package:recipe_generator_mobile/src/components/option_chips.dart';
import 'package:recipe_generator_mobile/src/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  final SpeechService _speechService = SpeechService();

  @override
  void initState() {
    super.initState();
    _speechService.onResult = (result) {
      setState(() {
        _textController.text = result;
      });
    };
    _speechService.onError = (err) {
      log("Speech error: $err");
    };
    _speechService.onStatus = (status) {
      log("Speech status: $status");
      // setState(() {});
    };
    _speechService.initSpeech();
  }

  void _toggleListening() {
    if (_speechService.isListening) {
      _speechService.stopListening();
    } else {
      _speechService.startListening();
    }
    setState(() {}); // To update mic icon
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('RapidRecipe AI'),
          backgroundColor: Colors.orange,
        ),
        drawer: DrawerComponent(),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Text(
                'Recipe Generator',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          labelText: 'Enter ingredients',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ButtonIcon(
                      onPress: () {
                        if (_textController.text.trim().isNotEmpty) {
                          recipeProvider
                              .addIngredient(_textController.text.trim());
                          _textController.clear();
                        }
                      },
                      icon: Icons.add,
                      width: 56,
                      height: 56,
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange,
                    ),
                    ButtonIcon(
                        onPress: _toggleListening,
                        icon: _speechService.isListening
                            ? Icons.mic
                            : Icons.mic_off,
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange,
                        width: 56,
                        height: 56),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Selected Ingredients:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          deleteIcon:
                              const Icon(Icons.cancel), // Custom delete icon
                          deleteButtonTooltipMessage:
                              'Delete this tag', // Tooltip for accessibility
                          backgroundColor: Colors.orangeAccent[100],
                          // labelStyle: TextStyle(color: Colors.blue[800]),
                        );
                      }).toList(),
                    ),
              const SizedBox(height: 30),
              OptionChips(
                title: 'Cuisine Options',
                options: getCuisineOptions(),
                selectedOption: recipeProvider.selectedCuisine,
                onSelected: (cuisine) => recipeProvider.setCuisine(cuisine),
              ),
              const SizedBox(height: 20),
              OptionChips(
                title: 'Meal Type Options',
                options: getMealTypeOptions(),
                selectedOption: recipeProvider.selectedMealType,
                onSelected: (mealType) => recipeProvider.setMealType(mealType),
              ),
              const SizedBox(height: 20),
              OptionChips(
                title: 'Dietary Options',
                options: getDietaryPreference(),
                selectedOption: recipeProvider.selectedDietary,
                onSelected: (dietary) => recipeProvider.setDietary(dietary),
              ),
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

              recipeProvider.recipe.trim().isNotEmpty
                  ? DisplayRecipeScreen(recipe: recipeProvider.recipe)
                  : SizedBox.shrink(),
              // Spacer(),
            ],
          ),
        )));
  }
}
