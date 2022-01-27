import 'package:flutter/material.dart';
import 'package:unglibrary/states/authen.dart';
import 'package:unglibrary/states/create_account.dart';
import 'package:unglibrary/utility/my_constant.dart';

Map<String, WidgetBuilder> map = {
  MyConstant.routeAuthen:(BuildContext context)=> const Authen(),
  MyConstant.routeCreateAccount:(BuildContext context)=> const CreateAccount(),
};

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     routes: map,
     title: MyConstant.appName,
     initialRoute: MyConstant.routeAuthen,
    );
  }
}
