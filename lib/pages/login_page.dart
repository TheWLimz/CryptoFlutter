import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyek_6/pages/signup_page.dart';
import 'package:proyek_6/providers/permission_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/fire_connection.dart';
import '../services/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  final FocusNode _focusEmail = FocusNode();
  final FocusNode _focusPassword = FocusNode();


  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child : Scaffold(
        body : Form(
          key : _formKey,
          child : Container(
            padding : const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Login',
                  style : TextStyle(fontSize: 40, fontWeight: FontWeight.bold)
                ),
                 const SizedBox(height: 20.0),
                TextFormField(
                  controller : _emailController,
                  decoration:  InputDecoration(
                    border : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40)
                    ),
                  
                    label: const Text('Enter your Email'),
                
                  ),
                  textInputAction: TextInputAction.next,
                  focusNode: _focusEmail,
                  validator: (value) => Validators.validateEmail(email: value),
                ),
                const SizedBox(height : 20.0),
                 TextFormField(
                        controller: _passwordController,
                        focusNode: _focusPassword,
                        decoration : InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)
                            ),
                            label: const Text('Enter your Password')),
                        obscureText: true,
                        
                        validator: (value) =>
                            Validators.validatePassword(password: value),
                        textInputAction: TextInputAction.next,
                      ),
                 const SizedBox(height: 20.0),
                 
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                             if(_formKey.currentState!.validate()){
                              User? user = await FireAuth.logInUsingEmailPassword(email: _emailController.text, password: _passwordController.text);
                              PermissionProvider permission = PermissionProvider();
                              if(user != null){
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString('email', user.email!);
                                permission.getStoragePermission(context);
                                Navigator.pushNamed(context, '/');

                              }
                              else{
                                Navigator.pushNamed(context, '/login');
                              }

                             }   
                        },
                        child: const Text("Log In",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 8,),

                      Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                 Navigator.of(context).push(MaterialPageRoute(builder : (context) => SignUpPage()));
                              },
                              child: const Text("Sign Up",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                            ),
                          )
                  ],
                ),
                const SizedBox(height: 5,),
                TextButton(child:const Text('Forget Password?'), onPressed: (){},),
                const SizedBox(height : 5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('or Log in with', style : TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: ()  {
                       
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                           FaIcon(FontAwesomeIcons.google),
                           SizedBox(width: 10,),
                           Text('Google', style : TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        )
      )
    );
  }
}