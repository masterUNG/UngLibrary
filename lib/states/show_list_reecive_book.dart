import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unglibrary/models/reserve_model.dart';
import 'package:unglibrary/states/show_progress.dart';
import 'package:unglibrary/utility/my_constant.dart';
import 'package:unglibrary/widgets/show_text.dart';

class ShowListReceiveBook extends StatefulWidget {
  const ShowListReceiveBook({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowListReceiveBook> createState() => _ShowListReceiveBookState();
}

class _ShowListReceiveBookState extends State<ShowListReceiveBook> {
  bool load = true;
  bool? haveData;

  var reserveModels = <ReserveModel>[];

  @override
  void initState() {
    super.initState();
    readReserveBook();
  }

  Future<void> readReserveBook() async {
    await FirebaseAuth.instance.authStateChanges().listen((event) async {
      String docUser = event!.uid;

      await FirebaseFirestore.instance
          .collection('user')
          .doc(docUser)
          .collection('reserve')
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          haveData = true;

          for (var item in value.docs) {
            ReserveModel reserveModel = ReserveModel.fromMap(item.data());
            reserveModels.add(reserveModel);
          }
        } else {
          haveData = false;
        }

        setState(() {
          load = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: const Text('แสดงหนังสือ ที่จองไว้'),
      ),
      body: load
          ? const ShowProgress()
          : haveData!
              ? LayoutBuilder(
                builder: (context, constraints) {
                  return ListView.builder(
                      itemCount: reserveModels.length,
                      itemBuilder: (context, index) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: constraints.maxWidth - 150,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ShowText(
                                        text: reserveModels[index].nameBook,
                                        textStyle: MyConstant().h2Style()),
                                    ShowText(
                                        text:
                                            convertToString(reserveModels[index].endDate),
                                        textStyle: MyConstant().h3Style()),
                                        ShowText(text: reserveModels[index].status ? 'สถานะ : กำลังจอง' : 'สถานะ : ยกเลิก หรือ เลยเวลาจอง' )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                height: 150,
                                child: Image.network(reserveModels[index].cover),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                }
              )
              : Center(
                  child: ShowText(
                  text: 'ไม่มีหนังสือที่จองไว้',
                  textStyle: MyConstant().h1Style(),
                )),
    );
  }

  String convertToString(Timestamp endDate) {
    DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    return dateFormat.format(endDate.toDate());
  }
}
