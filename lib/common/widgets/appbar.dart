import 'package:flutter/material.dart';

import '../ui/sizes.dart';

PreferredSizeWidget myAppBar(BuildContext context) {
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
      // child: Container(
      //   width: 100,
      //   height: 100,
      //   decoration: BoxDecoration(
      //       // image: const DecorationImage(
      //       //     image: AssetImage(
      //       //       "assets/images/logo_02.png",
      //       //     ),
      //       //     fit: BoxFit.none),
      //       color: Colors.yellow,
      //       borderRadius: BorderRadius.only(
      //           bottomLeft: Radius.circular(Sizes.padding),
      //           bottomRight: Radius.circular(Sizes.padding))),
      // ),
    ),
    toolbarHeight: Sizes.height / 12,
    // leading: const Icon(Icons.menu),
    actions: [
      GestureDetector(
        onTap: () {},
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed("/home");
                },
                child: const Icon(Icons.home_outlined))),
      )
    ],
  );
}
