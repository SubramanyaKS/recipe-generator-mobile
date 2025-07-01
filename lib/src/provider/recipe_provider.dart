import 'package:flutter/material.dart';
import 'package:recipe_generator_mobile/src/utils/utils.dart';

class RecipeProvider with ChangeNotifier {
  final List<String> _ingredients = [];
  String _recipe = '';
  String  _selectedcuisine='';

  List<String> get ingredients => _ingredients;
  String get recipe => _recipe;
  String get selectedcuisine => _selectedcuisine;

  void addIngredient(String ingredient) {
    if (!_ingredients.contains(ingredient)) {
      _ingredients.add(ingredient);
    }
    notifyListeners();
  }

  void removeIngredient(String ingredient) {
    _ingredients.remove(ingredient);
    notifyListeners();
  }

  void removeIngredientByIndex(int index){
    _ingredients.removeAt(index);
    notifyListeners();
  }

  void clearIngredients() {
    _ingredients.clear();
    notifyListeners();
  }

  void setCuisine(String cuisine) {
    _selectedcuisine=cuisine;
    notifyListeners();
  }

  void generateRecipe() async{
    String response = await generateRecipeFromIngredients(ingredients,selectedcuisine);
    if(response.isEmpty){
      response = 'No recipe found for the given ingredients.';
    }
    if(response.isNotEmpty){
      _recipe=response;

    }


    notifyListeners();
  }

}