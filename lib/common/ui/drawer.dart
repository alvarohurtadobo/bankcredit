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
      backgroundColor: Colors.white,
      child: SafeArea(
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushNamed("/profile");
              },
              child: Container(
                height: Sizes.height / 6,
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
                          image: DecorationImage(
                              image: NetworkImage(currentUser.pictureUrl),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(width: Sizes.boxSeparation),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "¡Hola!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: Sizes.width * 0.5,
                            child: Text(
                              currentUser.getFullName(),
                              maxLines: 3,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                          // const Text(
                          //   "Última sesión 01/15/2022",
                          //   style: TextStyle(
                          //       fontWeight: FontWeight.normal,
                          //       fontSize: 14,
                          //       color: Colors.white),
                          // ),
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
            drawerTile(context, "assets/icons/whatsapp.png", "Contáctanos", "",
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
          padding: EdgeInsets.symmetric(vertical: Sizes.padding),
          margin: EdgeInsets.symmetric(horizontal: Sizes.padding),
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
          padding: EdgeInsets.symmetric(vertical: Sizes.padding),
          margin: EdgeInsets.symmetric(horizontal: Sizes.padding),
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
