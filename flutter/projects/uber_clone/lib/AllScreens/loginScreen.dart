import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:uber_clone/AllScreens/registrationScreen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const String idScreen = "login";

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 35.0,
            ),
            Center(
              child: Image(
                image: AssetImage("assets/images/taxi_gif_1.gif"),
                width: 290.0,
                height: 290.0,
                alignment: Alignment.center,
              ),
            ),
            Text(
              'Login as a Rider',
              style: TextStyle(
                fontSize: 28.0,
                fontFamily: 'Brand Bold',
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(60, 30, 60, 25),
              child: Column(
                children: [
                  TextField(
                    controller: emailTextEditingController,
                    scrollPadding: const EdgeInsets.only(bottom: 150),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: 24.0,
                      ),
                      hintText: "Please provide your email",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordTextEditingController,
                    //scrollPadding: const EdgeInsets.only(bottom: 50),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: 24.0,
                      ),
                      hintText: "Please provide your password",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10.0,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      backgroundColor: Color(0xFFFFE438),
                      side: BorderSide(
                        width: 2,
                      ),
                    ),
                    onPressed: () {
                      loginAndAuthenticateUser(context);
                    },
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Brand Bold",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Do not have an Account?',
                  style: TextStyle(color: Colors.black),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, RegistrationScreen.idScreen, (route) => false);
                  },
                  child: Text(
                    'Register Here',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async {
    final User? firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      //user signed in  successfully

      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage(
          "Congratulations , your account has been created", context);
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);
    } else {
      //user unable to sign in
      displayToastMessage("New User account has not been created", context);
    }
  }
}
