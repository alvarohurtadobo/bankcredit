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
      ),
      toolbarHeight: Sizes.height / 13,
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: Sizes.padding),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed("/home");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Icon(
                      Icons.home_outlined,
                      size: 1.5 * Sizes.padding,
                    ),
                  ))),
        )
      ],
      leading: Builder(
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.center,
            child: Scaffold.of(context).hasDrawer
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 1.5 * Sizes.padding,
                        width: 1.5 * Sizes.padding,
                        child: Icon(
                          Icons.menu,
                          size: 1.5 * Sizes.padding,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 20),
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
                  ),
          );
        },
      ));
}
