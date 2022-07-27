import 'package:flutter/material.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';

Future<bool> genericConfirmationDialog(
    BuildContext context, String finalLabel) async {
  double dialogWidth = Sizes.width * 0.8;
  double dialogHeight = dialogWidth / 1.6;

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
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(dialogHeight * 0.07)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: dialogHeight * 0.10,
                      ),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(bottom: dialogHeight / 16),
                          height: dialogHeight * 0.12,
                          width: double.infinity,
                          color: const Color(0xffc4c4c4),
                          child: Text(
                            "¿ESTÁ SEGURO?",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.font8,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none),
                          )),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: dialogWidth * 0.1),
                        child: Text(
                          finalLabel,
                          style: TextStyle(
                              color: const Color(0xff858585),
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.normal,
                              fontSize: Sizes.font10),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: dialogWidth * 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                height: Sizes.tileHeightMedium,
                                width: dialogWidth * 0.35,
                                decoration: BoxDecoration(
                                    color: const Color(0xffFF6A1B),
                                    border: Border.all(
                                        color: const Color(0xffFF6A1B)),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            Sizes.tileHeightMedium / 8))),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: const Text("NO",
                                      style: TextStyle(color: Colors.white)),
                                )),
                            Container(
                                height: Sizes.tileHeightMedium,
                                width: dialogWidth * 0.35,
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
                                  child: const Text("YES",
                                      style: TextStyle(color: Colors.white)),
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
