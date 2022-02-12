import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:unglibrary/models/book_model.dart';
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
  var forYouBookModels = <BookModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllBook();
  }

  Future<void> readAllBook() async {
    await FirebaseFirestore.instance.collection('book').get().then((value) {
      for (var item in value.docs) {
        BookModel bookModel = BookModel.fromMap(item.data());
        setState(() {
          forYouBookModels.add(bookModel);
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
            const ShowTitle(
              title: 'สำหรับคุณ',
            ),
            newForYouListView(),
            const ShowTitle(title: 'ยอดนิยม'),
            newForYouListView(),
            const ShowTitle(title: 'มาใหม่'),
            newForYouListView(),
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
                                imageUrl: forYouBookModels[index].cover),
                          ),
                          ShowText(text: forYouBookModels[index].name),
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
}
