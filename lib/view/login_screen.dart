import 'choose_screen.dart';
import 'constants_ui.dart';
import 'sign_up.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController digitController = TextEditingController();
  bool passToggle = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children:[
          Image.asset('assets/images/img_hex_green.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),



          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Row(
                  children: [
                    Text('Med Alert',
                      style: TextStyle(
                          color: ColorConstants.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize : 40.0,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Arial'),),
                    SizedBox(width: 20.0,),
                    Icon(Icons.notifications_active_sharp,size: 50.0, color:ColorConstants.primaryColor,),
                  ],

                ),

                const SizedBox(height: 16.0,),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email or Username',
                      prefixIcon: Icon(Icons.person),
                      border:  OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 24.0),
                TextField(
                  controller: digitController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone),
                      hintText: '+91 ',
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 10.0,),
                ElevatedButton(
                  onPressed: () {
                    // Check if email and password are not empty
                    if (emailController.text.trim().isEmpty || passwordController.text.isEmpty) {
                      // Show an error message if either email or password is empty
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter both email/username and password'),

                        ),
                      );
                    } else {
                      // Navigate to the next screen when both email and password are not empty
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChooseScreen()),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom( backgroundColor: ColorConstants.primaryColor),
                  child: const Text('Login',style: TextStyle(color: Colors.white),),
                ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    // Navigate to the registration screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupScreen()),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'New User? ',
                      style: const TextStyle(color: Colors.black54, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign Up',
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
                                  builder: (context) => const SignupScreen(),
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
        ],
      ),
    );
  }
}