import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/screens/workout.dart';
import 'package:flutter_app1/service/db.dart';
import 'package:flutter_app1/service/word.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

//import 'package:toast/toast.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import 'dataTable.dart';

class ListDb extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ListDb> {
  String _titleAppbar = "";
  String _task1 = "";
  List<Word> _tasks = [];

  int rate = 0;
  TextStyle _style = TextStyle(color: Colors.amberAccent, fontSize: 17);
  TextStyle _style1 = TextStyle(color: Colors.white, fontSize: 20);
  RefreshModel _refreshModel = RefreshModel();

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  late List _myActivities;
  late List<List> _lessons = [];
  Set<int> listLesson={};
  Widget format(Word item) {
    if (item.english == null) {
      item.english = "не задано";
    }
    if (item.russia == null) {
      item.russia = "не задано";
    }
    if (item.transcr == null) {
      item.transcr = "не задано";
    }
    return Slidable(
      actionPane: SlidableStrechActionPane(),
      closeOnScroll: true,
      // dismissal: SlidableDismissal(dragDismissible: false,)

      actions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () =>
              {deleteDialog(context, item)}, // _showSnackBar('Delete'),
        ),
        /*IconSlideAction(
                caption: 'Share',
                color: Colors.indigo,
                icon: Icons.share,
                onTap: () =>{}, // _showSnackBar('Share'),
              ),
            ],
*/
        /*
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'More',
                color: Colors.black45,
                icon: Icons.more_horiz,
                onTap: () =>{},// _showSnackBar('More'),
              ),*/
      ],

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          "id: ",
                          style: _style,
                        ),
                        Text(
                          item.id.toString(),
                          style: _style1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "less: ",
                          style: _style,
                        ),
                        Text(
                          item.lesson.toString(),
                          style: _style1,
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text(
                          "english: ",
                          style: _style,
                        ),
                        Text(
                          item.english,
                          style: _style1,
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text(
                          "russia:  ",
                          style: _style,
                        ),
                        Text(
                          item.russia,
                          style: _style1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "transcr:",
                          style: _style,
                        ),
                        Text(
                          item.transcr,
                          style: _style1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Data Add:",
                          style: _style,
                        ),
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(item.dataAdd)
                              .toLocal()
                              .toString()
                              .substring(0, 10),
                          style: _style1,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "rating:",
                          style: _style,
                        ),
                        Text(
                          item.rating.toString(),
                          style: _style1,
                        ),
                      ],
                    ),
                    // Text(""),
                  ],
                ),
              ),

              /* Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ElevatedButton(onPressed:() {deleteDialog(context, item);},style: ButtonStyle
                        (backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                          minimumSize:MaterialStateProperty.all(Size(30, 40)), padding: MaterialStateProperty.all(EdgeInsets.zero)  ),child:  Text("delete")),
                    ),

                    */
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: ElevatedButton(
                    onPressed: () {
                      _update1(context, item);
                    },
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(60, 60)),
                        padding: MaterialStateProperty.all(EdgeInsets.zero)),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("update"))),
              )
            ],
          ),
          Container(
            width: 300,
            height: 5,
            color: Colors.amber,
          )
        ],
      ),
    );
    // Container(width: 300,height: 5, color: Colors.black,)
  }

  List<Widget> get _items => _tasks.map((item) => format(item)).toList();

  //Word get _items1 (int i)=>_tasks[i];

  @override
  void initState() {
    _myActivities = [];

    //final slider =Provider.of<SliderModel>(context);
    _refreshModel.update = true;
    refresh();
    super.initState();
  }

  void refresh() async {
    if (_isSearching) {
      List<Map<String, dynamic>> _results =
          await Db.searchQuery(Word.table, searchQuery);
      _tasks = _results.map((item) => Word.fromMap(item)).toList();
      List<Map<String, dynamic>> _results1 =
          await Db.searchQueryRus(Word.table, searchQuery);
      _tasks.addAll(_results1.map((item) => Word.fromMap(item)).toList());
    } else {
      List<Map<String, dynamic>> _results = await Db.query(Word.table);
      _tasks = _results.map((item) => Word.fromMap(item)).toList();
    }
    ;

    listLesson.clear();
    bool k = false;
    _lessons.clear();
    //_lessons.add(list = [_tasks[0].lesson, 0, 1]);
    int countI = _lessons.length;
    for (int i = 0; i < _tasks.length; i++) {
      listLesson.add(_tasks[i].lesson);

     // k = false;
      //int count = 1;
      //print('_lessons.length=${_lessons.length}');
      //for (int j = 0; j < countI; j++) {
        //if (_tasks[i].lesson == _lessons[j][0]) {
          //k = true;
          //count++;
       // }
      }
     // if (k) {
      //  _lessons.add(list = [_tasks[i].lesson, 0, count]);
    //  }
     // print('count= $count');
   // }

    //_titleAppbar = _tasks.length.toString();
    _titleAppbar = listLesson.length.toString();

    setState(() {});
  }

  void deleteDialog(BuildContext context, Word item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('НАХ?'),
            //elevation: 0,
            children: [
              Row(
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('нех'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                      _delete(item);
                    },
                    child: Text('нах!'),
                  )
                ],
              ),
            ],
          );
        });
  }

  void _delete(Word item) async {
    await Db.delete(Word.table, item);
    Fluttertoast.showToast(
      msg: 'нах!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
    );
    refresh();
  }

  void _save(Word item) async {
    Navigator.of(context).pop();

    await Db.insert(Word.table, item);
    setState(() => {});
    refresh();
  }

  void _saveupdate(Word item) async {
    Navigator.of(context).pop();

    await Db.update(Word.table, item);
    print("ID:${item.id}");
    setState(() => {});
    refresh();
  }

  void _update1(BuildContext context, Word item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //final slider =Provider.of<SliderModel>(context);
          // return   Consumer<SliderModel>(
          // builder: (context, slider, child){
          return AlertDialog(
              //title: Text("Update Task"),
              actions: <Widget>[
                TextButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop()),
                TextButton(
                    child: Text('Save'),
                    onPressed: () => {
                          if (item.id == 0) {_save(item)} else _saveupdate(item)
                        })
              ],
              content: Container(
                width: 500,
                child: ListView(children: <Widget>[
                  TextFormField(
                    initialValue: item.english,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'English word',
                    ),
                    onChanged: (value) {
                      item.english = value;
                    },
                  ),
                  TextFormField(
                    autofocus: false,
                    initialValue: item.russia,
                    decoration: InputDecoration(
                        labelText: 'Перевод на русский',
                        counterText: item.russia,
                        hintText: item.russia),
                    onChanged: (value) {
                      item.russia = value;
                    },
                  ),
                  TextFormField(
                    initialValue: item.transcr,
                    autofocus: false,
                    decoration: InputDecoration(
                        labelText: 'транскрипция', hintText: item.transcr),
                    onChanged: (value) {
                      item.transcr = value;
                    },
                  ),
                  TextFormField(
                    initialValue: item.lesson.toString(),
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    decoration: InputDecoration(
                        labelText: 'less', hintText: item.lesson.toString()),
                    onChanged: (value) {
                      int value1 = int.parse(value);
                      item.lesson = value1;
                      print("value1=$value1");
                    },
                  ),
                  Consumer<SliderModel>(builder: (context, slider, child) {
                    //if(slider.rate==null){slider.rate=0;}
                    slider.rate = item.rating;
                    return Column(
                      children: [
                        Container(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text('Rating'),
                                Text('${slider.rate.toString()}'),
                              ],
                            ),
                            Expanded(
                              child: Slider(
                                value: slider.rate.toDouble(),
                                min: 0,
                                max: 10,
                                divisions: 5,
                                label: slider.rate.toString(),
                                onChanged: (double newValue) {
                                  slider.rate = newValue.round();
                                  item.rating = newValue.toInt();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  })
                ]),
              ));
        });
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.black),
      ),
      style: TextStyle(color: Colors.black, fontSize: 20.0),
      onChanged: (query) => {print('search; $query'), updateSearchQuery(query)},
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
      IconButton(
          icon: Icon(Icons.auto_stories),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Workout()),
            );
          }),
      IconButton(
          icon: Icon(Icons.filter_alt),
          onPressed: () {
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context ) => MyDataTable(list:listLesson)),
            );
          })
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
      refresh();
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  @override
  Widget build(BuildContext context) {
    //final slider =Provider.of<SliderModel>(context);
    if (!_isSearching) {
      refresh();
    }
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : Container(),
        title:
            _isSearching ? _buildSearchField() : Text("Word: $_titleAppbar "),
        toolbarHeight: 40,
        actions: _buildActions(),
        /*
            IconButton(icon: Icon(Icons.update), onPressed: refresh),
            IconButton(icon: Icon(Icons.auto_stories),
          onPressed: () {
           Navigator.push(context,
            MaterialPageRoute(builder: (context) => Workout()),
          );

          print('refresh');
          },)
            */
      ),
      body: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.fromLTRB(3, 5, 1, 5),
          child: Column(
            children: [
              MultiSelectFormField(
                autovalidate: false,
                chipBackGroundColor: Colors.red,
                chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                checkBoxActiveColor: Colors.red,
                checkBoxCheckColor: Colors.green,
                dialogShapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                title: Text(
                  "Title Of Form",
                  style: TextStyle(fontSize: 16),
                ),
                dataSource: [
                  {
                    "display": "Running1",
                    "value": "Runningg1",
                  },
                  {
                    "display": "Climbing2",
                    "value": "Climbing2",
                  },
                  {
                    "display": "Walking3",
                    "value": "Walking3",
                  },
                  {
                    "display": "Running4",
                    "value": "Running4",
                  },
                  {
                    "display": "Climbing5",
                    "value": "Climbing5",
                  },
                  {
                    "display": "Walking6",
                    "value": "Walking6",
                  },
                  {
                    "display": "Running7",
                    "value": "Running7",
                  },
                  {
                    "display": "Climbing8",
                    "value": "Climbing8",
                  },
                  {
                    "display": "Walking9",
                    "value": "Walking9",
                  },
                ],
                textField: 'display',
                valueField: 'value',
                okButtonLabel: 'OK',
                cancelButtonLabel: 'CANCEL',
                hintWidget: Text('Please choose one or more'),
                initialValue: _myActivities,
                onSaved: (value) {
                  if (value == null) return;
                  setState(() {
                    _myActivities = value;
                  });
                },
              ),
              /*Slider(value: rate.toDouble(),
                          min: 0,
                          max: 10,
                          divisions: 5,
                          onChanged: (double newValue1) {
                            setState(() {
                              rate = newValue1.round();
                            });
                          },), */

              Expanded(
                  child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _items[index];
                      })),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Word item = Word(
              id: 0,
              english: "",
              russia: "",
              transcr: "",
              dataAdd: DateTime.now().millisecondsSinceEpoch,
              complete: false,
              rating: 0,
              lesson: 0);
          _update1(context, item);
        },
        tooltip: 'New TODO',
        child: Icon(Icons.library_add),
      ),
    );
  }
}

class SliderModel extends ChangeNotifier {
  int _rate = 0;

  int get rate => _rate;

  void set rate(int value) {
    _rate = value;
    notifyListeners();
  }
}
