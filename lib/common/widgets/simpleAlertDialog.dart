import '../ui/sizes.dart';
import 'package:flutter/material.dart';

void nothing() {}

Future<bool> simpleAlertDialog(
    BuildContext context, String title, String message,
    {String buttonLabel = "OK", Function action = nothing}) async {
  double dialogWidth = Sizes.width;
  // double dialogHeight = dialogWidth / 1.2; estaba en 1.2
  double dialogHeight = dialogWidth / 1.38;
  bool? response = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            actions: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Container())
            ],
            actionsAlignment: MainAxisAlignment.end,
            backgroundColor: Colors.transparent,
            contentPadding: const EdgeInsets.all(0),
            content: Container(
              padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
              height: dialogHeight,
              width: dialogWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(dialogHeight * 0.04)),
              ),
              child: Column(children: [
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
                  height: Sizes.boxSeparation * 7,
                ),
                Text(
                  title,
                  style:
                      const TextStyle(color: Color(0xff0F62A4), fontSize: 28),
                ),
                SizedBox(
                  height: Sizes.boxSeparation * 6,
                ),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                Expanded(
                  child: SizedBox(
                    height: 4 * Sizes.boxSeparation,
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff0077CD),
                      borderRadius: BorderRadius.circular(Sizes.boxSeparation),
                    ),
                    child: TextButton(
                        onPressed: () {
                          action();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          buttonLabel,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ))),
                SizedBox(
                  height: 2 * Sizes.padding,
                ),
              ]),
            ));
      });

  return response == true;
}
