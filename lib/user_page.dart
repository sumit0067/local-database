import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'database/db.dart';
import 'package:fluttertoast/fluttertoast.dart';


class UserPage extends StatefulWidget {
  final id;
  const UserPage({Key key, this.id}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isloading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var userDate;
  gatData()async{
    userDate = await DBSearchProvider.dbSearchProvider.selectUser(widget.id);
    setState(() {
      emailController.text = userDate[0]['email'];
      nameController.text = userDate[0]['name'];
      passwordController.text = userDate[0]['password'];
      _image= File.fromUri(Uri.parse(userDate[0]['image']));
    });
  }


  File _image;

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
          _image = File(file.path);
        });
      }
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    gatData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        Navigator.pop(context,"refers");
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: (){
              Navigator.pop(context,"refers");
            },
              child: const Icon(
                  Icons.arrow_back_ios,
              ),
          ),
          title: const Text(
            "Register Page",
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(

              children: [

                const SizedBox(
                  height: 30,
                ),

                GestureDetector(
                  onTap: (){
                    _optionDialogBox();
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.file(
                      File.fromUri(
                        Uri.parse(
                          _image.path,
                        ),
                      ),
                      fit: BoxFit.fill,
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                TextFormField(
                  controller: nameController,
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
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.red),
                      )
                  ),
                ),

                const SizedBox(
                  height: 70,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    ElevatedButton(
                      onPressed: () async {
                        await DBSearchProvider.dbSearchProvider.deleteUser(widget.id);
                        Fluttertoast.showToast(
                            msg: "profile Delete",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );

                        Navigator.pop(context,"refers");


                        setState(() {});
                      },
                      child: const Text(
                        "Delete profile",
                      ),
                    ),

                    const SizedBox(width: 20,),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () async {
                        await DBSearchProvider.dbSearchProvider.updateUser(
                            nameController.text,
                            emailController.text,
                            _image.path.toString(),
                            widget.id,
                        );

                        await DBSearchProvider.dbSearchProvider.selectUser(widget.id);

                        Fluttertoast.showToast(
                            msg: "profile update",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );

                        setState(() {});
                      },
                      child: const Text(
                        "Update profile",
                      ),
                    ),

                  ],
                ),

              ],

            ),
          ),
        ),
      ),
    );
  }
}
