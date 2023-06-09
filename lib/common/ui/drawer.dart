// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:credidiunsa_app/user/model/user.dart';
import 'package:credidiunsa_app/common/model/sesion.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:credidiunsa_app/common/widgets/genericConfirmationDialog.dart';

class MyDrawer extends StatelessWidget {
  // const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    wasLogged = true;
    return Drawer(
      backgroundColor:  const Color(0xff0077cd),
      child: SafeArea(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushNamed("/profile");
              },
              child: Container(
                height: Sizes.height / 5.2,
                padding: EdgeInsets.all(Sizes.padding * 0.6),
                decoration: const BoxDecoration(
                  color: Color(0xff0077cd),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: Sizes.width / 8,
                      width: Sizes.width / 8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.width / 16)),
                          image: pathToRecentlyUpdatedImage == ""
                              ? DecorationImage(
                                  image: NetworkImage(currentUser.pictureUrl),
                                  fit: BoxFit.cover)
                              : DecorationImage(
                                  image: FileImage(
                                      File(pathToRecentlyUpdatedImage)),
                                  fit: BoxFit.cover)),
                    ),
                    SizedBox(width: Sizes.boxSeparation),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "¡Hola!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.font6,
                                color: Colors.white),
                          ),
                          SizedBox(
                            // medida photo ***************************************
                            width: Sizes.width * 0.5,
                            child: Text(
                              currentUser.getFullName(),
                              maxLines: 3,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: Sizes.font8,
                                  color: Colors.white),
                            ),
                          ),
                          Text(
                            "Última sesión ${ultimaConexion.month}/${ultimaConexion.day}/${ultimaConexion.year}",
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: Sizes.font10,
                                color: Colors.white),
                          ),
                        ])
                  ],
                ),
              ),
            ),
            drawerTile(context, "assets/icons/person.png", "Mi Perfil",
                "Actualiza tu información",
                route: "/profile"),
            drawerTile(context, "assets/icons/cards.png", "Medios de pago",
                "Donde hacer tus pagos",
                route: "/payment"),
            drawerTile(context, "assets/icons/settings.png",
                "Detalles de la cuenta", "Movimientos y pagos",
                route: "/accountDetails"),
            // drawerTile(context, "assets/icons/rise.png", "Aumento", "de cupo"),
            drawerTile(context, "assets/icons/policies.png", "Políticas",
                "de producto",
                route: "/politics"),
            drawerTile(
                context, "assets/icons/promo.png", "Promociones", "y novedades",
                route: "/promotions"),
            drawerTile2(context, "assets/icons/whatsapp.png", "Contáctanos", "",
                route: "/contact"),
            logoutTile(context),
            Container(
              height: Sizes.height * 0.2,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget drawerTile(
      BuildContext context, String assetName, String title, String subtitle,
      {String route = "/"}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushNamed(route);
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: Sizes.padding, horizontal: Sizes.padding),
          // margin: EdgeInsets.symmetric(horizontal: Sizes.padding),
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xffB1B2B3)))),
          child: Row(
            children: [
              Container(
                width: Sizes.padding,
                height: Sizes.padding,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(assetName))),
              ),
              SizedBox(
                width: Sizes.padding,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: const Color(0xff4F5051),
                          fontSize: Sizes.font10,
                          fontWeight: FontWeight.bold)),
                  subtitle == ""
                      ? Container()
                      : Text(subtitle,
                          style: TextStyle(
                              color: const Color(0xff4F5051),
                              fontSize: Sizes.font10,
                              fontWeight: FontWeight.normal))
                ],
              ),
            ],
          )),
    );
  }

  Widget drawerTile2(
      BuildContext context, String assetName, String title, String subtitle,
      {String route = "/"}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushNamed(route);
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: Sizes.padding + 5.3,horizontal: Sizes.padding),
          // margin: EdgeInsets.symmetric(horizontal: Sizes.padding),
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xffB1B2B3)))),
          child: Row(
            children: [
              Container(
                width: Sizes.padding,
                height: Sizes.padding,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(assetName))),
              ),
              SizedBox(
                width: Sizes.padding,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: const Color(0xff4F5051),
                          fontSize: Sizes.font10,
                          fontWeight: FontWeight.bold)),
                  subtitle == ""
                      ? Container()
                      : Text(subtitle,
                          style: TextStyle(
                              color: const Color(0xff4F5051),
                              fontSize: Sizes.font10,
                              fontWeight: FontWeight.normal))
                ],
              ),
            ],
          )),
    );
  }

  Widget logoutTile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        genericConfirmationDialog(
                context, "¿Está seguro que desea cerrar sesión?")
            .then((confirmation) {
          if (confirmation) {
            print("Confirm logout, clearing user notification id and token");
            currentUser = User.empty();
            SharedPreferences.getInstance().then((myPrefs) {
              myPrefs.remove("jwt");
              // myPrefs.remove("document");
              // myPrefs.remove("password");
              myPrefs.remove("expiration");
              Navigator.of(context).pop();
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pop(); // Para el drawer???
              Navigator.of(context).pushNamed("/login");
            });
          }
        });
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: Sizes.padding + 3.5, horizontal: Sizes.padding),
          // margin: EdgeInsets.symmetric(horizontal: Sizes.padding),
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xffB1B2B3)))),
          child: Row(
            children: [
              const Icon(
                Icons.exit_to_app,
                color: Color(0xffFF6A1B),
              ),
              SizedBox(
                width: Sizes.padding,
              ),
              Text("Cerrar sesión",
                  style: TextStyle(
                      color: const Color(0xff4F5051),
                      fontSize: Sizes.font10,
                      fontWeight: FontWeight.bold)),
            ],
          )),
    );
  }
}
