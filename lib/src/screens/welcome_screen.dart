import 'package:flutter/material.dart';
import 'package:recipe_generator_mobile/src/components/gradient_background.dart';
import 'package:recipe_generator_mobile/src/screens/auth_screen.dart';
import 'package:recipe_generator_mobile/src/utils/constant.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black45,
        body: GradientBackground(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                ),
              ),
              const Spacer(),

              Padding(
                padding: const EdgeInsets.only(left:50),
                child: Text(tagline,style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 30,
                ),),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                      builder: (context) => AuthScreen(),
                      ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                  elevation: 20,
                  shadowColor: Colors.white,
                  minimumSize: const Size.fromHeight(60),
                ),
                child: const Text("Get Started"),
              ),

              const Spacer(),
            ],
          ),
        )));
  }
}
