import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mycity/AllScreens/mainScreen.dart';
import 'package:mycity/AllScreens/registrationScreen.dart';
import 'package:mycity/main.dart';
import 'package:mycity/widgets/buttonWithBoundryOnly.dart';
import 'package:mycity/widgets/loadWaitingWidget.dart';
import 'package:mycity/widgets/mainEleveatedButtonStyle.dart';
import 'package:mycity/widgets/textFieldBox.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/safe_area_values.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:auto_size_text/auto_size_text.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const String idScreen = "login";
  bool checkboxholder = false;

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  'Hi, Welcome Back!👋',
                  style: TextStyle(fontFamily: "Teko", fontSize: 35),
                ),
                Text(
                  "Hello again, you have been missed!",
                  style: TextStyle(
                    fontFamily: "BarlowCondensed",
                    fontSize: 15,
                    color: Colors.black38,
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Email Address",
                  style: TextStyle(
                    fontFamily: "BarlowCondensed",
                    fontSize: 22,
                  ),
                ),
                TextFieldBox(
                  obscureText: false,
                  controller: emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter your email',
                  isDefaultHeight: true,
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "Password",
                  style: TextStyle(
                    fontFamily: "BarlowCondensed",
                    fontSize: 22,
                  ),
                ),
                TextFieldBox(
                  controller: passwordTextEditingController,
                  obscureText: true,
                  hintText: 'Enter your password',
                  isDefaultHeight: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 54.0,
                      width: 20.0,
                      child: Checkbox(
                        value: checkboxholder,
                        onChanged: (bool) {},
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Remember me",
                      style: TextStyle(fontFamily: "BarlowCondensed"),
                    ),
                    Spacer(),
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontFamily: "BarlowCondensed",
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Center(
                      child: MainElevatedButtonStyle(
                        onClick: () {
                          loginAndAuthenticateUser(context);
                        },
                        horizontalPadding: 80,
                        verticalPadding: 10,
                        buttonText: "              Login              ",
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.grey[700],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        "Or Login With",
                        style: TextStyle(
                          fontFamily: "BarlowCondensed",
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 150,
                      child: ButtonWithBoundryOnly(buttonText: "Facebook"),
                    ),
                    SizedBox(
                      width: 150,
                      child: ButtonWithBoundryOnly(buttonText: "Google"),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          fontFamily: "BarlowCondensed",
                          color: Colors.black,
                          fontSize: 15),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Don't have an account?",
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RegistrationScreen.idScreen,
                                  (route) => false);
                            },
                          text: "  Sign Up",
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontFamily: "FjallaOne",
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
      builder: (BuildContext context) {
        return ShowWaitingDialog();
      },
      context: context,
      barrierDismissible: false,
    );
    final User? firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);

      passwordTextEditingController.clear;

      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: errMsg.message.toString(),
          maxLines: 3,
          textAlign: TextAlign.start,
        ),
      );

      // displayToastMessage("Error: " + errMsg.toString(), context,
      //     duration: Toast.LENGTH_LONG);
    }))
        .user;

    if (firebaseUser != null) {
      //user signed in  successfully

      usersRef.child(firebaseUser.uid).once().then((event) {
        final snap = event.snapshot;
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.idScreen, (route) => false);
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(
              message:
                  "You are logged in as ${(snap.value! as Map)['user_name']}",
              maxLines: 3,
              textAlign: TextAlign.start,
            ),
          );
        } else {
          Navigator.pop(context);
          _firebaseAuth.signOut();

          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.error(
              message:
                  "No record exist for this user, Please create new account.",
              maxLines: 3,
              textAlign: TextAlign.start,
            ),
          );
        }
      });
    } else {
      Navigator.pop(context);
      //user unable to sign in

      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "Error Occured, Cannot be signed in.",
          maxLines: 3,
          textAlign: TextAlign.start,
        ),
      );
    }
  }
}
