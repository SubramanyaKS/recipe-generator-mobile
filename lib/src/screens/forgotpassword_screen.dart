import 'package:flutter/material.dart';
import 'package:recipe_generator_mobile/src/components/bottom_card.dart';
import 'package:recipe_generator_mobile/src/components/gradient_background.dart';
import 'package:recipe_generator_mobile/src/screens/auth_screen.dart';
import 'package:recipe_generator_mobile/src/services/auth.dart';

class ForgotpasswordScreen extends StatefulWidget {
  const ForgotpasswordScreen({super.key});

  @override
  State<ForgotpasswordScreen> createState() => _ForgotpasswordScreenState();
}

class _ForgotpasswordScreenState extends State<ForgotpasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final AuthService _authService = AuthService();

  void forgotPassword () async{
    final email = emailController.text.trim();
    String? message;

     message = await _authService.forgotPassword(email: email);
     
      if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
        Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AuthScreen(),
            ));

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                // color: Colors.white,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Receive an Email to reset your password',style: TextStyle(fontSize: 16),),
                      const SizedBox(height: 40),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 40,),
                      ElevatedButton(
                        onPressed: (){forgotPassword();},
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                          elevation: 18,
                          shadowColor: Colors.orangeAccent,
                          minimumSize: const Size.fromHeight(60),
                        ),
                        child: Text('Process'),
                      ),
                      const SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}