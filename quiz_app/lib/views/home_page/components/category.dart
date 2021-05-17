import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/category.dart';
import 'package:quiz_app/views/home_page/components/background.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String userRule;
  bool _isLoading = false;
  List CategoryList = [];
  @override
  void initState() {
    super.initState();
    fecthCourseList();
  }

  fecthCourseList() async {
    setState(() {
      _isLoading = true;
    });
    dynamic resultant = await DataCategorys().GetCategoryList();

    if (resultant == null) {
      print('Unable to get category');
    } else {
      setState(() {
        CategoryList = resultant;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference category =
        FirebaseFirestore.instance.collection('Categorys');
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              Text(
                'Test exam',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 40,
                  color: Colors.black87,
                  fontWeight: FontWeight.w900,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              _isLoading
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SingleChildScrollView(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            height: 80,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 80,
                                  width: size.width * 0.535,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: AutoSizeText(
                                    '${CategoryList[index]['categoryDes']}',
                                    maxLines: 3,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Text(
                                    '${CategoryList[index]['categoryName']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: CategoryList.length,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
