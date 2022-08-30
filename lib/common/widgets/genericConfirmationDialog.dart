import 'package:flutter/material.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';

Future<bool> genericConfirmationDialog(
    BuildContext context, String finalLabel) async {
  double dialogWidth = Sizes.width * 0.8;
  double dialogHeight = dialogWidth / 1.2;

  return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: const EdgeInsets.all(0),
              content: Container(
                  height: dialogHeight,
                  width: dialogWidth,
                  padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(dialogHeight * 0.03)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Sizes.padding,
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Container(
                              width: 1.6 * Sizes.padding,
                              height: 1.6 * Sizes.padding,
                              decoration: BoxDecoration(
                                  color: const Color(0xff0077CD),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(0.8 * Sizes.padding))),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: Sizes.boxSeparation,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: dialogWidth * 0.1),
                        child: Text(
                          "¿Estás seguro de cerrar sesión?",
                          style: TextStyle(
                              color: const Color(0xff0F62A4),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              fontSize: Sizes.font8),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 5 * Sizes.boxSeparation,
                      ),
                      Container(
                          height: Sizes.tileHeightMedium,
                          width: dialogWidth-2*Sizes.padding,
                          decoration: BoxDecoration(
                              color: const Color(0xff0077CD),
                              border:
                                  Border.all(color: const Color(0xff0077CD)),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Sizes.tileHeightMedium / 8))),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text("Si, quiero salir",
                                style: TextStyle(color: Colors.white)),
                          )),
                      SizedBox(
                        height: Sizes.boxSeparation,
                      ),
                      Container(
                          height: Sizes.tileHeightMedium ,
                          width: dialogWidth-2*Sizes.padding,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: const Color(0xff0077CD)),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Sizes.tileHeightMedium / 8))),
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text("Volver",
                                style: TextStyle(color: Color(0xff0077CD))),
                          )),
                      SizedBox(
                        height: 2*Sizes.boxSeparation,
                      ),
                    ],
                  )),
            );
          }) ==
      true;
}
