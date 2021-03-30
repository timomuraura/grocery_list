import 'package:flutter/material.dart';
import 'package:grocery_list/pallete.dart';
import 'package:grocery_list/screens/homepage.dart';

class GroceryCardWidget extends StatelessWidget {
  // const GroceryCardWidget({Key key}) : super(key: key);
  final String title;
  final String description;
  GroceryCardWidget({this.title, this.description}); //constructor

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 23.0, horizontal: 24.0),
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
            color: Colors.white, //backround color for the grocery card
            borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? ('(unamed grocery)'),
              style: TextStyle(
                  color: Color(0xFF211551),
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
            // Padding(
            //   padding: EdgeInsets.only(top: 10.0),
            //   child: Text(description ?? "No description added",
            //       style: TextStyle(
            //           fontSize: 16.0, color: Color(0xFF86829D), height: 1.5)),
            // ),
          ],
        ));
  }
}

class GroceryWidget extends StatelessWidget {
  // const GroceryWidget({Key key}) : super(key: key);
  final String text;
  final bool isDone;
  GroceryWidget({this.text, @required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            margin: EdgeInsets.only(right: 12.0),
            decoration: BoxDecoration(
                color: isDone ? Color(0xFF7349FE) : Colors.transparent,
                borderRadius: BorderRadius.circular(6.0),
                border: isDone
                    ? null
                    : Border.all(color: Color(0xFF86829D), width: 1.5)),
            child: Image(
              image: AssetImage("assets/images/check_icon.png"),
            ),
          ),
          Text(
            text ?? "(Unamed Grocery Widget)",
            style: TextStyle(
                color: isDone ? Color(0xFF211551) : Color(0xFF86829D),
                fontSize: 16.0,
                fontWeight: isDone ? FontWeight.bold : FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  // const ProfileWidget({Key key}) : super(key: key);
  final String firstName;
  final String lastName;
  ProfileWidget({this.firstName, this.lastName}); //constructor

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
            color: Colors.white, //backround color for the grocery card
            borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'First Name',
                  style: TextStyle(
                      color: Color(0xFF211551),
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter First Name",
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Last Name',
                  style: TextStyle(
                      color: Color(0xFF211551),
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Last Name",
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

// login background
class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key key,
    @required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) => LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.center,
        colors: [Colors.black, Colors.transparent],
      ).createShader(rect),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}

// Textinput Field
class TextInputField extends StatelessWidget {
  const TextInputField({
    Key key,
    @required this.icon,
    @required this.hint,
    this.inputType,
    this.inputAction,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.grey[500].withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: TextField(
            onSubmitted: (value) => {print(value)},
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  icon,
                  size: 28,
                  color: kWhite,
                ),
              ),
              hintText: hint,
              hintStyle: kBodyText,
            ),
            style: kBodyText,
            keyboardType: inputType,
            textInputAction: inputAction,
          ),
        ),
      ),
    );
  }
}

// Round button
class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    @required this.buttonName,
  }) : super(key: key);

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: kBlue,
      ),
      child: FlatButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (contex) => Homepage())),
        child: Text(
          buttonName,
          style: kBodyText.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
