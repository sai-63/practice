import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practice/pages/home-page.dart';
import 'package:practice/pages/signup-page.dart';
import 'chat-page.dart';

class Homes extends StatefulWidget {
  @override
  _HomesState createState() => _HomesState();
}

class _HomesState extends State<Homes> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue,Colors.deepPurple,Colors.purple]),
          ),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.blue,Colors.deepPurple,Colors.purple]),
              ),
              width: 400.0,
              height: 680.0,
              margin: EdgeInsets.all(12),
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
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 8.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.length == 0) {
                          return "Email cannot be empty";
                        }
                        if (!RegExp(
                            "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
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
                            icon: Icon(_isObscure3
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure3 = !_isObscure3;
                              });
                            }),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Password',
                        enabled: true,
                        contentPadding: const EdgeInsets.only(
                            left: 14.0, bottom: 8.0, top: 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: new BorderSide(color: Colors.white),
                          borderRadius: new BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        RegExp regex = new RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        }
                        if (!regex.hasMatch(value)) {
                          return ("please enter valid password min. 6 character");
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
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0))),
                      elevation: 5.0,
                      height: 40,
                      onPressed: () {
                        setState(() {
                          visible = true;
                        });
                        signIn(
                            emailController.text, passwordController.text);
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
                    Visibility(
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        visible: visible,
                        child: Container(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: Colors.white),
                        ),
                        TextButton(
                            onPressed: (){
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: Text('SignUp',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25.0,color: Colors.black),
                            ))
                      ],
                    )
                  ],
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
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(email: email)
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
