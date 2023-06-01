import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/pages/home-page.dart';

class Homes extends StatefulWidget {
  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height, // Set the container height to match the screen height
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue, Colors.deepPurple, Colors.purple]),
          ),
          child: SafeArea(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.blue, Colors.deepPurple, Colors.purple]),
                ),
                padding: EdgeInsets.all(12),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                          enabled: true,
                          contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.length == 0) {
                            return "Email cannot be empty";
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                            return ("Please enter a valid email");
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: _isObscure3,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure3 ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure3 = !_isObscure3;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Password',
                          enabled: true,
                          contentPadding: const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Please enter a valid password (min. 6 characters)");
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          passwordController.text = value!;
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password ....",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        elevation: 5.0,
                        height: 40,
                        onPressed: () {
                          setState(() {
                            visible = true;
                          });
                          signIn(emailController.text, passwordController.text);
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Text(
                              'SignUp',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(email: email)),
        );
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        } else {
          errorMessage = 'An error occurred. Please try again later.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
