// Language: dart

import 'package:credidiunsa_app/common/model/launcher.dart';

import '../../common/ui/sizes.dart';
import 'package:flutter/material.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/common/widgets/summaryCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Sizes.setSizes(width, height);

    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: MyDrawer(),
      body: Container(
        color: const Color(0xff0077cd),
        child: ListView(children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    width: double.infinity,
                    height: Sizes.height * 0.27,
                    padding: EdgeInsets.all(Sizes.padding),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(Sizes.border),
                            bottomRight: Radius.circular(Sizes.border)),
                        image: const DecorationImage(
                            image: AssetImage("assets/images/image_03.png"),
                            fit: BoxFit.cover)),
                    child: Container(
                        width: Sizes.width * 0.5,
                        height: 60,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/images/logo_02.png"),
                                fit: BoxFit.fill))),
                  ),
                  SizedBox(
                    height: Sizes.height * 0.28,
                  ),
                  Container(
                    width: double.infinity,
                    height: Sizes.height * 0.3,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/image_04.png"),
                            fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    height: 2 * Sizes.boxSeparation,
                  ),
                  Padding(
                    padding: EdgeInsets.all(Sizes.padding),
                    child: const Text(
                      "Promociones y novedades",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left:Sizes.padding),
                    height: Sizes.width / 2.5,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        displayImage("assets/images/asset_01.png"),
                        displayImage("assets/images/asset_02.png"),
                        displayImage("assets/images/asset_03.png"),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                  top: Sizes.padding,
                  left: Sizes.padding,
                  child: GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                      child: Container(
                          width: Sizes.padding * 2,
                          height: Sizes.padding * 2,
                          decoration: BoxDecoration(
                              color: const Color(0xff0077cd),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Sizes.padding * 2 / 2))),
                          child: Icon(
                            Icons.menu,
                            size: 1.5*Sizes.padding,
                            color: Colors.white,
                          )))),
              Positioned(
                  top: Sizes.padding,
                  left: 2.8 * Sizes.padding,
                  child: Container(
                      width: 6*Sizes.padding * 1.6,
                      height: Sizes.padding * 2,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/logo_02.png"),
                              fit: BoxFit.fitWidth)))),
              Positioned(
                  top: 6 * Sizes.padding,
                  left: 2 * Sizes.padding,
                  child: summaryCard(
                      "Tu saldo", "disponible para compras", "L 40,000.00",
                      scale: 0.8)),
              Positioned(
                  top: 6.5 * Sizes.padding + Sizes.height / 6.2,
                  left: 2 * Sizes.padding,
                  child: GestureDetector(
                    onTap: () {
                      customLaunchUrl("https://www.diunsa.hn/credidiunsa");
                    },
                    child: summaryCard(
                        "Tu cuota", "mensual para pagar", "L 35,000.00",
                        myColor: const Color(0xffFF6A1B), scale: 0.8),
                  ))
            ],
          ),
        ]),
      ),
    );
  }

  Widget displayImage(String assetName) {
    return Container(
      margin: EdgeInsets.only(right:1.5*Sizes.boxSeparation),
      width: Sizes.width / 2.5,
      height: Sizes.width / 2.5,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(assetName), fit: BoxFit.fill)),
    );
  }
}
