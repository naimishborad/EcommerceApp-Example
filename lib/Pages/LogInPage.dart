import 'package:ecomcons/Services/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 43, 55, 65),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 150),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LottieBuilder.asset(
                  'assets/login.json',
                  reverse: true,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, fixedSize: Size.fromWidth(200)),
                    onPressed: () {
                      final provider =
                          Provider.of<AuthProvider>(context, listen: false);
                      provider.signInWithGoogle();
                    },
                    icon: Icon(Icons.login_outlined),
                    label: Text("SignIn"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
