class Users {
  final String uid;
  final String mshv;
  final String email;
  final String name;
  final String rule;
  final String cid;

  Users({
    this.uid,
    this.mshv,
    this.email,
    this.name,
    this.rule,
    this.cid,
  });

  // Users.fromData(Map<String, dynamic> data)
  //     : uid = data['uid'],
  //       mshv = data['mshv'],
  //       password = data['password'],
  //       email = data['email'],
  //       name = data['name'],
  //       rule = data['rule'],
  //       cid = data['cid'];

  // Map<String, dynamic> toJson() {
  //   return {
  //     'uid': uid,
  //     'mshv': mshv,
  //     'password': password,
  //     'email': email,
  //     'name': name,
  //     'rule': rule,
  //     'cid': cid,
  //   };
  // }
  // factory Users.fromJson(Map<String, dynamic> json) {
  //   return Users(
  //     uid: json['uid'],
  //     mshv: json['mshv'],
  //     password: json['password'],
  //     email: json['email'],
  //     name: json['name'],
  //     rule: json['rule'],
  //     cid: json['cid'],
  //   );
  // }
}
