
import 'dart:convert';

import 'package:assignment_flutter_developer_venum/screen2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isChecked = false;
  bool isSubmit = false;

  String? _validateEmail(String value) {
    // Regular expression for a valid email format
    String pattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$';
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final String apiEndpoint = 'https://apiv2stg.promilo.com/user/oauth/token';
      // final String clientId = 'test45@yopmail.com'; //
      // final String clientSecret = 'Test@123'; // Replace with your actual client secret
      //
      // final String basicAuth =
      //     'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}';
      //
      // final String email = _emailController.text;
      // final String password = _passwordController.text;
      // final String hashedPassword = 'SHA256_HASH_HERE'; //
      String email = _emailController.text;
      String password = _passwordController.text;

      // Hash the password using SHA-256
      var bytes = utf8.encode(password);
      var digest = sha256.convert(bytes);
      String hashedPassword = digest.toString();

      final Map<String, String> data = {
        'username': email,
        'password': hashedPassword,
        'grant_type': 'password',
      };

      try {
        final response = await http.post(
          Uri.parse(apiEndpoint),
          headers: {
            "Authorization": "Basic UHJvbWlsbzpxNCE1NkBaeSN4MiRHQg=="
          },
          body: data,
        );

        if (response.statusCode == 200) {
          print('Login successful: ${response.body}');

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Login Successful',style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,fontWeight: FontWeight.w600)),
                ),
              ),
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Screen2(),  // Specify the new page to navigate to
            ),
          );

        } else {
          print('Login failed: ${response.body}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Invalid ID Password',style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,fontWeight: FontWeight.w600)),
                ),
              ),
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
            ),
          );
        }
      } catch (e) {
        print('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An error occurred. Please try again.'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 22),
                Text('promilo',style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,fontWeight: FontWeight.w600),),
                SizedBox(height: 20),
                Center(
                    child: Text('Hi, Welcome Back!',style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 20,fontWeight: FontWeight.w600))),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Please Sign in to continue',style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,fontWeight: FontWeight.w600),),
                ),
                SizedBox(height: 5),
        
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Enter Email or Mob no.',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  validator: (value) => _validateEmail(value!),
                ),
        
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('Sign in With OTP',style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,fontWeight: FontWeight.w600),),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Password',style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,fontWeight: FontWeight.w600),),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'Enter password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Checkbox(
                            value: isChecked,
        
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          Text('Remember me',style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,),),
                        ],
                      ),
                    ),
        
                    Text('Forgot Password',style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,fontWeight: FontWeight.w600),)
        
                  ],
                ),
                ElevatedButton(
                  onPressed: () async{
        
                    setState(() {
                      isSubmit = true;
                    });
        
                    FocusScope.of(context).unfocus();
        
                    if (_formKey.currentState!.validate()) {
                      print('Email: ${_emailController.text}');
                    }
        
                    await _login();
        
                  },
                    child: Text('Submit',style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.blue,width: 2),
                    backgroundColor: isSubmit ? Colors.blueGrey.withOpacity(0.1) : Colors.indigo,
        
                    minimumSize: Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Divider(
                        // Customize divider properties as needed
                        thickness: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    Text('or',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                    Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Divider(
                        // Customize divider properties as needed
                        thickness: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlutterSocialButton(
                      onTap: () {},
                      mini: true,
                      buttonType: ButtonType.google,
                    ),
        
                    FlutterSocialButton(
                      onTap: () {},
                      mini: true,
                      buttonType: ButtonType.linkedin,
                    ),
                    FlutterSocialButton(
                      onTap: () {},
                      mini: true,
                      buttonType: ButtonType.facebook,
                    ),
                    FlutterSocialButton(
                      onTap: () {},
                      mini: true,
                      buttonType: ButtonType.twitter,
                    ),
                    FlutterSocialButton(
                      onTap: () {},
                      mini: true,
                      buttonType: ButtonType.whatsapp,
                    ),
        
        
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Business User?',style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 16,fontWeight: FontWeight.w500),),
                    Text("Don't have an account",style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 16,fontWeight: FontWeight.w500),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Login Here',style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,fontWeight: FontWeight.w500),),
                    Text("Sign Up",style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16,fontWeight: FontWeight.w500),),
                  ],
                ),
                SizedBox(height: 15),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: "By continuing, you agree to \n Promilo's ",
                        style: TextStyle(fontSize: 14,color: Colors.blueGrey.withOpacity(0.5))),
                    TextSpan(text: "Terms of Use & Privacy Policy",
                        style: TextStyle(fontSize: 15,color: Colors.black))
                  ]
                ),
                ),
                Text(" ",style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,fontWeight: FontWeight.w500),),
        
              ],
            ),
          ),
        ),
      )
    );
  }
}
