// ignore_for_file: file_names, library_private_types_in_public_api, avoid_print, use_build_context_synchronously

import 'dart:io';
import 'package:credidiunsa_app/common/model/sesion.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/user/model/user.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';

class UpdateProfilePicturePage extends StatefulWidget {
  const UpdateProfilePicturePage({Key? key}) : super(key: key);

  @override
  _UpdateProfilePicturePageState createState() =>
      _UpdateProfilePicturePageState();
}

class _UpdateProfilePicturePageState extends State<UpdateProfilePicturePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    print("Current user pic is ${currentUser.pictureUrl}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isIos = Platform.isIOS;
    return Scaffold(
        appBar: myAppBar(context),
        body: Container(
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 5 * Sizes.boxSeparation,
                ),
                Text(
                  "Foto de perfil",
                  style: TextStyle(
                      color: const Color(0xff0077CD),
                      fontWeight: FontWeight.bold,
                      fontSize: Sizes.font8),
                ),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.width / 5),
                  child: Text(
                    "Tu foto permite reconocer ¿Qué te gustaría hacer?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: const Color(0xff0077CD),
                        fontWeight: FontWeight.normal,
                        fontSize: Sizes.font10),
                  ),
                ),
                SizedBox(
                  height: 3 * Sizes.boxSeparation,
                ),
                Container(
                  height: 0.2 * Sizes.height,
                  width: 0.2 * Sizes.height,
                  decoration: BoxDecoration(
                      color: const Color(0xffD9D9D9),
                      borderRadius: BorderRadius.all(
                          Radius.circular(Sizes.boxSeparation)),
                      image: pathToRecentlyUpdatedImage == ""
                          ? DecorationImage(
                              image: NetworkImage(currentUser.pictureUrl),
                              fit: BoxFit.cover)
                          : DecorationImage(
                              image:
                                  FileImage(File(pathToRecentlyUpdatedImage)),
                              fit: BoxFit.cover)),
                ),
                Expanded(
                    child: SizedBox(
                  height: Sizes.boxSeparation,
                )),
                Container(
                    // padding: EdgeInsets.symmetric(
                    //     horizontal: Sizes.boxSeparation, vertical: 0),
                    width: (Sizes.width - 3 * Sizes.padding),
                    decoration: BoxDecoration(
                        color: const Color(0xff0077CD),
                        borderRadius: BorderRadius.circular(Sizes.border / 2),
                        border: Border.all(color: const Color(0xff0077CD))),
                    child: TextButton(
                        onPressed: () {
                          getImageFileName(camera: false);
                        },
                        child: Text(
                          isIos ? "Subir foto" : "Elegir de galería",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.font10 * 0.95),
                        ))),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                Container(
                    // padding: EdgeInsets.symmetric(
                    //     horizontal: Sizes.boxSeparation, vertical: 0),
                    width: (Sizes.width - 3 * Sizes.padding),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Sizes.border / 2),
                        border: Border.all(color: const Color(0xff0077CD))),
                    child: TextButton(
                        onPressed: () {
                          getImageFileName(camera: true);
                        },
                        child: Text(
                          "Tomar foto",
                          style: TextStyle(
                              color: const Color(0xff0077CD),
                              fontSize: Sizes.font10 * 0.95),
                        ))),
                SizedBox(
                  height: Sizes.boxSeparation,
                ),
                SizedBox(
                    // padding: EdgeInsets.symmetric(
                    //     horizontal: Sizes.boxSeparation, vertical: 0),
                    width: (Sizes.width - 3 * Sizes.padding),
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Lo haré después",
                          style: TextStyle(
                            color: const Color(0xff0077CD),
                            fontSize: Sizes.font10 * 0.95,
                            decoration: TextDecoration.underline
                          ),
                        ))),
                SizedBox(
                  height: 3 * Sizes.boxSeparation,
                ),
              ]),
        ));
  }

  void getImageFileName({bool camera = false}) async {
    image = await _picker.pickImage(
        source: camera ? ImageSource.camera : ImageSource.gallery);
    if (image == null) {
      print("No image selected");
      return;
    }
    filePathTemporal = image!.path;
    Navigator.of(context).pushNamed("/confirmProfilePicture");
  }
}
