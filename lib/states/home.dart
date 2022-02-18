import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unglibrary/models/book_model.dart';
import 'package:unglibrary/states/borrow_book.dart';
import 'package:unglibrary/states/show_progress.dart';
import 'package:unglibrary/states/show_title.dart';
import 'package:unglibrary/utility/my_constant.dart';
import 'package:unglibrary/widgets/show_button.dart';
import 'package:unglibrary/widgets/show_form.dart';
import 'package:unglibrary/widgets/show_logo.dart';
import 'package:unglibrary/widgets/show_text.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var forYouBookModels = <BookModel>[]; // for สำหรับคุณ
  var faveritBookModels = <BookModel>[]; // for ยอดนิยม
  var newBookModels = <BookModel>[]; // for มาใหม่

  @override
  void initState() {
    super.initState();
    readAllBook();
  }

  Future<void> readAllBook() async {
    await FirebaseFirestore.instance.collection('book').get().then((value) {
      for (var item in value.docs) {
        BookModel bookModel = BookModel.fromMap(item.data());
        setState(() {
          forYouBookModels.add(bookModel);
          if (newBookModels.length <= 3) {
            newBookModels.add(bookModel);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            newSearch(),
            const ShowTitle(title: 'สำหรับคุณ'),
            newForYouListView(),
            const ShowTitle(title: 'ยอดนิยม'),
            newFaveritListView(),
            const ShowTitle(title: 'มาใหม่'),
            newListView(),
          ],
        ),
      ),
    );
  }

  SizedBox newForYouListView() {
    return SizedBox(
      height: 200,
      child: forYouBookModels.isEmpty
          ? const ShowProgress()
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: forYouBookModels.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BorrowBook(bookModel: forYouBookModels[index]),
                    )),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 150,
                          child: CachedNetworkImage(
                              errorWidget: (context, url, error) =>
                                  const ShowLogo(),
                              imageUrl: forYouBookModels[index].cover),
                        ),
                        ShowText(text: cutWord(forYouBookModels[index].title)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  SizedBox newFaveritListView() {
    return SizedBox(
      height: 200,
      child: forYouBookModels.isEmpty
          ? const ShowProgress()
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: newBookModels.length,
              itemBuilder: (context, index) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 150,
                        child: CachedNetworkImage(
                            errorWidget: (context, url, error) =>
                                const ShowLogo(),
                            imageUrl: newBookModels[index].cover),
                      ),
                      ShowText(text: cutWord(newBookModels[index].title)),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  SizedBox newListView() {
    return SizedBox(
      height: 200,
      child: forYouBookModels.isEmpty
          ? const ShowProgress()
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: newBookModels.length,
              itemBuilder: (context, index) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 150,
                        child: CachedNetworkImage(
                            errorWidget: (context, url, error) =>
                                const ShowLogo(),
                            imageUrl: newBookModels[index].cover),
                      ),
                      ShowText(text: cutWord(newBookModels[index].title)),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Row newSearch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ShowForm(
          width: 200,
          label: 'Search',
          changeFunc: (String string) {},
        ),
        ShowButton(
          label: 'Search',
          pressFunc: () {},
        ),
      ],
    );
  }

  String cutWord(String title) {
    String string = title;
    if (string.length > 20) {
      string = string.substring(0, 20);
      string = '$string ...';
    }
    return string;
  }
}
