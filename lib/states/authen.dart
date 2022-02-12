// ignore_for_file: invalid_return_type_for_catch_error

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unglibrary/states/my_service.dart';
import 'package:unglibrary/utility/my_constant.dart';
import 'package:unglibrary/utility/my_dialog.dart';
import 'package:unglibrary/widgets/show_button.dart';
import 'package:unglibrary/widgets/show_form.dart';
import 'package:unglibrary/widgets/show_logo.dart';
import 'package:unglibrary/widgets/show_text.dart';

class Authen extends StatefulWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: MyConstant().primaryBox(),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  newLogo(),
                  newAppName(),
                  newUsername(),
                  newPassword(),
                  newLogin(),
                  newRegister(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ShowButton newRegister(BuildContext context) => ShowButton(
        label: 'Register',
        pressFunc: () =>
            Navigator.pushNamed(context, MyConstant.routeCreateAccount),
      );

  ShowButton newLogin() => ShowButton(
        label: 'Login',
        pressFunc: () async {
          if ((email?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            MyDialog(context: context)
                .normalDialog('Have Space ?', 'Please Fill Every Blank');
          } else {
            await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: email!, password: password!)
                .then((value) => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyService(),
                    ),
                    (route) => false))
                .catchError((onError) => MyDialog(context: context)
                    .normalDialog(onError.code, onError.message));
          }
        },
      );

  ShowForm newUsername() {
    return ShowForm(
      label: 'Username :',
      changeFunc: (String value) => email = value.trim(),
    );
  }

  ShowForm newPassword() {
    return ShowForm(
      label: 'Password :',
      changeFunc: (String value) => password = value.trim(),
    );
  }

  ShowText newAppName() {
    return ShowText(
      text: MyConstant.appName,
      textStyle: MyConstant().h1Style(),
    );
  }

  SizedBox newLogo() {
    return const SizedBox(
      width: 200,
      child: ShowLogo(),
    );
  }
}
