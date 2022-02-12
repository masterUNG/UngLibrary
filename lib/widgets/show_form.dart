// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:unglibrary/utility/my_constant.dart';
import 'package:unglibrary/widgets/show_text.dart';

class ShowForm extends StatelessWidget {
  final String label;
  final Function(String) changeFunc;
  final double? width;
  const ShowForm({
    Key? key,
    required this.label,
    required this.changeFunc,
     this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: width ?? 250,
      height: 40,
      child: TextFormField(
        onChanged: changeFunc,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            fillColor: Colors.white.withOpacity(0.75),
            filled: true,
            label: ShowText(text: label),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyConstant.dark),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyConstant.light),
              borderRadius: BorderRadius.circular(20),
            )),
      ),
    );
  }
}
