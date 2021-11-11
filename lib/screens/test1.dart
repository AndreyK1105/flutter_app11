import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Woolha.com Flutter Tutorial',
      home: _InputChipExample(),
    );
  }
}

class _InputChipExample extends StatefulWidget {
  @override
  _InputChipExampleState createState() =>
      new _InputChipExampleState();
}

class _InputChipExampleState extends State<_InputChipExample> with TickerProviderStateMixin {
 bool select=false;
  late int _selectedIndex;
  List<String> _options = ['Woolha', 'Flutter', 'Dart'];

  Widget _buildChips() {
    List<Widget> chips = [];

    for (int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: select,
        label: Text(_options[i], style: TextStyle(color: Colors.white)),
        avatar: FlutterLogo(),
        elevation: 10,
        pressElevation: 5,
        shadowColor: Colors.teal,
        backgroundColor: Colors.black54,
        selectedColor: Colors.blue,
        onSelected: (bool selected) {
          setState(() {

              _selectedIndex = i;
              select=!select;
              print(select);

          });
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: choiceChip
      ));
    }

    return ListView(
      // This next line does the trick.
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Woolha.com Flutter Tutorial'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 30,
                child: _buildChips(),
              ),
            ],
          )
      ),
    );
  }
}