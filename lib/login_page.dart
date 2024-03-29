import 'package:flutter/material.dart';
import 'package:local_database_example/home_page.dart';
import 'package:local_database_example/register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'database/db.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final key = GlobalKey<FormState>();

  bool isVisible= false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "LoginPage",
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                TextFormField(
                  controller: emailController,
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.blue,
                      ),

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.blue,
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      )
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                TextFormField(
                  controller: passwordController,
                  validator: validatePassword,
                  obscureText: !isVisible,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: const TextStyle(
                      color: Colors.blue,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),

                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      ),

                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.blue,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            isVisible=!isVisible;
                          });
                        },
                          child: Icon(
                              isVisible
                                  ?
                              Icons.visibility
                                  :
                              Icons.visibility_off,
                            color: Colors.blue,
                          ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      )
                  ),
                ),

                const SizedBox(
                  height: 50,
                ),

                ElevatedButton(
                  onPressed: () async {
                    if(key.currentState.validate()) {
                      var login = await DBSearchProvider.dbSearchProvider.loginUser(emailController.text.trim(), passwordController.text);

                      if(login!="loginFail"){

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );

                      }else{
                        Fluttertoast.showToast(
                            msg: "Email and password is invalid",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue
                    ),
                    child: const Icon(
                        Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                        text: "Don't have account? ",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      children: [
                        TextSpan(
                          text: "Register Now",
                          style: TextStyle(
                            color: Colors.red,
                          )
                        )
                      ]
                    ),
                  ),
                )

              ],

            ),
          ),
        ),
      ),
    );
  }
}

class ValidationMixin {
  String validateEmail(String value) {
    if(value.isEmpty){
      return "Enter your email-id";
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter valid email-id';
    }

    return null;
  }


  String validatePassword(String value) {
    if (value.isEmpty) {
      return  'enter your password';
    }
    if (value.length < 4) {
      return  'use more than 4 character';
    }
    return null;
  }

}