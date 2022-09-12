import 'dart:convert';
import 'dart:io';

import 'package:credidiunsa_app/common/model/sesion.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/common/widgets/appbar.dart';
import 'package:credidiunsa_app/common/widgets/simpleAlertDialog.dart';
import 'package:credidiunsa_app/user/model/user.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/updateUserProfilePic.dart';

class ConfirmProfilePicturePage extends StatefulWidget {
  const ConfirmProfilePicturePage({Key? key}) : super(key: key);

  @override
  _ConfirmProfilePicturePageState createState() =>
      _ConfirmProfilePicturePageState();
}

class _ConfirmProfilePicturePageState extends State<ConfirmProfilePicturePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  bool loading = false;

  @override
  void initState() {
    print("Current user pic is ${currentUser.pictureUrl}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      image: DecorationImage(
                          image: FileImage(File(filePathTemporal)),
                          fit: BoxFit.cover)),
                ),
                Expanded(
                    child: SizedBox(
                  height: Sizes.boxSeparation,
                )),
                loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        // padding: EdgeInsets.symmetric(
                        //     horizontal: Sizes.boxSeparation, vertical: 0),
                        width: (Sizes.width - 3 * Sizes.padding),
                        decoration: BoxDecoration(
                            color: const Color(0xff0077CD),
                            borderRadius:
                                BorderRadius.circular(Sizes.border / 2),
                            border: Border.all(color: const Color(0xff0077CD))),
                        child: TextButton(
                            onPressed: () {
                              setState(() {
                                loading = true;
                              });
                              uploadImage().then((success) async {
                                setState(() {
                                  loading = false;
                                });
                                if (success) {
                                  if (auxJwt == "") {
                                    // Ruta de actualización normal
                                    print(
                                        "Setting recently uploaded picture to $filePathTemporal");
                                    imageCache.clear();
                                    pathToRecentlyUpdatedImage =
                                        filePathTemporal;
                                    simpleAlertDialog(
                                            context,
                                            "¡Felicitaciones!",
                                            "Tu foto de perfil ha sido actualizada exitosamente")
                                        .then((value) {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    });
                                    // exit(0);

                                  } else {
                                    // Ruta de creación de cuenta
                                    auxJwt = "";
                                    print("Clear aux JWT");
                                    simpleAlertDialog(context, "¡Lo sentimos!",
                                            "No ha sido posible actualizar tu foto de perfil")
                                        .then((value) {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    });
                                  }
                                }
                              });
                            },
                            child: Text(
                              "Finalizar",
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
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cambiar foto",
                          style: TextStyle(
                              color: const Color(0xff0077CD),
                              fontSize: Sizes.font10 * 0.95),
                        ))),
                SizedBox(
                  height: 3 * Sizes.boxSeparation,
                ),
              ]),
        ));
  }

  Future<bool> uploadImage() async {
    if (filePathTemporal.contains(".") &&
        (filePathTemporal.contains("png") ||
            filePathTemporal.contains("jpg"))) {
      List<String> splitted = filePathTemporal.split(".");
      String extension = splitted[splitted.length - 1];
      print("Ext is $extension");
      final bytes = File(filePathTemporal).readAsBytesSync();
      String base64Image =
          "data:image/$extension;base64,${base64Encode(bytes)}";

      print("Uploading : $base64Image");
      if (await updateUserProfilePicture(base64Image)) {
        print("New user pic is ${currentUser.pictureUrl}");
        setState(() {});
      }
      return true;
    }
    return false;
  }
}
