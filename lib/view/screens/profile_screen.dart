import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internship_task/res/colors.dart';
import 'package:internship_task/res/components/button.dart';
import 'package:internship_task/res/components/textform_field.dart';
import 'package:internship_task/utils/image_utils.dart';
import 'package:internship_task/utils/routes/routes_name.dart';
import 'package:internship_task/utils/utils.dart';
import 'package:internship_task/viewmodel/profile_view_view_model.dart';
import 'package:provider/provider.dart';

class CustomerProfileScreen extends StatefulWidget {
  String imageUrl;
  String name;
  String mobileNo;
  String? about;
  String? address;
  CustomerProfileScreen(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.mobileNo,
      this.about,
      this.address});

  @override
  State<CustomerProfileScreen> createState() => _CustomerProfileScreenState();
}

class _CustomerProfileScreenState extends State<CustomerProfileScreen> {
  User? userInfo = FirebaseAuth.instance.currentUser;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  Utils utils = Utils();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.name;
    mobileNoController.text = widget.mobileNo;
    aboutController.text = widget.about!;
    addressController.text = widget.address!;
  }

  FocusNode firstNode = FocusNode();
  FocusNode secondNode = FocusNode();
  FocusNode thirdNode = FocusNode();
  FocusNode fourthNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final HeightX = MediaQuery.of(context).size.height;
    final WidthY = MediaQuery.of(context).size.width;
    final imageUtils = Provider.of<ImageUtils>(context, listen: false);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.lightMedBlue,
          title: Center(
              child: Text(
            "My Profile",
            style: GoogleFonts.poppins(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppColor.white),
          )),
          leading: InkWell(
              onTap: () {
                imageUtils.setImage = null;
                print("Image Path: ${imageUtils.image}");
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesName.bottomNav,
                  (route) => false,
                );
              },
              child: Icon(CupertinoIcons.back)),
        ),
        backgroundColor: AppColor.skyLightBlue,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Consumer<ImageUtils>(
                builder: (context, vm, child) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(180),
                                child: vm.image != null
                                    ? Image.file(
                                        vm.image!,
                                        height: HeightX * 0.27,
                                        width: WidthY * 0.54,
                                        fit: BoxFit.cover,
                                      )
                                    : ExtendedImage.network(
                                        widget.imageUrl,
                                        cache: true,
                                        fit: BoxFit.cover,
                                        height: HeightX * 0.27,
                                        width: WidthY * 0.54,
                                      ))),
                        Positioned(
                          child: CircleAvatar(
                            child: InkWell(
                                onTap: () {
                                  vm.pickImage();
                                },
                                child: Icon(Icons.edit)),
                            radius: HeightX * 0.03,
                          ),
                          left: WidthY * 0.51,
                          top: HeightX * 0.2,
                        )
                      ],
                    ),
                  );
                },
              ),
              Consumer<ProfileViewViewModel>(
                builder: (context, pvvm, child) {
                  return Column(
                    children: [
                      InputTextfield(
                        borderColor: AppColor.black,
                        hintText: "Name",
                        label: "Name",
                        editController: nameController,
                        fieldFontSize: 17,
                        currentFocus: firstNode,
                        nextFocus: secondNode,
                        customPrefixIcon: Icon(Icons.person),
                        prefixIconColor: AppColor.black,
                      ),
                      InputTextfield(
                        borderColor: AppColor.black,
                        hintText: "Mobile No",
                        label: "Mobile No",
                        editController: mobileNoController,
                        fieldFontSize: 17,
                        currentFocus: secondNode,
                        nextFocus: thirdNode,
                        customPrefixIcon: Icon(Icons.contact_phone),
                      ),
                      InputTextfield(
                        borderColor: AppColor.black,
                        hintText: "About",
                        label: "About",
                        editController: aboutController,
                        fieldFontSize: 17,
                        currentFocus: thirdNode,
                        nextFocus: fourthNode,
                        customPrefixIcon: Icon(CupertinoIcons.info_circle_fill),
                      ),
                      InputTextfield(
                        borderColor: AppColor.black,
                        hintText: "Address",
                        label: "Address",
                        editController: addressController,
                        fieldFontSize: 17,
                        currentFocus: fourthNode,
                        nextFocus: fourthNode,
                        customPrefixIcon: Icon(Icons.home_filled),
                        prefixIconColor: AppColor.black,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: InkWell(
                          onTap: () {
                            utils.checkInternet(context).then(
                              (value) {
                                if (value) {
                                  if (widget.name == nameController.text &&
                                      widget.mobileNo ==
                                          mobileNoController.text &&
                                      widget.about == aboutController.text &&
                                      widget.address ==
                                          addressController.text &&
                                      imageUtils.image == null) {
                                    Utils.flushBar(
                                        "Nothing to update", context);
                                  } else {
                                    pvvm.editProfileInfo(
                                        userInfo!.uid,
                                        nameController.text,
                                        mobileNoController.text,
                                        aboutController.text,
                                        addressController.text,
                                        context);
                                  }
                                }
                              },
                            );
                          },
                          child: Button(
                            buttonHeight: HeightX * 0.08,
                            buttonWidth: WidthY * 0.95,
                            buttonText: "Save",
                            buttonColor: AppColor.mediumBlue,
                            buttonTextColor: AppColor.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Button(
                          buttonHeight: HeightX * 0.08,
                          buttonWidth: WidthY * 0.95,
                          buttonText: "Logout",
                          buttonTextColor: AppColor.white,
                          buttonColor: AppColor.mediumBlue,
                          buttonOntap: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RoutesName.login,
                              (route) => false,
                            );
                          },
                        ),
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
