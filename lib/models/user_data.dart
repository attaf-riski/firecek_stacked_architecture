class UserData {
  final userName, imageURL, email;
  final List<String> myProduct;

  UserData({this.userName, this.imageURL, this.myProduct, this.email});

  static UserData fromMap({Map<String, dynamic> map, String email}) {
    if (map == null) return null;

    return UserData(
        imageURL: map['imageURL'],
        userName: map['name'],
        myProduct: map['myProduct'].cast<String>(),
        email: email);
  }
}
