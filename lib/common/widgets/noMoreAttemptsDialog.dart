import 'package:flutter/material.dart';

import '../model/launcher.dart';
import '../ui/sizes.dart';

Future<bool> getNoMoreAttemptsDialog(
  BuildContext context,
) async {
  double dialogWidth = Sizes.width * 0.8;
  double dialogHeight = dialogWidth / 1.6;
  bool response = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            actions: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Color(0xff0F62A4),
                  ))
            ],
            actionsAlignment: MainAxisAlignment.end,
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(0),
            content: Container(
              height: dialogHeight,
              width: dialogWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(dialogHeight * 0.07)),
              ),
              child: Column(children: [
                const Text(
                  "¡Lo sentimos!",
                  style: TextStyle(color: Color(0xff0F62A4), fontSize: 22),
                ),
                const Text(
                  "Has agotado los intentos permitidos. Por favor comunícate con servicio al cliente por medio del chat",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                SizedBox(
                  height: 3 * Sizes.boxSeparation,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff0077CD),
                      borderRadius: BorderRadius.circular(Sizes.border),
                    ),
                    child: TextButton(
                        onPressed: () {
                          launchUrl("www.facebook.com");
                        },
                        child: const Text(
                          "Quiero ir al chat",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )))
              ]),
            ));
      });

  return response == true;
}
