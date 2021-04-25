class UserTypeModel {
  UserTypeModel({this.userType, this.image, this.permistionID});

  String userType;
  String image;
  int permistionID;

  List<UserTypeModel> getListUserType() {
    List<UserTypeModel> userTypes = new List();
    userTypes.add(UserTypeModel(
        userType: 'farmer',
        image: 'assets/images/image1.jpeg',
        permistionID: 2));
    userTypes.add(UserTypeModel(
        userType: 'farmer_4c',
        image: 'assets/images/image2.png',
        permistionID: 3));
    userTypes.add(UserTypeModel(
        userType: 'host', image: 'assets/images/image4.jpg', permistionID: 4));
    userTypes.add(UserTypeModel(
        userType: 'manager',
        image: 'assets/images/image4.jpg',
        permistionID: 5));

    return userTypes;
  }
}
