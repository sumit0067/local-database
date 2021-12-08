
import 'package:flutter/material.dart';

class Helper {
  static final Helper dialogCall = Helper._();

  Helper._();


  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          Container(
              margin: const EdgeInsets.only(left: 5),
              child:const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(" Loading ...",
                  style: TextStyle(
                      fontSize: 18),
                ),
              )
          ),
        ],
      ),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

}