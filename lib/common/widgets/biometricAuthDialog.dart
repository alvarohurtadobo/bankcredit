// ignore_for_file: file_names

import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:flutter/material.dart';

Future<bool> biometricAuthConfirmationDialog(BuildContext context) async {
  double dialogWidth = Sizes.width * 0.8;
  double dialogHeight = dialogWidth * 1.2;

  return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: const EdgeInsets.all(0),
              content: Container(
                  height: dialogHeight,
                  width: dialogWidth,
                  decoration: BoxDecoration(
                    color: const Color(0xffE5E5EA),
                    borderRadius:
                        BorderRadius.all(Radius.circular(dialogHeight * 0.07)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: dialogHeight * 0.10,
                      ),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: dialogHeight / 16),
                          height: dialogHeight * 0.2,
                          padding: EdgeInsets.symmetric(
                              horizontal: dialogWidth * 0.1),
                          width: double.infinity,
                          color: const Color(0xffE5E5EA),
                          child: Text(
                            "¿Quieres ingresar con face ID / touch ID?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: const Color(0xff0077CD),
                                fontSize: Sizes.font8 + 6,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none),
                          )),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: dialogWidth * 0.1),
                        child: Text(
                          "Si deseas acceder de forma rápida, acepta ingresar con tu dispositivo a través de face ID /Touch ID",
                          style: TextStyle(
                              color: const Color(0xff858585),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              fontSize: Sizes.font10 + 2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: Sizes.padding,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: dialogWidth * 0.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: Sizes.tileHeightMedium,
                                width: dialogWidth * 0.8,
                                decoration: BoxDecoration(
                                    color: const Color(0xff0077CD),
                                    border: Border.all(
                                        color: const Color(0xff0077CD)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            Sizes.tileHeightMedium / 8))),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text("Aceptar",
                                      style: TextStyle(color: Colors.white)),
                                )),
                            const SizedBox(
                              height: 17,
                            ),
                            Container(
                                height: Sizes.tileHeightMedium,
                                width: dialogWidth * 0.8,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    border: Border.all(
                                        color: const Color(0xff0077CD)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            Sizes.tileHeightMedium / 8))),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text("No, lo haré después",
                                      style:
                                          TextStyle(color: Color(0xff0077CD))),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: dialogHeight * 0.10,
                      ),
                    ],
                  )),
            );
          }) ==
      true;
}
