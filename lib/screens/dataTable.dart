/// Flutter code sample for DataTable

// This sample shows how to display a [DataTable] with alternate colors per
// row, and a custom color for when the row is selected.

import 'package:flutter/material.dart';
import 'package:flutter_app1/screens/listDb.dart';

class MyDataTable extends StatelessWidget {
  Set  <int> list={};
  List<int> selectedList=[];
 MyDataTable({Key? key, required this.list}) : super(key: key);

  static const String _title = 'Flutter Code Sample';
  //


  @override
  Widget build(BuildContext context) {


    int numItems = list.length ;
    for(int i in list){
      selectedList.add(i);
    }

    List<bool> selected = List<bool>.generate(numItems, (int index) => false);


    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title),actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pop(FilterModel(false,[0]));
          }, icon: Icon(Icons.clear))
        ],),

        body:  MyStatefulWidget(checkList: selected),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            List<int> sel=[];


            for(int i=0; i<selected.length; i++){
              if(selected[i]){sel.add(selectedList[i]);}
            }
            Navigator.of(context).pop(FilterModel(true, sel ));},
          child: Icon(Icons.filter_alt),
        ),
      ),
    );
  }
}
/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
   List <bool> checkList =[];

   MyStatefulWidget({Key? key, required this.checkList}) : super(key: key);

  @override void initState(){

    //

  }
  //int numItems = 10 ;







  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  @override MyStatefulWidget get widget=> super.widget;






  @override
  Widget build(BuildContext context) {


    return SizedBox(
      width: double.infinity,
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text('Number'),
          ),
        ],
        rows: List<DataRow>.generate(
          widget.checkList.length,
              (int index) => DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  // All rows will have the same selected color.
                  if (states.contains(MaterialState.selected)) {
                    return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                  }
                  // Even rows will have a grey color.
                  if (index.isEven) {
                    return Colors.grey.withOpacity(0.3);
                  }
                  return null; // Use default value for other states and odd rows.
                }),
            cells: <DataCell>[DataCell(Text('Row $index'))],
            selected: widget.checkList[index],
            onSelectChanged: (bool? value) {
              setState(() {
                widget.checkList[index] = value!;
              });
            },
          ),
        ),
      ),
    );
  }
}
