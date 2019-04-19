import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'List',
      home: Scaffold(
        appBar: AppBar(
          title: Text('English Words'),
        ),
        body: MyCustomFields(),
      ),
    );
  }
}

class MyCustomFields extends StatefulWidget {
  @override
  MyCustomState createState() {
    // TODO: implement createState
    return MyCustomState();
  }
}

class MyCustomState extends State<MyCustomFields> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  List<DropdownMenuItem<String>> list = [];
  String selected = null;

  void dropDownData() {
    list = [];
    list.add(new DropdownMenuItem(child: new Text('One'), value: 'One'));
    list.add(new DropdownMenuItem(child: new Text('Two'), value: 'Two'));
    list.add(new DropdownMenuItem(child: new Text('Three'), value: 'Three'));
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2025));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    dropDownData();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new DropdownButton(
              isExpanded: true,
              value: selected,
              items: list,
              hint: Text('Select the item'),
              onChanged: (value) {
                selected = value;
                setState(() {});
              }),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Value';
              }
            },
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Second';
              }
            },
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter Date';
              }
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () => _selectDate(context),
            child: Text('Select Date'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Process data')));
                }
              },
              child: Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}
