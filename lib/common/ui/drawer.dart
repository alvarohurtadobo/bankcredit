import 'package:credidiunsa_app/common/ui/sizes.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  // const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff0077cd),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(Sizes.padding * 0.6),
              decoration: const BoxDecoration(
                color: Color(0xff0077cd),
              ),
              child: Row(
                children: [
                  Container(
                    height: Sizes.width / 6,
                    width: Sizes.width / 6,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/demo/avatar.png"))),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "¡Hola!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.white),
                        ),
                        Text(
                          "María Camila Pérez",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                        Text(
                          "Última sesión 01/15/2022",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              color: Colors.white),
                        ),
                      ])
                ],
              ),
            ),
            drawerTile(
                context, Icons.person, "Mi Perfil", "Actualiza tu información",
                route: "/profile"),
            drawerTile(context, Icons.payments, "Medios de pago",
                "Donde hacer tus pagos",
                route: "/payment"),
            drawerTile(context, Icons.settings, "Detalles de la cuenta",
                "Movimientos y pagos",
                route: "/accountDetails"),
            drawerTile(context, Icons.keyboard_double_arrow_up_sharp, "Aumento",
                "de cupo"),
            drawerTile(
                context, Icons.present_to_all, "Políticas", "de producto",
                route: "/politics"),
            drawerTile(context, Icons.label, "Promociones", "y novedades",
                route: "/promotions"),
            drawerTile(context, Icons.whatsapp, "Contáctanos", "",
                route: "/contact"),
            Expanded(child: Container(color: Colors.white))
          ],
        ),
      ),
    );
  }

  Widget drawerTile(
      BuildContext context, IconData icon, String title, String subtitle,
      {String route = "/"}) {
    return GestureDetector(
      onTap: () {
        if (route != "/") {
          Navigator.of(context).pushNamed(route);
        }
      },
      child: Container(
        padding: EdgeInsets.all(Sizes.boxSeparation),
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Color(0xffB1B2B3)))),
        child: ListTile(
          leading: Icon(
            icon,
            color: const Color(0xffFF6A1B),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      ),
    );
  }
}
