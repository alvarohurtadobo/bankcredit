// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';

Widget summaryCard(String title, String subtitle, String amount,
    {Color myColor = const Color(0xff0F62A4), double scale = 1}) {
  return Container(
    width: Sizes.width * scale,
    height: Sizes.height / 6.2,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(2 * Sizes.boxSeparation),
        topRight: Radius.circular(2 * Sizes.boxSeparation),
        bottomLeft: Radius.circular(scale != 1 ? 2 * Sizes.boxSeparation : 0),
        bottomRight: Radius.circular(scale != 1 ? 2 * Sizes.boxSeparation : 0),
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: myColor, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          // SizedBox(
          //   height: Sizes.boxSeparation,
          // ),
          Text(subtitle,
              style: TextStyle(
                  color: myColor, fontSize: 21, fontWeight: FontWeight.normal)),
          SizedBox(
            height: Sizes.boxSeparation,
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: Sizes.boxSeparation, horizontal: 3*Sizes.padding),
            decoration: BoxDecoration(
                color: myColor,
                borderRadius:
                    BorderRadius.all(Radius.circular(Sizes.padding / 3))),
            child: Text(amount,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    ),
  );
}
