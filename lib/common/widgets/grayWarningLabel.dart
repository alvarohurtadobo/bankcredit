// ignore_for_file: file_names

import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:flutter/material.dart';

Widget grayWarningLabel(String label, bool activeWarning,
    {bool disappearWarning = false, bool center = false}) {
  return (disappearWarning && !activeWarning)
      ? Container()
      : Container(
          width: Sizes.width,
          height: Sizes.height / 20,
          padding: EdgeInsets.only(bottom: Sizes.boxSeparation),
          child: Row(
            mainAxisAlignment:
                center ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Icon(
                activeWarning ? Icons.check_circle : Icons.check_circle,
                color: activeWarning
                    ? const Color.fromARGB(255, 143, 143, 143)
                    : const Color(0xff4DB21C),
              ),
              SizedBox(
                width: Sizes.boxSeparation,
              ),
              Text(label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: activeWarning
                          ? const Color.fromARGB(255, 143, 143, 143)
                          : const Color(0xff4DB21C),
                      fontSize: Sizes.font10 - 4)),
            ],
          ),
        );
}
