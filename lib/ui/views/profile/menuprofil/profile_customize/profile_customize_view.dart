import 'package:firecek_stacked_architecture/models/user_data.dart';
import 'package:firecek_stacked_architecture/shared/constant.dart';
import 'package:firecek_stacked_architecture/shared/loading.dart';
import 'package:firecek_stacked_architecture/shared/ui_helpers.dart';
import 'package:firecek_stacked_architecture/ui/widgets/input_field.dart';
import 'package:firecek_stacked_architecture/ui/widgets/watertankmonitor/top_background.dart';
import 'package:firecek_stacked_architecture/viewmodels/profile/menuprofile/profileCustomize/profile_customize_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ProfileCustomizeView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileCustomizeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: ListView(
          children: [
            TopBackground(
              title: 'Profile Customize',
              height: MediaQuery.of(context).size.height * 0.2,
              backButton: () => model.backButton(),
            ),
            (model.isBusy)
                ? Loading()
                : SizedBox(
                    child: ListView(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(60.0, 0.0, 60.0, 0.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    child: SizedBox(
                                      child: (model.isSelectNewImage)
                                          ? Image.file(
                                              model.selectedImage,
                                              fit: BoxFit.cover,
                                            )
                                          : Image(
                                              image: NetworkImage(
                                                  model.userData.imageURL),
                                              fit: BoxFit.cover,
                                            ),
                                      height: 100,
                                      width: 100,
                                    ),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  RaisedButton(
                                      child: Text(
                                        'Choose a file',
                                        style: buttonTitleTextStyle,
                                      ),
                                      color: Colors.lightBlue,
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) => Padding(
                                                  child: SizedBox(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'Select Source',
                                                          style:
                                                              profileCardTextStyle,
                                                        ),
                                                        ListTile(
                                                          leading: Icon(
                                                              Icons.camera),
                                                          onTap: () async {
                                                            await model
                                                                .selectImage(
                                                                    isFromGalery:
                                                                        false);
                                                          },
                                                          title: Text('Camera'),
                                                        ),
                                                        ListTile(
                                                          leading: Icon(
                                                              Icons.folder),
                                                          onTap: () async {
                                                            await model
                                                                .selectImage(
                                                                    isFromGalery:
                                                                        true);
                                                          },
                                                          title:
                                                              Text('Gallery'),
                                                        ),
                                                      ],
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                    ),
                                                    height: 150.0,
                                                  ),
                                                  padding: EdgeInsets.all(30.0),
                                                ));
                                      })
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                              ),
                              verticalSpaceMedium,
                              Text('Name: '),
                              InputField(
                                controller: _nameController,
                                placeholder: model.userData.userName,
                                textInputAction: TextInputAction.done,
                                fieldFocusNode: _nameFocusNode,
                              ),
                              verticalSpaceSmall,
                              Text('Email: '),
                              // ignore: missing_required_param
                              InputField(
                                placeholder: model.userData.email,
                                isReadOnly: true,
                                additionalNote: "*Email can't change",
                              ),
                              verticalSpaceMedium,
                              Row(
                                children: [
                                  RaisedButton(
                                      color: Colors.lightBlue,
                                      child: Text(
                                        "Update Profile",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        await model.updateProfile(
                                            _nameController.text);
                                      }),
                                ],
                                mainAxisAlignment: MainAxisAlignment.end,
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        )
                      ],
                    ),
                    height: MediaQuery.of(context).size.height * 0.8,
                  ),
          ],
        ),
      ),
      onModelReady: (model) => model.listenToUserData(),
      viewModelBuilder: () => ProfileCustomizeViewModel(),
    );
  }
}
