
import 'package:chat_app/constant/color_constants.dart';
import 'package:chat_app/screens/registration_screen.dart';
import 'package:chat_app/screens/signin_screen.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomScreen extends StatefulWidget {
  static String TAG = 'signIn_screen';
  const WelcomScreen({Key? key}) : super(key: key);

  @override
  State<WelcomScreen> createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  height: 180,
                  child: Image.asset('images/logo.png' , color: orangeColor,),
                ),
                const Text(
                  'MessageMe',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: orangeColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30,),
            CustomButton(text: 'Sign In' ,
              color: orangeColor,
              onPress: (){
                Navigator.pushNamed(context, SignInScreen.TAG);
              },
            ),
            CustomButton(text: 'register',
              color: blueColor,
              onPress: (){
                Navigator.pushNamed(context, RegistrationScreen.TAG);
              },
            ),
          ],
        ),
      ),
    );
  }
}
