import 'package:flutter/material.dart';
import 'package:local_database_example/model/note_model.dart';
import 'package:intl/intl.dart';
import 'database/db.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {




  // Save data to database
  void _save() async {
    await DBSearchProvider.dbSearchProvider.createNote("1","sumit","dsf","07-12-2021");
    await DBSearchProvider.dbSearchProvider.getAllNote();
    print(DBSearchProvider.dbSearchProvider.noteList.length);
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DBSearchProvider.dbSearchProvider.noteList.length ==0
              ?
          Container()
              :
         ListView.builder(
           itemCount: DBSearchProvider.dbSearchProvider.noteList.length,
           shrinkWrap: true,
           physics: const NeverScrollableScrollPhysics(),
           itemBuilder: (context, index) => Column(
             children: [
               Padding(
                 padding: const EdgeInsets.only(bottom: 8.0),
                 child: Column(
                   children: [
                     Text(
                         DBSearchProvider.dbSearchProvider.noteList[index]['title'],
                       style: TextStyle(
                           fontSize: 18,
                         fontWeight: FontWeight.w600,
                       ),
                     ),
                     SizedBox(width: 20,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [

                         ElevatedButton(
                           onPressed: () async {
                             await DBSearchProvider.dbSearchProvider.deleteNote(DBSearchProvider.dbSearchProvider.noteList[index]["id"]);
                             await DBSearchProvider.dbSearchProvider.getAllNote();

                             setState(() {});
                           },
                           child: const Text(
                             "delete Data",
                           ),
                         ),
                         SizedBox(width: 20,),
                         ElevatedButton(
                           style: ElevatedButton.styleFrom(primary: Colors.green),
                           onPressed: () async {
                             await DBSearchProvider.dbSearchProvider.updateNote("sumit",DBSearchProvider.dbSearchProvider.noteList[index]["id"]);
                              await DBSearchProvider.dbSearchProvider.getAllNote();

                             setState(() {});
                           },
                           child: const Text(
                             "update Data",
                           ),
                         ),

                       ],
                     ),
                   ],
                 ),
               )
             ],
           ),
         ),
          ElevatedButton(
              onPressed: () async {
                _save();
              },
              child: const Text(
                  "insert Data",
              ),
          ),

        ],
      ),
    );
  }
}



