import 'package:flutter/material.dart';
import 'package:recipe_generator_mobile/src/components/bottom_card.dart';
import 'package:recipe_generator_mobile/src/components/gradient_background.dart';
import 'package:recipe_generator_mobile/src/screens/home_screen.dart';
import 'package:recipe_generator_mobile/src/services/auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
 late Size mediaSize;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLogin=false;

   @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void _submitAuthForm() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    String? message;
    if (_isLogin) {
      message = await _authService.signIn(email: email, password: password);
    } else {
      message = await _authService.signUp(email: email, password: password);
    }

    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
      if(_isLogin){
        Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black45,
      body: GradientBackground(
        child: Stack(
          children: [
            Positioned(
              top: 100,
              left: 150,
              child: Text(
                _isLogin ? 'Login' : 'Sign Up',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    fontStyle: FontStyle.italic,
                    color: Colors.white),
              ),
            ),
            Positioned(
                bottom: 0,
                child: BottomCard(mediaSize: mediaSize, child: _buildForm()))
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          Text(
            "Email address",
            style: const TextStyle(color: Colors.black),
          ),
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.email),
            ),
          ),
          const SizedBox(height: 40),
          Text(
            "Password",
            style: const TextStyle(color: Colors.black),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.remove_red_eye),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 40),
          TextButton(
              onPressed: () {
                debugPrint("Password : ${passwordController.text}");
              },
              child: Text("Forgot Password")),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: _submitAuthForm,
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              foregroundColor: Colors.white,
              backgroundColor: Colors.orange,
              elevation: 20,
              shadowColor: Colors.orangeAccent,
              minimumSize: const Size.fromHeight(60),
            ),
            child: Text(_isLogin ? 'Login' : 'Sign Up'),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                  _isLogin = !_isLogin;
                });
                  },
                  child: Text(_isLogin
                  ? 'Create a new account'
                  : 'I already have an account'),),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}