import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:unglibrary/models/reserve_model.dart';
import 'package:unglibrary/states/ecard.dart';
import 'package:unglibrary/states/history.dart';
import 'package:unglibrary/states/home.dart';
import 'package:unglibrary/states/noti.dart';
import 'package:unglibrary/states/review.dart';
import 'package:unglibrary/states/show_list_reecive_book.dart';
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
    const Home(),
    const History(),
    const Review(),
    const Ecard(),
    const Noti(),
  ];

  int indexWidget = 0;

  FlutterLocalNotificationsPlugin flutterLocalNotiPlugin =
      FlutterLocalNotificationsPlugin();
  InitializationSettings? initializationSettings;
  AndroidInitializationSettings? androidInitializationSettings;

  var reserveModels = <ReserveModel>[];
  Timestamp? nearestTimeNoti;

  @override
  void initState() {
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
    setupLocalNoti();
    findTimeForNoti();
  }

  Future<void> findTimeForNoti() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(event!.uid)
          .collection('reserve')
          .orderBy('endDate')
          .get()
          .then((value) async {
        for (var item in value.docs) {
          ReserveModel reserveModel = ReserveModel.fromMap(item.data());
          reserveModels.add(reserveModel);
        }

        nearestTimeNoti = reserveModels[0].endDate;
        print('เวลาใกล้สุด ==>> ${nearestTimeNoti!.toDate().toString()}');

        DateTime currentDateTime = DateTime.now();
        DateTime nearestDateTime = nearestTimeNoti!.toDate();

        var diff = nearestDateTime.difference(currentDateTime);
        print('เวลาที่ diff กัน -->>> ${diff.inDays}');

        if (diff.inDays > 0 && diff.inDays <= 2) {
          Duration duration = const Duration(seconds: 10);
          await Timer(
              duration,
              () => processDisplayNoti('หนังสือที่จองได้แล้ว',
                  'หนังสือ ${reserveModels[0]}  จะมาอีกภายใน ${diff.inDays} วัน นะครับ'));
        }
      });
    });
  }

  Future<void> setupLocalNoti() async {
    androidInitializationSettings =
        const AndroidInitializationSettings('app_icon');
    initializationSettings =
        InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotiPlugin.initialize(
      initializationSettings!,
      onSelectNotification: onSelectNoti,
    );
  }

  Future<void> onSelectNoti(String? string) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ShowListReceiveBook(),
        ));
  }

  Future<void> processDisplayNoti(String title, String body) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      priority: Priority.high,
      importance: Importance.max,
      ticker: 'ticker',
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotiPlugin.show(0, title, body, notificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: (() =>
                  processDisplayNoti('หัวข้อทดสอบ', 'รายละเอียดทดสอบ')),
              icon: Icon(Icons.android)),
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, MyConstant.routeAuthen, (route) => false));
              },
              icon: const Icon(Icons.logout))
        ],
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
