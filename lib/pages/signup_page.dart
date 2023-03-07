import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import '../main.dart';
import '../services/fire_connection.dart';
import '../services/validators.dart';



class SignUpPage extends StatefulWidget {
   const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final FocusNode _focusUsername = FocusNode();
   final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPassword = FocusNode();

  final _registerFormKey = GlobalKey<FormState>();
  
   final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isProccesing = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
          onTap:(){
            _focusUsername.unfocus();
             _focusEmail.unfocus();
             _focusPassword.unfocus();
          },
          child: Scaffold(
             appBar: AppBar(backgroundColor: Colors.white, foregroundColor: Colors.black,),
              body: Form(
                  key: _registerFormKey,
                  child: Container(
                    padding : const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       const  Text('Sign Up',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _usernameController,
                      focusNode: _focusUsername,
                      decoration :InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          label: const Text('Enter your Username')),
                      validator: (value) =>
                          Validators.validateName(name: value),
                          textInputAction: TextInputAction.next,
                    ),

                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _emailController,
                          focusNode: _focusEmail,
                          decoration: InputDecoration(
                      border : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                      label: const Text('Enter your Email')
                    ),
                          validator: (value) =>
                              Validators.validateEmail(email: value),
                              textInputAction: TextInputAction.next,
                        ),
                       const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _focusPassword,
                          decoration : InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          label: const Text('Enter your Password')),
                          obscureText: true,
                          validator: (value) =>
                              Validators.validatePassword(password: value),
                              textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20.0),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_registerFormKey.currentState!.validate()) {
                                User? user =
                                    await FireAuth.registerUsingEmailPassword(email: _emailController.text, username: _usernameController.text, password: _passwordController.text);
                                 setState(() {
                                   _isProccesing = true;
                                 });   
        
                                if (user != null) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => MainPage()));
                                }
                              }
                            },
                            child: const Text("Sign Up", style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),

                      ],
                    ),
                  ))),
        ));
  }
}