// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:unglibrary/utility/my_constant.dart';
import 'package:unglibrary/utility/my_dialog.dart';
import 'package:unglibrary/widgets/show_button.dart';
import 'package:unglibrary/widgets/show_form.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? name, email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: const Text('Create Account'),
      ),
      body: Container(
        decoration: MyConstant().primaryBox(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: Column(
              children: [
                ShowForm(
                  label: 'Display Name :',
                  changeFunc: (String value) => name = value.trim(),
                ),
                ShowForm(
                  label: 'Email :',
                  changeFunc: (String value) => email = value.trim(),
                ),
                ShowForm(
                  label: 'Password :',
                  changeFunc: (String value) => password = value.trim(),
                ),
                ShowButton(
                  label: 'Create New Account',
                  pressFunc: () {
                    print('name = $name, email = $email, password = $password');

                    if ((name?.isEmpty ?? true) ||
                        (email?.isEmpty ?? true) ||
                        (password?.isEmpty ?? true)) {
                      print('Have Space');
                      MyDialog(context: context).normalDialog(
                          'Have Space ?', 'Please Fill Every Blank');
                    } else {
                      print('No Space');
                    }
                  },
                  width: 250,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
