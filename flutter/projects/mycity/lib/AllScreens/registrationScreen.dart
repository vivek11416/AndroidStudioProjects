import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mycity/AllScreens/loginScreen.dart';
import 'package:mycity/AllScreens/mainScreen.dart';
import 'package:mycity/main.dart';
import 'package:mycity/widgets/buttonWithBoundryOnly.dart';
import 'package:mycity/widgets/loadWaitingWidget.dart';
import 'package:mycity/widgets/mainEleveatedButtonStyle.dart';
import 'package:mycity/widgets/textFieldBox.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});
  bool checkboxholder = false;
  static const String idScreen = "registration";

  TextEditingController nameTextEditingController = TextEditingController();
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
                  'Create Account',
                  style: TextStyle(fontFamily: "Teko", fontSize: 35),
                ),
                Text(
                  "Connect with your community Today!",
                  style: TextStyle(
                    fontFamily: "BarlowCondensed",
                    fontSize: 15,
                    color: Colors.black38,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Name",
                  style: TextStyle(
                    fontFamily: "BarlowCondensed",
                    fontSize: 22,
                  ),
                ),
                TextFieldBox(
                  obscureText: false,
                  controller: nameTextEditingController,
                  hintText: 'Enter your Full Name',
                  isDefaultHeight: false,
                  textBoxHeight: 45,
                ),
                SizedBox(
                  height: 15,
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
                  isDefaultHeight: false,
                  textBoxHeight: 45,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Password",
                  style: TextStyle(
                    fontFamily: "BarlowCondensed",
                    fontSize: 22,
                  ),
                ),
                TextFieldBox(
                  obscureText: true,
                  controller: passwordTextEditingController,
                  hintText: 'Enter your password',
                  isDefaultHeight: false,
                  textBoxHeight: 45,
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
                      "I agree to the terms and conditions",
                      style: TextStyle(fontFamily: "Teko"),
                    ),
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
                          if (nameTextEditingController.text.length < 3) {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.info(
                                message: "Name must be atleast 3 characters.",
                                textStyle: TextStyle(),
                                maxLines: 3,
                                textAlign: TextAlign.start,
                              ),
                            );
                          } else if (!emailTextEditingController.text
                              .contains("@")) {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.info(
                                message: "Email address is not valid",
                                textStyle: TextStyle(),
                                maxLines: 3,
                                textAlign: TextAlign.start,
                              ),
                            );
                          } else if (passwordTextEditingController.text.length <
                              6) {
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.info(
                                message:
                                    "Password must be atleast 6 characters",
                                textStyle: TextStyle(),
                                maxLines: 3,
                                textAlign: TextAlign.start,
                              ),
                            );
                          } else {
                            registerNewUser(context);
                          }
                        },
                        horizontalPadding: 80,
                        verticalPadding: 10,
                        buttonText: "           Register              ",
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
                        "Or Register With",
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
                SizedBox(height: 35 //to 60,
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
                          text: "Already have an account?",
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  LoginScreen.idScreen, (route) => false);
                            },
                          text: "  Log In",
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
  void registerNewUser(BuildContext context) async {
    showDialog(
      builder: (BuildContext context) {
        return ShowWaitingDialog();
      },
      context: context,
      barrierDismissible: false,
    );
    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: errMsg.message.toString(),
          textStyle: TextStyle(),
          maxLines: 3,
          textAlign: TextAlign.start,
        ),
      );
    }))
        .user;

    if (firebaseUser != null) {
      //user created successfully

      Map userDataMap = {
        "user_name": nameTextEditingController.text.trim(),
        "user_email": emailTextEditingController.text.trim(),
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.success(
          message: "Congratulations , your account has been created",
          textStyle: TextStyle(),
          maxLines: 3,
          textAlign: TextAlign.start,
        ),
      );

      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);
    } else {
      Navigator.pop(context);
      //error occured in creating user
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          message: "New User account has not been created",
          textStyle: TextStyle(),
          maxLines: 3,
          textAlign: TextAlign.start,
        ),
      );
    }
  }
}
