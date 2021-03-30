import 'package:flutter/material.dart';
import 'package:grocery_list/database_helper.dart';
import 'package:grocery_list/models/user.dart';
// import 'package:grocery_list/screens/grocerypage.dart';
import 'package:grocery_list/screens/homepage.dart';
import 'package:grocery_list/widgets.dart';

// import 'package:grocery_list/screens/homepage.dart';
// import 'package:grocery_list/widgets.dart';
const darkBlueColor = Color(0xff486579);

class Profile extends StatefulWidget {
  // Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    // _getUsers();
  }

  // Contact _contact = Contact();
  User _user = User();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundImage(
          image: 'assets/images/background.png',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[_form()],
            ),
          ),
        )
      ],
    );
  }

  _form() => Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                onSaved: (val) => setState(() => _user.firstName = val),
                validator: (val) =>
                    (val.length == 0 ? 'This field is required' : null),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                onSaved: (val) => setState(() => _user.lastName = val),
                validator: (val) =>
                    (val.length == 0 ? 'This field is required' : null),
              ),
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: RaisedButton(
                    onPressed: () => _onSubmit(),
                    child: Text('Submit'),
                    color: darkBlueColor,
                    textColor: Colors.white,
                  ))
            ],
          ),
        ),
      );
  _onSubmit() {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      DatabaseHelper _dbHelper = DatabaseHelper();

// create an instance of the grocery
      _dbHelper.insertuser(_user);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Homepage(
                  user: null,
                )),
      ).then((value) => {setState(() {})});
      setState(() {});
      print(_user.firstName);
    }
  }


}
