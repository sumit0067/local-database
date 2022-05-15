import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:local_database_example/Helper/helper.dart';
import 'database/db.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>  {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  var image;

  final key = GlobalKey<FormState>();

  bool isVisible= false;
  bool isVisible1= false;
  bool isloading= false;

  registerUser() async {

    Helper.dialogCall.showAlertDialog(context);
    var value = await DBSearchProvider.dbSearchProvider.createUser(
        nameController.text.trim(),
        emailController.text.trim(),
        passwordController.text.trim(),
      _image.path.toString(),
    );

    if(value == "user exist"){
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "User Already Exist",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }else{
      Future.delayed(Duration(seconds: 3),(){
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }

  }


  PickedFile _image;

  void _optionDialogBox() async {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final imageSource = await showModalBottomSheet<ImageSource>(

        context: context,

        isScrollControlled: true,
        backgroundColor: Colors.white,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
          ),

        ),

        elevation: 2,
        builder: (builder) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
                padding: MediaQuery
                    .of(context)
                    .viewInsets,
                child: Container(
                    child: Wrap(
                      children: <Widget>[
                        ListTile(
                          dense: true,
                          onTap: () =>
                              Navigator.pop(context, ImageSource.camera),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: height * 0.02),
                              ),
                              const Icon(Icons.camera, color: Colors.blue),
                              Padding(
                                padding: EdgeInsets.only(left: height * 0.02),
                              ),
                              const Text(
                                'camera',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListTile(
                          dense: true,
                          onTap: () =>
                              Navigator.pop(context, ImageSource.gallery),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: height * 0.02),
                              ),
                              const Icon(Icons.sd_storage, color: Colors.blue),
                              Padding(
                                padding: EdgeInsets.only(left: height * 0.02),
                              ),
                              const Text(
                                "gallery",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))),
          );
        });
    if (imageSource != null) {
      setState(() {
        isloading = true;
      });
      final file = await ImagePicker.platform.pickImage(source: imageSource,imageQuality: 50);
      if (file != null) {
        setState(() {
          _image = file;
        });
      }
      setState(() {
        isloading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Register Page",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: key,
          child: Column(

            children: [

              const SizedBox(
                height: 30,
              ),

              GestureDetector(
                onTap: ()=>_optionDialogBox(),
                child: Container(
                  height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle
                    ),
                    child: _image != null
                        ?
                    ClipRRect(  
                      borderRadius: BorderRadius.circular(100),
                      child: Image.file(
                          File(_image.path),
                        fit: BoxFit.fill,
                      ),
                    )
                  : const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.white,
                    ),
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              TextFormField(
                controller: nameController,
                validator: validateName,
                decoration: InputDecoration(
                    labelText: "Name",
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
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
                    )
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: validateEmail,
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
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.blue,
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
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
                height: 30,
              ),

              TextFormField(
                controller: repasswordController,
                obscureText: !isVisible1,
                validator: (value)=>validateRePassword(value, passwordController.text),
                decoration: InputDecoration(
                    labelText: "Re-Password",
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
                          isVisible1=!isVisible1;
                        });
                      },
                      child: Icon(
                        isVisible1
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

              GestureDetector(
                  onTap: (){
                    if(key.currentState.validate()){
                      if(_image!=null){
                        registerUser();
                      }else{
                        Fluttertoast.showToast(
                            msg: "Please select image",
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


            ],

          ),
        ),
      ),
    );
  }
}


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


  String validateName(String value) {
    if (value.isEmpty) {
      return 'Enter your name';
    }
    if (value.length < 3) {
      return "Use more than 3 character";
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

  String validateRePassword(String value, String passwordValue,) {
    if (value.isEmpty) {
      return  'enter your re password';
    }
    if (value.length < 4) {
      return 'use more than 4 character';
    }
    if (value != passwordValue) {
      return 're Password not match';
    }
    return null;
  }

