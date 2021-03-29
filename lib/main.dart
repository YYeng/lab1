import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  AbsiApp createState() => AbsiApp();
}

class AbsiApp extends State<MyApp> {
  final TextEditingController sexEditingController =
      new TextEditingController();
  final TextEditingController ageEditingController =
      new TextEditingController();
  final TextEditingController heightEditingController =
      new TextEditingController();
  final TextEditingController weightEditingController =
      new TextEditingController();
  final TextEditingController wcEditingController = new TextEditingController();

  double resultABSI = 0.0;
  double resultABSIz = 0.0;
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'ABSI CALCULATOR',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue[900],
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: Text("Sex", style: TextStyle(fontSize: 15)),
            ),
            Container(
              width: 200,
              padding: EdgeInsets.fromLTRB(10, 10, 70, 10),
              child: DropdownButton(
                value: _value,
                items: [
                  DropdownMenuItem(
                    child: Text("Male"),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text("Female"),
                    value: 2,
                  )
                ],
                onChanged: (value) {
                  setState(() {
                    _value = value;
                  });
                },
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 10, 5, 10),
              child: Text("Age", style: TextStyle(fontSize: 15)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(40, 10, 0, 10),
              width: 160,
              child: TextFormField(
                controller: ageEditingController,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.isNotEmpty) {
                    return validAge(value);
                  }
                  return null;
                },
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.indigo),
                )),
              ),
            ),
            Container(
              width: 45,
              child: Text("years"),
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
              child: Text("Height", style: TextStyle(fontSize: 15)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(35, 10, 0, 10),
              width: 160,
              child: TextFormField(
                controller: heightEditingController,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (height) {
                  if (height.isNotEmpty) {
                    return validHeight(height);
                  }
                  return null;
                },
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.indigo),
                )),
              ),
            ),
            Container(
              width: 50,
              child: Text("cm"),
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
              child: Text("Weight", style: TextStyle(fontSize: 15)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(35, 10, 0, 10),
              width: 160,
              child: TextFormField(
                controller: weightEditingController,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (weight) {
                  if (weight.isNotEmpty) {
                    return validWeight(weight);
                  }
                  return null;
                },
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.indigo),
                )),
              ),
            ),
            Container(
              width: 50,
              child: Text("kg"),
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: EdgeInsets.fromLTRB(30, 15, 0, 20),
              child:
                  Text("Waist\nCircumference", style: TextStyle(fontSize: 14)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              width: 130,
              child: TextFormField(
                controller: wcEditingController,
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (wc) {
                  if (wc.isNotEmpty) {
                    return validWC(wc);
                  }
                  return null;
                },
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.indigo),
                )),
              ),
            ),
            Container(
              width: 50,
              child: Text("cm"),
            )
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 250,
              height: 50,
              child: RaisedButton(
                child: Text("Check Result",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                onPressed: calculateResult,
              ),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: EdgeInsets.all(30),
              child: Text("ABSI",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.all(30),
              width: 150,
              child: Text(resultABSI.toStringAsFixed(5),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            )
          ]),
        ])),
      ),
    );
  }

  void calculateResult() {
    setState(() {
      double height = double.parse(heightEditingController.text);
      double weight = double.parse(weightEditingController.text);
      double waistC = double.parse(wcEditingController.text);

      height = height / 100;
      waistC = waistC / 100;

      double bmi = weight / (pow(height, 2));

      resultABSI = waistC / (pow(bmi, 2 / 3) * sqrt(height));
    });
  }

  validAge(String age) {
    double age = double.parse(ageEditingController.text);
    if (age < 2) {
      //_validAge = false;
      return "The youngest\nage is 2";
    } else if (age >= 86) {
      return "Sorry,this only for\npeople under 86\nyears of age";
    }
  }

  validHeight(String height) {
    double height = double.parse(heightEditingController.text);
    if (height < 50 || height > 250) {
      return "Please enter the\ncorrect value of\nheight";
    }
  }

  validWeight(String weight) {
    double weight = double.parse(weightEditingController.text);
    if (weight <= 0) {
      return "Weight needs to\nbe a positive\nvalue.";
    }
  }

  validWC(String waistC) {
    double waistC = double.parse(wcEditingController.text);
    if (waistC <= 30) {
      return "Waist\ncircumference\nneeds to be\ngreater than\n30cm";
    }
  }
}
