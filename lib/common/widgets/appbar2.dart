import 'package:flutter/material.dart';

import '../ui/sizes.dart';

PreferredSizeWidget myAppBar2() {
  return AppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        padding: EdgeInsets.only(top: 8 * Sizes.padding),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(
                  "assets/images/logo_04.png",
                ),
                fit: BoxFit.none),
            color: const Color(0xff0077CD),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Sizes.padding),
                bottomRight: Radius.circular(Sizes.padding))),
      ),
      toolbarHeight: Sizes.height / 12,
      leading: Builder(
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () async {
                bool confirm = true;
                // print("Appbar back $confirm");
                if (confirm) {
                  Navigator.of(context).pop();
                }
              },
              child: Container(
                alignment: Alignment.topCenter,
                height: 1.5 * Sizes.padding,
                width: 1.5 * Sizes.padding,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(1.5 * Sizes.padding / 2))),
                child: Icon(
                  Icons.arrow_back,
                  size: 1.5 * Sizes.padding,
                  color: const Color(0xff0077CD),
                ),
              ),
            ),
          );
        },
      ));
}
