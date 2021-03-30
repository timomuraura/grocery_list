import 'package:flutter/material.dart';
import 'package:grocery_list/screens/grocerypage.dart';
import 'package:grocery_list/widgets.dart';
import 'package:grocery_list/database_helper.dart';

class Homepage extends StatefulWidget {
  final String user;
  Homepage({this.user});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
          child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              color: Color(0xFFF6F6F6), //background color
              child: Stack(
                children: [
                  Column(
                    // align content from start
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // container children
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 32.0, bottom: 32.0),
                        child:
                            Image(image: AssetImage('assets/images/logo.png',)),
                          // child: _list(),
                            
                      ),
                      _list(),
                      Expanded(                        
                        child: FutureBuilder(
                          initialData: [],
                          future: _dbHelper.getGrocery(),
                          builder: (contex, snapshot) {
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (contex, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        contex, 
                                        MaterialPageRoute(
                                          builder: (contex) => Grocerypage(
                                            grocery: snapshot.data[index],
                                          )
                                          ));
                                    },
                                    child: GroceryCardWidget(
                                    title: snapshot.data[index].title,
                                  ),
                                  );
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      bottom: 24.0,
                      right: 0.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Grocerypage(grocery: null,)),
                          ).then((value) => {setState(() {})});
                        },
                        child: Container(
                            height: 60.0,
                            width: 60.0,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF7349FE),
                                      Color(0xFF643FDB)
                                    ],
                                    begin: Alignment(0.0, -1.0),
                                    end: Alignment(0.0, 1.0)),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Image(
                              image: AssetImage("assets/images/add_icon.png"),
                            )),
                      ))
                ],
              ))),
    );
  }

  _list() => Expanded(
        child: FutureBuilder(
          initialData: [],
          future: _dbHelper.getUser(),
          builder: (contex, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (contex, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          contex,
                          MaterialPageRoute(
                              builder: (contex) => Grocerypage(
                                    grocery: snapshot.data[index],
                                  )));
                    },
                    child: Text(
                       snapshot.data[index].firstName +
                          ' ' +
                          snapshot.data[index].lastName,
                          // style: padding,
                    ),
                  );
                });
          },
        ),
      );
}
