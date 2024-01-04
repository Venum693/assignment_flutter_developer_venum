import 'package:flutter/material.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isChecked = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('promilo',style: TextStyle(
                color: Colors.black,
                fontSize: 18,fontWeight: FontWeight.w600),),
            Center(
                child: Text('Hi, Welcome Back!',style: TextStyle(
                color: Colors.indigo,
                fontSize: 20,fontWeight: FontWeight.w600))),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Please Sign in to continue',style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18,fontWeight: FontWeight.w600),),
            ),

            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Enter Email or Mob no.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
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
            )

          ],
        ),
      )
    );
  }
}
