// Model Class for Converting Map<String, dynamic> data which is fetched
// from FirebaseFirestore to member variables of the class to easily access
// without checking the Map key names again and again

class UserProfileDataModel {
  String? name;
  String? mobileNo;
  String? about;
  String? address;
  String? imageUrl;

  // Constructor
  UserProfileDataModel.fromData(Map<String, dynamic> userProfile) {
    // assigning Map values to member variables
    imageUrl = userProfile["imageUrl"];
    name = userProfile["name"];
    mobileNo = userProfile["mobile"];
    // checking about and address keys are exists or not in FirebaseFirestore
    about = userProfile.containsKey("about") && userProfile["about"] != null
        ? userProfile["about"]
        : "";
    address =
        userProfile.containsKey("address") && userProfile["address"] != null
            ? userProfile["address"]
            : "";
  }
}
