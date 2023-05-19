// ignore_for_file: prefer_const_constructors
import 'package:AsianTea/custom/custom_app_bar.dart';
import 'package:AsianTea/screens/home_screen.dart';
import 'package:flutter/material.dart';


class OrderSuccessfullScreen extends StatefulWidget {
  static const String idScreen = "homeScreen";

  @override
  _OrderSuccessfullScreenState createState() => _OrderSuccessfullScreenState();
}

class _OrderSuccessfullScreenState extends State<OrderSuccessfullScreen> {

  void redirectHome() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed:  () {
          Navigator.of(context).push(
              MaterialPageRoute(
              builder: (context) => HomeScreen(),));
        },
        backgroundColor: const Color(0xFF000000),
        label: const Text("HOME PAGE"),
        icon: Icon(Icons.home),
      ),
      appBar: CustomAppBar(
        appBar: AppBar(),
        widgets: [],
      ),
      backgroundColor: const Color(0xFFD8BFD8),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Container(
            child: Icon(
              Icons.celebration_rounded,
              size: 60,
              color: Colors.green,
            ),
          ),
          Align(
            child: Text(
              'Your order is complete!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000)
              ),
            ), 
          ),
          SizedBox(height: 10,),
          Text("Thank you and goodbay!",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000)
            ),)
        ]),
    );
  }

}
