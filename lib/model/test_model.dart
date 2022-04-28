import 'package:cloud_firestore/cloud_firestore.dart';

class Test{
  String? id;
  bool? test;


  Test({
    this.id,
    this.test,

  });

  factory Test.fromDoc(DocumentSnapshot doc) {

    return Test(
      id: doc.id,
      test: doc['test'],


    );
  }
}