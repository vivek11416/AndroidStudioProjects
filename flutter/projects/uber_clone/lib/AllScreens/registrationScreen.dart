import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:uber_clone/AllScreens/loginScreen.dart";
import 'package:fluttertoast/fluttertoast.dart';
import "package:uber_clone/AllScreens/mainScreen.dart";
import "package:uber_clone/AllWidgets/progressDialog.dart";
import "package:uber_clone/main.dart";

const double fieldTextSize = 18;

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});
  static const String idScreen = "register";

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 55.0,
            ),
            Center(
              child: Image(
                image: AssetImage("assets/images/registration.gif"),
                width: 170.0,
                height: 170.0,
                alignment: Alignment.center,
              ),
            ),
            Text(
              'Register as a Rider',
              style: TextStyle(
                fontSize: 24.0,
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
                    controller: nameTextEditingController,
                    scrollPadding: const EdgeInsets.only(bottom: 150),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(
                        fontSize: fieldTextSize,
                      ),
                      hintText: "Please provide your Name",
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
                    controller: emailTextEditingController,
                    scrollPadding: const EdgeInsets.only(bottom: 150),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: fieldTextSize,
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
                    controller: phoneTextEditingController,
                    scrollPadding: const EdgeInsets.only(bottom: 150),
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Phone",
                      labelStyle: TextStyle(
                        fontSize: fieldTextSize,
                      ),
                      hintText: "Please provide your Phone Number",
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
                    scrollPadding: const EdgeInsets.only(bottom: 150),
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: fieldTextSize,
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
                    height: 20,
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
                      //print('Registration Screen');
                      if (nameTextEditingController.text.length < 3) {
                        displayToastMessage(
                            "Name must be atleast 3 characters.", context);
                      } else if (!emailTextEditingController.text
                          .contains("@")) {
                        displayToastMessage(
                            "Email address is not valid", context);
                      } else if (phoneTextEditingController.text.isEmpty) {
                        displayToastMessage(
                            "Phone number is mandatory", context);
                      } else if (passwordTextEditingController.text.length <
                          6) {
                        displayToastMessage(
                            "Password must be atleast 6 characters", context);
                      } else {
                        registerNewUser(context);
                      }
                    },
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Brand Bold",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an Account?',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.idScreen, (route) => false);
                        },
                        child: Text(
                          'Login Here',
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
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Registering User, Please wait....");
        });
    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context,
          duration: Toast.LENGTH_LONG);
    }))
        .user;

    if (firebaseUser != null) {
      //user created successfully

      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text,
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage(
          "Congratulations , your account has been created", context);
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);
    } else {
      Navigator.pop(context);
      //error occured in creating user
      displayToastMessage("New User account has not been created", context);
    }
  }
}

displayToastMessage(String message, BuildContext context,
    {Toast duration: Toast.LENGTH_SHORT}) {
  Fluttertoast.showToast(msg: message, toastLength: duration);
}
