// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:unglibrary/utility/my_constant.dart';
import 'package:unglibrary/widgets/show_text.dart';

class ShowTitle extends StatelessWidget {
  final String title;
  const ShowTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ShowText(
            text: title,
            textStyle: MyConstant().h2Style(),
          ),
        ),
      ],
    );
  }
}
