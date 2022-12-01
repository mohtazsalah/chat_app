import 'package:chat_app/constant/color_constants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/text_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignInScreen extends StatefulWidget {
  static String TAG = 'welcome_screen';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _auth = FirebaseAuth.instance;


  late String email ;
  late String password ;
  bool loader = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loader,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 150,
                  child: Image.asset('images/logo.png'),
                ),
                const SizedBox(height: 20,),
                CustomTextForm(
                  type: TextInputType.emailAddress,
                  obscure: false,
                  hint: 'Enter your email',
                  onChange: (value){
                    email = value;
                  },
                ),
                const SizedBox(height: 8,),
                CustomTextForm(
                  type: TextInputType.text,
                  obscure: true,
                  hint: 'Enter your password',
                  onChange: (value){
                    password = value;
                  },
                ),
                SizedBox(height: 10,),
                CustomButton(
                    text: 'Sign In',
                    color: orangeColor,
                    onPress: () async {
                      setState(() {
                        loader = true;
                      });
                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: email,
                            password: password
                        );
                        if(user != null){
                          Navigator.pushNamed(context, ChatScreen.TAG);
                          setState(() {
                            loader = false;
                          });
                        }
                      }catch (e){
                        print(e);
                        setState(() {
                          loader = false;
                        });
                      }
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
