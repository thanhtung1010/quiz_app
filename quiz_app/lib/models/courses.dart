import 'package:cloud_firestore/cloud_firestore.dart';

class DataCourses {
  final CollectionReference courseList =
      FirebaseFirestore.instance.collection('Couses');

  final DocumentReference nameCourseList =
      FirebaseFirestore.instance.collection('Couses').doc('courseName');

  Future<void> AddCourses(Map courseData, String courseId) async {
    await FirebaseFirestore.instance
        .collection('Couses')
        .doc(courseId)
        .set(courseData)
        .catchError((e) {
      if (!e) {
        print('add course success');
      } else {
        print(e.toString());
      }
    });
  }

  Future GetCourseList() async {
    List CourseList = [];

    try {
      await courseList.get().then((querySnapshot) => {
            querySnapshot.docs.forEach((element) {
              CourseList.add(element.data());
            }),
          });
      return CourseList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future GetIdCourses() async {
    List<String> CourseList = [];

    try {
      await courseList.get().then((querySnapshot) => {
            querySnapshot.docs.forEach((element) {
              CourseList.add(element.get('courseId'));
            }),
          });
      return CourseList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future GetNameCourses() async {
    List CourseList = [];

    try {
      await courseList.get().then((querySnapshot) => {
            querySnapshot.docs.forEach((element) {
              CourseList.add(element.get('courseName'));
            }),
          });
      return CourseList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future GetNameCourseById(String courseId) async {
    String nameCourse, desCourse;

    try {
      await courseList.doc(courseId).get().then((DocumentSnapshot doc) => {
            nameCourse = doc.get('courseName'),
            desCourse = doc.get('courseDes'),
          });
      return nameCourse;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
