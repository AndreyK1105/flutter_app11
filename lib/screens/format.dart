import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../service/word.dart';
final TextStyle _style = const TextStyle(color: Colors.amberAccent, fontSize: 17);
final TextStyle _style3 = const TextStyle(color: Colors.amberAccent, fontSize: 15);
final TextStyle _style2 = const TextStyle(color: Colors.white, fontSize: 15);
final TextStyle _style1 = const TextStyle(color: Colors.white, fontSize: 20);
final TextStyle _style4 = const TextStyle(color: Colors.black54, fontSize: 20);
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
        {}, // _showSnackBar('Delete'),
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