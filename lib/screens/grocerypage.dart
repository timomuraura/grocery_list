import 'package:flutter/material.dart';
import 'package:grocery_list/database_helper.dart';
import 'package:grocery_list/models/grocery.dart';
import 'package:grocery_list/models/item.dart';
import 'package:grocery_list/widgets.dart';

class Grocerypage extends StatefulWidget {
  // Grocerypage({Key key}) : super(key: key);
  final Grocery grocery;
  Grocerypage({@required this.grocery});

  @override
  _GrocerypageState createState() => _GrocerypageState();
}

class _GrocerypageState extends State<Grocerypage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  int _groceryId = 0;
  String _groceryTitle = "";

  @override
  void initState() {
    if (widget.grocery != null) {
      _groceryTitle = widget.grocery.title;
      _groceryId = widget.grocery.id;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 24.0, bottom: 6.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context); //Go back to previous page
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Image(
                              image: AssetImage(
                                  'assets/images/back_arrow_icon.png')),
                        ),
                      ),
                      Expanded(
                          child: TextField(
                        onSubmitted: (value) async {
                          // check if field is empty
                          if (value != '') {
                            // check if the grocery is null
                            if (widget.grocery == null) {
                              // create an instance of the grocery
                              Grocery _newGrocery = Grocery(title: value);
                              await _dbHelper.insertgrocery(_newGrocery);
                            } else {
                              print('Update the existing grocery');
                            }
                          }
                        },
                        controller: TextEditingController()
                          ..text = _groceryTitle,
                        decoration: InputDecoration(
                            hintText: "Enter Grocery Category",
                            border: InputBorder.none),
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF211551),
                        ),
                      ))
                    ],
                  )),
              // Padding(
              //   padding: EdgeInsets.only(bottom: 12.0),
              //   child: TextField(
              //     decoration: InputDecoration(
              //         hintText: "Enter Description for the grocery..",
              //         border: InputBorder.none,
              //         contentPadding: EdgeInsets.symmetric(horizontal: 24.0)),
              //   ),
              // ),
              FutureBuilder(
                initialData: [],
                future: _dbHelper.getItems(_groceryId),
                builder: (context, snapshot) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () async{
                              // switch the checkbox
                              if (snapshot.data[index].isDone == 0) {
                                await _dbHelper.updatePurchase(
                                    snapshot.data[index].id, 1);
                              } else {
                                await _dbHelper.updatePurchase(
                                    snapshot.data[index].id, 0);
                              }
                              setState(() {
                                                              
                                                            });
                            },
                            child: GroceryWidget(
                              text: snapshot.data[index].title,
                              isDone: snapshot.data[index].isDone == 0
                                  ? false
                                  : true,
                            ));
                      },
                    ),
                  );
                },
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 20.0,
                        height: 20.0,
                        margin: EdgeInsets.only(right: 12.0),
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                                color: Color(0xFF86829D), width: 1.5)),
                        child: Image(
                          image: AssetImage("assets/images/check_icon.png"),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onSubmitted: (value) async {
                            // check if field is empty
                            if (value != '') {
                              // check if the grocery is null
                              if (widget.grocery != null) {
                                DatabaseHelper _dbHelper = DatabaseHelper();

                                // create an instance of the grocery
                                Item _newItem = Item(
                                    title: value,
                                    isDone: 0,
                                    groceryId: widget.grocery.id);
                                await _dbHelper.insertitem(_newItem);
                                setState(() {});
                              }
                            }
                          },
                          decoration: InputDecoration(
                              hintText: 'Enter Grocery item',
                              border: InputBorder.none),
                        ),
                      )
                    ],
                  ))
            ],
          ),
          // Positioned(
          //     bottom: 24.0,
          //     right: 24.0,
          //     child: GestureDetector(
          //       // onTap: () {
          //       //   Navigator.push(
          //       //     context,
          //       //     MaterialPageRoute(builder: (context) => Grocerypage()),
          //       //   );
          //       // },
          //       child: Container(
          //           height: 60.0,
          //           width: 60.0,
          //           decoration: BoxDecoration(
          //               color: Color(0xFFFE3577),
          //               borderRadius: BorderRadius.circular(20.0)),
          //           child: Image(
          //             image: AssetImage("assets/images/delete_icon.png"),
          //           )),
          //     ))
        ],
      )),
    ));
  }
}
