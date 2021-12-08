import 'dart:io';

import 'package:flutter/material.dart';
import 'package:local_database_example/user_page.dart';
import 'database/db.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void getUser() async {
    await DBSearchProvider.dbSearchProvider.getAllUser();
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Home"),
      ),
      body: DBSearchProvider.dbSearchProvider.userList.isEmpty
          ?
      Container()
          :
         Padding(
           padding: const EdgeInsets.fromLTRB(20,30,20,0),
           child: Column(
             children: [

               Row(
                 children: const [

                   Text(
                     "Id",
                     style: TextStyle(
                       fontSize: 18,
                       fontWeight: FontWeight.w600,
                     ),
                   ),

                   SizedBox(width: 10),

                   Expanded(
                     child: Text(
                       "Name",
                       style: TextStyle(
                         fontSize: 18,
                         fontWeight: FontWeight.w600,
                       ),
                     ),
                   ),

                   Text(
                     "Profile",
                     style: TextStyle(
                       fontSize: 18,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                   SizedBox(width: 10),

                 ],
               ),

               SizedBox(height: 20),

               ListView.builder(
                 itemCount: DBSearchProvider.dbSearchProvider.userList.length,
                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
                 itemBuilder: (context, index) => Column(
                   children: [
                     InkWell(
                       onTap: () async {
                        var value = await Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) =>
                                   UserPage(
                                       id:DBSearchProvider.dbSearchProvider.userList[index]['id'],
                                   ),
                             ),
                         );

                        if(value!=null){
                          getUser();
                        }
                       },
                       child: Padding(
                         padding: const EdgeInsets.fromLTRB(0,0,0,10),
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text(
                               "${DBSearchProvider.dbSearchProvider.userList[index]['id']}",
                               style: const TextStyle(
                                 fontSize: 18,
                                 fontWeight: FontWeight.w600,
                               ),
                             ),

                             SizedBox(width: 10),

                             Text(
                               "${DBSearchProvider.dbSearchProvider.userList[index]['name'] }",
                               style: const TextStyle(
                                 fontSize: 18,
                                 fontWeight: FontWeight.w600,
                               ),
                             ),

                             SizedBox(width: 10),

                             Expanded(
                               child: Text(
                                 DBSearchProvider.dbSearchProvider.userList[index]['email'],
                                 maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                                 style: const TextStyle(
                                   fontSize: 18,
                                   fontWeight: FontWeight.w600,
                                 ),
                               ),
                             ),



                             ClipRRect(
                               borderRadius: BorderRadius.circular(100),
                               child: Image.file(
                                   File.fromUri(
                                       Uri.parse(
                                           DBSearchProvider.dbSearchProvider.userList[index]['image'],
                                       ),
                                   ),
                                 fit: BoxFit.fill,
                                 width: 40,
                                 height: 40,
                               ),
                             ),

                           ],
                         ),
                       ),
                     )
                   ],
                 ),
               ),
             ],
           ),
         ),
    );
  }
}



