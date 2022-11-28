import 'package:chat_app/constant/color_constants.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/signin_screen.dart';
import 'package:chat_app/widget/custom_button.dart';
import 'package:chat_app/widget/text_form.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static String TAG = 'registration_screen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool loader = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: loader,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 180,
                child: Image.asset('images/logo.png'),
              ),
              const SizedBox(height: 50,),
              CustomTextForm(
                type: TextInputType.emailAddress,
                obscure: false,
                  hint: 'Enter your email',
                  onChange: (value){
                    email = value ;
                  },
              ),
              const SizedBox(height: 10,),
              CustomTextForm(
                type: TextInputType.text,
                obscure: true,
                hint: 'Enter your password',
                onChange: (value){
                  password = value ;
                },
              ),
              SizedBox(height: 20,),
              CustomButton(
                  text: 'register',
                  color: blueColor,
                  onPress: () async {
                    setState((){
                      loader = true;
                    });
                    try {
                      final newUser = await _auth.createUserWithEmailAndPassword(
                          email: email,
                          password: password
                      );
                      Navigator.pushNamed(context, ChatScreen.TAG);
                      setState((){
                        loader = false;
                      });
                    }catch (e){
                      print(e);
                      setState((){
                        loader = false;
                      });
                    }
                    // print(email);
                    // print(password);
                    // Navigator.pushNamed(context, SignInScreen.TAG);
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
