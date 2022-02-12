import 'package:flutter/material.dart';
import 'package:unglibrary/states/ecard.dart';
import 'package:unglibrary/states/history.dart';
import 'package:unglibrary/states/home.dart';
import 'package:unglibrary/states/noti.dart';
import 'package:unglibrary/states/review.dart';
import 'package:unglibrary/utility/my_constant.dart';

class MyService extends StatefulWidget {
  const MyService({
    Key? key,
  }) : super(key: key);

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  var bottomNavigationBarItems = <BottomNavigationBarItem>[];
  var titles = <String>[
    'Home',
    'History',
    'Review',
    'Ecard',
    'Noti',
  ];

  var iconDatas = <IconData>[
    Icons.home,
    Icons.history,
    Icons.reviews,
    Icons.card_membership,
    Icons.notifications,
  ];

  var widgets = <Widget>[
    Home(),
    History(),
    Review(),
    Ecard(),
    Noti(),
  ];

  int indexWidget = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    int i = 0;
    for (var item in iconDatas) {
      BottomNavigationBarItem bottomNavigationBarItem = BottomNavigationBarItem(
        backgroundColor: MyConstant.primary,
        icon: Icon(item),
        label: titles[i],
      );
      bottomNavigationBarItems.add(bottomNavigationBarItem);
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: const Text('My Service'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            indexWidget = value;
          });
        },
        currentIndex: indexWidget,
        items: bottomNavigationBarItems,
      ),
      body: widgets[indexWidget],
    );
  }
}
