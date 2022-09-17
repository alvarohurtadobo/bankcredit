// ignore_for_file: file_names

import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:flutter/material.dart';

Widget warningLabel(String label, bool activeWarning,
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
                activeWarning ? Icons.warning_amber_outlined : Icons.check_circle,
                color: activeWarning ? Colors.red : const Color(0xff4DB21C),
              ),
              SizedBox(
                width: Sizes.boxSeparation,
              ),
              Text(label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color:
                          activeWarning ? Colors.red : const Color(0xff4DB21C),
                      fontSize: Sizes.font10)),
            ],
          ),
        );
}
