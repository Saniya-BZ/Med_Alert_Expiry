import 'package:crud_new/view/start_app.dart';
import 'constants_ui.dart';
import 'package:flutter/material.dart';


class ChooseScreen extends StatefulWidget {
  const ChooseScreen({super.key});

  @override
  State<ChooseScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ChooseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/img_hex_green.png',
            fit: BoxFit.cover,

          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.medical_services_rounded,
                  color: ColorConstants.primaryColor,
                  size: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Who are you?',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartApp()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.primaryColor,
                  ),
                  child: const Text(
                    'General User',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StartApp()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.primaryColor,
                  ),
                  child: const Text(
                    'Medical Pharmacist',
                    style: TextStyle(color: Colors.white),
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