import 'package:cloud_firestore/cloud_firestore.dart';

class DataCategorys {
  final CollectionReference categoryList =
      FirebaseFirestore.instance.collection('Categorys');

  final DocumentReference nameCategoryList =
      FirebaseFirestore.instance.collection('Categorys').doc('categoryName');

  Future<void> AddCategory(Map catogeryData, String catogeryId) async {
    await FirebaseFirestore.instance
        .collection('Categorys')
        .doc(catogeryId)
        .set(catogeryData)
        .catchError((e) {
      if (!e) {
        print('add Categorys success');
      } else {
        print(e.toString());
      }
    });
  }

  Future GetCategoryList() async {
    List CategoryList = [];

    try {
      await categoryList.get().then((querySnapshot) => {
            querySnapshot.docs.forEach((element) {
              CategoryList.add(element.data());
            }),
          });
      return CategoryList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future GetIdCategory() async {
    List<String> CategoryList = [];

    try {
      await categoryList.get().then((querySnapshot) => {
            querySnapshot.docs.forEach((element) {
              CategoryList.add(element.get('categoryId'));
            }),
          });
      return CategoryList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future GetNameCategory() async {
    List CategoryList = [];

    try {
      await categoryList.get().then((querySnapshot) => {
            querySnapshot.docs.forEach((element) {
              CategoryList.add(element.get('categoryName'));
            }),
          });
      return CategoryList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future GetNameCategoryById(String categoryId) async {
    String nameCategory;

    try {
      await categoryList.doc(categoryId).get().then((DocumentSnapshot doc) => {
            nameCategory = doc.get('categoryName'),
          });
      return nameCategory;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
