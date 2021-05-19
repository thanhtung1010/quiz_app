import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/category.dart';
import 'package:quiz_app/views/components/squared_button.dart';
import 'package:random_string/random_string.dart';

class ManageCategory extends StatefulWidget {
  @override
  _ManageCategoryState createState() => _ManageCategoryState();
}

class _ManageCategoryState extends State<ManageCategory> {
  int _selectedIndex = 0;
  List<Widget> list = [
    Add(),
    Delete(),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Center(
          child: list[_selectedIndex],
        ),
        Positioned(
          left: 0,
          bottom: 0,
          child: Column(
            children: [
              SquaredButton(
                height: 70,
                width: 70,
                color: _selectedIndex == 0 ? Colors.purple[50] : Colors.white,
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 30,
                  color: _selectedIndex == 0 ? Colors.black : Colors.grey,
                ),
                onclick: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              SquaredButton(
                height: 70,
                width: 70,
                color: _selectedIndex == 1 ? Colors.purple[50] : Colors.white,
                icon: Icon(
                  Icons.do_disturb_on_outlined,
                  size: 30,
                  color: _selectedIndex == 1 ? Colors.black : Colors.grey,
                ),
                onclick: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  String CategoryName, CategoryDes, imgURL, CategoryId;
  DataCategorys dataCategory = new DataCategorys();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  addCategory() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      CategoryId = randomAlphaNumeric(20);
      Map<String, String> CategoryMap = {
        "categoryId": CategoryId,
        "categoryName": CategoryName,
        "categoryDes": CategoryDes,
        "imgURL": imgURL,
      };

      await dataCategory.AddCategory(CategoryMap, CategoryId).then((value) => {
            setState(() {
              _isLoading = false;
            })
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _isLoading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      return value.isEmpty
                          ? "Name Category cannot be empty"
                          : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    onChanged: (val) {
                      CategoryName = val;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  TextFormField(
                    validator: (value) {
                      return value.isEmpty
                          ? "Description Category cannot be empty"
                          : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    onChanged: (val) {
                      CategoryDes = val;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  TextFormField(
                    validator: (value) {
                      return value.isEmpty
                          ? "Course image URL cannot be empty"
                          : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Course image URL',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    onChanged: (val) {
                      imgURL = val;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  FloatingActionButton(
                    onPressed: () => {
                      addCategory(),
                    },
                    child: Icon(Icons.done),
                  ),
                ],
              ),
            ),
          );
  }
}

class Delete extends StatefulWidget {
  @override
  _DeleteState createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  CollectionReference categoryInfo =
      FirebaseFirestore.instance.collection('Categorys');
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  List categoryIdList = [];
  String categoryID, categoryName, categoryDes;

  @override
  void initState() {
    super.initState();
    fecthIdCategoryList();
  }

  fecthIdCategoryList() async {
    dynamic resultant = await DataCategorys().GetIdCategory();

    if (resultant == null) {
      print('Unable to get category');
    } else {
      setState(() {
        categoryIdList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference questionList = FirebaseFirestore.instance
        .collection('Categorys')
        .doc(categoryID)
        .collection('Questions');
    Size size = MediaQuery.of(context).size;
    return _isLoading
        ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropDownField(
                    onValueChanged: (dynamic value) {
                      setState(() {
                        categoryID = value;
                      });
                    },
                    value: categoryID,
                    required: false,
                    hintText: 'Find course with name',
                    labelText: 'Courses',
                    items: categoryIdList,
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  FutureBuilder<DocumentSnapshot>(
                    future: categoryInfo.doc(categoryID).get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.hasData && !snapshot.data.exists) {
                        return Text("Category does not exist");
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> data = snapshot.data.data();
                        return TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: '${data['categoryDes']}',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(26),
                            ),
                          ),
                        );
                      }

                      return Text("loading");
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  FloatingActionButton(
                    onPressed: () => {
                      setState(() {
                        _isLoading = true;
                      }),
                      questionList
                          .doc()
                          .delete()
                          .then((value) => {
                                categoryInfo
                                    .doc(categoryID)
                                    .delete()
                                    .then((value) => {
                                          setState(() {
                                            _isLoading = false;
                                          }),
                                          print('Category Deleted !!'),
                                        })
                                    .catchError((e) => {
                                          setState(() {
                                            _isLoading = false;
                                          }),
                                          print("Failed to delete category: $e")
                                        })
                              })
                          .catchError((error) {
                        setState(() {
                          _isLoading = false;
                        });
                        print("Failed to delete category: $error");
                      })
                    },
                    child: Icon(Icons.done),
                  ),
                ],
              ),
            ),
          );
  }
}
