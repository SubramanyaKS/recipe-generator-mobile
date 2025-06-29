import 'package:flutter/material.dart';
import 'package:recipe_generator_mobile/src/services/api.dart';
import 'package:recipe_generator_mobile/src/utils/utils.dart';

class RecipeProvider with ChangeNotifier {
  final List<String> _ingredients = [];
  String _recipe = '';

  List<String> get ingredients => _ingredients;
  String get recipe => _recipe;

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

  void setRecipe(String recipe) {
    _recipe = recipe;
    notifyListeners();
  }

  void generateRecipe() async{

    String res = convertIngredients(_ingredients);
    ServerApiCall apicall = ServerApiCall();
    String response = await apicall.generateRecipe(res);
    _recipe=response;
    notifyListeners();
  }

}