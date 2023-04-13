import "package:flutter/material.dart";

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 85.0,
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
                      print('Login Screen');
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
                    print('Register page');
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
}
