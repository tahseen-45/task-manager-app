import 'dart:async';
import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internship_task/globalvar/global_var.dart';
import 'package:internship_task/utils/utils.dart';

// class for managing image uploading relating operations
class ImageUtils with ChangeNotifier {
  ImagePicker picker = ImagePicker();
  File? _image;
  double _uploadProgress = 0.0;
  // getter method to get data from _image as File
  File? get image => _image;
  double get uploadProgress => _uploadProgress;
  String? _imageUrl;
  String? get imageUrl => _imageUrl;
  // Setter method to set the image file path in _image
  set setImage(File? image) {
    _image = image;
    notifyListeners();
  }
  // Function to allow user to select image from his/her phone gallery
  Future<void> pickImage() async {
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _image = File(pickedImage.path);
      imageFile = File(pickedImage.path);
      notifyListeners();
    }
  }
  // Function to upload image to Cloudinary
  Future<dynamic> uploadImage() async {
    try {
      final cloudinary = Cloudinary.unsignedConfig(cloudName: "dkl8guvvs");
      final response = await cloudinary.unsignedUpload(
        uploadPreset: "ml_default",
        file: _image!.path,
        // Reads the image bytes
        fileBytes: _image!.readAsBytesSync(),
        // Listening to image uploading progress
        progressCallback: (count, total) {
          _uploadProgress = (count / total);
          if ((count - 550) < total) {
            notifyListeners();
          }
        },
      );
      if (response.isSuccessful) {
        // Return image url
        return response.secureUrl;
      }
    } catch (e) {
      Utils.flutterToast(e.toString());
    }
  }
}
