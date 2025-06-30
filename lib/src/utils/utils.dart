import 'dart:developer';

import 'package:recipe_generator_mobile/src/services/api.dart';

String convertIngredients(List<dynamic> ingredients){
  String result = ingredients.join(', ');
  return  result;
}
Future<String> generateRecipeFromIngredients(List<dynamic> ingredients) async {
  String res = convertIngredients(ingredients);
  ServerApiCall apiCall = ServerApiCall();
  try {
    String response = await apiCall.generateRecipe(res);
    return response;
  } catch (e) {
    log('Error generating recipe: $e');
    throw Exception(e);
    // return 'Error generating recipe';
  }
}

List<String> getCuisineOptions() {
  return [
    'Italian',
    'Chinese',
    'Indian',
    'Mexican',
    'French',
    'Japanese',
  ];
}

void downloadRecipe(String recipe) {
  // Implement the logic to download the recipe
  // This could involve saving the recipe to a file or sharing it
  log('Downloading recipe: $recipe');
  // For example, you could use a package like path_provider and dio to save the file
  // This is just a placeholder for the actual implementation
  
}