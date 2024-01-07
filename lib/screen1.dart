
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
  bool _isSubmitEnabled = false;

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
      var digest = sha256.convert(bytes); //The user's password are hashed using SHA-256 before being sent in the request.
      String hashedPassword = digest.toString();

      final Map<String, String> data = {
        'username': email,
        'password': hashedPassword,
        'grant_type': 'password',
      };

      //using http post
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
              content: const Padding(
                padding: EdgeInsets.all(8.0),
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
              builder: (context) => Screen2(),  // navigate to second screen
            ),
          );

        } else {
          print('Login failed: ${response.body}');

          //snackbar message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Padding(
                padding: EdgeInsets.all(8.0),
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
          const SnackBar(
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
                const SizedBox(height: 22),
                const Text('promilo',style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,fontWeight: FontWeight.w600),),
                const SizedBox(height: 20),
                const Center(
                    child: Text('Hi, Welcome Back!',style: TextStyle(
                    color: Colors.indigo,
                    fontSize: 20,fontWeight: FontWeight.w600))),
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Please Sign in to continue',style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,fontWeight: FontWeight.w600),),
                ),
                const SizedBox(height: 5),
        
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Enter Email or Mob no.',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  validator: (value) => _validateEmail(value!),
                  onChanged: _updateSubmitButtonState,
                ),
        
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('Sign in With OTP',style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,fontWeight: FontWeight.w600),),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Password',style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 18,fontWeight: FontWeight.w600),),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'Enter password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                  onChanged: _updateSubmitButtonState,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,

                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        const Text('Remember me',style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,),),
                      ],
                    ),
        
                    const Text('Forgot Password',style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 18,fontWeight: FontWeight.w600),)
        
                  ],
                ),
                ElevatedButton(
                  onPressed: () async{
        
                    FocusScope.of(context).unfocus();// dismisiing keypad
        
                    if (_formKey.currentState!.validate()) {
                      print('Email: ${_emailController.text}');// validating email
                    }
        
                    await _login();
        
                  },
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.blue,width: 2),
                    backgroundColor: _isSubmitEnabled ? Colors.indigo : Colors.blueGrey.shade200,
        
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                    child: const Text('Submit',style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: const Divider(
                        // Customize divider properties as needed
                        thickness: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    const Text('or',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Divider(
                        // Customize divider properties as needed
                        thickness: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 15),
                const Row(
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
                const Row(
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
                const SizedBox(height: 15),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: "By continuing, you agree to \n Promilo's ",
                        style: TextStyle(fontSize: 14,color: Colors.blueGrey.withOpacity(0.5))),
                    const TextSpan(text: "Terms of Use & Privacy Policy",
                        style: TextStyle(fontSize: 15,color: Colors.black))
                  ]
                ),
                ),
                const Text(" ",style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,fontWeight: FontWeight.w500),),
        
              ],
            ),
          ),
        ),
      )
    );
  }


  void _updateSubmitButtonState(String _) {
    setState(() {
      _isSubmitEnabled =
          _validateEmail(_emailController.text) == null && _passwordController.text.isNotEmpty;
    });
  }

}
