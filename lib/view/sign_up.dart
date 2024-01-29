import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'constants_ui.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/img_hex_green.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome!",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                  const Text(
                    "Please enter your details to signup",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'UserName',
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Enter Your UserName',
                    ),
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',
                      prefixIcon: Icon(Icons.email),
                      hintText: 'Enter Your Email Address',
                    ),
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Enter Your Password',
                    ),
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock_outlined),
                      hintText: 'Enter Password Again To Confirm',
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: SizedBox(
                      width: 240,
                      height: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: ColorConstants.primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Signup',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'Already created an account? ',
                        style: const TextStyle(color: Colors.black54, fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Login',
                            style: const TextStyle(
                              color: ColorConstants.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}