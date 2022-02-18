// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:unglibrary/models/book_model.dart';
import 'package:unglibrary/states/show_progress.dart';
import 'package:unglibrary/utility/my_constant.dart';
import 'package:unglibrary/widgets/show_button.dart';
import 'package:unglibrary/widgets/show_text.dart';

class BorrowBook extends StatefulWidget {
  final BookModel bookModel;
  const BorrowBook({
    Key? key,
    required this.bookModel,
  }) : super(key: key);

  @override
  _BorrowBookState createState() => _BorrowBookState();
}

class _BorrowBookState extends State<BorrowBook> {
  BookModel? bookModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookModel = widget.bookModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: const Text('ยืม จอง หนังสือ'),
      ),
      body: Center(
        child: Column(
          children: [
            newCover(),
            ShowText(
              text: bookModel!.title,
              textStyle: MyConstant().h2Style(),
            ),
            const SizedBox(
              height: 16,
            ),
            newDetail(title: 'ผู้เขียน :', detail: bookModel!.author),
            newDetail(title: 'Publisher :', detail: bookModel!.publisher),
            newDetail(title: 'Category :', detail: bookModel!.bookCatetory),
            newDetail(title: 'Code :', detail: bookModel!.bookCode),
            newDetail(title: 'จำนวนหน้า :', detail: bookModel!.numberOfPage),
            newDetail(title: 'Detail :', detail: bookModel!.detail),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ShowButton(label: 'ยืม', pressFunc: (){}),
                ShowButton(label: 'จอง', pressFunc: (){}, primaryColor: Colors.red.shade200,),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget newDetail({required String title, required String detail}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShowText(text: title),
          SizedBox(
            width: 300,
            child: ShowText(text: detail),
          ),
        ],
      ),
    );
  }

  Widget newCover() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 32),
      width: 120,
      height: 150,
      child: CachedNetworkImage(
        imageUrl: bookModel!.cover,
        placeholder: (context, string) => const ShowProgress(),
      ),
    );
  }
}
