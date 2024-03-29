// ignore: file_names
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/feature/domain/entities/word_entiti/word_entiti.dart';
import 'package:flutter_app1/screens/loadFile.dart';
import 'package:flutter_app1/screens/workout.dart';
import 'package:flutter_app1/service/db.dart';
import 'package:flutter_app1/service/filterElement.dart';
import 'package:flutter_app1/service/word.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class ListDb extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ListDb> {
  String _titleAppbar = "";
 // String _task1 = "";
  List<Word> _tasks = [];
  List<Widget> _itemsList = [];
  List <FilterElement>listFilter= [];

  int rate = 0;
  final TextStyle _style = const TextStyle(color: Colors.amberAccent, fontSize: 17);
  final TextStyle _style3 = const TextStyle(color: Colors.amberAccent, fontSize: 15);
  final TextStyle _style2 = const TextStyle(color: Colors.white, fontSize: 15);
  final TextStyle _style1 = const TextStyle(color: Colors.white, fontSize: 20);
  final TextStyle _style4 = const TextStyle(color: Colors.black54, fontSize: 20);
  final RefreshModel _refreshModel = RefreshModel();

  final TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  bool _isFilter = false;
  String searchQuery = "Search query";
  Set <int> filterQuery = {};

  //late List _myActivities;
 final List<List> _lessons = [];
  Set<int> listLesson={};
  Widget format(Word item) {
   /* if (item.english == null) {
      item.english = "не задано";
    }
    if (item.russia == null) {
      item.russia = "не задано";
    }
    if (item.transcr == null) {
      item.transcr = "не задано";
    }*/
    return Slidable(
      startActionPane: ActionPane(motion:  const StretchMotion() ,children: [
        SlidableAction(
        label: 'Delete',
          backgroundColor: Colors.red,
        icon: Icons.delete,
          onPressed: (_) =>
        {deleteDialog(context, item)}, // _showSnackBar('Delete'),
      )],),

      closeOnScroll: true,
      // dismissal: SlidableDismissal(dragDismissible: false,)


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


        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration:  BoxDecoration(borderRadius: BorderRadius.circular(8),
                color: Colors.grey[500]),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 2.0, 0.0, 2.0 ),
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
                                  style: _style3,
                                ),
                                Text(
                                  item.id.toString(),
                                  style: _style2,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "less: ",
                                  style: _style3,
                                ),
                                Text(
                                  item.lesson.toString(),
                                  style: _style2,
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
                                  "russia:   ",
                                  style: _style,
                                ),
                                Expanded(
                                  child: Text(
                                    item.russia,
                                    style: _style4,
                                  ),
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
                                  style: _style3,
                                ),
                                Text(
                                  DateTime.fromMillisecondsSinceEpoch(item.dataAdd)
                                      .toLocal()
                                      .toString()
                                      .substring(0, 10),
                                  style: _style2,
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
                    height: 0,
                    color: Colors.amber,
                  )
                ],
              ),
            ),
          ),
        ),
      );

    // Container(width: 300,height: 5, color: Colors.black,)
  }

  List<Widget> get _items => _tasks.map((item) => format(item)).toList();

  //Word get _items1 (int i)=>_tasks[i];

  @override
  void initState() {
    //_myActivities = [];

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
      if(searchQuery!=''){
      List<Map<String, dynamic>> _results1 =
          await Db.searchQueryRus(Word.table, searchQuery);
      _tasks.addAll(_results1.map((item) => Word.fromMap(item)).toList());}
    } else if (_isFilter){
      List<Map<String, dynamic>> _results = await Db.searchQueryFilter1(Word.table, listFilter);
      _tasks = _results.map((item) => Word.fromMap(item)).toList();

    } else {
      List<Map<String, dynamic>> _results = await Db.query(Word.table);
      _tasks = _results.map((item) => Word.fromMap(item)).toList();
    }
   List <Map<String, dynamic>> _listLess=await Db.queryLesson(Word.table);


    listLesson.clear();
   // bool k = false;
    //_lessons.toSet();
    _lessons.clear();
    //_lessons.add(list = [_tasks[0].lesson, 0, 1]);
  //  int countI = _lessons.length;
    for (int i = 0; i < _listLess.length; i++) {
    //  if (i<100)print('_listLess[i][lesson]===${_listLess[i]['lesson']}');
      listLesson.add(_listLess[i]['lesson']);
      //listLesson.add(_tasks[i].lesson);
    }
    List <FilterElement> list1=[];
    for (int i in listLesson){
      FilterElement filterElement=FilterElement(i, false);
      list1.add(filterElement);
    }


    // for (int i=0; i<listFilter.length; i++){
    //   list1.add(listFilter[i]);
    //
    // }
    // listFilter.clear();
    // bool check=false;
    if(_isFilter) {
      for (int i = 0; i < list1.length; i++) {
        for (int j = 0; j < listFilter.length; j++) {
          //  print('List1.lenght=${list1.length}');
          if (list1[i].lesson == listFilter[j].lesson) {
            list1[i].checkLesson = listFilter[j].checkLesson;
            break;
          }
        }

        // FilterElement filterElement = FilterElement(i, check);
        // listFilter.add(filterElement);
        // check = false;
      }
    }
    listFilter.clear();
    listFilter.addAll(list1);


print('listFilter.length==${listFilter.length}');



     // if (k) {
      //  _lessons.add(list = [_tasks[i].lesson, 0, count]);
    //  }
     // print('count= $count');
   // }

    //_titleAppbar = _tasks.length.toString();
    _titleAppbar = listLesson.length.toString();

    _itemsList= _items;
print ("_itemsList.length=====${_itemsList.length}");
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
                    child: const Text('нех'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context);
                      _delete(item);
                    },
                    child: const Text('нах!'),
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
        builder: ( _) {
          // final slider =Provider.of<SliderModel>(context);
          // slider.rate=item.rating;
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
                   Consumer<SliderModel>(builder: (_, slider, __) {
                    //if(slider.rate==null){slider.rate=0;}
                   slider.rateNoUpdate = item.rating;
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
                                Text(slider.rate.toString()),
                              ],
                            ),
                            Expanded(
                              child: Slider(

                                value: slider.rate.toDouble(),
                                min: 0,
                                max: 10,
                                divisions: 10,
                                label: slider.rate.toString(),
                                onChanged: (double newValue) {
                                  slider.rate = newValue.toInt();
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
              _isSearching=false;

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
          onPressed: () async {
            List<WordEntiti> wordEntiti=WordEntiti.fromWord(_tasks);
            await Navigator.pushNamed(context, '/worcout_page', arguments: wordEntiti );
            // await Navigator.pushNamed(context, '/workout', arguments:_tasks );
            //await Navigator.pushNamed(context, '/worcout1', arguments: _tasks );

             refresh();
          }),

      IconButton(
          icon: Icon(Icons.file_download),
          onPressed: () {
            Navigator.pushNamed(context, '/load');
          }),

      IconButton(
    icon: Icon(Icons.account_box),
    onPressed: (){
      Navigator.pushNamed(context, '/auth_fireBase');
    },
    ),

      IconButton(
        icon: Icon(Icons.account_tree),
        onPressed: (){
          Navigator.pushNamed(context, '/test3');
        },
      ),
      IconButton(
          icon: (_isFilter)?Icon(Icons.filter_alt):Icon(Icons.filter_alt_outlined),
          onPressed: () async {
            FilterModel filterModel= FilterModel(false, listFilter);
          // List <int>? listFilter=[];
              filterModel = (await Navigator.pushNamed<FilterModel>  (context, '/dataTable', arguments:filterModel))!;
           // Navigator.pushNamed (context, '/dataTable', arguments:listLesson);
            _isFilter=filterModel._isFilter;

            listFilter=filterModel.listFilterList;
            if(filterModel._isFilter){
            refresh();} else {
              _isFilter=false;
              refresh();
            }

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
      _items.clear();
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
      //_isSearching=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final slider =Provider.of<SliderModel>(context);
   // if (!_isSearching) {
     // refresh();
   // }
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : Container(),
        title:
            _isSearching ? _buildSearchField() : Text("Lessons: $_titleAppbar "),
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
                    itemCount: _itemsList.length,
                    itemBuilder: (BuildContext context, int index) {
                     // print(_items.length);
                      return _itemsList[index];
                    }),
              ),

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
              dataAdd: 0,
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

  void set rateNoUpdate(int value){
    _rate=value;
  }
}
class FilterModel {
   bool _isFilter=false;
  Set <int> listFilter={};
  List<FilterElement> listFilterList=[];

  FilterModel(this._isFilter, this.listFilterList);
}
class LessCheck {
  bool _check = false;
  int _lesson=0;

  LessCheck(this._check, this._lesson);

  bool get check => _check;

  int get lesson => _lesson;
}
