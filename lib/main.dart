import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_generator_mobile/src/provider/recipe_provider.dart';
import 'package:recipe_generator_mobile/src/screens/home_screen.dart';
import 'package:recipe_generator_mobile/src/utils/environment.dart';

void main() async {
  await Environment.load();
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
