// ignore_for_file: file_names, library_private_types_in_public_api, avoid_print

import '../../common/ui/sizes.dart';
import 'package:flutter/material.dart';
import '../../common/model/cuotaMensual.dart';
import 'package:credidiunsa_app/common/ui/drawer.dart';
import 'package:credidiunsa_app/bank/model/promo.dart';
import 'package:credidiunsa_app/bank/bloc/getPromos.dart';
import 'package:credidiunsa_app/common/model/launcher.dart';
import 'package:credidiunsa_app/common/repository/api.dart';
import 'package:credidiunsa_app/common/widgets/summaryCard.dart';
import 'package:credidiunsa_app/bank/ui/components/promoCards.dart';
import 'package:credidiunsa_app/common/model/currencyFormatter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double saldo = 0;
  double cuota = 0;

  @override
  void initState() {
    API.getCuota().then((myRes) {
      CuotaMensual object = CuotaMensual.fromBackendResponse(myRes.myBody);
      saldo = object.capital;
      cuota = object.cuota;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Sizes.setSizes(width, height);

    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: MyDrawer(),
      body: SafeArea(
        child: Container(
          color: const Color(0xff0077cd),
          child: SingleChildScrollView(
            child: Column(children: [
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
                                    image:
                                        AssetImage("assets/images/logo_02.png"),
                                    fit: BoxFit.fill))),
                      ),
                      SizedBox(
                        height: Sizes.height * 0.28,
                      ),
                      GestureDetector(
                        onTap: () {
                          customLaunchUrl("https://www.diunsa.hn/credidiunsa");
                        },
                        child: Container(
                          width: double.infinity,
                          height: Sizes.height * 0.3,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/image_04_01.png"),
                                  fit: BoxFit.cover)),
                        ),
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
                      Padding(
                        padding: EdgeInsets.only(left: Sizes.padding),
                        child: FutureBuilder(
                            future: getPromosAndNovels(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                print("I have promos");
                                return SizedBox(
                                  height: Sizes.height / 5,
                                  width: double.infinity,
                                  child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: myNovelties
                                          .map((prom) =>
                                              promoCard(context, prom))
                                          .toList()),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10 * Sizes.boxSeparation,
                      ),
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
                                size: 1.5 * Sizes.padding,
                                color: Colors.white,
                              )))),
                  Positioned(
                      top: Sizes.padding,
                      left: 2.8 * Sizes.padding,
                      child: Container(
                          width: 6 * Sizes.padding * 1.6,
                          height: Sizes.padding * 2,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/logo_02.png"),
                                  fit: BoxFit.fitWidth)))),
                  Positioned(
                      top: 6 * Sizes.padding,
                      left: 2 * Sizes.padding,
                      child: summaryCard("Cupo", "disponible para compras",
                          currencyFormatter.format(saldo),
                          scale: 0.8)),
                  Positioned(
                      top: 6.5 * Sizes.padding + Sizes.height / 6.2,
                      left: 2 * Sizes.padding,
                      child: GestureDetector(
                        onTap: () {
                          customLaunchUrl("https://pagos.credidiunsa.com/");
                        },
                        child: summaryCard("Tu cuota", "mensual para pagar",
                            currencyFormatter.format(cuota),
                            myColor: const Color(0xffFF6A1B), scale: 0.8),
                      ))
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget displayImage(String assetName) {
    return Container(
      margin: EdgeInsets.only(right: 1.5 * Sizes.boxSeparation),
      width: Sizes.width / 2.5,
      height: Sizes.width / 2.5,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(assetName), fit: BoxFit.fill)),
    );
  }
}
