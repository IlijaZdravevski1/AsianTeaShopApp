import 'dart:developer';

import 'package:AsianTea/model/teaa.dart';
import 'package:flutter/material.dart';
import '../custom/custom_app_bar.dart';

class OrderScreen extends StatefulWidget {
  final Teaa _item;

  OrderScreen(this._item);

  @override
  _OrderState createState() => _OrderState(this._item);
}

class _OrderState extends State<OrderScreen> {
  _OrderState(this._item);

  final Teaa _item;

  void increaseSugarQuantity() {
    setState(() {
      _item.sugar += 1;
    });
  }

  void decreaseSugarQuantity() {
    setState(() {
      if (_item.sugar > 0) {
        _item.sugar -= 1;
      }
    });
  }

  void toggleMilk() {
    setState(() {
      if (_item.milk) {
        _item.milk = false;
      } else {
        _item.milk = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          appBar: AppBar(),
          widgets: const <Widget>[],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed:  () { Navigator.pop(context); },
          backgroundColor: const Color(0xFF00FF00),
          label: const Text("DONE"),
          icon: Icon(Icons.done),
        ),
        backgroundColor: const Color(0xFFD8BFD8),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            const SizedBox(
              width: double.infinity,
              height: 50,
              child: Center(
                child: Text(
                  'MPORTANT: Asian teas are served with specially Matcha milk in them!',
                  style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(children: <Widget>[
                Image.asset(
                  _item.image,
                  height: 150,
                ),
                Text(
                  _item.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text(
                        'Sugar',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: const Icon(
                            Icons.remove_circle,
                            size: 30,
                            color: Color(0xFF000000),
                          ),
                          onTap: () {
                            decreaseSugarQuantity();
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _item.sugar.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          child: const Icon(
                            Icons.add_circle,
                            size: 30,
                            color: Color(0xFF000000),
                          ),
                          onTap: () {
                            increaseSugarQuantity();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text(
                        'Milk',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    Expanded(
                      child: Switch(
                        value: _item.milk,
                        activeColor: const Color(0xFF000000),
                        onChanged: (bool value) {
                          toggleMilk();
                        },
                      ),
                    ),
                    const Expanded(
                      child: Text(''),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Text(
                        'Total',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${_item.price} MKD denar',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    const Expanded(
                      child: Text(''),
                    ),
                  ],
                ),
              ]),
            )
          ]),
        ));
  }
}
