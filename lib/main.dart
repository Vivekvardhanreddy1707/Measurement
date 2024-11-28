import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Features/app/splash_screen/splashScreen.dart';
import 'Features/userauth/presentation/pages/login_page.dart';
import 'Features/userauth/presentation/pages/Signup_page.dart';
import 'Features/userauth/presentation/pages/Home_Page.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAcarRdJh1pAhwoE0ILjm2AzWldLyke944",
            appId: "1:340078607845:web:844137f437bfe6fef4c30c",
            messagingSenderId: "340078607845",
            projectId: "capstone-7a8e1"
        ),
    );
  } else {
    await Firebase.initializeApp();

  }
  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}
class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase',
      routes: {
        '/': (context) => splashScreen(
          // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginPage(),
        ),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignupPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
