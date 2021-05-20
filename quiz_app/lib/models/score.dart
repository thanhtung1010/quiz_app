import 'package:cloud_firestore/cloud_firestore.dart';

class DataScore {
  final CollectionReference categoryList =
      FirebaseFirestore.instance.collection('Scores');
  Future<void> AddScore(Map scoreData, String scoreId) async {
    await categoryList.doc(scoreId).set(scoreData).catchError((e) {
      if (!e) {
        print('add score success');
      } else {
        print(e.toString());
      }
    });
  }
}
