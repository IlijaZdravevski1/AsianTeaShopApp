// ignore_for_file: prefer_const_constructors

import 'package:AsianTea/camera/preview_page.dart';
import 'package:AsianTea/custom/custom_app_bar.dart';
import 'package:AsianTea/model/TeaShop.dart';
import 'package:AsianTea/model/Location.dart';
import 'package:AsianTea/model/teaa.dart';
import 'package:AsianTea/screens/cart_screen.dart';
import 'package:AsianTea/screens/google_map_screen.dart';
import 'package:AsianTea/screens/login_screen.dart';
import 'package:AsianTea/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'info_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String idScreen = "homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String userAddress;
  int _selectedIndex = -1;
  List<Teaa> _teaas = <Teaa>[];
  List<Teaa> _cartList = <Teaa>[];

  List<TeaShop> shops = [
    TeaShop(
        shopName: "Kicevo Store",
        location: Location(latitude: 42.078050, longitude: 22.181713)),
    TeaShop(
        shopName: "Resen Store",
        location: Location(latitude: 41.0889, longitude: 21.0122)),
    TeaShop(
        shopName: "Ohrid Store",
        location: Location(latitude: 41.1172, longitude: 20.8016)),
    TeaShop(
        shopName: "Skopje Store",
        location: Location(latitude: 42.004906, longitude: 21.409890)),
    TeaShop(
        shopName: "Struga Store",
        location: Location(latitude: 41.1781, longitude: 20.6772)),
    TeaShop(
        shopName: "Tetovo Store",
        location: Location(latitude: 42.0084, longitude: 20.9714)),
    TeaShop(
        shopName: "Strumica Store",
        location: Location(latitude: 41.4379, longitude: 22.6426)),
  ];

  void _populateTeaas() {
    var list = <Teaa>[
      Teaa(
          name: 'Ceylon origin Sri Lanka',
          price: 160,
          image: 'assets/images/Ceylon.png',
          sugar: 0,
          milk: false),
      Teaa(
          name: 'Darjeeling origin China',
          price: 180,
          image: 'assets/images/Darjeeling.png',
          sugar: 0,
          milk: false),
      Teaa(
          name: 'Hōjicha origin Japan',
          price: 180,
          image: 'assets/images/Hōjicha.png',
          sugar: 0,
          milk: false),
      Teaa(
          name: 'Longjing origin China',
          price: 140,
          image: 'assets/images/Longjing.png',
          sugar: 0,
          milk: false),
      Teaa(
          name: 'Pu_Erh origin Japan',
          price: 220,
          image: 'assets/images/Pu_Erh.png',
          sugar: 0,
          milk: false),
      Teaa(
          name: 'Matcha Tea origin Japan',
          price: 190,
          image: 'assets/images/Matcha.png',
          sugar: 0,
          milk: false),
      Teaa(
          name: 'Pure White Tea origin China',
          price: 120,
          image: 'assets/images/White_tea.png',
          sugar: 0,
          milk: false),
    ];

    setState(() {
      _teaas = list;
    });
  }

  @override
  void initState() {
    super.initState();
    _populateTeaas();
  }

  Future _signOut() async {
    try {
      await FirebaseAuth.instance.signOut().then((value) {
        print("User signed out");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    } on FirebaseAuthException catch (e) {
      print("ERROR HERE");
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF8A2BE2),
          selectedItemColor:
              _selectedIndex == -1 ? Color(0xFF000000) : Colors.grey[700],
          unselectedItemColor: Color(0xFF000000),
          currentIndex: _selectedIndex == -1 ? 0 : _selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Your Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
              ),
              label: "Map",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.info_outline_rounded,
              ),
              label: "About us",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.logout,
              ),
              label: "Logout",
            )
          ],
          onTap: (index) {
            if (index == 0) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfileScreen(),
              ));
            } else if (index == 1) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MapScreen(shops),
              ));
            } else if (index == 2) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => InfoScreen(),
              ));
            } else {
              _signOut();
            }
          },
        ),
        appBar: CustomAppBar(
          appBar: AppBar(),
          widgets: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 23.0, top: 5.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => PreviewPage()));
                  },
                  child: Icon(Icons.photo_library),
                )),
            Padding(
                padding: const EdgeInsets.only(right: 16.0, top: 33.0),
                child: GestureDetector(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
                        size: 30.0,
                      ),
                      if (_cartList.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: CircleAvatar(
                            radius: 8.0,
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            child: Text(
                              _cartList.length.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  onTap: () {
                    if (_cartList.isNotEmpty) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CartScreen(_cartList),
                        ),
                      );
                    }
                  },
                )),
          ],
        ),
        body: _createBody());
  }

  GridView _createBody() {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(4.0),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: _teaas.length,
      itemBuilder: (context, index) {
        var item = _teaas[index];
        return Card(
            color: Color.fromRGBO(225, 166, 107, 100),
            elevation: 4.0,
            child: Stack(
              fit: StackFit.loose,
              alignment: Alignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      item.image,
                      height: 100,
                    ),
                    Text(
                      item.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      item.price.toString() + ' MKD',
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                    bottom: 8.0,
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      child: Icon(
                        Icons.add_circle,
                        color: Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          _cartList.add(item);
                        });
                      },
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
