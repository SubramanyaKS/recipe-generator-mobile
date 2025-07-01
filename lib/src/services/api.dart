import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:recipe_generator_mobile/src/utils/environment.dart';

class ServerApiCall {
  final dio = Dio();

Future<String> generateRecipe(String ingredients, String cuisine) async{
  try {
    final response = await dio.post(
      '${Environment.backendUrl}/api/recipe-generate',
      data: {'ingredients': ingredients,'cuisine':cuisine},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      
    );
    if (response.statusCode == 200) {
      return response.data['recipe'] as String;
    } else {
      throw Exception('Failed to generate recipe: ${response.statusCode}');
    }
  } on DioException catch (e) {
    log('DioException occurred: ${e.message}');
    if (e.response != null) {
      log('Response data: ${e.response?.data}');
      log('Response status code: ${e.response?.statusCode}');
    }
    throw Exception('Failed to generate recipe: ${e.message}');
    
  } catch (e) {
    log('An error occurred: $e');
    throw Exception('Failed to generate recipe: $e');
  }

}

}