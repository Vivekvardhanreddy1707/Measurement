
import 'package:flutter/material.dart';
import '../../../../global/common/toast.dart';
import '../../firebase_auth_implementation/firebase_auth_serivces.dart';
import 'login_page.dart';
import '../Widget/form_container_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Home_Page.dart';
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isSigningUp = false;
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar:AppBar(
          title:Text('Sign Up'),
        ),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Text(
              'Sign Up',
              style:TextStyle(
                  fontSize:35,
                  color:Colors.teal,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FormContainerWidget(
              controller: _usernameController,
              hintText: "UserName",
              isPasswordField: false,
            ),
            SizedBox(height: 10,),
            FormContainerWidget(
              controller: _emailController,
              hintText: "Email",
              isPasswordField: false,
            ),
            SizedBox(height: 10,),
            FormContainerWidget(
              controller: _passwordController,
              hintText: "Password",
              isPasswordField: true,
            ),
            SizedBox(height: 30,),
            GestureDetector(
              onTap:  (){
                _signUp();

              },
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:Center(
                  child:isSigningUp?CircularProgressIndicator(color: Colors.white,):Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("have an account?"),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) =>LoginPage()),
                          (route) => false,
                    );
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  void _signUp() async {

    setState(() {
      isSigningUp = true;
    });
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);
    setState(() {
      isSigningUp = false;
    });
    if (user != null) {
      showToast(message: "User is successfully created");
      Navigator.pushNamed(context, "/home");
    } else {
      showToast(message: "Some error happend");
    }
  }
}
