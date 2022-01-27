import 'package:flutter/material.dart';
import 'package:unglibrary/utility/my_constant.dart';
import 'package:unglibrary/widgets/show_button.dart';
import 'package:unglibrary/widgets/show_form.dart';
import 'package:unglibrary/widgets/show_logo.dart';
import 'package:unglibrary/widgets/show_text.dart';

class Authen extends StatelessWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

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
        pressFunc: () => Navigator.pushNamed(context, MyConstant.routeCreateAccount),
      );

  ShowButton newLogin() => ShowButton(
        label: 'Login',
        pressFunc: () {},
      );

  ShowForm newUsername() {
    return ShowForm(
      label: 'Username :', changeFunc: (String value) {  },
    );
  }

  ShowForm newPassword() {
    return ShowForm(
      label: 'Password :', changeFunc: (String value) {  },
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
