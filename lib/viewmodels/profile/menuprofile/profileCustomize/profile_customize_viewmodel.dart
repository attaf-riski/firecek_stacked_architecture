import 'dart:io';

import 'package:firecek_stacked_architecture/app/locator.dart';
import 'package:firecek_stacked_architecture/models/user.dart';
import 'package:firecek_stacked_architecture/models/user_data.dart';
import 'package:firecek_stacked_architecture/services/auth_service.dart';
import 'package:firecek_stacked_architecture/services/cloud_storage_service.dart';
import 'package:firecek_stacked_architecture/services/firestore_service.dart';
import 'package:firecek_stacked_architecture/services/media_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileCustomizeViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final MediaService _mediaService = locator<MediaService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  final DialogService _dialogService = locator<DialogService>();
  //User uid and email
  User user;
  //user data
  UserData _userData;
  //getter
  UserData get userData => _userData;
  //listen to firestore user data stream
  void listenToUserData() async {
    setBusy(true);
    user = await _authService.userUIDAndEmail;
    _firestoreService
        .listenToUserDataRealTime(user.uid, user.email)
        .listen((result) {
      _userData = result;
      setBusy(false);
      notifyListeners();
    });
  }

  //backButton
  backButton() {
    _navigationService.back();
  }

  //image
  File _selectedImage;
  File get selectedImage => _selectedImage;
  //if false show image profile from firebase is true from file
  bool _isSelectNewImage = false;
  bool get isSelectNewImage => _isSelectNewImage;

  //select image
  Future selectImage({bool isFromGalery = true}) async {
    var tempImage = await _mediaService.getImage(fromGallery: isFromGalery);
    if (tempImage != null) {
      _selectedImage = File(tempImage.path);
      _isSelectNewImage = true;
      notifyListeners();
    }
  }

  //update profile
  Future updateProfile(String name) async {
    CloudStorageResult cloudStorageResult;
    if (_selectedImage != null && name != '') {
      //update name and image
      cloudStorageResult = await _cloudStorageService.uploadImage(
          imageToUpload: _selectedImage, email: userData.email);
      if (cloudStorageResult != null) {
        bool isSuccessUpdate = await _firestoreService.createUserData(
            user.uid, name, cloudStorageResult.imageUrl, userData.myProduct);
        if (isSuccessUpdate) {
          await _dialogService.showDialog(
              title: 'Updating Profile Has Success',
              dialogPlatform: DialogPlatform.Material,
              description: 'Please check again.');
        } else {
          await _dialogService.showDialog(
              title: 'Updating Profile Has Failed',
              dialogPlatform: DialogPlatform.Material,
              description: 'Please try again.');
        }
      } else {
        await _dialogService.showDialog(
            title: 'Uplouding Image Has Failed',
            dialogPlatform: DialogPlatform.Material,
            description: 'Please try again.');
      }
    } else if (_selectedImage == null && name != '') {
      //update name
      bool isSuccessUpdate = await _firestoreService.createUserData(
          user.uid, name, userData.imageURL, userData.myProduct);
      if (isSuccessUpdate) {
        await _dialogService.showDialog(
            title: 'Updating Profile Has Success',
            dialogPlatform: DialogPlatform.Material,
            description: 'Please check again.');
      } else {
        await _dialogService.showDialog(
            title: 'Updating Profile Has Failed',
            dialogPlatform: DialogPlatform.Material,
            description: 'Please try again.');
      }
    } else if (_selectedImage != null && name == '') {
      //update image
      cloudStorageResult = await _cloudStorageService.uploadImage(
          imageToUpload: _selectedImage, email: userData.email);
      if (cloudStorageResult != null) {
        bool isSuccessUpdate = await _firestoreService.createUserData(user.uid,
            userData.userName, cloudStorageResult.imageUrl, userData.myProduct);
        if (isSuccessUpdate) {
          await _dialogService.showDialog(
              title: 'Updating Profile Has Success',
              dialogPlatform: DialogPlatform.Material,
              description: 'Please check again.');
        } else {
          await _dialogService.showDialog(
              title: 'Updating Profile Has Failed',
              dialogPlatform: DialogPlatform.Material,
              description: 'Please try again.');
        }
      } else {
        await _dialogService.showDialog(
            title: 'Uplouding Image Has Failed',
            dialogPlatform: DialogPlatform.Material,
            description: 'Please try again.');
      }
    } else {
      //not update anything
      await _dialogService.showDialog(
          title: 'No Update Detected',
          dialogPlatform: DialogPlatform.Material,
          description: 'Please try again.');
    }
  }
}
